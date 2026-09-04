#!/usr/bin/env python3
"""Can you VERIFY a remote LLM inference without re-proving it? Measurements.

DREAMED ARTIFACT -- see docs/dreamed/README.md. Not owner-authored, not reviewed.

Companion to `docs/dreamed/trustless-distributed-ai.md`. The confidentiality half of
trustless AI is priced in `llm_cost.py`; this is the INTEGRITY half -- did the server
actually run the model it billed for.

The cheap answer to integrity is replication: have k independent providers do the same
work and compare. That is sound only if inference is reproducible ACROSS providers, and
the measurements below are about whether it is and what to do when it is not.

  L  reduction-order sensitivity -- how far apart can two honest implementations of the
                                   same dot product land, at float32 and float64.
  M  autoregressive amplification -- why "the outputs look close" is not a verification
                                   criterion for a sequence model.
  N  gap-gated verification     -- the proposed escape: accept a token on approximate
                                   agreement only when its top-2 logit gap exceeds twice
                                   the tolerance, escalate the rest. What does it cost?
  O  deterrence economics       -- sampling rate needed to make model substitution
                                   irrational, checked against Proof of Sampling
                                   (arXiv 2405.00295).
  P  collusion                  -- what k-of-N independence actually buys.

N is a PARAMETRIC MODEL, not a measurement: it sweeps plausible top-2 gap distributions
because no model weights are loaded here. Labelled at the point of use. L, M, O, P are
exact arithmetic.

Pure stdlib. Run via ./run.sh (address space and CPU capped).
"""

from __future__ import annotations

import math
import random
import struct


def rule(title: str) -> None:
    print()
    print("=" * 74)
    print(title)
    print("=" * 74)


def f32(x: float) -> float:
    """Round a Python float (binary64) to the nearest binary32 value."""
    return struct.unpack("f", struct.pack("f", x))[0]


# --------------------------------------------------------------------------
# L -- how far apart can two honest implementations land
# --------------------------------------------------------------------------


def dot_orders(a: list[float], b: list[float], f32_mode: bool):
    """The same dot product accumulated in four legitimate orders."""
    step = f32 if f32_mode else (lambda x: x)
    prods = [step(x * y) for x, y in zip(a, b)]

    def seq(xs):
        acc = 0.0
        for v in xs:
            acc = step(acc + v)
        return acc

    def pairwise(xs):
        if len(xs) == 1:
            return xs[0]
        mid = len(xs) // 2
        return step(pairwise(xs[:mid]) + pairwise(xs[mid:]))

    def blocked(xs, width):
        # what a GPU reduction with a fixed tile width does
        partials = [seq(xs[i:i + width]) for i in range(0, len(xs), width)]
        return seq(partials)

    return {
        "forward": seq(prods),
        "reverse": seq(list(reversed(prods))),
        "pairwise": pairwise(prods),
        "blocked-32": blocked(prods, 32),
        "blocked-128": blocked(prods, 128),
    }


def experiment_L(seed: int = 20260904) -> None:
    rule("L. How far apart can two HONEST implementations of one logit land?")
    print("Both providers run the same weights on the same input and neither cheats.")
    print("They differ only in the order their hardware accumulates a dot product --")
    print("tile width, pairwise tree, sequential. Floating-point addition is not")
    print("associative, so the results differ. The question is by how much, because")
    print("that number is the tolerance any replication-based check must allow.")
    print()
    rng = random.Random(seed)
    # NOTE on methodology: an earlier version of this table divided each trial's
    # spread by that trial's own dot-product magnitude. That is unsound -- the dot
    # product of two independent Gaussian vectors is centred on zero, so the
    # denominator is occasionally tiny and the "relative error" column reported
    # spurious outliers. The stable scale is the RMS dot magnitude over trials,
    # which is what a logit's typical size actually is.
    print(f"{'width d':>8} {'precision':>10} {'max |diff|':>13} {'RMS |dot|':>12} "
          f"{'ratio':>11}")
    print("-" * 74)
    for d in (768, 4096, 16384):
        for f32_mode in (True, False):
            worst_abs = 0.0
            sq = 0.0
            trials = 200
            for _ in range(trials):
                a = [rng.gauss(0, 1) for _ in range(d)]
                b = [rng.gauss(0, 1) / math.sqrt(d) for _ in range(d)]
                if f32_mode:
                    a = [f32(x) for x in a]
                    b = [f32(x) for x in b]
                vals = list(dot_orders(a, b, f32_mode).values())
                worst_abs = max(worst_abs, max(vals) - min(vals))
                sq += vals[0] ** 2
            rms = math.sqrt(sq / trials)
            print(f"{d:>8} {'float32' if f32_mode else 'float64':>10} "
                  f"{worst_abs:>13.3e} {rms:>12.3e} {worst_abs / rms:>11.3e}")
    print("-" * 74)
    print("So two honest float32 providers can disagree on a logit by about 1e-5 in")
    print("absolute terms (a few parts per million of the logit scale) from reduction")
    print("order alone, and float64 by about 2e-14. No amount of good faith closes")
    print("that. Any cross-provider check must therefore be a TOLERANCE check, not an")
    print("equality check -- unless the arithmetic is made exact, which is experiment")
    print("L2.")
    print()
    print("L2. The same accumulation in fixed-point integer arithmetic:")
    ints_a = [rng.randint(-2**15, 2**15) for _ in range(4096)]
    ints_b = [rng.randint(-2**7, 2**7) for _ in range(4096)]
    prods = [x * y for x, y in zip(ints_a, ints_b)]
    fwd = sum(prods)
    rev = sum(reversed(prods))
    blocked = sum(sum(prods[i:i + 32]) for i in range(0, len(prods), 32))
    print(f"  forward {fwd}, reverse {rev}, blocked-32 {blocked}")
    print(f"  all identical: {fwd == rev == blocked}")
    print("  Integer addition IS associative, so reduction order cannot matter and")
    print("  cross-provider bit-exactness is free. This is why opML runs its models")
    print("  inside an integer VM rather than on a GPU, and it is the single")
    print("  structural reason quantised inference is the verifiable kind.")


# --------------------------------------------------------------------------
# M -- why "close enough" is not a criterion for a sequence model
# --------------------------------------------------------------------------


def experiment_M() -> None:
    rule("M. Autoregressive amplification: one flipped token ends the comparison")
    print("Under greedy decoding a token is an argmax, which is a discrete function of")
    print("continuous logits. A perturbation below the top-2 gap changes nothing at")
    print("all; one above it changes the token, and every token after it is then")
    print("conditioned on different history. There is no partial credit.")
    print()
    print("Probability that a completion of n tokens is reproduced exactly, given a")
    print("per-token probability p that the top-2 gap falls below the tolerance:")
    print()
    header = f"{'p':>10}" + "".join(f"{n:>10}" for n in (16, 64, 256, 1024, 4096))
    print(header)
    print("-" * 74)
    for p in (1e-1, 1e-2, 1e-3, 1e-4, 1e-5):
        row = f"{p:>10.0e}"
        for n in (16, 64, 256, 1024, 4096):
            row += f"{(1 - p) ** n:>10.4f}"
        print(row)
    print("-" * 74)
    print("Read the 1e-3 row: a one-in-a-thousand per-token flip rate reproduces a")
    print("256-token answer only 77% of the time and a 4096-token one 2% of the time.")
    print("A verifier that re-runs the model and compares completions would therefore")
    print("raise a fraud alarm on an HONEST provider most of the time at long context.")
    print("Comparing text is the wrong primitive; the comparison has to happen at the")
    print("logit level, per token, with an explicit tolerance -- experiment N.")


# --------------------------------------------------------------------------
# N -- gap-gated verification
# --------------------------------------------------------------------------


def experiment_N() -> None:
    rule("N. Gap-gated verification: accept on a margin, escalate near ties")
    print("PARAMETRIC MODEL, not a measurement -- no model weights are loaded here.")
    print("The proposal: a verifier accepts a token when the two providers' logits")
    print("agree within tolerance eps AND the top-2 gap exceeds 2*eps, because then")
    print("the argmax provably cannot differ (Lean: `argmax_stable`). Tokens failing")
    print("the gap test are escalated to an exact check. The cost of the scheme is")
    print("the escalation rate, i.e. the fraction of tokens whose top-2 gap is small.")
    print()
    print("Top-2 logit gaps are modelled as Exponential(1/mu) for a few plausible mu;")
    print("the escalation rate is then P(gap <= 2 eps) = 1 - exp(-2 eps / mu).")
    print()
    eps_list = [1e-5, 1e-4, 1e-3, 1e-2]
    print(f"{'mean gap mu':>12}" + "".join(f"{f'eps={e:.0e}':>14}" for e in eps_list))
    print("-" * 74)
    for mu in (3.0, 1.0, 0.3, 0.1):
        row = f"{mu:>12.1f}"
        for eps in eps_list:
            rate = 1 - math.exp(-2 * eps / mu)
            row += f"{rate:>14.2e}"
        print(row)
    print("-" * 74)
    print("At the float32 tolerance of experiment L (eps ~ 1e-5) the escalation rate")
    print("sits between 7e-6 and 2e-4 across every gap scale modelled. So on the order")
    print("of one token in ten thousand needs exact treatment, and the rest are")
    print("settled by a cheap tolerance comparison whose soundness is a theorem rather")
    print("than a hope.")
    print()
    print("The honest caveat: an exponential gap model is a guess. A confident model")
    print("has a heavier concentration near zero than this at exactly the moments that")
    print("matter (a genuine 50/50 continuation), and those are also the tokens where")
    print("a cheating provider gains most. Measuring the real distribution is one")
    print("afternoon with any open-weights model and is the first thing to do before")
    print("trusting this table.")


# --------------------------------------------------------------------------
# O -- deterrence
# --------------------------------------------------------------------------


def experiment_O() -> None:
    rule("O. Deterrence: how often must you check to make substitution irrational?")
    print("The attack that FHE cannot detect at all: bill for a large model, run a")
    print("small one. A provider paid to run model A, secretly running model B, saves")
    print("s per request and is caught with probability q, losing a bond D. Cheating")
    print("is irrational when s < q*D, i.e. q > s/D. With verification by replication")
    print("at sampling rate r and a single honest checker, q = r.")
    print()
    print("Compute cost is roughly linear in parameter count, so substituting model B")
    print("for model A saves a fraction 1 - |B|/|A| of the request's cost.")
    print()
    print(f"{'claimed':>12} {'actually run':>14} {'saving s':>10} "
          f"{'bond D = 10x':>14} {'bond D = 1000x':>16}")
    print("-" * 74)
    pairs = [("70B", 70.0, "8B", 8.0), ("70B", 70.0, "1B", 1.0),
             ("8B", 8.0, "1B", 1.0), ("8B", 8.0, "0.5B", 0.5)]
    for na, a, nb, b in pairs:
        s = 1 - b / a
        print(f"{na:>12} {nb:>14} {s:>10.3f} "
              f"{s / 10:>13.2%} {s / 1000:>15.3%}")
    print("-" * 74)
    print("Read the last column: with a bond worth a thousand requests, checking")
    print("about ONE REQUEST IN A THOUSAND already makes substitution unprofitable.")
    print("That is the whole asymmetry between the two halves of trustlessness --")
    print("integrity can be SAMPLED and confidentiality cannot. You cannot encrypt")
    print("one prompt in a thousand and call the channel private, but you can check")
    print("one inference in a thousand and call the provider honest, because the")
    print("cheat has to be repeated to be worth anything and every repetition is")
    print("another draw against the same probability.")
    print()
    print("This is the shape of Proof of Sampling (arXiv 2405.00295), which makes it")
    print("a Nash equilibrium rather than a bound; the arithmetic here is the toy")
    print("version and is not offered as a new result. Note what it assumes, though,")
    print("and what experiments L and M say about that assumption: the checker must")
    print("be able to REPRODUCE the computation. Sampled deterrence inherits every")
    print("determinism problem above, and inherits it silently.")


# --------------------------------------------------------------------------
# P -- collusion
# --------------------------------------------------------------------------


def experiment_P() -> None:
    rule("P. What k-of-N independence actually buys")
    print("Replication across N providers is only as good as their independence. If a")
    print("fraction c of the population colludes (same operator behind several fronts,")
    print("same cloud region, same jurisdiction), a check that samples k providers")
    print("fails silently when all k drawn are colluding: probability c^k.")
    print()
    ks = [2, 3, 5, 7]
    print(f"{'colluding c':>12}" + "".join(f"{f'k={k}':>13}" for k in ks))
    print("-" * 74)
    for c in (0.5, 0.3, 0.1, 0.03):
        row = f"{c:>12.0%}"
        for k in ks:
            row += f"{c ** k:>13.2e}"
        print(row)
    print("-" * 74)
    print("Undetected-collusion probability falls geometrically in k, so a handful of")
    print("replicas buys a lot -- IF c is really the fraction you think it is. That")
    print("is not a cryptographic assumption and cannot be made into one; it is an")
    print("economic and jurisdictional claim about who owns which datacentre, and it")
    print("is the actual trust root of every 'trustless' distributed inference")
    print("network. Worth saying plainly: these systems do not remove trust, they")
    print("convert it from trust in one party's honesty into trust in many parties'")
    print("independence, which is a better bet but a bet.")


def main() -> None:
    print("toesnail / docs/dreamed -- trustless inference: the integrity half")
    print("DREAMED ARTIFACT, unreviewed. See docs/dreamed/README.md.")
    experiment_L()
    experiment_M()
    experiment_N()
    experiment_O()
    experiment_P()
    print()
    print("done.")


if __name__ == "__main__":
    main()

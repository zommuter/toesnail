#!/usr/bin/env python3
"""How much evidence does one observation carry about WHICH model ran?

DREAMED ARTIFACT -- see docs/dreamed/README.md. Not owner-authored, not reviewed.

Companion to `docs/dreamed/model-attestation.md`. The owner's question: how do you
trust a trustless server to run the LLM it promised -- an "LLM footprint/signature"?

That question is easier than the one `trustless-distributed-ai.md` asks. Verifying a
COMPUTATION needs reproducibility. Verifying an IDENTITY only needs a statistical test,
because a different model is a different distribution and distributions are testable
from samples. The measurements below are about how many samples.

  Q  evidence per observation -- inverting the published detection results into an
                                information rate, which says WHY activation
                                fingerprints beat sampled tokens by two orders of
                                magnitude.
  R  sequential test cost     -- observations needed to separate two models as a
                                function of their per-observation KL divergence.
  S  audit evasion            -- the deterrence threshold when the provider can
                                RECOGNISE an audit and behave honestly for it. This is
                                where encryption changes the answer.
  T  fingerprint width        -- how many random projection dimensions an activation
                                fingerprint needs, by Johnson-Lindenstrauss.

Q inverts other people's measured results into a derived quantity; it is labelled as
derived at the point of use and is only as good as the model behind the inversion.
R, S, T are exact arithmetic.

Pure stdlib. Run via ./run.sh (hard cgroup memory cap, no swap, CPU quota).
"""

from __future__ import annotations

import math


def rule(title: str) -> None:
    print()
    print("=" * 74)
    print(title)
    print("=" * 74)


# --------------------------------------------------------------------------
# Q -- evidence per observation
# --------------------------------------------------------------------------

def sprt_n(kl: float, alpha: float, beta: float) -> float:
    """Wald's expected sample size for a sequential likelihood-ratio test."""
    return math.log((1 - beta) / alpha) / kl


def kl_from_n(n: float, alpha: float, beta: float) -> float:
    return math.log((1 - beta) / alpha) / n


def experiment_Q() -> None:
    rule("Q. Why an activation fingerprint beats a sampled token by ~150x")
    print("DERIVED, not measured here. DiFR (arXiv 2511.20621) reports detecting 4-bit")
    print("quantization at AUC > 0.999 with two different observables:")
    print()
    print("  Token-DiFR       within 300 output tokens")
    print("  Activation-DiFR  using 2 output tokens")
    print()
    print("Inverting each through Wald's sequential-test relation n ~ log((1-b)/a)/KL")
    print("at a = b = 1e-3 turns those into an evidence rate per observation:")
    print()
    a = b = 1e-3
    print(f"{'observable':<20} {'n to decide':>12} {'implied KL (nats/obs)':>23} "
          f"{'bits/obs':>10}")
    print("-" * 74)
    rows = [("sampled token", 300.0), ("activation fingerprint", 2.0)]
    kls = {}
    for label, n in rows:
        kl = kl_from_n(n, a, b)
        kls[label] = kl
        print(f"{label:<20} {n:>12.0f} {kl:>23.4f} {kl / math.log(2):>10.3f}")
    print("-" * 74)
    ratio = kls["activation fingerprint"] / kls["sampled token"]
    print(f"Evidence ratio: {ratio:.0f}x per observation.")
    print()
    print("The reason is information-theoretic and worth stating plainly. A sampled")
    print("token is ONE DRAW from the output distribution: it carries at most log2(V)")
    print("bits and in practice far less, because a confident model puts nearly all")
    print("its mass on one token and the draw is then almost surely that token,")
    print("whatever the model. An activation vector is not a draw at all -- it is a")
    print("direct, continuous, high-dimensional measurement of the computation. So")
    print("sampling is the lossy step, and any verification scheme built on generated")
    print("TEXT is paying an enormous and avoidable information tax.")
    print()
    print("Caveat on the inversion: Wald's relation assumes i.i.d. observations and a")
    print("simple-vs-simple hypothesis test, and DiFR reports AUC rather than a")
    print("sequential test's error rates. Treat the two KL figures as order-of-")
    print("magnitude, and the RATIO as the robust part -- it is what survives most")
    print("choices of a and b, since both rows are divided by the same constant.")


# --------------------------------------------------------------------------
# R -- how many observations
# --------------------------------------------------------------------------

def experiment_R() -> None:
    rule("R. Observations needed to tell two models apart")
    print("Wald sequential test, error rates a = b, versus per-observation KL")
    print("divergence between the promised model and the substituted one.")
    print()
    kl_list = [(1e-3, "near-identical (same model, different kernel)"),
               (0.023, "4-bit quantization (derived in Q)"),
               (0.1, "fine-tune or a watermark"),
               (1.0, "a genuinely smaller model"),
               (3.45, "activation fingerprint of a quantized model")]
    alphas = [1e-2, 1e-3, 1e-6]
    print(f"{'KL':>8}  {'what it is':<42}" + "".join(f"{f'a=1e-{int(-math.log10(x))}':>10}"
                                                     for x in alphas))
    print("-" * 74)
    for kl, label in kl_list:
        row = f"{kl:>8.3f}  {label:<42}"
        for a in alphas:
            row += f"{sprt_n(kl, a, a):>10.0f}"
        print(row)
    print("-" * 74)
    print("Note the top row. Distinguishing a model from ITSELF running on different")
    print("hardware needs thousands of observations, which is the good news: benign")
    print("numerical divergence is not mistaken for fraud, it is merely slow to rule")
    print("out. And note the cost structure -- tightening the false-accusation rate")
    print("from 1e-2 to 1e-6 only triples the sample size, because the requirement")
    print("enters logarithmically. Cheap certainty is available; cheap SPEED is not.")


# --------------------------------------------------------------------------
# S -- audit evasion, and what encryption changes
# --------------------------------------------------------------------------

def experiment_S() -> None:
    rule("S. The provider that recognises an audit")
    print("Deterrence (trustless_verify.py, experiment O) says cheating is irrational")
    print("when the catch probability q exceeds saving/bond. That assumed the provider")
    print("cannot tell an audit from a real request. Drop the assumption: let the")
    print("provider recognise an audit with probability d and behave honestly on it.")
    print("The effective catch rate becomes q = r(1-d) for an audit rate r, so the")
    print("required audit rate is r = s / (D (1-d)).")
    print()
    s = 0.886          # substituting 8B for 70B
    print(f"saving s = {s:.3f} (70B billed, 8B run), bond D in units of one request")
    print()
    ds = [0.0, 0.5, 0.9, 0.99, 0.999]
    print(f"{'bond D':>10}" + "".join(f"{f'd={d}':>13}" for d in ds))
    print("-" * 74)
    for D in (10, 100, 1000, 10000):
        row = f"{D:>10}"
        for d in ds:
            r = s / (D * (1 - d))
            row += f"{min(r, 1.0):>12.2%}" + ("*" if r > 1 else " ")
        print(row)
    print("-" * 74)
    print("A starred cell means NO audit rate suffices: even checking every request")
    print("fails, because the provider is honest exactly when checked.")
    print()
    print("This is the finding, and it inverts something I wrote in the two sibling")
    print("essays. In a PLAINTEXT API the provider sees the prompt, and audit prompts")
    print("are recognisable -- Model Equality Testing publishes its prompt sets, and")
    print("benchmark-shaped queries are statistically obvious. d is large.")
    print()
    print("Under FHE the provider sees ciphertext. It cannot distinguish an audit from")
    print("a real request, because distinguishing them is exactly the confidentiality")
    print("property the scheme provides. d = 0, by the same assumption that makes the")
    print("encryption worth having. So FHE does not merely 'fail to provide integrity'")
    print("-- it is what makes an integrity audit UNEVADABLE. The two properties are")
    print("complementary rather than orthogonal, and the composition runs in the")
    print("direction I had assumed it did not.")


# --------------------------------------------------------------------------
# T -- fingerprint width
# --------------------------------------------------------------------------

def experiment_T() -> None:
    rule("T. How wide does an activation fingerprint need to be?")
    print("Activation-DiFR compresses an activation vector by random orthogonal")
    print("projection. Johnson-Lindenstrauss says k >= 8 ln(m) / e^2 dimensions")
    print("preserve all pairwise distances among m vectors to relative error e, so")
    print("the fingerprint width is set by the accuracy wanted, NOT by the model's")
    print("width d -- which is why the scheme's overhead does not grow with model size.")
    print()
    print(f"{'vectors m':>10}" + "".join(f"{f'e={e}':>12}" for e in (0.5, 0.3, 0.1)))
    print("-" * 74)
    for m in (10, 100, 1000, 10000):
        row = f"{m:>10}"
        for e in (0.5, 0.3, 0.1):
            row += f"{math.ceil(8 * math.log(m) / e ** 2):>12}"
        print(row)
    print("-" * 74)
    print("A few hundred floats per checked token, against a hidden state of 4096 and")
    print("a vocabulary of 128k. That is the 25-75% communication saving DiFR reports,")
    print("and it is also why the scheme composes with encryption: a random projection")
    print("is a LINEAR map, so under FHE it is a ciphertext-times-plaintext product --")
    print("the cheap kind, needing no relinearisation. An encrypted activation")
    print("fingerprint costs the server almost nothing beyond what it already pays.")
    print()
    print("The bound above is the generic worst case; JL is famously loose in practice")
    print("and the real requirement is usually smaller. It is quoted here as a")
    print("ceiling, not a target.")


def main() -> None:
    print("toesnail / docs/dreamed -- model attestation: which model actually ran?")
    print("DREAMED ARTIFACT, unreviewed. See docs/dreamed/README.md.")
    experiment_Q()
    experiment_R()
    experiment_S()
    experiment_T()
    print()
    print("done.")


if __name__ == "__main__":
    main()

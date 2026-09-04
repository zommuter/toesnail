---
title: "Dreamed: trustless distributed AI, and the integer arithmetic that unlocks it"
permalink: /dreamed/trustless-distributed-ai
---

# Dreamed: trustless distributed AI, and the integer arithmetic that unlocks it

> **STATUS: DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](./). Written by an AI agent on
> 2026-09-04 from an owner-picked seed. Nothing here is theory or a correction; nothing moves into
> `crypto/` or the `verify/` machinery without the owner authoring the move. Claims about owner
> content live under [Surfaced for the owner](#8-surfaced-for-the-owner), located, never resolved.

**Seed (owner, this session):** *"follow the 'everyone said it's impossible, till someone who
didn't know made it anyway' approach to some healthy extent. The goal is clear, be creative about
finding a way to the trustless distributed AI, also consider other approaches than FHE-LLM if not
possible (or even if, multiple methods are better)"*, and the side-question that turned out to be
the load-bearing one: *"LLMs with integer arithmetics possible? think MP3 vs OGG"*.

**Context.** Fourth of the session's FHE cluster; sibling of [`fhe-llm`](fhe-llm.md), which prices
the **confidentiality** half. This one is the **integrity** half and the synthesis.

Measurements from [`docs/dreamed/fhe-search/trustless_verify.py`](fhe-search/trustless_verify.py),
run under `fhe-search/run.sh` (hard cgroup memory cap, no swap, CPU quota -- see
[`capped.sh`](capped.sh)). Lean in
[`docs/dreamed/lean/TrustlessVerify.lean`](lean/TrustlessVerify.lean).

## 0. Summary

The owner's codec analogy is not an analogy. It is the same engineering problem, already solved
once, in a field that hit it thirty years earlier -- and following it produces the one
architectural choice that serves **both** halves of trustlessness at once.

1. **"Trustless" is two requirements.** Confidentiality (can the server read my prompt) and
   integrity (did the server run the model it billed for). FHE gives the first and **zero** of the
   second. They have opposite cost curves: **integrity can be sampled, confidentiality cannot.**
2. **The cheap route to integrity is replication, and it is blocked by reproducibility.** Two
   honest providers running identical weights on identical input disagree on a logit by about
   **1e-5** at float32, purely from the order their hardware sums a dot product. Measured below.
3. **That tiny disagreement is not tiny, because decoding is discrete and autoregressive.** At a
   per-token divergence rate of one in a thousand, a 4096-token completion is reproduced **1.7%**
   of the time -- so a verifier comparing *text* accuses honest providers almost always.
4. **Codecs already solved this, the same way, for the same reason.** Predictive coding feeds its
   own output back, so decoder drift compounds; the industry's answer was to mandate **bit-exact
   integer transforms**. Autoregressive decoding is predictive coding.
5. **Integer-only transformers exist and are faster.** I-BERT runs BERT end to end in INT8 with
   integer GELU, softmax and LayerNorm at FP32 accuracy and **3.1-3.6x** speedup.
6. **And that is the convergence.** An integer-only model is bit-exactly reproducible, hence
   verifiable by replication; and it is natively evaluable by the **exact** FHE schemes (BFV/BGV)
   rather than the approximate one everybody uses. One choice, both halves, and it is already
   faster in plaintext. This is the essay's actual proposal.
7. **The residual honesty:** none of this removes trust. It converts trust in one party's honesty
   into trust in many parties' independence, which is an economic claim, not a cryptographic one.

## 1. What FHE does not give you

The seed's framing was confidentiality. The gap worth naming is that a fully homomorphic pipeline
is **completely defenceless against a provider who runs the wrong model**. The server evaluates a
circuit over ciphertexts; the client decrypts *something*; both a 70B model and a 1B model produce
plausible-looking text. There is no signal to check against, because everything the client could
check with is encrypted from the client's own key and the server never saw plaintext to be caught
lying about.

This is not a corner case. It is the *economically obvious* attack: compute cost is roughly linear
in parameter count, so substituting an 8B for a 70B saves 89% of the bill. Under FHE it is
undetectable by construction.

So a trustless system needs a second mechanism, and the good news is that the second mechanism is
much cheaper than the first, for a structural reason:

| | confidentiality | integrity |
|---|---|---|
| can you check a sample? | **no** -- encrypting one prompt in a thousand protects nothing | **yes** -- checking one inference in a thousand deters, because the cheat must be repeated to pay |
| cost shape | pay on every request, forever | pay on a sampled fraction |

Sampled deterrence is exact arithmetic. A provider saving fraction $s$ per request, caught with
probability $q$, forfeiting a bond $D$, has negative expected value from cheating exactly when

$$ q > s/D \veq{deterrence-dreamed}\lean $$

| claimed | actually run | saving $s$ | rate needed, $D = 10\times$ | rate needed, $D = 1000\times$ |
|---|---|---:|---:|---:|
| 70B | 8B | 0.886 | 8.86% | **0.089%** |
| 70B | 1B | 0.986 | 9.86% | 0.099% |
| 8B | 1B | 0.875 | 8.75% | 0.088% |

**With a bond worth a thousand requests, checking one request in about a thousand already makes
substitution unprofitable.** This is the shape of **Proof of Sampling** (arXiv 2405.00295), which
makes it a Nash equilibrium rather than a bound; the table is the toy version and is not offered
as a new result. What matters here is what it *assumes*, quietly: that the checker can reproduce
the computation. Section 2 is about how badly that fails.

## 2. Honest providers disagree

Replication is the cheap checker: have another provider redo the work and compare. For that to
mean anything, two honest providers must produce the same answer. They do not.

The same dot product accumulated in different but equally legitimate orders -- sequential,
pairwise tree, GPU tile widths of 32 and 128 -- over 200 random trials per row:

| width $d$ | precision | max spread | RMS $\lvert\text{dot}\rvert$ | ratio |
|---:|---|---:|---:|---:|
| 768 | float32 | $2.74\cdot10^{-6}$ | 0.981 | $2.8\cdot10^{-6}$ |
| 768 | float64 | $5.33\cdot10^{-15}$ | 0.983 | $5.4\cdot10^{-15}$ |
| 4096 | float32 | $8.35\cdot10^{-6}$ | 0.989 | $8.4\cdot10^{-6}$ |
| 4096 | float64 | $2.22\cdot10^{-14}$ | 1.007 | $2.2\cdot10^{-14}$ |
| 16384 | float32 | $1.22\cdot10^{-5}$ | 1.002 | $1.2\cdot10^{-5}$ |
| 16384 | float64 | $2.18\cdot10^{-14}$ | 0.969 | $2.2\cdot10^{-14}$ |

Floating-point addition is not associative, so this is not a bug in anyone's implementation and no
amount of good faith closes it. A cross-provider check must be a **tolerance** check.

**A correction to the usual story, which I had wrong until I checked it.** The popular account
blames GPU concurrency and atomic adds. Thinking Machines Lab's *Defeating Nondeterminism in LLM
Inference* rules that out -- the same matmul on the same data is bitwise reproducible, because
atomics are essentially absent from the forward pass. The real cause of nondeterministic
production endpoints is **batch-invariance failure**: kernel numerics change with batch size, and
batch size changes with server load, so *your* request's arithmetic depends on who else is
querying. They fix it with batch-invariant kernels and demonstrate bitwise identical outputs
across 1000 runs at roughly **2x** cost.

That is a real result and it is also **not the one replication needs**. They address run-to-run
determinism on an identical hardware and software stack, explicitly not cross-hardware
equivalence. Cross-*provider* verification is a different problem, and it is the one the
verification protocols quietly assume away.

## 3. Why a small disagreement is not a small problem

Decoding turns continuous logits into a discrete token by argmax. A perturbation below the
top-two gap changes nothing at all; one above it changes the token, and every subsequent token is
then conditioned on different history. There is no partial credit.

Probability that an $n$-token completion is reproduced exactly, given per-token divergence $p$:

| $p$ | 16 | 64 | 256 | 1024 | 4096 |
|---:|---:|---:|---:|---:|---:|
| $10^{-1}$ | 0.185 | 0.001 | 0.000 | 0.000 | 0.000 |
| $10^{-2}$ | 0.852 | 0.526 | 0.076 | 0.000 | 0.000 |
| $10^{-3}$ | 0.984 | 0.938 | 0.774 | 0.359 | **0.017** |
| $10^{-4}$ | 0.998 | 0.994 | 0.975 | 0.903 | 0.664 |
| $10^{-5}$ | 1.000 | 0.999 | 0.997 | 0.990 | 0.960 |

$$ (1-p)^n \le e^{-np} \veq{amplify-dreamed}\lean $$

**A verifier that re-runs the model and compares the text raises fraud alarms on honest providers,
and does so more often the longer the answer.** Comparing completions is the wrong primitive. The
comparison has to be per token, at the logit level, with an explicit tolerance -- and a tolerance
comparison on a discrete argmax is unsound unless something bounds the margin.

## 4. Gap-gated verification: making the tolerance check sound

The fix is a side condition, and it is a theorem rather than a heuristic. If two providers' logits
agree within $\varepsilon$ and the winner's margin exceeds $2\varepsilon$, the argmax cannot
differ:

$$ \lVert w - v\rVert_\infty \le \varepsilon \ \wedge\ \text{margin}(v) > 2\varepsilon \implies \arg\max w = \arg\max v \veq{argmaxstable-dreamed}\lean $$

So: **accept a token on cheap tolerance agreement when its margin clears the bar; escalate the
rest to an exact check.** The strict inequality is not slack -- at margin exactly $2\varepsilon$ a
counterexample exists and is in the Lean file.

The cost of the scheme is the escalation rate. **PARAMETRIC MODEL, not a measurement** -- no
weights are loaded here; top-2 gaps are modelled as Exponential(mean $\mu$), giving escalation
rate $1 - e^{-2\varepsilon/\mu}$:

| mean gap $\mu$ | $\varepsilon=10^{-5}$ | $10^{-4}$ | $10^{-3}$ | $10^{-2}$ |
|---:|---:|---:|---:|---:|
| 3.0 | $6.7\cdot10^{-6}$ | $6.7\cdot10^{-5}$ | $6.7\cdot10^{-4}$ | $6.6\cdot10^{-3}$ |
| 1.0 | $2.0\cdot10^{-5}$ | $2.0\cdot10^{-4}$ | $2.0\cdot10^{-3}$ | $2.0\cdot10^{-2}$ |
| 0.3 | $6.7\cdot10^{-5}$ | $6.7\cdot10^{-4}$ | $6.6\cdot10^{-3}$ | $6.5\cdot10^{-2}$ |
| 0.1 | $2.0\cdot10^{-4}$ | $2.0\cdot10^{-3}$ | $2.0\cdot10^{-2}$ | 0.18 |

At the measured float32 tolerance ($\varepsilon \sim 10^{-5}$) escalation runs between $10^{-5}$
and $2\cdot10^{-4}$ across every gap scale modelled -- roughly one token in ten thousand.

**The caveat is load-bearing and I want it read, not skimmed.** An exponential gap model is a
guess, and it is wrong in the direction that hurts: real logit gaps concentrate near zero exactly
at genuine 50/50 continuations, which are also the tokens where a cheating provider gains most.
Measuring the true distribution is an afternoon with any open-weights model and should be done
before anyone trusts that table.

## 5. The codec precedent, and integer-only transformers

The owner's side-question -- *LLMs with integer arithmetic, think MP3 vs OGG* -- is the essay's
turning point, so it gets its own section.

**The precedent.** Early standards specified transforms *mathematically, with a conformance
tolerance*: JPEG's IDCT was famously under-specified, and decoders disagreed. That is survivable
for independent still frames. It is not survivable for **predictive** coding, where each frame is
reconstructed from the previously *decoded* frame, because encoder and decoder then drift apart
and the error accumulates. The industry's answer, from H.264 onward, was to mandate **bit-exact
integer transforms**; Opus ships a bit-exact fixed-point reference decoder for the same reason.

**Autoregressive decoding is predictive coding.** Each token is generated from previously decoded
tokens. Section 3's table is exactly the drift-accumulation curve, and the fix is exactly the same
fix. This is not an analogy that illustrates a point -- it is the same structural problem with a
known, deployed, thirty-year-old solution.

**And it is available.** Integer-only transformers are not hypothetical:

- **I-BERT** (Kim et al., ICML 2021) runs BERT end to end in INT8 with **no floating point
  anywhere**, replacing the hard operations with integer algorithms: `i-GELU` (second-order
  polynomial for erf), `i-Softmax` (numerical stabilisation plus polynomial exp plus bit-shifts),
  `i-LayerNorm` (iterative integer square root). Accuracy matches or slightly exceeds FP32, at
  **3.08x** (base) and **3.56x** (large) speedup on a T4.
- **I-ViT** (ICCV 2023) does the same for vision transformers.
- **BitNet b1.58** goes further, with ternary weights $\{-1,0,+1\}$ and INT8 activations.

Confirmed by construction below: integer addition **is** associative, so reduction order cannot
matter and cross-provider bit-exactness is free.

```
forward -180756565, reverse -180756565, blocked-32 -180756565  ->  identical
```

This is also why **opML** runs its models inside an integer VM (a MIPS emulator) rather than on a
GPU: not because the VM is fast, but because it is the only way to get a bit-exact referee for its
fraud-proof bisection game.

## 6. The convergence, which is this essay's proposal

Three separate lines land on the same architectural choice, and I have not seen them drawn
together, which is the main reason this essay exists.

1. **Integrity wants integer arithmetic**, because bit-exact reproducibility makes replication and
   dispute-resolution sound, and removes the entire tolerance/margin apparatus of section 4. No
   escalation rate, no gap model, no honest-provider false alarms.
2. **Confidentiality wants integer arithmetic too**, and this is the part that surprised me.
   Everyone evaluates transformers under **CKKS** because CKKS is *approximate* arithmetic and
   transformers are float. But BFV and BGV are **exact integer** FHE schemes, and an integer-only
   transformer is natively evaluable under them with no approximation error at all. The
   accuracy-versus-depth trade-off that dominates the FHE-transformer literature is partly an
   artefact of insisting the model stay in floating point.
3. **The nonlinearities are already done.** I-BERT replaced GELU, softmax and LayerNorm with
   *integer polynomial* algorithms for hardware reasons. Low-degree polynomials over integers is
   precisely what an exact FHE scheme evaluates. The FHE-friendliness was produced as a
   side-effect of an unrelated optimisation -- convergent evolution, and it means the hard design
   work has partly been done by people who were not thinking about encryption.

So the proposal: **an integer-only, quantised transformer is the natural substrate for trustless
distributed AI**, because the same property buys verifiability and exact homomorphic evaluation,
and it is already 3x faster in the clear. In the codec framing: stop specifying the model as
mathematics with a tolerance, and start specifying it as a bit-exact integer program.

**What I have not checked, and would need to before believing my own conclusion:** whether BFV/BGV
noise growth over I-BERT's polynomial depth is actually better than CKKS's, or merely
differently bad. Exact arithmetic removes approximation error but does nothing about multiplicative
depth, and the integer polynomials may cost more depth than CKKS's cheaper approximations. That is
a real possibility that would weaken point 2 to "cleaner semantics, similar cost", and it is
lead 1 below rather than something I am asserting.

## 7. The three integrity mechanisms, ranked

| mechanism | cost | needs | verdict |
|---|---|---|---|
| **zkML** (proof of inference) | very high; a 1M-parameter nanoGPT needed ~80 min proving | nothing but the prover | soundest, and the only one with no trust assumption; too slow for LLM scale today |
| **Replication + consensus** | $k\times$ compute | bit-exact reproducibility **and** $k$ independent providers | cheapest, and the one integer arithmetic unlocks |
| **Optimistic / fraud proofs** (opML) | ~$1\times$ plus a challenge window | one honest watcher, bonds, a bit-exact referee | best ratio; opML runs 7B-LLaMA on a commodity PC. Latency cost is the challenge window, not compute |

opML's own comparison is the striking one: zkML on a **1M-parameter** nanoGPT takes about 80
minutes of proving, while opML runs a **7B** LLaMA on an ordinary PC without a GPU. Four orders of
magnitude in model size for a weaker but economically sufficient guarantee. The optimistic
approach is right for the same reason sampling is right: **you do not need to prove every
inference, you need to make cheating lose money.**

Composition with confidentiality has been done too: **opp/ai** (arXiv 2402.15006) combines
optimistic verification with privacy-preserving evaluation. So the pieces of "trustless
distributed AI" all exist separately. What does not yet exist, as far as I can find, is a stack
that gets both properties from **one** substrate rather than bolting them together -- which is
what section 6 proposes.

## 8. What independence actually buys, stated honestly

Replication across $N$ providers is only as good as their independence. If a fraction $c$ of the
population colludes -- one operator behind several fronts, one cloud region, one jurisdiction -- a
$k$-sample check fails silently with probability $c^k$:

| colluding $c$ | $k=2$ | $k=3$ | $k=5$ | $k=7$ |
|---:|---:|---:|---:|---:|
| 50% | 0.25 | 0.125 | 0.031 | 0.0078 |
| 30% | 0.090 | 0.027 | 0.0024 | 0.00022 |
| 10% | 0.010 | 0.0010 | $10^{-5}$ | $10^{-7}$ |
| 3% | 0.00090 | $2.7\cdot10^{-5}$ | $2.4\cdot10^{-8}$ | $2.2\cdot10^{-11}$ |

A handful of replicas buys a great deal -- **if $c$ is really what you think it is.** That is not
a cryptographic assumption and cannot be made into one; it is an economic and jurisdictional claim
about who owns which datacentre. Worth saying plainly, because the word "trustless" invites the
opposite reading: these systems do not remove trust. They convert trust in one party's honesty
into trust in many parties' independence. That is a much better bet. It is still a bet.

## 9. Surfaced for the owner

Located, evidenced, not resolved. Nothing filed into any ledger.

1. **The codec insight is yours, not mine, and it is the best idea in this batch.** Recorded
   explicitly because the provenance matters for a directory whose whole purpose is keeping
   owner-seeded and AI-generated material distinguishable. The MP3-versus-bit-exact-codec framing
   produced section 5 and section 6; I would not have got there from the cryptography literature,
   which discusses quantisation as an efficiency question and not as a *conformance* question.
2. **No owner content is touched by this essay.** It has no source in `crypto/` or `physics/`,
   locates no discrepancy, and proposes no edit. Stated so the absence is not read as an omission.
3. **The scope question from [`fhe-llm`](fhe-llm.md) applies here twice over.** That essay noted
   the FHE-LLM thread may not belong in toesnail at all; this one is further from physics still --
   distributed-systems economics with a codec detour. If the owner wants the crypto wing to stay a
   counting page, this essay and its sibling are the two to move or drop, and that is entirely his
   call. I have kept both in `docs/dreamed/` precisely so that call stays open.

## 10. Lean attestation

**File** [`docs/dreamed/lean/TrustlessVerify.lean`](lean/TrustlessVerify.lean). **Command**
`cd verify && ../docs/dreamed/capped.sh -m 6G -- lake env lean --threads=2 ../docs/dreamed/lean/TrustlessVerify.lean`.
**Exit status `0`, `sorry` count `0`.** Mathlib is the rev pinned in `verify/lake-manifest.json`;
imports are narrow, no `import Mathlib`.

| Claim | Lean names | Status |
|---|---|---|
| gap-gated verification is sound (section 4) | `WinsBy`, `AgreeWithin`, `argmax_stable` | proved |
| the margin condition is not slack | `margin_necessary` | proved (explicit counterexample) |
| completion agreement decays exponentially (section 3) | `agree_pow_le_exp` | proved |
| sampled deterrence condition (section 1) | `cheatPayoff`, `deterrence` | proved |
| the checker can reproduce the computation | `CheckerCanReproduce` | **definition only, deliberately unproved** |

`CheckerCanReproduce` is a definition rather than a hypothesis in use because section 2 shows it is
**false as stated** for floating-point inference across heterogeneous providers. It is in the file
as the thing every sampled-verification argument assumes silently, so that the weakening
(reproduction-within-tolerance plus a margin test) is visible as a weakening.

`\veq` badges above attest against this dreamed file only, never against the repo's sidecar
machinery (`docs/dreamed/README.md` rule).

## 11. Follow-up leads

1. **BFV/BGV depth for an integer-only transformer** (mechanizable, and it gates section 6): does
   exact integer FHE actually cost less than CKKS for I-BERT's polynomial nonlinearities, or does
   the depth eat the gain? This is the one measurement that decides whether the convergence
   argument is a finding or a hope, and I have deliberately not asserted the answer.
2. **Measure the real top-2 logit gap distribution** (mechanizable, one afternoon): replaces
   section 4's parametric guess with data, and tells you the true escalation rate. Should be done
   before section 4 is believed.
3. **Cross-hardware bit-exactness for an integer-only model** (mechanizable, medium): run I-BERT
   or a BitNet model on two different accelerators and check bit-identity end to end. If it holds,
   replication-based verification is available *today* for those models, which would be a
   deployable result rather than a design.
4. **Sampled integrity in the presence of adaptive cheating** (owner direction): the deterrence
   table assumes a provider who cheats on every request. One who cheats only on requests it
   predicts will not be checked is a harder game, and Proof of Sampling's equilibrium argument is
   where to start rather than my arithmetic.
5. **Whether this belongs in toesnail** (owner-only, gating): see surfaced item 3.

---
title: "Dreamed: how to tell which model actually ran, and why encryption helps"
permalink: /dreamed/model-attestation
---

# Dreamed: how to tell which model actually ran, and why encryption helps

> **STATUS: DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](./). Written by an AI agent on
> 2026-09-04 from an owner-picked seed. Nothing here is theory or a correction; nothing moves into
> `crypto/` or the `verify/` machinery without the owner authoring the move. Claims about owner
> content live under [Surfaced for the owner](#8-surfaced-for-the-owner), located, never resolved.

**Seed (owner, this session):** *"how to trust a trustless server to actually run the LLM they
promise? e.g. a kind of LLM footprint/signature, or something else?"*

**Context.** Fifth of the session's FHE cluster, and a direct follow-on from
[`trustless-distributed-ai`](trustless-distributed-ai.md), which treated integrity as "did the
server compute correctly" and ran into reproducibility. This essay asks the *narrower* question --
"did the server run the model it promised" -- and the narrowing turns out to matter a great deal.

Measurements from [`docs/dreamed/fhe-search/model_attestation.py`](fhe-search/model_attestation.py),
run under `fhe-search/run.sh` (hard cgroup memory cap, no swap, CPU quota -- see
[`capped.sh`](capped.sh)). Lean in
[`docs/dreamed/lean/ModelAttestation.lean`](lean/ModelAttestation.lean).

## 0. Summary

1. **The footprint the seed asks for exists and is called Activation-DiFR.** Random orthogonal
   projections of a layer's activations, compared against a trusted reference. It detects 4-bit
   quantization at AUC > 0.999 using **two output tokens**. There is also a purely behavioural
   route (Model Equality Testing, ICLR 2025) needing about 10 samples per prompt.
2. **The problem is not hypothetical and the base rate is bad.** Model Equality Testing found
   **11 of 31** commercial Llama endpoints serving distributions that differ from Meta's released
   weights. DiFR cites Kimi K2 providers at 61-72% similarity to reference, and an Anthropic
   inference bug that degraded output for weeks before detection.
3. **Identity is far cheaper to check than correctness**, because it is a statistical question
   about a distribution rather than a reproducibility question about a computation. It sidesteps
   the entire float-determinism problem of the sibling essay.
4. **Sampling is the expensive mistake.** Derived from the published detection thresholds: a
   sampled token carries about **0.033 bits** of evidence about model identity; an activation
   fingerprint carries about **4.98 bits**. A factor of **150**. Verification built on generated
   *text* pays an enormous and avoidable information tax.
5. **The finding, and it reverses my own two earlier essays.** Both said FHE gives confidentiality
   and no integrity. That is true of FHE alone and **false of FHE plus an audit**: a provider that
   cannot read the prompt cannot tell an audit from a real request, so it must cheat on both or
   neither. Encryption is what makes the audit unevadable. In a plaintext API the provider *can*
   recognise audits -- the prompt sets are published -- and at perfect recognition **no audit rate
   whatsoever suffices**, not even checking every request.
6. **My gap-gated verification proposal from the sibling essay is not novel.** DiFR (Nov 2025)
   uses a clipped logit-gap margin for the same purpose, and does it better. Recorded in section 6
   and corrected in the sibling.

## 1. Two different questions

The sibling essay asked whether a server *computed correctly*, and hit a wall: honest providers
disagree numerically, so verification needs reproducibility that heterogeneous hardware does not
provide. The seed's question is narrower and the narrowing is the whole trick.

| question | what it needs | difficulty |
|---|---|---|
| did the server compute this output correctly? | reproduce the computation | blocked on cross-provider determinism |
| did the server run model $A$? | distinguish two probability distributions | **a statistics problem, and a cheap one** |

A different model is a different distribution over outputs. Distributions are testable from
samples, and no sample has to match any other sample exactly. Nothing in that argument mentions
reduction order, batch invariance or floating point.

This also matches the *economically real* attack. A provider does not benefit from corrupting one
answer; it benefits from systematically serving a cheaper model, which is precisely a persistent
distributional change. Identity testing is aimed at the attack that pays.

## 2. What already exists

Comprehensively, because the seed asks for something that has largely been built.

**Behavioural, black-box: Model Equality Testing** (Gao et al., ICLR 2025, arXiv 2410.20247).
Formulates "which model is this API serving" as two-sample testing between API completions and a
reference distribution. Maximum Mean Discrepancy with a simple string kernel on Hamming distance
between completions; **median 77.4% power** against a range of distortions using an average of
**10 samples per prompt**. Detects quantization, watermarking and fine-tuning. Needs only text
samples, so it works against any API. Empirically: **11 of 31** Llama endpoints tested in summer
2024 deviated from Meta's reference weights.

**White-box-ish, cheap: DiFR** (Karvonen et al., arXiv 2511.20621, Nov 2025).

- *Token-DiFR* compares generated tokens against a trusted reference implementation **conditioned
  on the same random seed**. Seed synchronisation tightly constrains valid outputs, so the tokens
  themselves become auditable evidence at **zero additional cost to the provider**. Detects 4-bit
  quantization at AUC > 0.999 **within 300 output tokens**.
- *Activation-DiFR* is the "footprint" of the seed: **random orthogonal projections compress
  activations into compact fingerprints**. AUC > 0.999 at **2 output tokens**, with 25-75% less
  communication than prior methods. Open-source vLLM integration.

**Ownership fingerprinting, which is a different problem and is worth not confusing with this
one.** Chain & Hash (ICLR 2026), REEF, Instructional Fingerprinting, TRAP: these implant a
signature *into* a model so its **owner** can prove someone else is serving their weights. The
direction is reversed -- the model owner is the verifier and the deployer is the suspect. For the
seed's question the *client* is the verifier and needs no cooperation from the model's author, so
the equality-testing and DiFR line is the relevant one. The two literatures use the word
"fingerprint" for both and the conflation is easy.

## 3. Why the activation fingerprint wins, quantified

**DERIVED, not measured here.** Inverting DiFR's two published detection thresholds through
Wald's sequential-test relation $n \approx \log((1-\beta)/\alpha)/\mathrm{KL}$ at
$\alpha=\beta=10^{-3}$:

| observable | $n$ to decide | implied KL (nats/obs) | bits/obs |
|---|---:|---:|---:|
| sampled token | 300 | 0.0230 | **0.033** |
| activation fingerprint | 2 | 3.4534 | **4.982** |

**A factor of 150 per observation.** The reason is information-theoretic and worth stating plainly:

A sampled token is **one draw** from the output distribution. It carries at most $\log_2 V$ bits,
and in practice far less, because a confident model puts nearly all its mass on one token and the
draw is then almost surely that token *whatever model produced it*. Confidence, which is what
makes a model useful, is exactly what destroys its identifiability from samples. An activation
vector is not a draw at all -- it is a direct, continuous, high-dimensional measurement of the
computation itself.

**So sampling is the lossy step, and any attestation scheme built on generated text is paying an
enormous and avoidable tax.** If the seed's "footprint" is to be built, build it on activations.

*Caveat on the inversion, since it is doing real work above:* Wald's relation assumes i.i.d.
observations and a simple-versus-simple test, while DiFR reports AUC. Treat the two absolute KL
figures as order-of-magnitude. The **ratio** is the robust part, because both rows are divided by
the same constant and it survives most choices of $\alpha,\beta$.

**How many observations in general**, at various separations:

| KL / obs | what it is | $\alpha=10^{-2}$ | $10^{-3}$ | $10^{-6}$ |
|---:|---|---:|---:|---:|
| 0.001 | same model, different kernel | 4595 | 6905 | 13816 |
| 0.023 | 4-bit quantization (derived above) | 200 | 300 | 601 |
| 0.1 | fine-tune or watermark | 46 | 69 | 138 |
| 1.0 | a genuinely smaller model | 5 | 7 | 14 |
| 3.45 | activation fingerprint of a quantized model | 2 | 2 | 4 |

Two structural readings. The top row is **good** news: telling a model apart from *itself* on
different hardware takes thousands of observations, so benign numerical divergence is not mistaken
for fraud -- merely slow to rule out. And tightening the false-accusation rate from $10^{-2}$ to
$10^{-6}$ only **triples** the sample size, because it enters logarithmically:

$$ N(\alpha/c) = N(\alpha) + \frac{\log c}{\mathrm{KL}} \veq{waldlog-dreamed}\lean $$

**Cheap certainty is available. Cheap speed is not.** You can afford to be nearly certain before
accusing a provider, which matters because a false accusation against an honest provider is the
failure mode that kills such a scheme socially.

## 4. The finding: encryption makes the audit unevadable

Everything above assumes the provider cannot tell an audit from a real request. Drop that.

Let the provider recognise an audit with probability $d$ and behave honestly for it. The effective
catch rate under audit rate $r$ becomes $r(1-d)$, so the rate needed to deter a provider saving
$s$ against a bond $D$ is $s/(D(1-d))$ -- strictly increasing in $d$, and unbounded:

| bond $D$ | $d=0$ | $d=0.5$ | $d=0.9$ | $d=0.99$ | $d=0.999$ |
|---:|---:|---:|---:|---:|---:|
| 10 | 8.86% | 17.7% | 88.6% | **impossible** | **impossible** |
| 100 | 0.89% | 1.77% | 8.86% | 88.6% | **impossible** |
| 1000 | 0.09% | 0.18% | 0.89% | 8.86% | 88.6% |
| 10000 | 0.01% | 0.02% | 0.09% | 0.89% | 8.86% |

"Impossible" is literal: **at $d=1$ no audit rate works, because the provider is honest exactly
when checked.** Auditing every single request fails.

$$ \text{view}(\text{audit}) = \text{view}(\text{real}) \implies \text{cheat on real} \Rightarrow \text{cheat on audit} \veq{auditblind-dreamed}\lean $$

**Now the composition.** In a plaintext API $d$ is large and structurally so: Model Equality
Testing publishes its prompt sets, benchmark-shaped queries are statistically obvious, and a
provider wanting to cheat has every incentive to keep a list. Under FHE the provider sees
ciphertext. It cannot distinguish an audit from a real request, **because distinguishing them is
exactly the task the encryption is assumed to prevent** -- the same IND-CPA property that makes
the scheme worth deploying at all. So $d = 0$ by construction.

**FHE does not merely fail to provide integrity. It is what makes an integrity audit unevadable.**
Confidentiality and integrity are complementary here, not orthogonal, and the composition runs in
the direction my two earlier essays asserted it did not. That correction is section 6.

The honest limit, which is in the Lean file as a definition rather than a hypothesis in use:
ciphertexts hide *values*, and nothing else. Timing, length, arrival pattern and account identity
are not hidden by encryption, and each is a channel by which an audit might still be recognised.
Audit indistinguishability is an assumption to be **engineered** -- audits must come from ordinary
accounts, at ordinary times, with ordinary lengths -- not a gift from the cryptography.

## 5. What the footprint costs to carry

Activation-DiFR compresses by random projection, and Johnson-Lindenstrauss bounds the width:
$k \ge 8\ln(m)/\varepsilon^2$ preserves pairwise distances among $m$ vectors to relative error
$\varepsilon$. Crucially **this depends on the number of vectors compared, not on the model's
width**, which is why overhead does not grow with model size:

| vectors $m$ | $\varepsilon=0.5$ | $0.3$ | $0.1$ |
|---:|---:|---:|---:|
| 10 | 74 | 205 | 1843 |
| 100 | 148 | 410 | 3685 |
| 1000 | 222 | 615 | 5527 |
| 10000 | 295 | 819 | 7369 |

A few hundred floats per checked token, against a hidden state of 4096 and a vocabulary of 128k.
(JL is famously loose; read the table as a ceiling.)

**And it composes with encryption almost for free.** A random projection is a **linear map**, so
under FHE it is a ciphertext-times-plaintext product -- the cheap kind, no relinearisation, no key
switching. From [`fhe-llm`](fhe-llm.md): under 6% of a transformer's multiplications are the
expensive ciphertext-ciphertext kind, and a projection is not one of them. **An encrypted
activation fingerprint costs the server essentially nothing beyond what it already pays.**

So the full stack is coherent: encrypted inference (confidentiality), encrypted activation
fingerprints returned alongside the result (attestation evidence), sampled client-side checking
against a reference (deterrence), and the encryption itself guaranteeing the provider cannot see
which requests are being checked.

## 6. Corrections to my own earlier essays in this batch

Both belong here rather than buried, because the batch is meant to be read as a whole.

**(a) Gap-gated verification is not novel.** [`trustless-distributed-ai`](trustless-distributed-ai.md)
section 4 proposes accepting a token on tolerance agreement when the top-2 margin exceeds
$2\varepsilon$. **DiFR does this**, published November 2025, and does it better: it uses a clipped
logit-gap margin as a *continuous statistic aggregated over tokens* rather than my binary
accept-or-escalate gate, and adds seed synchronisation, which I had not considered and which
constrains the provider far more tightly. My `argmax_stable` remains a correct theorem and a
useful statement of *why* the margin works; it is independently derived, not new. The sibling
essay has been corrected.

**(b) "FHE gives confidentiality and zero integrity" is too strong.** I wrote it in
[`fhe-llm`](fhe-llm.md) section 0 and again in the trustless essay. It is right about FHE in
isolation and wrong about the system: section 4 above shows encryption strictly *strengthens* a
sampled audit by removing the provider's ability to detect it. Both siblings now point here.

**(c) A methodological note, since the owner asked for this discipline explicitly.** My first
reading of DiFR came from an automated summary of the PDF, produced in response to a question I
had phrased as *"does it use a tolerance/margin criterion?"* -- a leading question. The summary
duly said yes, and also said DiFR "uses cryptographic techniques to verify", which is **false**:
Token-DiFR is a statistical test, not a cryptographic protocol. Checking the actual PDF confirmed
the margin (27 occurrences, a clipped logit-gap statistic) and refuted the cryptography. One of
two claims fabricated, and the fabricated one was the one I had not asked about. Ask non-leading
questions of summarisers, and verify against the source before building on either answer.

## 7. Where this leaves the seed

"How to trust a trustless server to actually run the LLM they promise" has a good answer, and it
is better than the answer to the harder question the previous essay asked:

- **Use activation fingerprints, not text.** 150x the evidence per observation, and linear under
  encryption so nearly free to compute homomorphically.
- **Sample, do not prove.** Two tokens per audited request, and audit a small fraction of requests
  chosen by the client.
- **Bond the provider.** With a bond worth a thousand requests, a 0.09% audit rate deters
  substituting an 8B for a 70B.
- **Encrypt, and the audit becomes unevadable.** This is the part that is not in the literature as
  far as I can find, and it is the one thing here I would call a contribution.
- **Do not confuse this with ownership fingerprinting.** Different verifier, different suspect,
  different literature.

What it does *not* give: it detects a **persistent** distributional change, which is the attack
that pays. It does not detect a provider that corrupts one specific answer for one specific user,
and no sampling scheme will. That needs per-request proof, which is zkML, which is four orders of
magnitude away.

## 8. Surfaced for the owner

Located, evidenced, not resolved. Nothing filed into any ledger.

1. **No owner content is touched.** This essay has no source in `crypto/` or `physics/`, locates
   no discrepancy, and proposes no edit to anything he wrote.
2. **Two corrections to earlier essays in this same batch** are recorded in section 6 and applied
   in the siblings. Flagged here because a reader of only one essay would otherwise carry away a
   claim this one retracts.
3. **The scope question is now overdue and is his to settle.** Three of the five essays in this
   cluster are systems security with no connection to physics or to `crypto/fhe.md`'s counting
   argument. They live in `docs/dreamed/` where nothing is committed to, but if any of this is to
   be *built*, `docs/dreamed/` is the wrong home for it. Options and a recommendation are in
   section 9; the decision is not mine to record.

## 9. If this is to be built: a staged plan

Offered because the owner asked what the next steps are. **Every stage is falsifiable and the
early ones are cheap**, which is the property that matters -- each stage's result decides whether
the next is worth starting.

| stage | what | cost | decides |
|---|---|---|---|
| **0** | Measure the real top-2 logit gap distribution on an open-weights model | an afternoon | whether the sibling essay's escalation-rate table is real. Also the cheapest possible first result |
| **1** | Reproduce Model Equality Testing against two endpoints of the same open model | a day; needs API credits | whether the 11-of-31 base rate still holds in 2026. A *measurement of the world*, publishable on its own |
| **2** | Activation fingerprints on a local model: project, store reference, detect a 4-bit swap | a few days; local GPU-free is fine at small scale | reproduces DiFR's headline claim, and gives a working fingerprint implementation |
| **3** | Encrypted-audit proof of concept: run stage 2's projection under an FHE library on a toy model | a week or two; Concrete-ML or OpenFHE | **the actual contribution** of section 4, and the only stage nobody has done |
| **4** | Integer-only model under BFV/BGV, per the sibling essay's convergence claim | weeks | whether exact FHE beats CKKS on an integer transformer -- the sibling's named falsifier |

Stage 3 is the one worth doing, and stages 0-2 exist to derisk it. Stage 4 is a separate bet.

## 10. Lean attestation

**File** [`docs/dreamed/lean/ModelAttestation.lean`](lean/ModelAttestation.lean). **Command**
`cd verify && ../docs/dreamed/capped.sh -m 6G -- lake env lean --threads=2 ../docs/dreamed/lean/ModelAttestation.lean`.
**Exit status `0`, `sorry` count `0`.** Mathlib is the rev pinned in `verify/lake-manifest.json`;
imports are narrow, no `import Mathlib`.

| Claim | Lean names | Status |
|---|---|---|
| audit blindness (section 4) | `Strategy`, `cheating_is_caught`, `passes_audit_is_honest` | proved |
| recognisable audits cost more | `requiredRate`, `requiredRate_mono` | proved |
| perfect recognition defeats any audit rate | `evasion_total` | proved |
| certainty is logarithmically cheap (section 3) | `waldN`, `waldN_log_cost` | proved |
| audits really are indistinguishable | `AuditIndistinguishable` | **definition only, deliberately unproved** |

`cheating_is_caught` is one rewrite, and I want that visible rather than dressed up: all the
content is in the hypothesis, and the essay's argument is that FHE *supplies* the hypothesis. It
is in Lean because stating it forced me to notice that the hypothesis is exactly IND-CPA, which is
what turned "FHE gives no integrity" into its opposite. `AuditIndistinguishable` is the honest
counterweight -- encryption hides values, not timing or length or identity.

`\veq` badges above attest against this dreamed file only, never against the repo's sidecar
machinery (`docs/dreamed/README.md` rule).

## 11. Follow-up leads

1. **Stage 3 above** (mechanizable, a week or two): an encrypted activation fingerprint end to
   end. This is the essay's own claim made real, and the only lead here I would prioritise.
2. **Quantify $d$ for real APIs** (mechanizable, medium): how well *can* a provider recognise
   audit traffic in practice, from prompt statistics, timing and account patterns? Section 4's
   table is worthless without a real value of $d$, and I have supplied none.
3. **Adaptive-adversary version of the deterrence game** (owner direction): a provider choosing
   when to cheat based on a posterior over being audited, rather than a fixed rate. Proof of
   Sampling's equilibrium is the right frame; my arithmetic is not.
4. **Fingerprint robustness against a provider who knows the projection** (mechanizable, and it
   may be fatal): if the projection matrix is public, can a cheating provider run the cheap model
   and forge fingerprints that match the expensive one? Secret or freshly-sampled projections
   presumably fix it, at a key-management cost. **I have not checked this and it could invalidate
   section 5.**

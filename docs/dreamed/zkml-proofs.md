---
title: "Dreamed: zkML, and the wall that is not where the batch put it"
permalink: /dreamed/zkml-proofs
---

# Dreamed: zkML, and the wall that is not where the batch put it

> **STATUS: DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](./). Written by an AI agent on
> 2026-09-04 from an owner-picked seed. Nothing here is theory or a correction; nothing moves into
> `crypto/` or the `verify/` machinery without the owner authoring the move. Claims about owner
> content live under [Surfaced for the owner](#11-surfaced-for-the-owner), located, never resolved.

**Seed (owner, this session):** *"if we find a FHE-LLM, next dream can be zero knowledge /
trustless distributed AI"* -- specifically the zkML half.

**Context.** Sixth of the session's FHE cluster and the direct follow-on to
[`model-attestation`](model-attestation.md), which ends: *"That needs per-request proof, which is
zkML, which is four orders of magnitude away."* My job was to establish whether that four orders is
**structural** or **engineering**. The answer changed both the number and the question.

Numbers from [`docs/dreamed/fhe-search/zkml_cost.py`](fhe-search/zkml_cost.py), run under
[`capped.sh`](capped.sh) (hard cgroup memory cap, no swap, CPU quota). Every input to that script is
somebody else's published measurement, named at the point of use; every output is arithmetic on
those inputs and is labelled DERIVED. Lean in
[`docs/dreamed/lean/ZkmlProofs.lean`](lean/ZkmlProofs.lean).

## 0. Summary

1. **The gap is engineering, and it is smaller than this batch said.** Measured against the
   plaintext forward pass of the same model on the same accelerator: **1671x to 6747x**, that is
   $10^{3.2}$ to $10^{3.8}$. Not four orders and rising -- three and a half, and falling.
2. **The scaling has no superlinear term, which is the whole test.** zkLLM's own pair: 7B takes
   620 s, 13B takes 803 s, identical hardware and sequence length. A **1.857x** parameter increase
   bought a **1.295x** time increase. Proving cost per parameter *fell*. A structural wall is the
   opposite inequality, and it is not there.
3. **This batch's "four orders" traced to a stale generation of proof system.** On one fixed task
   (prove GPT-2), Plonkish ZKML (EuroSys 2024) needs **4026 s**; GKR + Lasso zkGPT (USENIX Security
   2025) needs **21.8 s** on comparable CPU. **185x from changing the proof system**, in one year,
   with no new hardware. The 80-minute-nanoGPT figure the sibling essay quoted from opML is from
   February 2024 and predates both zkLLM and zkGPT.
4. **What dominates is the nonlinearities, exactly as under FHE and for a completely different
   reason.** zkGPT's own breakdown: lookups **55.5%**, both sumchecks together **40.8%**, the
   polynomial commitment **3.7%**. The linear algebra is nearly free for a structural reason worth
   naming -- Thaler's matrix-multiplication protocol proves an $n\times n$ product with $O(n^2)$
   extra work against the product's own $O(n^3)$, so **the prover does asymptotically less work
   than the computation it is proving.**
5. **Corollary nobody seems to draw: ZK hardware acceleration is aimed at the wrong 4%.** MSM/NTT
   accelerators attack the polynomial commitment. Amdahl on zkGPT's breakdown with the commitment
   made *infinitely fast*: **1.038x**. The lookup argument is the stage worth a chip.
6. **The real wall is semantic, not computational, and this batch had not noticed it.** A zkML proof
   over *private* weights certifies an **existential**: some weights consistent with the commitment
   produce this output. That is not "the promised model ran". The **Hollow-LLM attack** (arXiv
   2607.28884) instantiates the gap with ghost weights of the declared shape whose algebra collapses
   to a small model. So zkML answers the seed's question **only if the zero-knowledge over the
   weights is dropped** -- which is the property the provider wanted.
7. **Sampled zkML is the `d = 1` case of the preceding essay and would be worthless, except for
   ordering.** A demanded proof announces itself. Under that essay's evasion model no audit rate
   suffices. The fix is commit-then-challenge: the provider commits to the transcript when it
   serves, the challenge is drawn afterwards, and the recognition probability $d$ drops out of the
   arithmetic entirely. At a 1000x bond that is a **3.66x** total bill; at 10000x, **1.27x**.
8. **zkML and FHE are not exclusive -- they hide opposite operands.** FHE hides the client's input
   from the server, ZK hides the server's weights from the client. But the naive composition
   *multiplies*: $10^{3.5} \times 10^{3.5} \approx 10^{7}$. Proving in the FHE scheme's own algebra
   instead of simulating it (Fherret) keeps it near $10^{5.7}$.

## 1. Three different things, and they cost differently

The task asked me to separate these and it turned out to be the hinge of the essay.

| claim | what a proof gives you | cost |
|---|---|---|
| the **weights** were the committed ones | a commitment opening. Cheap, and not what anyone means | 3.7% of zkGPT's prover time |
| the **computation** was performed correctly *with respect to some admissible weights* | what zkML actually proves. Expensive | the entire remaining 96% |
| something about the **output** (it came from model $A$; it is not degraded) | **not provided**, and this is the finding | not purchasable at any price from the proof alone |

Row two is an existential statement. In the notation of the Lean file, a proof establishes
$\exists w,\ \mathrm{Admissible}(w) \wedge \mathrm{eval}(w, i) = o$, whereas the verifier wants
$\mathrm{eval}(w_0, i) = o$ for the *promised* $w_0$. Honesty implies the relation; the relation
does not imply honesty:

$$ \mathrm{eval}(w_0, i) = o \implies \exists w,\ \mathrm{eval}(w, i) = o \veq{zknp-dreamed}\lean $$

$$ \exists w,\ \mathrm{eval}(w,i) = o \ \not\Longrightarrow\ \mathrm{eval}(w_0, i) = o \veq{zkgap-dreamed}\lean $$

The counterexample is one line and it is in the Lean file, deliberately trivial: the point is not
that the gap is deep, it is that the implication people read into a zkML proof is false and that
saying so takes no cleverness.

**The instantiated attack.** *Hollow-LLM* (arXiv 2607.28884) makes it concrete. A provider declares
a large architecture and parameter count, commits to weights of exactly that shape, and serves from
a much smaller effective model; the committed "ghost weights" have an algebraic structure that
collapses the computation. Its own framing is the sentence to keep:

> the proof certifies membership in a nondeterministic polynomial-time (NP) relation [...] the proof
> does not attest to the algorithmic path taken to obtain that result or how much computation was
> necessary.

Measured asymmetry in that paper: serving cost stays at **1x** while an honest large model pays
**2.4-3.1x**, and ZK proving cost scales with the *declared* model, up to **5.89x**. Note what that
last figure means for the economics -- the attacker still pays full proving cost, so the attack
pays only when proving is rare. Which is exactly the sampled regime section 6 recommends. I read
that as a caution on my own recommendation, not as a refutation of the paper.

**And the fix, which is also in Lean.** If the admissible set is the singleton $\{w_0\}$ -- the
commitment opens to a *publicly known* weight vector, as it can for any published checkpoint -- the
existential collapses and the proof does certify identity:

$$ \mathrm{Admissible} = \{w_0\} \ \wedge\ \exists w \in \mathrm{Admissible},\ \mathrm{eval}(w,i)=o \implies \mathrm{eval}(w_0,i)=o \veq{zkpin-dreamed}\lean $$

**So the zero-knowledge property over the weights is precisely what costs you the identity
guarantee.** It is not an incidental feature: zkGPT's own introduction gives the motive plainly
("the model parameters are trade secrets"). A provider that will publish its weights can prove it
ran them. A provider that will not, cannot -- and no improvement in prover speed changes that,
because the obstruction is a quantifier, not a cost.

This is the answer to the seed's question that I did not expect to be writing. The batch has spent
two essays treating zkML as the expensive-but-sound endpoint of integrity. For **open-weights**
models it is. For the commercial case that motivated the whole thread, it is sound about the
computation and silent about the model.

## 2. The measured gap

Every row an outside measurement, with the derivation of the last two columns stated.

**Anchors.** zkLLM (Sun, Li, Bi, Ai, Zhang; arXiv 2404.16109), Table 1: NVIDIA A100-SXM4 40 GB,
sequence length 2048 from C4, one full forward pass, 22.9-23.1 GB prover memory.

| model | prover | verifier | proof |
|---|---:|---:|---:|
| LLaMa-2-7B | 620 s | -- | -- |
| LLaMa-2-13B | 803 s | 3.95 s | 188 kB |
| OPT-13B | 713 s | 3.71 s | 160 kB |

zkGPT (Qu, Sun, Liu, Lu, Guo, Chen, Zhang; USENIX Security 2025; eprint 2025/1184): GPT-2 (124M),
input $32\times768$ so **sequence length 32**, Intel Xeon 6126 16-core with 32 threads. **21.8 s**
prover, **0.35 s** verifier, **101 kB** proof. Quantisation level $Q=16$, with perplexity increase
under 0.5 on WikiText-2, PTB and LAMBADA.

**DERIVED overhead.** Plaintext baseline $2NT$ FLOPs divided by the accelerator's peak, and again
at a stated MFU, because the honest answer is a range:

| system / model | prover s | plaintext s | x at MFU 1.0 | x at realistic MFU |
|---|---:|---:|---:|---:|
| zkLLM LLaMa-2-7B | 620 | 0.092 | 6747 | 2699 |
| zkLLM LLaMa-2-13B | 803 | 0.171 | 4705 | 1882 |
| zkLLM OPT-13B | 713 | 0.171 | 4178 | 1671 |
| zkGPT GPT-2 (CPU) | 21.8 | 0.001 | 28019 | 2802 |

**$10^{3.22}$ to $10^{3.83}$ at LLM scale.** The assumptions are the MFU column (0.4 for the A100
rows, 0.1 for the CPU row, the latter chosen deliberately low so as not to flatter the prover) and
the $2NT$ FLOP count, which ignores attention's quadratic term and so *understates* the plaintext
baseline. Both choices push the reported overhead up rather than down.

## 3. Structural or engineering: the test, and the answer

The test is not "is it slow". It is **whether the overhead ratio grows with model size**. A
constant factor, however large, is an invoice. A widening ratio is a wall.

The criterion is arithmetic and worth stating once precisely, because it is easy to argue past:

$$ t_2 p_1 < t_1 p_2 \ \wedge\ p_1, p_2 > 0 \implies \frac{t_2}{p_2} < \frac{t_1}{p_1} \veq{perparam-dreamed}\lean $$

Sublinear growth in total cost and shrinking cost per parameter are the same statement. Inference
cost is proportional to parameters, so "cost per parameter" *is* the overhead. Now the data.
zkLLM ran two models of the same family on identical hardware at identical sequence length, which
is as clean an isolation of model size as the literature offers:

| candidate cost model | predicted 7B -> 13B ratio | observed | error |
|---|---:|---:|---:|
| cost proportional to parameters | 1.857 | 1.295 | +43.4% |
| cost proportional to activations $L\,T\,d$ | 1.562 | 1.295 | +20.6% |
| cost proportional to layer count | 1.250 | 1.295 | -3.5% |

**A 1.857x parameter increase bought a 1.295x time increase.** Sublinear. There is no superlinear
term visible anywhere in the published data.

**The caveat is load-bearing and I want it read.** $n = 2$. One family, one sequence length, one
implementation. This **rules out** "cost proportional to parameters"; it does **not establish**
"cost proportional to layers", and I have not fitted anything, because two points cannot fit two
exponents. The claim I am making is the weak one, and the weak one is sufficient: nothing in the
measurements has the shape of a structural wall.

**And a mechanism for why, which is the part that makes me believe the measurement rather than
merely report it.** Thaler's matrix-multiplication protocol (CRYPTO 2013, arXiv 1304.3812): the
prover *computes the output and then does $O(n^2)$ additional work* to prove an $n \times n$
product correct. The product itself is $O(n^3)$. **Proving a matrix multiplication is
asymptotically cheaper than performing it.** zkLLM states the same property for its own tensor
sumchecks: they "achieve less complexity than the computation process itself". So as models get
wider, the linear-algebra half of the proving overhead does not merely stay constant, it *shrinks
relative to inference*.

That is the structural fact underneath the sublinear measurement, and it is the opposite of what
"zero-knowledge proofs are astronomically expensive" leads one to expect.

## 4. Where the time actually goes

zkGPT publishes a component breakdown (its Table 5, fully-optimised column). Normalised:

| component | s | share |
|---|---:|---:|
| commit advice (weights and intermediates) | 0.8 | **3.7%** |
| GKR layer sumcheck (linear algebra) | 5.7 | 26.1% |
| combine sumcheck (linear algebra) | 3.2 | 14.7% |
| Lasso lookups (softmax, GeLU, norm, rounding) | 12.1 | **55.5%** |

**Nonlinearities beat linear algebra 1.36 to 1, and the commitment is noise.**

Three readings, in increasing order of how much I would defend them.

**(a) It answers the task's question 3(b) in the negative.** The candidate hypothesis was that
proving cost might be dominated by the commitment rather than the evaluation. In a Plonkish system
that is roughly true. In the fastest published LLM prover it is 3.7%.

**(b) It converges with the FHE siblings, by a different mechanism.** [`fhe-llm`](fhe-llm.md)
found that under 6% of a transformer's multiplications are the expensive ciphertext-ciphertext kind
and concluded "an FHE-LLM is not hard because of its matrix multiplies; it is hard because of the
nonlinearities". Here the linear algebra is cheap because the sumcheck prover is sublinear in the
matmul's own work, and the nonlinearities are expensive because a lookup argument must commit to
per-element witness data. Different reason, same verdict. Two independent cryptographic regimes
agreeing that **the transformer's hard part is `softmax`, `GeLU` and normalisation, not
`matmul`**, is worth more than either finding alone.

**(c) Amdahl on the hardware effort, which I think is a genuinely contrarian conclusion.** ZK
accelerators -- Cysic's C1, SZKP (arXiv 2408.05890), ZK-Flex -- target MSM and NTT, and the reported
kernel speedups are large: the ASIC literature quotes roughly 5x end to end with up to 77.7x on
individual MSM kernels, and GPU provers up to 17.6x over prior GPU provers. *(Those two figures come
to me through a search summary of that literature rather than from the papers themselves; I have not
opened them, and they are illustrative here rather than load-bearing.)* But MSM is the
*commitment*. With the commitment made infinitely fast, zkGPT's total speedup would be:

| stage made free | best possible speedup |
|---|---:|
| commitment (what MSM/NTT accelerators attack) | **1.04x** |
| combine sumcheck | 1.17x |
| GKR layer sumcheck | 1.35x |
| Lasso lookups | **2.25x** |

**An accelerator built for MSM buys a GKR + Lasso prover about four percent.** The hardware
programme and the fastest software are pointed at different components. I would want this checked
before it is believed -- the numbers are exact but the premise is that zkGPT's mix is
representative -- and it is follow-up lead 3.

## 5. The asymmetries that help

The task asked whether zkML has asymmetries analogous to the ones the siblings found. It has four,
and they compound.

**(a) Verification is nearly free and nearly constant.** zkGPT: **0.35 s**, **101 kB** for GPT-2.
zkLLM: **3.95 s**, **188 kB** for a 13B model. A **105x** larger model costs the verifier about
**11x** and grows the proof under **2x**. Whoever is checking does not need the accelerator that
did the work; a phone can verify a 13B inference. This changes who can afford to be the verifier,
which is a governance fact more than a performance one -- zkGPT's own framing is regulators
querying anonymously and demanding proofs.

**(b) Proving is off the critical path.** The proof systems here are non-interactive. The provider
serves the answer at full speed and produces the proof afterwards, in a batch, on cheaper hardware,
overnight. This is the sharpest contrast with the confidentiality half: FHE latency is *on* the
path and *sequential*, one encrypted forward pass per token with nothing amortising between them
([`fhe-llm`](fhe-llm.md) section 4). Integrity cost is deferrable; confidentiality cost is not.

**(c) The autoregressive penalty that ruins FHE does not obviously apply.** *DERIVED ESTIMATE,
assumptions stated:* generating $n$ tokens with a KV cache costs about the same total FLOPs as one
prefill pass over $n$ tokens, to within the causal-masking factor. If proving cost tracks circuit
size, proving a whole generation should cost roughly what zkLLM's 2048-token forward pass cost --
one proof, not $n$ proofs. **I have no measurement of this.** Every published LLM zkML number I
found proves a forward pass, not a decode loop with a growing cache, and the cache is exactly the
structure that could break the estimate. Follow-up lead 1.

**(d) Integrity can be sampled.** The sibling essays' central economic point, and section 6 is
about whether it survives contact with zkML.

## 6. Sampled proving, and the ordering trap

[`model-attestation`](model-attestation.md) section 4 shows that if a provider can recognise an
audit with probability $d$ and behave honestly for it, the audit rate needed to deter it is
$s/(D(1-d))$, unbounded as $d \to 1$, and at $d = 1$ **no rate whatsoever works**.

**Sampled zkML sits at $d = 1$.** A demanded proof announces itself. The provider learns exactly
which requests are checked, at the moment it is asked to prove them. Read naively against the
preceding essay, sampled zkML deters nothing at all -- which would be a flat contradiction between
two essays of the same batch.

**The resolution is ordering, not cryptography, and I want to be clear that it is standard.**
Commit-then-challenge: the provider publishes a binding commitment to the transcript when it
*serves*, and the challenge is drawn afterwards. The cheat decision is then taken before the audit
decision exists, so $d$ never enters:

$$ \frac{s}{D} \ \le\ \frac{s}{D(1-d)} \quad \text{for } 0 \le d < 1 \veq{commitrate-dreamed}\lean $$

with strict inequality as soon as $d > 0$. This is how NanoZK's layerwise SHA-256 commitments work,
how optimistic systems' fraud-proof bisection works, and how Fiat-Shamir works. **It is not new.**
What is new, or at least not stated anywhere I looked, is the *interaction*: the preceding essay's
recognition model makes self-announcing audits catastrophic, and zkML's audits are maximally
self-announcing, so commit-then-challenge is not a nicety for zkML -- it is the only thing standing
between sampled zkML and uselessness.

**The bill, DERIVED**, at 3000x proving overhead (midpoint of section 2) and the sibling's
deterrence rates $q = s/D$ for substituting an 8B for a 70B ($s = 0.886$):

| bond $D$ | audit rate $q$ | total bill |
|---:|---:|---:|
| 10x | 8.86% | 266.80x |
| 100x | 0.886% | 27.58x |
| 1000x | 0.0886% | **3.66x** |
| 10000x | 0.0089% | **1.27x** |

$$ r \le F/\mathrm{ov} \implies 1 + r\cdot\mathrm{ov} \le 1 + F \veq{amortised-dreamed}\lean $$

and, in the limit that matters, a large enough bond brings the bill within any $\varepsilon$ of
honest serving **at fixed proving overhead**:

$$ \forall \varepsilon > 0,\ \exists D > 0:\ 1 + \frac{s}{D}\mathrm{ov} < 1 + \varepsilon \veq{bondlimit-dreamed}\lean $$

**So the answer to "does sampling rescue zkML" is yes, and the 3000x is not the operative number.**
The per-request cost sets an exchange rate between *capital* (the bond) and *compute*; it does not
by itself decide affordability. A 1000x bond -- for an API request, a few thousand dollars -- makes
verifiable inference a 3.66x business, today, with published 2025 systems. That is a very different
conclusion from "four orders of magnitude away".

**The honest caveats, three of them.** The bond must be forfeitable, which needs a dispute
mechanism the cryptography does not supply. The challenge must be unpredictable -- a deterministic
client sampling schedule, or one seeded from anything the provider supplies, restores $d = 1$
exactly. And Hollow-LLM cuts here specifically: rare proving is the regime in which its attack pays,
because the attacker's proving cost is amortised away along with the honest provider's.

## 7. Composition with FHE: not exclusive, but do not multiply

The task asked whether proving a computation over data you cannot see is a fatal tension. It is not,
and the reason is a clean one:

**FHE hides the client's input from the server; zero-knowledge hides the server's weights from the
client. They protect opposite operands.** That is why they compose at all: neither is trying to hide
anything from the party that needs it. The server proves statements about ciphertexts it can
manipulate but not read; the client verifies statements about weights it cannot see; and FHE's own
correctness carries the conclusion from the ciphertext computation back to the plaintext one.

The tension is arithmetic instead, and it is severe:

| route | overhead against plaintext |
|---|---:|
| FHE alone | $10^{3.5}$ |
| zkML alone | $10^{3.5}$ |
| **naive zk-over-FHE** (prove the homomorphic circuit) | $\mathbf{10^{7.0}}$ |
| FHE + native proof (Fherret's ~140x) | $10^{5.7}$ |

$$ 1 \le a \ \wedge\ 1 \le b \implies a \le ab \ \wedge\ b \le ab \veq{compose-dreamed}\lean $$

The trivial lemma is in Lean because the design conclusion rests on it and the trivial direction is
the one people skip. Naive composition expresses the FHE evaluation as the arithmetic circuit to be
proved, so the two overheads multiply and you are paying for two separately hard problems at once.
The alternative is to prove in the FHE scheme's own algebra: *Fherret* (CiC 2025) reports prover
overhead of roughly **110-170 homomorphic evaluations** of random functions with verifier overhead
**58-93**, an additive factor over FHE rather than a multiplicative one against plaintext. The
blind-hash vFHE line (arXiv 2303.08886) reports about **4%** overhead for a diagonal matrix
multiplication at $n = 64$, worst case under 5x at $n = 1$. Frameworks exist (`circomlib-FHE`,
`zkOpenFHE`).

**One structural observation I did not find made anywhere, offered for demolition.** Under FHE the
provider's weights are already the only plaintext in the system, and the *client's* privacy is
supplied by the encryption. The zero-knowledge property is therefore doing work only for the
provider's trade secret -- and section 1 showed that exact property is what destroys the identity
guarantee. So in the FHE composition specifically, **there is a coherent design in which the model
is public and only the input is private**: the client gets confidentiality from FHE, the client gets
identity attestation from a *non*-zero-knowledge proof against a public weight commitment, and the
proof gets cheaper because the commitment opens publicly. What is lost is exactly the provider's
secrecy, which was never the owner's goal in the seed. Whether the resulting scheme is coherent
against a real adversary I have not checked; it is follow-up lead 2.

## 8. Verdict on the seed's question

**Engineering, with a semantic wall behind it that costs more than the engineering does.**

The cost gap is an invoice: a constant factor of $10^{3.2}$ to $10^{3.8}$, sublinear in model size,
with the linear-algebra half asymptotically free by Thaler's protocol, with 185x of it removed by a
single change of proof system inside one year, with verification already essentially free, with
proving off the critical path, and with sampling plus a bond converting it into a 1.3x to 3.7x
business today. Nothing in that list is a theorem against it. The batch's earlier framing --
"four orders of magnitude", "too slow for LLM scale today" -- was measured against February 2024
Plonkish systems and did not survive contact with the 2024-2025 GKR literature.

The wall that *is* real: with private weights a zkML proof does not say the promised model ran. It
says a model of the declared shape ran. Those differ, provably, and Hollow-LLM builds the
difference on purpose. The only known closure is to make the weights public, which is a commercial
decision and not a cryptographic one -- so the seed's question, for a commercial provider, is
answered by statistics (the preceding essay's activation fingerprints) and not by proofs.

**Ranked, and these are recommendations, never decisions:**

| goal | mechanism | status |
|---|---|---|
| prove an **open-weights** model ran, per request | zkML against a **public** weight commitment | available now; 3.66x at a 1000x bond |
| detect a **persistent** substitution by a closed provider | activation fingerprints + sampled audit, [`model-attestation`](model-attestation.md) | available now, and cheaper |
| prove a **closed-weights** provider ran its promised model | **nothing known** | Hollow-LLM; not a cost problem |
| encrypted **and** verified inference | FHE + native proof, never zk-over-FHE | $10^{5.7}$; research |

## 9. Corrections to earlier essays in this batch

Both belong here rather than buried, because the batch is meant to be read as a whole and because
this makes four retractions across six essays.

**(a) "zkML is four orders of magnitude away" is wrong twice over.**
[`model-attestation`](model-attestation.md) section 7 and
[`trustless-distributed-ai`](trustless-distributed-ai.md) section 7 both rest on opML's comparison,
which reports a 1M-parameter nanoGPT taking about 80 minutes to prove. opML's paper is February
2024. zkLLM appeared in April 2024 and proves **13B** in 803 s; zkGPT appeared at USENIX Security
2025 and proves GPT-2 in 21.8 s on a CPU. The correct statement is $10^{3.2}$ to $10^{3.8}$ in
*overhead*, sublinear in model size, and the sibling's "too slow for LLM scale today" should read
"affordable today when sampled". *(I was unable to re-verify opML's exact nanoGPT figure from the
paper itself -- the abstract does not contain it and the HTML version 3 returns 404. I therefore
report it as what the sibling essay quoted, and my correction stands on the zkLLM and zkGPT numbers
rather than on refuting opML's.)*

**(b) "zkML is the soundest mechanism, the only one with no trust assumption."**
[`trustless-distributed-ai`](trustless-distributed-ai.md) section 7's table says this. It is right
about the *computation* and wrong about the *model*, and the seed's question is about the model.
Section 1 above is the correction.

**(c) A tension the preceding essay could not have seen, resolved rather than retracted.** Its
$d$-recognition argument makes self-announcing audits catastrophic; zkML audits are maximally
self-announcing; so the two essays together appeared to say sampled zkML is worthless. Section 6
resolves it by ordering, and the resolution is standard practice rather than a repair I invented.
Flagged because a reader of both essays and not this one would carry away the contradiction.

**(d) A methodological note, since the owner asked for this discipline explicitly and it earned
its place three times this session.**

- A search summariser told me Halo2 "proving time scales sub-linearly", and offered as evidence
  that constraints grew 7.353x while proving time grew 22.5x. Those numbers are *superlinear*. The
  label contradicted its own data. I could not source the underlying measurement and have not used
  it as an anchor.
- NanoZK's comparison table lists zkLLM at **15.8 s** while zkLLM's own Table 1 says **803 s**. Both
  are correct: the 15.8 s row is zkLLM measured on **GPT-2** in zkGPT's Table 3, which NanoZK
  reproduces. I spent a while believing zkLLM's headline was inconsistent before finding the
  original. **When two papers disagree by 50x about the same system, suspect the task and not the
  measurement.**
- A first fetch of zkLLM's abstract returned two sentences marked "verbatim" and then paraphrase
  presented in the same register. The paraphrase was accurate; that it was indistinguishable from
  the quotation is the hazard.

## 10. What is already known, and what this essay adds

**Known and cited above**, none of it mine: the systems (zkLLM arXiv 2404.16109; zkGPT USENIX
Security 2025 / eprint 2025/1184; ZKML EuroSys 2024; NanoZK arXiv 2603.18046; EZKL), the proof
machinery (Thaler's matmul protocol CRYPTO 2013; GKR; linear-time GKR provers via zkCNN; Lasso,
EUROCRYPT 2024; Hyrax), the attack (Hollow-LLM arXiv 2607.28884), the FHE composition (Fherret
CiC 2025; vFHE arXiv 2303.08886), the hardware programme (SZKP arXiv 2408.05890; Cysic), and the
deterrence framing (Proof of Sampling arXiv 2405.00295, via the siblings). The commit-then-challenge
ordering fix is textbook.

**What I think this essay contributes, offered for the owner to knock down:**

1. **The structural-versus-engineering question answered with the right test.** Not "is it slow"
   but "does the overhead ratio grow", applied to zkLLM's own 7B/13B pair, with the criterion
   stated precisely enough to be in Lean. The answer is sublinear and the mechanism is Thaler's
   protocol.
2. **The Amdahl argument against the ZK hardware programme's target.** MSM acceleration buys a
   GKR + Lasso prover 1.04x. I did not find this said anywhere, and it is exact arithmetic on
   published numbers, so it should be easy to refute if wrong.
3. **The convergence with the FHE siblings on nonlinearities.** Two unrelated cryptographic regimes
   independently finding that the transformer's hard part is `softmax`/`GeLU`/`norm` and not
   `matmul`. Neither finding is mine; noticing that they are the same finding may be.
4. **The interaction between the preceding essay's $d$-recognition model and zkML's self-announcing
   audits**, and that commit-then-challenge is therefore load-bearing rather than hygienic.
5. **Reading Hollow-LLM as the actual answer to the seed**, rather than as a footnote on zkML: the
   seed asked how to know the promised model ran, and the honest answer is that a proof cannot tell
   you unless the weights are public. Hollow-LLM is a July 2026 paper and I would be unsurprised if
   this reading is already in the literature; I did not find it stated as a limit on *attestation*
   rather than as an attack on *provers*.

**And what it does not add:** every measurement here is somebody else's. This essay ran no prover,
loaded no model, and measured nothing. It is arithmetic and reading.

## 11. Surfaced for the owner

Located, evidenced, not resolved. **No finding or verdict here was filed into any ledger.** The
batch carries one neutral pointer (`TODO.md` `id:6646`) that lists these rulings AS PENDING, which
is how it stays visible to `/relay human` without anything being recorded as decided.

1. **No owner content is touched, and no discrepancy in owner content was found.** Stated
   explicitly so the absence is not read as an omission. This essay has no source in `physics/`,
   `essays/` or `crypto/`; it critiques nothing the owner wrote; it proposes no edit to any of it.
   Its corrections in section 9 are to **my own** earlier essays in this batch.
2. **Four retractions now stand across this cluster's six essays** (two in
   [`model-attestation`](model-attestation.md) section 6, two here). Flagged as a pattern rather
   than as four incidents: every one came from checking a number against its source rather than
   against a summary, and the batch would have been wrong in print without that discipline. The
   owner may reasonably read that as a reason to trust the cluster more, or less.
3. **The scope question, third time of asking, and it is his alone.** Six of this session's essays
   are systems security with no connection to physics or to `crypto/fhe.md`'s counting argument.
   `docs/dreamed/` commits to nothing, so nothing is broken by leaving them; but if any of it is to
   be built, this is the wrong home. I have not recorded a preference and will not.

## 12. Lean attestation

**File** [`docs/dreamed/lean/ZkmlProofs.lean`](lean/ZkmlProofs.lean). **Command**
`cd verify && ../docs/dreamed/capped.sh -m 6G -- lake env lean --threads=2 ../docs/dreamed/lean/ZkmlProofs.lean`.
**Exit status `0`, `sorry` count `0`.** Mathlib is the rev pinned in `verify/lake-manifest.json`;
imports are narrow, no `import Mathlib`.

| Claim | Lean names | Status |
|---|---|---|
| sublinear growth means shrinking overhead (section 3) | `perParam_decreasing`, `perParam_increasing` | proved |
| an honest run implies the proven relation (section 1) | `Certifies`, `ProvenRelation`, `certifies_implies_relation` | proved |
| the relation does **not** imply identity -- the Hollow-LLM gap | `relation_not_certifies` | proved (explicit counterexample) |
| a public weight pin closes it | `pinned_relation_certifies` | proved |
| commit-then-challenge beats blind auditing (section 6) | `requiredRateCommit`, `requiredRate_commit_le`, `requiredRate_commit_lt` | proved |
| a budget buys an audit rate; a bond buys near-free integrity | `amortised`, `amortised_budget`, `amortised_bond_tendsto_one` | proved |
| naive zk-over-FHE multiplies (section 7) | `naive_composition_costly` | proved |
| the overhead really is a constant factor, for all model sizes | `ConstantFactorOverhead` | **definition only, deliberately unproved** |
| the challenge really is unpredictable to the provider | `ChallengeUnpredictable` | **definition only, deliberately unproved** |

The pair `relation_not_certifies` / `pinned_relation_certifies` is the file's reason for existing.
Both are short, and the counterexample is deliberately as small as the statement allows -- the value
is not depth, it is that the implication a zkML proof is *read* as giving is false, and that the
only known repair is to delete the quantifier by publishing the weights. Writing it forced the
essay's verdict to change: I had drafted a cost-only conclusion.

The two definitions are the honest counterweights, and the second is the more dangerous. Ordering
only helps while the commitment binds and the challenge cannot be predicted; a deterministic
sampling schedule restores exactly the $d = 1$ failure section 6 removes.

`\veq` badges above attest against this dreamed file only, never against the repo's sidecar
machinery ([`docs/dreamed/README.md`](./) rule).

## 13. Follow-up leads

1. **Prove an autoregressive decode loop, not a forward pass** (mechanizable, medium; and it gates
   section 5(c)). Every published LLM zkML number proves a prefill. Generation with a growing KV
   cache is a different circuit shape, and the cache is exactly what could break the "one proof per
   completion" estimate. **Decides** whether the whole essay's cost figures transfer to the setting
   anyone actually cares about. If they do not, section 8's verdict weakens substantially.
2. **The public-model / private-input composition** (owner direction, then mechanizable). Section 7
   sketches a scheme where FHE supplies the client's privacy and a *non*-zero-knowledge proof
   against a public weight commitment supplies identity attestation. **Decides** whether the
   Hollow-LLM wall can be walked around in the encrypted setting rather than merely named. Needs an
   adversary model before it needs code, which is why it is owner direction first.
3. **Refute or confirm the Amdahl argument** (mechanizable, cheap). Get component breakdowns from
   two or three more GKR-based provers and check whether zkGPT's 3.7% commitment share is
   representative. **Decides** whether summary point 5 is a finding or an artefact of one system,
   and it is the claim here most likely to be wrong.
4. **Measure the Hollow-LLM attack's actual economics** (mechanizable, medium). The paper reports
   the attacker still pays proving cost scaling with the *declared* model, up to 5.89x. Under the
   sampled regime of section 6 that cost is amortised away. **Decides** whether sampling makes the
   attack more attractive, which would be an argument against my own recommendation and is the
   reason it is here.
5. **Whether any of this belongs in toesnail** (owner-only, gating). See surfaced item 3, and the
   identical item in both siblings. Three essays have now deferred it.

---
title: "Dreamed: routes to trustless distributed AI, and which walls are real"
permalink: /dreamed/fhe-llm
---

# Dreamed: routes to trustless distributed AI, and which walls are real

> **STATUS: DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](./). Written by an AI agent on
> 2026-09-04 from an owner-picked seed. Nothing here is theory or a correction; nothing moves into
> `crypto/` or the `verify/` machinery without the owner authoring the move. Claims about owner
> content live under [Surfaced for the owner](#8-surfaced-for-the-owner), located, never resolved.

**Seed (owner, this session):** *"a second goal is fhe-LLMs, i.e. encrypted input processed by an
untrusted cloud-LLM such that the result needs decryption, but I'm not even remotely sure how that
can work properly with tokenization, attention mechanism and so on"*, sharpened mid-session to:
*"follow the 'everyone said it's impossible, till someone who didn't know made it anyway' approach
to some healthy extent. The goal is clear, be creative about finding a way to the trustless
distributed AI, also consider other approaches than FHE-LLM if not possible (or even if, multiple
methods are better)."*

Numbers from [`docs/dreamed/fhe-search/llm_cost.py`](fhe-search/llm_cost.py) (exact operation
counts times published per-operation costs -- an **estimate**, with every anchor named). Lean in
[`docs/dreamed/lean/FHESoftmax.lean`](lean/FHESoftmax.lean).

## 0. Summary

Taking the seed's spirit seriously means first separating the walls that are theorems from the
walls that are invoices, because only one kind deserves respect.

**Proven impossible** (do not attempt): virtual black-box obfuscation in general (Barak et al.
2001, see the sibling essay [`fhe-encrypted-algorithm`](fhe-encrypted-algorithm.md)); security for
any deterministic algebraically homomorphic scheme (Boneh-Lipton 1996, see
[`fhe-toy-enumeration`](fhe-toy-enumeration.md)).

**Merely expensive** (attempt freely): *everything about FHE-LLM*. There is no theorem against it.
The gap is $10^3$ to $10^4$ in latency and about $10^6$ in bandwidth, and it is engineering.

And "trustless" is two requirements, not one, which the FHE framing hides:

| requirement | question | answer technology | status |
|---|---|---|---|
| **confidentiality** | can the server read my prompt? | FHE, MPC, TEE | expensive / deployed-with-caveats |
| **integrity** | did the server actually run the model it claims? | sampled auditing, model attestation, zero-knowledge proofs | separate, and **complementary** rather than orthogonal -- see [`model-attestation`](model-attestation.md) section 4 |

FHE gives the first and **nothing at all** of the second: a malicious server can homomorphically
evaluate a *different, cheaper* model and the client cannot tell.

*(Partially retracted in [`model-attestation`](model-attestation.md) section 4. "Nothing at all"
is right about FHE in isolation and wrong about the system: since the provider cannot read the
prompt, it cannot recognise an audit request, so encryption strictly **strengthens** sampled
integrity checking. Read the two together.)* For "trustless distributed AI"
as a goal, that is the more interesting half and the less discussed one.

Six levers below cut real cost, four of them from an architectural split this essay argues for,
and section 5 lays out five routes with honest verdicts. The strongest single conclusion:
**the client should own the entire vocabulary boundary**, and doing so is cheap, removes a whole
class of side channel, and eliminates one of the two softmaxes outright.

## 1. Answering the seed's own worry: tokenization and attention

The owner's stated doubt was tokenization and the attention mechanism. They turn out to be the
easy one and the hard one respectively, and not in the expected order.

**Tokenization is a non-problem, and it is a non-problem specifically under FHE.** The tokenizer
is public model data. The client tokenizes its own plaintext on its own machine and encrypts token
ids -- or better, embeddings (section 2). The server never sees a vocabulary lookup.

This is worth dwelling on because the recent literature reads the opposite way and I nearly copied
it. **OTRO** (arXiv 2606.17358, USC/Roblox/NVIDIA, June 2026) hardens the tokenizer with
square-root ORAM because **TDXRay** demonstrated end-to-end prompt reconstruction at over 90%
similarity on production Intel TDX by watching tokenizer memory *addresses*. Read the threat model
before importing the conclusion: OTRO's adversary is a malicious hypervisor under a confidential
VM, where the server tokenizes **plaintext inside an enclave** and leaks the address trace of a
hash-map lookup. There is no analogue under FHE, because the untrusted side never holds a
plaintext address to leak. OTRO itself explicitly separates its channel from token-*length*
attacks. So the correct reading is the reverse of the alarming one: **the whole enclave
access-pattern side-channel class is absent by construction under FHE**, and that is one of the
few places FHE strictly beats a TEE rather than merely costing more than one.

**Attention is where the difficulty actually is**, and the reason is precise. Model weights are
public -- the server owns them -- so nearly every multiplication has one plaintext operand, which
under CKKS needs no relinearisation and no key switching. The two products inside attention,
$QK^\top$ and the $PV$ contraction, have *both* operands derived from the encrypted input. At
context 512, one decoded token:

| model | ct $\times$ pt mults | ct $\times$ ct mults | ct $\times$ ct share |
|---|---:|---:|---:|
| GPT-2 small (124M) | $1.518\cdot10^{8}$ | $9.437\cdot10^{6}$ | 5.85% |
| GPT-2 XL (1.5B) | $2.046\cdot10^{9}$ | $7.864\cdot10^{7}$ | 3.70% |
| Llama-3 8B | $8.310\cdot10^{9}$ | $1.342\cdot10^{8}$ | 1.59% |
| Llama-3 70B | $7.890\cdot10^{10}$ | $6.711\cdot10^{8}$ | 0.84% |

**Under six percent of the multiplications are the hard kind, and the share falls below one
percent at 70B scale** -- it shrinks with model size, because the width-squared projection work
grows faster than the context-linear attention work. An FHE-LLM is not hard because of its matrix
multiplies. It is hard because of the nonlinearities, which no polynomial scheme evaluates
natively at all.

## 2. Lever set A: give the client the vocabulary boundary

The single design change with the best ratio of benefit to effort. The client already holds public
model weights; let it own both ends of the pipeline and give the server only the transformer
stack.

**The embedding.** An encrypted token id cannot index a table, so a server-side lookup is a
one-hot times the embedding matrix: $V \times d$ multiplies per token. Against the cost of one
transformer layer:

| model | server-side $V\!\cdot\!d$ | as % of one layer | client-side |
|---|---:|---:|---:|
| GPT-2 small | $3.86\cdot10^{7}$ | 409% | 0 |
| GPT-2 XL | $8.04\cdot10^{7}$ | 196% | 0 |
| Llama-3 8B | $5.25\cdot10^{8}$ | 216% | 0 |
| Llama-3 70B | $1.05\cdot10^{9}$ | 108% | 0 |

**The unembedding, which is the better half.** Have the server return the final *hidden state*
($d$ values) rather than the logits ($V$ values). The client multiplies by the public unembedding
matrix, applies softmax, and samples. For Llama-3 that is $128256/4096 \approx 31\times$ less
ciphertext per token -- straight off the $10^6$ bandwidth expansion that is the binding constraint
before latency is.

**And it deletes a softmax.** The vocabulary softmax moves to the client entirely. This is exact,
not approximate:

$$ \operatorname{softmax}(v)_i \le \operatorname{softmax}(v)_j \iff v_i \le v_j \veq{softmax-mono-dreamed}\lean $$

so the argmax is unchanged, and the client's sampling over decrypted logits is the same
distribution the server would have produced. Note carefully what this does *not* buy: it removes
the **final vocabulary** softmax, not the **attention** softmax, which is a weighted average and
genuinely needed. Section 3's lever is the one that helps there.

## 3. Lever set B: stop paying for numerical hygiene under encryption

Every plaintext softmax subtracts the row maximum before exponentiating. Under FHE a maximum is
one of the most expensive primitives there is -- it is a comparison, which CKKS cannot do at all
and TFHE charges a programmable bootstrap for. And it is not part of the answer:

$$ \operatorname{softmax}(v + c\mathbf{1}) = \operatorname{softmax}(v) \quad\text{for any } c \veq{softmax-shift-dreamed}\lean $$

The subtraction is a floating-point range device, nothing more. Under encryption it can be **any
public constant** -- a calibration bound on the logit range, measured offline on plaintext data --
and the semantics are untouched. This applies to the attention softmax, where the maxima are per
row per head per layer and therefore the bulk of them.

**A third lever in the same spirit: match the noise budget to the quantisation the model already
tolerates.** CKKS is approximate arithmetic and FHE-ML work routinely targets 20-30 bits of
precision because that is what "correct" means in a numerics paper. Production LLMs run at 4- and
8-bit weights with acceptable quality loss. The precision an FHE-LLM actually needs is set by the
model's own tolerance, not by an abstract accuracy target, and precision drives the ciphertext
modulus, which drives the ring dimension, which drives cost superlinearly. This is an
order-of-magnitude lever, not an orders-of-magnitude one, but it is being left on the table by
construction whenever the accuracy target is inherited from a non-ML setting.

## 4. What the bill actually looks like

Every row is somebody else's measurement, not this document's.

The single most important line to draw is **encoder against generative**, because the field's
headline numbers come from opposite sides of it and are routinely quoted as if comparable.

> **CORRECTED after an adversarial audit, same session.** The first version of this section
> contained three prior-art errors, all pushing in the same direction -- making FHE look better
> than it is -- and one of them was the exact mistake this essay warns about four paragraphs
> below. They are corrected in place and named in section 7(b), rather than quietly fixed.

**Encoder inference under FHE is demonstrated at BERT-base scale.**

| system | model | what | result |
|---|---|---|---|
| **NEXUS** (NDSS 2025) | BERT-base | one forward pass, **non-interactive** FHE (RNS-CKKS) | **37.3 s on GPU**, **164 MB**; 372.5$\times$ less bandwidth than BOLT, 53.6$\times$ than BumbleBee |
| **ARION** (eprint 2025/2271) | BERT-base / BERT-Tiny | same setting | **2.5$\times$** / **34.6$\times$** over **MOAI**, not over NEXUS |

The 37.3 s **is** the GPU figure: NEXUS's evaluation reports 857 s against 37.34 s, and the
abstract's "the GPU version achieving a 42.3$\times$ speedup ... **this enables** NEXUS to run
inference ... in just 37.3 seconds" makes the direction explicit. An earlier draft here applied
the 42.3$\times$ a second time and concluded "under a second", overstating the result by a factor
of about forty. ARION's own paper is also worth reading before leaning on any of these: it
distrusts the NEXUS number, remarking that "the runtime reported by NEXUS seems not end-to-end
runtime".

**Generative inference under end-to-end FHE has no published datapoint I can find at all.**

| system | model | s / token | regime |
|---|---|---:|---|
| Zama Concrete-ML, GPU | GPT-2 (124M) | 11 | **hybrid**: one attention head encrypted, everything else plaintext on the client |
| Zama Concrete-ML, CPU | GPT-2 (124M) | 300 | same hybrid |
| PUMA (2023) | **LLaMA-7B** | ~300 (5 min) | **3-party** MPC, honest majority, not FHE |
| BumbleBee (NDSS 2025) | LLaMA-7B | ~480 (8 min) | 2-party MPC, not FHE |

Two labels in that table were wrong in the first draft and both mattered.

The Zama rows are **not end-to-end FHE**. Zama's own documentation: the server "executes linear
layers", while "the client executes non-linear layers in the LLM, such as attention and activation
functions", and the demo encrypts "a single attention head of the multi-head attention block". The
nonlinearities -- which section 1 identifies as *the* hard part -- run in plaintext on the client.
This is precisely the failure mode the caution below describes, committed against this essay's own
anchor row. So the earlier conclusion "pure-FHE generative inference tops out around GPT-2 scale"
is **withdrawn**: no row in this table supports it, because no row is end-to-end pure FHE.

**PUMA is three-party, not two.** Its threat model: "secure against a semi-honest adversary that
corrupts no more than one of the three computing parties", over 2-out-of-3 replicated secret
sharing. That is a materially weaker trust assumption than the 2PC label implied, and section 5's
route R2 argued from the wrong one.

Bandwidth, Zama GPT-2: **2.2 MB per token** against roughly 2 bytes of plaintext token.

So the honest one-sentence state of the art: **one BERT-base forward pass in 37 seconds on a GPU
under non-interactive FHE; one token of a 7B generative model in about five minutes, and only via
multi-party computation with a non-collusion assumption.** For end-to-end FHE *generation* at any
scale, the public record appears to be empty. That is a larger gap than the first draft claimed,
not a smaller one, and its cause is structural: a BERT pass is one forward evaluation whose
sequence dimension packs into SIMD slots, while generation is $n$ sequential passes with a growing
KV cache, each conditioned on the last, so nothing amortises across steps.

A 2026 survey (Andreoletti et al., SUPSI/Prem AI, eprint 2026/105) reaches the same verdict from a
deployment angle: TEEs today as the only route at production latency, crypto-augmented designs in
the middle, and FHE as "the natural asymptotic endpoint", with current constraints that "preclude
its **widespread deployment** for large autoregressive models". It confirms the PUMA figure as
"roughly five minutes per token, representing the first MPC demonstration at that scale".

One further reading. A naive one-bootstrap-per-nonlinearity accounting gives **hours** per token,
so measured systems landing in seconds is entirely the achievement of SIMD packing and low-degree
approximation. The levers of sections 2 and 3 are of the same kind.

**A caution about the literature, which the owner raised and which turned out to be warranted --
including against this essay, see the correction box above.** A
2026 arXiv paper reports FHE Llama-3 inference at 237 ms and 80 tokens per second, which would
overturn everything above. It does not: read past the abstract and it integrates HE operations "to
secure **some of its layers**". It is not end-to-end encrypted inference and its headline number
is not comparable to the rows in this table. I do not cite it as an anchor, and I would treat any
FHE-LLM latency claim within two orders of magnitude of plaintext as unverified until its threat
model is read.

## 5. Five routes to trustless distributed AI

The seed asked for multiple methods and for creativity about them. Verdicts are recommendations,
never decisions.

**R1. Non-interactive FHE.** Client encrypts, server evaluates, client decrypts. Strongest
security story: nothing leaves the client in the clear, no online participation, no hardware
trust. Costs $10^3$-$10^4$ in latency and $10^6$ in bandwidth today. *Verdict:* the right target,
wrong decade for interactive chat; already fine for **batch** workloads where latency is free --
overnight document analysis, private retrieval scoring, offline classification.

**R2. Two-party MPC.** Server and client jointly evaluate on secret shares; the client does the
nonlinearities in the clear on its share. Fastest measured regime by a wide margin at 7B scale.
*Verdict:* the pragmatic choice today, at the cost of an online client and heavy communication.
The trust assumption needs stating precisely, and an earlier draft of this essay got it wrong.
BumbleBee is genuinely two-party. **PUMA is three-party with an honest majority** -- it tolerates
one semi-honest corruption out of three computing parties -- so it needs a non-colluding third
party that the client neither owns nor chooses. That is a real assumption about the world, not a
vacuous one, and it is the thing R4 below tries to replace with something checkable.

**R3. TEEs.** Deployed at scale now (Apple, Meta Private Processing, NVIDIA H100/Blackwell
confidential computing). Near-zero overhead. *Verdict:* the only route that works today at full
speed, and the trust does not vanish -- it moves to a hardware vendor and a hypervisor. TDXRay
is the reason that is not a rhetorical caveat: an end-to-end prompt reconstruction attack on
production Intel TDX, from access patterns the enclave does not hide. "Trustless" is exactly the
property a TEE does not have.

**R4. Threshold FHE across mutually distrusting providers.** This is the route that matches the
owner's phrase most literally, and it is the one I would most want explored. Split the decryption
key across $N$ independent operators under a threshold scheme; the computation is FHE, so no
single operator ever sees plaintext, and confidentiality survives any coalition below the
threshold. The distribution is not an implementation detail -- it *is* the trust model, replacing
"trust this provider" with "trust that these $N$ do not all collude", which is an economic and
jurisdictional assumption rather than a cryptographic one and can be made robust by choosing $N$
across adversarial jurisdictions. *Verdict:* strictly more expensive than R1 (threshold key
switching on top of FHE) and the only route whose *trust* story actually matches the goal.

**R5. Verifiable inference (zkML), which is orthogonal to all of the above.** None of R1-R4
answers "did the server run the model it promised". A server can evaluate a 1B model and bill for
70B, and FHE **alone** gives the client no signal to check against -- the ciphertexts decrypt to *something*
plausible either way. Zero-knowledge proofs of inference answer this, compose with any of R1-R4,
and are the subject the owner has already picked as the next session's seed. *Verdict:* the
neglected half of "trustless", and probably the half where a small amount of work buys the most,
because integrity proofs can be **sampled** -- proving one token in a thousand deters a cheating
server at a thousandth of the cost, which is a lever with no analogue on the confidentiality side.

**A sixth, offered as speculation rather than a route.** Attention's $QK^\top$ is a *bilinear*
form, and functional encryption for quadratic functions exists (Baltico-Catalano-Fiore-Gay,
CRYPTO 2017 and successors) with far better constants than general FHE. The shape matches
suspiciously well: the one genuinely hard operation in section 1 is exactly degree two. I have not
checked whether the key-generation model of quadratic FE can be made to fit an autoregressive
loop, and I suspect it cannot without leaking the attention pattern. Recorded because it is cheap
to check and would be significant if it worked.

## 6. The channel none of the routes close

Encryption hides values. It does not hide **how many ciphertexts there were or when they were
sent**, and for an autoregressive model that is a rich channel. **Weiss et al. (USENIX Security
2024)** reconstructed 29% of an AI assistant's responses and inferred the topic of 55% from the
sequence of *token lengths* alone, over TLS. FHE does not help at all. Padding is the mitigation,
and it is not free:

| padding scheme | leaked bits ($n \le 2048$) | mean waste |
|---|---:|---:|
| none | 11.00 | 0 tokens |
| power-of-2 buckets | 3.58 | 341 tokens |
| power-of-4 buckets | 2.81 | 409 tokens |
| power-of-16 buckets | 2.00 | 798 tokens |
| pad every request to max | 0.00 | 1024 tokens |

Under FHE, where a token already costs seconds, the only defensible setting is full padding, and
that multiplies an already $10^3$-$10^4$ slowdown by a further large factor. **The interaction
between the two costs is the honest reason FHE-LLM is hard, and it is not a cryptographic problem
at all.** A scheme could be free and this would remain.

## 7. What is already known, and what this essay adds

Known and cited above: the measured systems (Zama Concrete-ML; PUMA, arXiv 2307.12533; BumbleBee,
NDSS 2025), the side channels (Weiss et al. USENIX Security 2024; TDXRay via OTRO, arXiv
2606.17358), MPC-friendly approximations of GELU/softmax/LayerNorm (PUMA and successors), threshold
FHE, and zkML. Softmax shift-invariance and monotonicity are elementary and certainly folklore --
they are in Lean here because the design conclusions rest on them, not because they are new.

What I believe this essay contributes, offered for the owner to knock down:

1. The **client-owns-the-vocabulary-boundary** split stated as one design with all four of its
   consequences priced together: embedding saved, $31\times$ bandwidth saved, vocabulary softmax
   deleted exactly, tokenizer side-channel class removed by construction.
2. The reading of **OTRO/TDXRay as an argument *for* FHE over TEEs**. Stated more carefully after
   an audit: that FHE has no access-pattern side channel is textbook, and is exactly why TEEs need
   ORAM and FHE does not. What is worth saying is narrower -- that a 2026 result presented as a
   *tokenizer vulnerability in confidential LLM serving* is, read against its own threat model, a
   point in FHE's favour rather than a new worry for it.
3. The **confidentiality/integrity split** applied to the word "trustless", with the observation
   that integrity proofs can be sampled and confidentiality cannot -- so the two halves have
   completely different cost curves.

## 8. Surfaced for the owner

Located, evidenced, not resolved. **No finding or verdict here was filed into any ledger.** The
batch carries one neutral pointer (`TODO.md` `id:6646`) that lists these rulings AS PENDING, which
is how it stays visible to `/relay human` without anything being recorded as decided.

1. **`crypto/fhe.md` has no LLM section and this essay does not propose one.** The page is a
   counting argument about bijections; everything above is a systems argument. If the owner ever
   wants the crypto wing to reach modern FHE, the natural bridge is
   [`fhe-toy-enumeration`](fhe-toy-enumeration.md) section 4 (the quotient model), not this essay.
   Recorded as an option, explicitly not a recommendation.

2. **Routes R4 and R5 are taken further in a sibling essay.** The owner named "zero knowledge /
   trustless distributed AI" as a follow-on and then, mid-session, asked for it directly;
   [`trustless-distributed-ai`](trustless-distributed-ai.md) is that work. It argues that
   integrity and confidentiality want the *same* substrate (an integer-only quantised model),
   which if right partly supersedes this essay's lever set B -- an integer model needs no CKKS
   noise-budget tuning because BFV/BGV are exact. Flagged so the two are read together rather
   than as independent recommendations.

3. **No discrepancy found in owner content.** This essay has no owner-authored source; it
   critiques nothing of his.

## 9. Lean attestation

**File** [`docs/dreamed/lean/FHESoftmax.lean`](lean/FHESoftmax.lean). **Command**
`cd verify && ../docs/dreamed/capped.sh -m 6G -- lake env lean --threads=2 ../docs/dreamed/lean/FHESoftmax.lean`.
**Exit status `0`, `sorry` count `0`.** Mathlib is the rev pinned in `verify/lake-manifest.json`;
imports are narrow, no `import Mathlib`.

| Claim | Lean names | Status |
|---|---|---|
| softmax is a distribution | `softmax`, `sum_exp_pos`, `softmax_pos`, `softmax_sum_one` | proved |
| shift invariance (section 3) | `softmax_shift` | proved |
| order preservation (section 2) | `softmax_le_iff`, `softmax_argmax` | proved |

Both design levers rest on these and on nothing else, which is the point of proving them: the
argument "you can drop the encrypted maximum" is only as good as the invariance it appeals to, and
under encryption a wrong invariance is expensive to discover empirically.

`\veq` badges above attest against this dreamed file only, never against the repo's sidecar
machinery (`docs/dreamed/README.md` rule).

## 10. Follow-up leads

1. **Price the client-boundary split against a real model** (mechanizable, cheap): section 2's
   numbers are analytic. Running Concrete-ML's GPT-2 example with the embedding and unembedding
   moved client-side would turn them into a measurement. Decidable by doing it.
2. **Check the quadratic-FE idea** (mechanizable, half a day, likely negative): does any quadratic
   functional-encryption scheme survive an autoregressive loop without leaking the attention
   pattern? A negative is worth as much as a positive and is the likely outcome.
3. **Sampled integrity proofs** (owner direction, and the one I would pick): what fraction of
   tokens must be proved to make cheating uneconomic, as a function of the price gap between the
   promised model and the substituted one? This is a small piece of game theory, not cryptography,
   and it is the concrete question route R5 turns on.
4. **Threshold-FHE cost model** (mechanizable, larger): the overhead of $N$-party threshold
   decryption on top of R1, as a function of $N$. Determines whether R4 is a factor or an order of
   magnitude over R1, which decides whether the trust story is affordable.
5. **Whether any of this belongs in toesnail at all** (owner-only, gating): this is systems
   security, not physics or mathematics, and `crypto/` is currently one counting page. The honest
   possibility is that the whole thread lives better in a different repo.

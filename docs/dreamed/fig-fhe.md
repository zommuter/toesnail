---
title: The FHE cluster in seven charts
permalink: /dreamed/fig-fhe
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This page *proposes*; the owner disposes. Nothing here is toesnail theory, and nothing may be
> promoted into `physics/`, `essays/` or `crypto/` without the owner authoring the move himself.
>
> This page invents nothing and cites nothing of its own. It is a **figure sheet** over the FHE
> cluster, owner-seeded on `crypto/fhe.md` in the session of 2026-09-04. Every number is read off a
> named sibling essay, and the essay plus section is printed beside each chart. The tables under
> each chart carry the same figures as text.

The FHE cluster is the number-richest thing in `docs/dreamed/`, so it gets charts rather than boxes
of prose. Seven essays are drawn: [`fhe-toy-enumeration`](fhe-toy-enumeration),
[`fhe-encrypted-algorithm`](fhe-encrypted-algorithm), [`fhe-llm`](fhe-llm),
[`fhe-counting`](fhe-counting), [`model-attestation`](model-attestation),
[`zkml-proofs`](zkml-proofs) and [`trustless-distributed-ai`](trustless-distributed-ai). Where they
disagree with each other, chart 5 draws the disagreement instead of settling it; where they retract
themselves, chart 7 draws that too.

<style>
.tsfig{display:block;width:100%;height:auto;max-width:760px;margin:0 auto;background:#fcfcfb;font-family:system-ui,-apple-system,"Segoe UI",sans-serif}
.tsfig text{fill:#52514e;font-size:13px}
.tsfig .hd{fill:#0b0b0b;font-size:15px;font-weight:600}
.tsfig .sh{fill:#0b0b0b;font-size:14px;font-weight:600}
.tsfig .mu{fill:#898781;font-size:13px}
.tsfig .e{text-anchor:end;font-size:13px}
.tsfig .m{text-anchor:middle;font-size:13px}
.tsfig .val,.tsfig .lbl{fill:#0b0b0b;font-weight:600;font-size:13px}
.tsfig .good{fill:#0ca30c;font-weight:600;font-size:13px}
.tsfig .crt{fill:#d03b3b;font-weight:600;font-size:13px}
.tsfig .wrn{fill:#a06a00;font-weight:600;font-size:13px}
.tsfig .g{stroke:#e1e0d9;stroke-width:1}
.tsfig .ax{stroke:#c3c2b7;stroke-width:1}
.tsfig .card{fill:#f9f9f7;stroke:#e1e0d9;stroke-width:1}
.tsfig .dash{fill:none;stroke:#898781;stroke-width:2;stroke-dasharray:7 5}
.tsfig .ln{fill:none;stroke-width:2;stroke-linejoin:round}
.tsfig .mk{stroke:#fcfcfb;stroke-width:2}
.tsfig .s1{fill:#2a78d6}
.tsfig .s2{fill:#eb6834}
.tsfig .s3{fill:#1baf7a}
.tsfig .s1k{stroke:#2a78d6}
.tsfig .s2k{stroke:#eb6834}
.tsfig .s3k{stroke:#1baf7a}
.tsfig .arw{fill:none;stroke:#898781;stroke-width:2}
</style>

## 1. Three impossibility results, and the trap is conflating them

Source: [`fhe-encrypted-algorithm`](fhe-encrypted-algorithm) sections 0 and 4. "Encrypted algorithm"
names three problems, not one, and the single question that separates them is **who holds the
decryption key**. Blurring them is what makes the phrase sound simultaneously solved and impossible.

<div style="overflow-x:auto">

<svg class="tsfig" viewBox="0 0 760 348" role="img" aria-labelledby="c1t c1d">
<title id="c1t">The three problems that "encrypted algorithm" names, separated by who holds the decryption key</title>
<desc id="c1d">Three rows. When only the client can decrypt, the problem is private function evaluation and it is solved at a logarithmic cost. When the evaluator can run the program in the clear, the problem is obfuscation and virtual black box obfuscation is impossible. When the client who decrypts must not learn the server's circuit, the problem is circuit privacy and it is a cost. Figures repeated in the table below.</desc>
<text class="hd" x="14" y="24">One phrase, three problems, three different answers</text>
<text x="14" y="44">the separating question is who holds the decryption key, and nothing else</text>
<text class="mu" x="14" y="76">WHO HOLDS THE KEY</text>
<text class="mu" x="252" y="76">THE PROBLEM</text>
<text class="mu" x="430" y="76">ANSWER</text>
<text class="mu" x="556" y="76">WHAT IT COSTS</text>
<rect class="card" x="14" y="88" width="732" height="72"/>
<rect x="14" y="88" width="5" height="72" fill="#0ca30c"/>
<text x="32" y="112">client only. The evaluator</text>
<text x="32" y="130">sees two ciphertexts and</text>
<text x="32" y="148">one public circuit</text>
<text class="lbl" x="252" y="112">private function</text>
<text class="lbl" x="252" y="130">evaluation</text>
<text class="good" x="430" y="121">SOLVED</text>
<text x="556" y="112">a universal circuit,</text>
<text x="556" y="130">size O(k log k) for a</text>
<text x="556" y="148">size-k circuit, Valiant 1976</text>
<rect class="card" x="14" y="168" width="732" height="72"/>
<rect x="14" y="168" width="5" height="72" fill="#d03b3b"/>
<text x="32" y="192">the evaluator. It holds the</text>
<text x="32" y="210">program clearly enough to</text>
<text x="32" y="228">run it on inputs it chooses</text>
<text class="lbl" x="252" y="192">obfuscation</text>
<text x="252" y="210">running it is itself</text>
<text x="252" y="228">an oracle</text>
<text class="crt" x="430" y="192">VBB</text>
<text class="crt" x="430" y="210">IMPOSSIBLE</text>
<text font-size="13" x="556" y="192">no price. Barak et al. 2001.</text>
<text font-size="13" x="556" y="210">Indistinguishability obfuscation</text>
<text font-size="13" x="556" y="228">exists, but far from practical</text>
<rect class="card" x="14" y="248" width="732" height="72"/>
<rect x="14" y="248" width="5" height="72" fill="#fab219"/>
<text x="32" y="272">the client, who decrypts</text>
<text x="32" y="290">a result whose noise carries</text>
<text x="32" y="308">information about the circuit</text>
<text class="lbl" x="252" y="272">circuit privacy</text>
<text x="252" y="290">the one people forget</text>
<text x="252" y="308">exists</text>
<text class="wrn" x="430" y="281">A COST</text>
<text font-size="13" x="556" y="272">noise flooding, or bootstrap</text>
<text font-size="13" x="556" y="290">the result through a fresh key.</text>
<text font-size="13" x="556" y="308">A cost, not a barrier</text>
<text class="mu" x="14" y="340">Source: fhe-encrypted-algorithm.md sections 0 and 4. The first is what FHE gives almost for free.</text>
</svg>

</div>

Two measured findings from the same essay sit under this: the 2ⁿ program-bit floor of
`crypto/fhe.md:8` is a lower bound over **all** encodings and is attained, so the owner's line is
optimal rather than convenient; and the structural tax is **obliviousness**, not cryptography.
Euclid's algorithm pays a padding factor converging to about 2.5 (2.38, 2.48, 2.52, 2.54 at 4, 6,
8, 10 bits), and for a general program there is no computable worst case to pad to at all.

## 2. The toy scheme's exact trade-off

Source: [`fhe-toy-enumeration`](fhe-toy-enumeration) sections 1, 2 and 4. In the strict model
encryption is a permutation and the evaluator applies the same public operation, so the usable keys
are the automorphisms. A second operation intersects two automorphism groups, and on a k-bit word
with the field operations of GF(2ᵏ) the intersection is exactly the k Frobenius maps.

<div style="overflow-x:auto">

<svg class="tsfig" viewBox="0 0 760 606" role="img" aria-labelledby="c2t c2d">
<title id="c2t">Key bits against word size: the second operation collapses the key space from k bits to log base 2 of k</title>
<desc id="c2d">Upper panel, key bits against word size in bits. The one-time pad line rises linearly to 16 bits at word size 16. The strict two-operation scheme rises as the logarithm, reaching only 4 bits at word size 16. Lower panel, computable constants against key bits over the subgroups of the symmetric group on four points: all four constants are computable only at zero key bits. Figures in the tables below.</desc>
<text class="hd" x="14" y="24">Key entropy against word size, strict two-operation scheme versus the one-time pad</text>
<text font-size="13" x="14" y="44">key bits kept, on a k-bit word, exhaustive over GL(k,2) for k up to 4 and the exact Frobenius count beyond</text>
<line class="g" x1="60" y1="110" x2="700" y2="110"/>
<line class="g" x1="60" y1="165" x2="700" y2="165"/>
<line class="g" x1="60" y1="220" x2="700" y2="220"/>
<line class="g" x1="60" y1="275" x2="700" y2="275"/>
<line class="ax" x1="60" y1="330" x2="700" y2="330"/>
<text class="e mu" x="52" y="114">16</text>
<text class="e mu" x="52" y="169">12</text>
<text class="e mu" x="52" y="224">8</text>
<text class="e mu" x="52" y="279">4</text>
<text class="e mu" x="52" y="334">0</text>
<text class="mu" x="14" y="92">key bits</text>
<polyline class="ln s1k" points="60,316.3 102.7,302.5 145.3,288.8 188,275 230.7,261.3 273.3,247.5 316,233.8 358.7,220 401.3,206.3 444,192.5 486.7,178.8 529.3,165 572,151.3 614.7,137.5 657.3,123.8 700,110"/>
<polyline class="ln s2k" points="60,330 102.7,316.3 145.3,308.2 188,302.5 230.7,298.1 273.3,294.5 316,291.4 358.7,288.8 401.3,286.5 444,284.3 486.7,282.4 529.3,280.7 572,279.1 614.7,277.7 657.3,276.3 700,275"/>
<circle class="s1 mk" cx="60" cy="316.3" r="5"/><circle class="s1 mk" cx="102.7" cy="302.5" r="5"/><circle class="s1 mk" cx="145.3" cy="288.8" r="5"/><circle class="s1 mk" cx="188" cy="275" r="5"/>
<circle class="s2 mk" cx="60" cy="330" r="5"/><circle class="s2 mk" cx="102.7" cy="316.3" r="5"/><circle class="s2 mk" cx="145.3" cy="308.2" r="5"/><circle class="s2 mk" cx="188" cy="302.5" r="5"/>
<text class="s1 lbl e" x="694" y="102">one-time pad, k key bits</text>
<text class="s2 lbl e" x="694" y="266">two operations, log2 k key bits</text>
<text class="mu" x="200" y="352">filled markers are the exhaustively enumerated rows, k = 1 to 4</text>
<text class="m mu" x="60" y="352">1</text><text class="m mu" x="188" y="352">4</text><text class="m mu" x="358.7" y="352">8</text><text class="m mu" x="529.3" y="352">12</text><text class="m mu" x="700" y="352">16</text>
<text class="m mu" x="380" y="374">word size k, bits</text>
<text class="sh" x="14" y="416">Key entropy and functional completeness are exactly incompatible, not traded off</text>
<text font-size="13" x="14" y="436">computable constants against key bits, each subgroup of the symmetric group on 4 points as key space</text>
<line class="g" x1="60" y1="470" x2="700" y2="470"/>
<line class="g" x1="60" y1="495" x2="700" y2="495"/>
<line class="ax" x1="60" y1="520" x2="700" y2="520"/>
<text class="e mu" x="52" y="474">4</text>
<text class="e mu" x="52" y="499">2</text>
<text class="e mu" x="52" y="524">0</text>
<text class="mu" x="14" y="458">constants computable, of 4</text>
<circle class="s3 mk" cx="60" cy="420" r="6"/>
<circle class="s3 mk" cx="188" cy="470" r="6"/>
<circle class="s3 mk" cx="262.9" cy="495" r="6"/>
<circle class="s3 mk" cx="316" cy="520" r="6"/>
<circle class="s3 mk" cx="390.9" cy="495" r="6"/>
<circle class="s3 mk" cx="444" cy="520" r="6"/>
<circle class="s3 mk" cx="518.9" cy="520" r="6"/>
<circle class="s3 mk" cx="646.8" cy="520" r="6"/>
<text class="lbl" x="74" y="416">4 of 4, and only here: the key must be the identity</text>
<text class="crt" x="330" y="516">0 of 4 from key order 4 onward</text>
<text class="m mu" x="60" y="542">0</text><text class="m mu" x="188" y="542">1</text><text class="m mu" x="316" y="542">2</text><text class="m mu" x="444" y="542">3</text><text class="m mu" x="572" y="542">4</text><text class="m mu" x="700" y="542">5</text>
<text class="m mu" x="380" y="564">key bits</text>
<text class="mu" x="14" y="576">Source: fhe-toy-enumeration.md sections 1 and 2. Rows are indexed by subgroup order;</text>
<text class="mu" x="14" y="594">where several share an order the most favourable is shown.</text>
</svg>

</div>

| word size k, bits | GL(k,2) = Aut(+) | Aut(+, times) | key bits kept | one-time pad bits |
|---:|---:|---:|---:|---:|
| 1 | 1 | 1 | 0 | 1 |
| 2 | 6 | 2 | 1 | 2 |
| 3 | 168 | 3 | 1.585 | 3 |
| 4 | 20160 | 4 | 2 | 4 |

`Aut(+, times)` is k exactly, the Frobenius maps and nothing else. Read against `crypto/fhe.md:14`,
whose criterion rejects anything above one key bit per data bit: two operations cap the key at
log₂ k bits for k data bits, which is asymptotically **zero** key bits per data bit.

| key bits | key group order | equivariant operations of 4^16 | constants computable |
|---:|---:|---:|---:|
| 0 | 1 | 4294967296 | 4 of 4 |
| 1 | 2 | 65536 | 2 of 4 |
| 1.585 | 3 | 1024 | 1 of 4 |
| 2 | 4 | 256 | 0 of 4 |
| 2.585 | 6 | 32 | 1 of 4 |
| 3 | 8 | 16 | 0 of 4 |
| 3.585 | 12 | 4 | 0 of 4 |
| 4.585 | 24 | 2 | 0 of 4 |

**And randomising bought exactly zero.** Model C makes encryption one-to-many, and then any family
of plaintext operations can be induced with no algebraic constraint at all. Publishing the
evaluation tables gives the key away anyway: over all nontrivial partitions the mean number of
consistent keys is **1.000, maximum 1, at every ciphertext size tested** (4, 6, 8 and 10; 14, 62,
254 and 1022 partitions; 0.0 percent of trials with more than one). The essay had predicted 2 and
was wrong, because complementing the classes turns XOR into NXOR. Whatever makes real FHE hard, it
is not the algebra.

## 3. The state of the art, including one honest absence

Source: [`fhe-llm`](fhe-llm) section 4, rewritten after an adversarial audit found three prior-art
errors in it, all flattering to FHE. The line worth drawing is **encoder against generative**,
because the field's headline numbers come from opposite sides of it and are quoted as comparable.

<div style="overflow-x:auto">

<svg class="tsfig" viewBox="0 0 760 448" role="img" aria-labelledby="c3t c3d">
<title id="c3t">Measured latency of encrypted transformer inference, and the missing end-to-end pure-FHE generative datapoint</title>
<desc id="c3d">A dot plot on a logarithmic seconds axis. One BERT-base forward pass under non-interactive FHE takes 37.3 seconds on GPU. Per-token generative figures are 11 seconds for a hybrid GPT-2 on GPU, 300 seconds for the same hybrid on CPU, about 300 seconds for LLaMA-7B under three-party MPC and about 480 seconds under two-party MPC. The last lane is empty: no end-to-end pure-FHE generative datapoint is published at any scale. Figures in the table below.</desc>
<text class="hd" x="14" y="24">What has actually been measured, and the one lane with nothing in it</text>
<text x="14" y="44">seconds, logarithmic. Encoder rows are one forward pass; generative rows are per decoded token</text>
<line class="g" x1="320" y1="72" x2="320" y2="300"/>
<line class="g" x1="456.7" y1="72" x2="456.7" y2="300"/>
<line class="g" x1="593.3" y1="72" x2="593.3" y2="300"/>
<line class="ax" x1="730" y1="72" x2="730" y2="300"/>
<text class="m mu" x="320" y="66">1 s</text>
<text class="m mu" x="456.7" y="66">10 s</text>
<text class="m mu" x="593.3" y="66">100 s</text>
<text class="m mu" x="730" y="66">1000 s</text>
<text class="lbl" x="14" y="102">NEXUS, BERT-base, GPU</text>
<text x="14" y="119">non-interactive FHE (RNS-CKKS), one pass, 164 MB</text>
<circle class="s1 mk" cx="534.8" cy="106" r="7"/>
<text class="s1 lbl" x="548" y="111">37.3 s</text>
<text class="lbl" x="14" y="150">Zama Concrete-ML, GPT-2, GPU</text>
<text x="14" y="167">hybrid: one attention head encrypted, rest on the client</text>
<circle class="s2 mk" cx="462.3" cy="154" r="7"/>
<text class="s2 lbl" x="476" y="159">11 s per token</text>
<text class="lbl" x="14" y="198">Zama Concrete-ML, GPT-2, CPU</text>
<text x="14" y="215">same hybrid, nonlinearities in plaintext on the client</text>
<circle class="s2 mk" cx="658.6" cy="202" r="7"/>
<text class="s2 lbl e" x="645" y="207">300 s per token</text>
<text class="lbl" x="14" y="246">PUMA, LLaMA-7B</text>
<text x="14" y="263">3-party MPC, honest majority, not FHE</text>
<circle class="s3 mk" cx="658.6" cy="250" r="7"/>
<text class="s3 lbl e" x="645" y="255">about 300 s per token</text>
<text class="lbl" x="14" y="294">BumbleBee, LLaMA-7B</text>
<text x="14" y="311">2-party MPC, not FHE</text>
<circle class="s3 mk" cx="686.4" cy="298" r="7"/>
<text class="s3 lbl e" x="673" y="303">about 480 s per token</text>
<text class="crt" x="14" y="348">end-to-end pure FHE, generative, any scale</text>
<text x="14" y="365">the thing the seed actually asked for</text>
<rect class="dash" x="320" y="330" width="410" height="42"/>
<text class="m crt" x="525" y="356">NO PUBLISHED DATAPOINT AT ALL</text>
<text class="mu" x="14" y="398">Source: fhe-llm.md section 4. The lane is drawn empty because the record is empty, not because the value is small.</text>
<text class="mu" x="14" y="416">The gap is autoregression, not encryption: a BERT pass packs its sequence into SIMD slots;</text>
<text class="mu" x="14" y="434">generation is n sequential passes, nothing amortises.</text>
</svg>

</div>

| system | model | what | result |
|---|---|---|---|
| NEXUS (NDSS 2025) | BERT-base | one forward pass, non-interactive FHE | 37.3 s on GPU, 164 MB |
| Zama Concrete-ML, GPU | GPT-2 (124M) | hybrid, one attention head encrypted | 11 s per token |
| Zama Concrete-ML, CPU | GPT-2 (124M) | same hybrid | 300 s per token |
| PUMA (2023) | LLaMA-7B | 3-party MPC, honest majority | about 300 s per token |
| BumbleBee (NDSS 2025) | LLaMA-7B | 2-party MPC | about 480 s per token |
| **none found** | **any** | **end-to-end pure FHE, generative** | **no published datapoint** |

The essay withdrew its own earlier conclusion that "pure-FHE generative inference tops out around
GPT-2 scale", because no row in that table is end-to-end pure FHE. The honest state of the art: one
BERT-base forward pass in 37 seconds on a GPU under non-interactive FHE, one token of a 7B
generative model in about five minutes and only via multi-party computation with a non-collusion
assumption. Also from that essay: under 6 percent of a transformer's multiplications are the
expensive ciphertext-times-ciphertext kind at GPT-2 scale, falling to 0.84 percent at 70B, so an
FHE-LLM is not hard because of its matrix multiplies.

## 4. The identity-evidence chart, the cluster's sharpest number

Source: [`model-attestation`](model-attestation) sections 2 and 3. Inverting DiFR's two published
detection thresholds through Wald's sequential-test relation gives the evidence each observation
carries about model identity. This is **derived, not measured**, and the essay says so: the two
absolute values are order-of-magnitude, and the ratio is the robust part because both are divided
by the same constant.

<div style="overflow-x:auto">

<svg class="tsfig" viewBox="0 0 760 500" role="img" aria-labelledby="c4t c4d">
<title id="c4t">Identity evidence per observation: a sampled token carries 0.033 bits, an activation fingerprint 4.98 bits</title>
<desc id="c4d">A bar chart of bits of identity evidence per observation. A seed-synchronised token carries 0.033 bits; an activation fingerprint carries 4.982 bits, about 150 times more. Below, the observation counts needed to detect a 4-bit swap at AUC above 0.999: 300 output tokens against 2. Below that, a grid of 31 squares of which 11 are marked: 11 of 31 commercial Llama endpoints deviated from Meta's released weights.</desc>
<text class="hd" x="14" y="24">Evidence about which model ran, per observation</text>
<text x="14" y="44">bits per observation, derived from DiFR's published detection thresholds via Wald's relation</text>
<line class="ax" x1="220" y1="76" x2="220" y2="200"/>
<line class="g" x1="316" y1="76" x2="316" y2="200"/>
<line class="g" x1="412" y1="76" x2="412" y2="200"/>
<line class="g" x1="508" y1="76" x2="508" y2="200"/>
<line class="g" x1="604" y1="76" x2="604" y2="200"/>
<line class="g" x1="700" y1="76" x2="700" y2="200"/>
<text class="m mu" x="220" y="70">0</text><text class="m mu" x="316" y="70">1</text><text class="m mu" x="412" y="70">2</text><text class="m mu" x="508" y="70">3</text><text class="m mu" x="604" y="70">4</text><text class="m mu" x="700" y="70">5</text>
<text class="lbl e" x="208" y="104">seed-synchronised token</text>
<text class="e" x="208" y="121">Token-DiFR, 300 tokens to decide</text>
<rect class="s2" x="220" y="90" width="4" height="30" rx="2"/>
<text class="s2 lbl" x="234" y="111">0.033 bits</text>
<text class="lbl e" x="208" y="164">activation fingerprint</text>
<text class="e" x="208" y="181">Activation-DiFR, 2 tokens to decide</text>
<rect class="s1" x="220" y="150" width="478" height="30" rx="4"/>
<text class="lbl e" x="688" y="171" fill="#fcfcfb">4.982 bits</text>
<text class="m mu" x="460" y="220">bits of identity evidence per observation</text>
<text class="crt" x="220" y="244">a factor of about 150, and it is an upper bound on plain sampling:</text>
<text class="crt" x="220" y="262">a seed-synchronised token is strictly more informative than an ordinary one</text>
<text class="sh" x="14" y="300">Observations needed to detect a 4-bit quantization swap at AUC above 0.999</text>
<rect class="card" x="14" y="314" width="356" height="72"/>
<text class="mu" x="30" y="338">TOKEN-DiFR, GENERATED TEXT</text>
<text class="val" x="30" y="372" style="font-size:26px">300 output tokens</text>
<rect class="card" x="390" y="314" width="356" height="72"/>
<text class="mu" x="406" y="338">ACTIVATION-DiFR, THE FOOTPRINT</text>
<text class="val" x="406" y="372" style="font-size:26px">2 output tokens</text>
<text class="sh" x="14" y="420">And the base rate is bad: Model Equality Testing, ICLR 2025</text>
<text x="14" y="440">commercial Llama endpoints tested against Meta's released weights, summer 2024</text>
<rect x="220" y="454" width="187" height="30" rx="4" fill="#d03b3b"/>
<rect x="409" y="454" width="337" height="30" rx="4" fill="#f0efec" stroke="#c3c2b7"/>
<text class="lbl" x="234" y="475" fill="#fcfcfb">11 deviating from Meta's weights</text>
<text class="lbl" x="423" y="475">20 matching, of 31 endpoints tested</text>
</svg>

</div>

| observable | observations to decide | implied KL, nats per observation | bits per observation |
|---|---:|---:|---:|
| seed-synchronised token (Token-DiFR) | 300 | 0.0230 | 0.033 |
| activation fingerprint (Activation-DiFR) | 2 | 3.4534 | 4.982 |

A sampled token is one draw from the output distribution, and a confident model puts nearly all its
mass on one token whatever model produced it. Confidence, which is what makes a model useful, is
exactly what destroys its identifiability from samples. The same essay's own reversal is in chart 7:
because a provider under FHE cannot recognise an audit request, encryption is what makes a sampled
integrity check unevadable.

## 5. The internal disagreement, drawn as a disagreement

Sources: [`zkml-proofs`](zkml-proofs) sections 0, 2 and 9 against
[`model-attestation`](model-attestation) section 7 and
[`trustless-distributed-ai`](trustless-distributed-ai) section 7. The cluster contradicts itself
about how far zkML is from practicality. The essays did not resolve it, and this chart does not
resolve it either.

<div style="overflow-x:auto">

<svg class="tsfig" viewBox="0 0 760 344" role="img" aria-labelledby="c5t c5d">
<title id="c5t">The cluster's internal disagreement on the zkML overhead gap, with who holds which position</title>
<desc id="c5d">A logarithmic overhead axis from ten to the three to ten to the four point two. The zkml-proofs essay places the measured gap as a band from ten to the three point two to ten to the three point eight, calling it engineering and sublinear in model size. Two sibling essays place it at about ten to the four and call it four orders away. The disagreement is unresolved.</desc>
<text class="hd" x="14" y="24">How far is zkML from practical? The cluster gives two answers</text>
<text x="14" y="44">prover overhead against the plaintext forward pass of the same model, logarithmic</text>
<line class="ax" x1="80" y1="270" x2="710" y2="270"/>
<line class="g" x1="80" y1="90" x2="80" y2="270"/>
<line class="g" x1="338.3" y1="90" x2="338.3" y2="270"/>
<line class="g" x1="596.7" y1="90" x2="596.7" y2="270"/>
<text class="m mu" x="80" y="290">1000x</text>
<text class="m mu" x="338.3" y="290">about 3000x</text>
<text class="m mu" x="596.7" y="290">10000x</text>
<text class="m mu" x="395" y="312">overhead against plaintext inference</text>
<rect class="s1" x="183.3" y="98" width="310" height="30" rx="4"/>
<text class="lbl" x="195" y="119" fill="#fcfcfb">1671x to 6747x</text>
<text class="s1 lbl" x="80" y="88">zkml-proofs.md: ENGINEERING, not structural</text>
<text x="80" y="150">measured band, four systems on named hardware. Sublinear: a 1.857x parameter</text>
<text x="80" y="168">increase from LLaMa-2-7B to 13B bought only a 1.295x time increase</text>
<circle class="s2 mk" cx="596.7" cy="212" r="9"/>
<text class="s2 lbl e" x="580" y="200">model-attestation.md and trustless-distributed-ai.md:</text>
<text class="s2 lbl e" x="580" y="218">ABOUT FOUR ORDERS AWAY</text>
<text class="e" x="580" y="240">both rest on opML's February 2024 nanoGPT figure, which zkml-proofs</text>
<text class="e" x="580" y="258">shows predates both zkLLM (April 2024) and zkGPT (2025)</text>
<path class="arw" d="M493 113 L 560 113 L 560 200" stroke-dasharray="6 4"/>
<text class="crt" x="14" y="336">UNRESOLVED in the cluster. Drawn, not settled: no owner ruling has been taken on which figure stands.</text>
</svg>

</div>

| essay | position | figure | evidence given |
|---|---|---|---|
| `zkml-proofs.md` | engineering, not structural | 1671x to 6747x, i.e. 10^3.2 to 10^3.8 | zkLLM and zkGPT measurements; sublinear in model size |
| `model-attestation.md` section 7 | four orders of magnitude away | about 10^4 | opML's nanoGPT comparison, via the sibling |
| `trustless-distributed-ai.md` section 7 | too slow for LLM scale today | about 10^4 | the same opML comparison |

`zkml-proofs.md`'s supporting numbers, all of them somebody else's measurements: on one fixed task
(prove GPT-2), Plonkish ZKML needs 4026 s while GKR-plus-Lasso zkGPT needs 21.8 s on comparable
CPU, **185x from changing the proof system alone in one year**; zkGPT's own breakdown puts lookups
at 55.5 percent, both sumchecks at 40.8 percent and the polynomial commitment at 3.7 percent, so
MSM and NTT accelerators buy that prover 1.04x. Its own caveat is load-bearing: the sublinearity
test rests on n = 2, one family, one sequence length, one implementation.

That essay also adds a wall neither side had drawn: over **private** weights a zkML proof certifies
an existential, that some admissible weights produce this output, not that the promised model ran.
It answers the seed only if zero knowledge over the weights is dropped, which is the property the
provider wanted in the first place.

## 6. The convergence, and the credit for it

Source: [`trustless-distributed-ai`](trustless-distributed-ai) sections 3, 4a, 5 and 6.
**The MP3-versus-bit-exact-codec framing is the owner's**, recorded as his in that essay's section
9 item 1 and repeated here because this directory exists to keep owner-seeded and AI-generated
material distinguishable.

<div style="overflow-x:auto">

<svg class="tsfig" viewBox="0 0 760 596" role="img" aria-labelledby="c6t c6d">
<title id="c6t">Drift compounds over a completion, and integer arithmetic removes it while also fitting exact FHE schemes</title>
<desc id="c6d">Upper panel, the probability that a completion is reproduced exactly, against completion length in tokens, for three per-token divergence rates. At one in a thousand a 4096-token answer reproduces 1.7 per cent of the time. Lower panel, one architectural choice serving both halves of trustlessness: an integer-only quantised transformer is bit-exactly reproducible and natively evaluable under the exact FHE schemes.</desc>
<text class="hd" x="14" y="24">Autoregressive decoding is predictive coding, so drift compounds</text>
<text x="14" y="44">probability an n-token completion is reproduced exactly, given a per-token divergence rate p</text>
<line class="g" x1="80" y1="110" x2="700" y2="110"/>
<line class="g" x1="80" y1="157.5" x2="700" y2="157.5"/>
<line class="g" x1="80" y1="205" x2="700" y2="205"/>
<line class="g" x1="80" y1="252.5" x2="700" y2="252.5"/>
<line class="ax" x1="80" y1="300" x2="700" y2="300"/>
<text class="e mu" x="72" y="114">1.00</text>
<text class="e mu" x="72" y="161">0.75</text>
<text class="e mu" x="72" y="209">0.50</text>
<text class="e mu" x="72" y="256">0.25</text>
<text class="e mu" x="72" y="304">0.00</text>
<text class="mu" x="14" y="92">reproduced exactly</text>
<polyline class="ln s3k" points="80,110.4 235,111.1 390,114.8 545,128.4 700,173.8"/>
<polyline class="ln s1k" points="80,113.0 235,121.8 390,152.9 545,231.8 700,296.8"/>
<polyline class="ln s2k" points="80,138.1 235,200.1 390,285.6 545,300 700,300"/>
<circle class="s3 mk" cx="700" cy="173.8" r="5"/>
<circle class="s1 mk" cx="700" cy="296.8" r="5"/>
<circle class="s2 mk" cx="390" cy="285.6" r="5"/>
<text class="s3 lbl e" x="694" y="164">p = 0.0001</text>
<text class="s2 lbl" x="400" y="282">p = 0.01</text>
<text class="s1 lbl e" x="690" y="288">p = 0.001</text>
<text class="crt e" x="690" y="322">1.7 per cent at 4096 tokens</text>
<text class="m mu" x="80" y="322">16</text><text class="m mu" x="235" y="322">64</text><text class="m mu" x="390" y="322">256</text><text class="m mu" x="545" y="322">1024</text>
<text class="m mu" x="390" y="344">completion length, tokens</text>
<text class="sh" x="14" y="384">One architectural choice, both halves of trustlessness</text>
<rect class="card" x="14" y="398" width="232" height="86"/>
<text class="lbl" x="30" y="424">integer-only quantised</text>
<text class="lbl" x="30" y="442">transformer</text>
<text x="30" y="464">I-BERT: INT8 end to end,</text>
<text x="30" y="480">3.08x base, 3.56x large, on a T4</text>
<path class="arw" d="M246 425 L 300 425" marker-end="url(#a6)"/>
<path class="arw" d="M246 458 L 300 458" marker-end="url(#a6)"/>
<defs><marker id="a6" markerWidth="8" markerHeight="8" refX="7" refY="4" orient="auto"><path d="M0,0 L8,4 L0,8 z" fill="#898781"/></marker></defs>
<rect class="card" x="304" y="398" width="442" height="40"/>
<rect x="304" y="398" width="5" height="40" fill="#2a78d6"/>
<text class="lbl" x="322" y="416">INTEGRITY: integer addition is associative, so reduction order</text>
<text x="322" y="432">cannot matter and cross-provider bit-exactness is free</text>
<rect class="card" x="304" y="444" width="442" height="40"/>
<rect x="304" y="444" width="5" height="40" fill="#1baf7a"/>
<text class="lbl" x="322" y="462">CONFIDENTIALITY: natively evaluable by the exact schemes</text>
<text font-size="13" x="322" y="478">BFV and BGV, rather than the approximate CKKS everyone uses</text>
<text class="wrn" x="14" y="510">Honest limit, retracted by the essay itself: i-Softmax uses bit-shifts, i-LayerNorm an iterative integer square root.</text>
<text class="wrn" x="14" y="528">Those are not polynomials over the plaintext ring, so the third leg of the convergence does not hold.</text>
<text class="mu" x="14" y="552">Source: trustless-distributed-ai.md sections 3, 5 and 6. The MP3-versus-bit-exact-codec framing is</text>
<text class="mu" x="14" y="568">the OWNER'S, not the essay's. Codecs mandated bit-exact integer transforms from H.264 onward for</text>
<text class="mu" x="14" y="584">exactly this reason; Opus ships a bit-exact fixed-point decoder.</text>
</svg>

</div>

| per-token divergence p | 16 tokens | 64 | 256 | 1024 | 4096 |
|---:|---:|---:|---:|---:|---:|
| 0.01 | 0.852 | 0.526 | 0.076 | 0.000 | 0.000 |
| 0.001 | 0.984 | 0.938 | 0.774 | 0.359 | **0.017** |
| 0.0001 | 0.998 | 0.994 | 0.975 | 0.903 | 0.664 |

**The 1.7 per cent is illustrative, not a measurement, and the essay says so in its own section 4a.**
Stage 0 measured GPT-2 over 2048 token positions: argmax disagreements between float32 and float64
were **zero**, so the true per-token divergence is under 1/2048, and at that measured upper bound a
4096-token completion still reproduces only about **13 per cent** of the time. The argument survives
with the number moved: drift compounds, and comparing completion text is the wrong primitive.

The underlying disagreement is unfixable in floating point. Honest providers running identical
weights on identical input disagree on a logit by about 1e-5 at float32 (max spread 1.22e-5 at width
16384) purely from the order their hardware sums a dot product, and by about 1e-14 at float64.
Floating-point addition is not associative, so no amount of good faith closes it. Every one of those
numbers is exactly zero in integer arithmetic.

## 7. The cluster correcting itself

Source: [`model-attestation`](model-attestation) section 6 and [`zkml-proofs`](zkml-proofs)
section 9. Four retractions stand across six essays, and every one came from checking a number
against its source rather than against a summary.

<div style="overflow-x:auto">

<svg class="tsfig" viewBox="0 0 760 336" role="img" aria-labelledby="c7t c7d">
<title id="c7t">The four retractions the cluster made against its own earlier essays</title>
<desc id="c7d">Two correcting essays and their targets. model-attestation section 6 retracts the batch's own gap-gated verification as non-novel, DiFR having got there first, and reverses the claim that FHE gives no integrity in two sibling essays. zkml-proofs section 9 retracts the four-orders figure and the claim that zkML has no trust assumption.</desc>
<text class="hd" x="14" y="24">Four retractions across six essays, all self-inflicted and all published in place</text>
<text x="14" y="44">the correcting essay on the left, what it retracts in the middle, the essay corrected on the right</text>
<rect class="card" x="14" y="66" width="188" height="112"/>
<rect x="14" y="66" width="5" height="112" fill="#2a78d6"/>
<text class="lbl" x="32" y="92">model-attestation.md</text>
<text x="32" y="110">section 6</text>
<text x="32" y="140">two corrections, one of</text>
<text x="32" y="158">them reversing its own</text>
<text x="32" y="176">earlier headline claim</text>
<rect class="card" x="14" y="192" width="188" height="112"/>
<rect x="14" y="192" width="5" height="112" fill="#eb6834"/>
<text class="lbl" x="32" y="218">zkml-proofs.md</text>
<text x="32" y="236">section 9</text>
<text x="32" y="266">two more, both against</text>
<text x="32" y="284">a figure the batch had</text>
<text x="32" y="302">quoted twice</text>
<path class="arw" d="M206 96 L 250 96" marker-end="url(#a7)"/>
<path class="arw" d="M206 152 L 250 152" marker-end="url(#a7)"/>
<path class="arw" d="M206 222 L 250 222" marker-end="url(#a7)"/>
<path class="arw" d="M206 278 L 250 278" marker-end="url(#a7)"/>
<defs><marker id="a7" markerWidth="8" markerHeight="8" refX="7" refY="4" orient="auto"><path d="M0,0 L8,4 L0,8 z" fill="#898781"/></marker></defs>
<text class="crt" x="256" y="88">RETRACTED: gap-gated verification is novel</text>
<text x="256" y="106">DiFR, November 2025, got there first, with a clipped logit-gap</text>
<text font-size="13" x="256" y="122">statistic and seed synchronisation. Target: trustless-distributed-ai section 4</text>
<text class="crt" x="256" y="152">REVERSED: FHE gives confidentiality and zero integrity</text>
<text x="256" y="170">a provider that cannot read the prompt cannot recognise an audit,</text>
<text font-size="13" x="256" y="186">so encryption makes the audit unevadable. Targets: fhe-llm section 0</text>
<text x="256" y="202">and trustless-distributed-ai sections 0 and 1</text>
<text class="crt" x="256" y="232">RETRACTED: zkML is four orders of magnitude away</text>
<text font-size="13" x="256" y="250">the figure came from opML, February 2024, predating zkLLM and zkGPT.</text>
<text font-size="13" x="256" y="266">Targets: model-attestation section 7, trustless-distributed-ai section 7</text>
<text class="crt" x="256" y="290">RETRACTED: zkML is the only mechanism with no trust assumption</text>
<text font-size="13" x="256" y="308">right about the computation, wrong about the model.</text>
<text font-size="13" x="256" y="324">Target: trustless-distributed-ai section 7</text>
</svg>

</div>

| correcting essay | what it retracts | essays corrected |
|---|---|---|
| `model-attestation.md` section 6(a) | this batch's own gap-gated verification, as non-novel | `trustless-distributed-ai.md` section 4 |
| `model-attestation.md` section 6(b) | "FHE gives confidentiality and zero integrity" | `fhe-llm.md` section 0, `trustless-distributed-ai.md` sections 0 and 1 |
| `zkml-proofs.md` section 9(a) | "zkML is four orders of magnitude away" | `model-attestation.md` section 7, `trustless-distributed-ai.md` section 7 |
| `zkml-proofs.md` section 9(b) | "zkML is the soundest, the only one with no trust assumption" | `trustless-distributed-ai.md` section 7 |

Two more self-corrections are inside single essays. Chart 6 carries one:
`trustless-distributed-ai.md` section 6 leg 3 retracts its own claim that I-BERT's nonlinearities
are integer polynomials, quoting its own two sections earlier as the refutation. Chart 3 carries the
other: `fhe-llm.md` section 4 was rewritten after an audit found three prior-art errors, including
applying a 42.3x GPU speedup a second time and concluding "under a second" where the measured figure
is 37.3 s.

## What is not drawn here

- **`fhe-counting.md` is in the cluster but not on this page.** Its content is Lean scoping of four
  debts of `crypto/fhe.md` plus the independently confirmed `stirling` residual of +0.4068095 bits,
  one constant rather than a distribution, and a chart would add nothing to it.
- **No figure here is this page's own.** Every value is read off a named essay section, and where an
  essay labels a value DERIVED, PARAMETRIC or illustrative, that label is repeated above.
- **Nothing here is a verdict.** These are AI recommendations awaiting the owner's ruling, as the
  cluster's own neutral pointer (`TODO.md` `id:6646`) records them: pending, not decided. The scope
  question all three systems-security essays defer to him is the largest, and is not touched here.

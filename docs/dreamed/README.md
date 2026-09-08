---
title: Dreamed
permalink: /dreamed
---

# `docs/dreamed/` -- AI-generated exploration, NOT owner-authored, NOT reviewed

Everything under this directory was **dreamed by an AI agent**, not written by the owner
and not yet read by him. It is speculative exploration seeded from the owner's *own*
existing material (`physics/`, `essays/`, `docs/se-corpus.md`, his StackExchange corpus)
and nothing here has any authority.

**Status of every file in here: UNREVIEWED. Treat as a conversation starter, not content.**

## Hard rules for this directory

- Nothing here is theory. The repo's hard constraint (`CLAUDE.md`, `CONVENTIONS.md`
  "Working contract") reserves physics direction to the owner. These essays *propose*;
  the owner disposes.
- **Nothing here may be promoted into `physics/` or `essays/` without the owner
  explicitly authoring the move.** A copy-paste is not a promotion.
- `\veq` badges inside dreamed essays are **claims about the dreamed Lean file only**.
  They are NOT attestations against the repo's sidecar/verify machinery
  (`physics/*.toml`, `tests/test_verify.sh`) and are deliberately not wired into it.
- Runnable code lives in `docs/dreamed/<topic>/` (`resogram-lib/`, `fhe-search/`). It is
  dreamed too: unreviewed, not wired into `tests/`, and not part of `make test`. Where a
  search could be expensive it runs under a resource-capped wrapper.
- Lean files live in `docs/dreamed/lean/`. They are checked from `verify/` with
  `../docs/dreamed/capped.sh -m 6G -- lake env lean --threads=2 ../docs/dreamed/lean/<file>.lean`,
  so they are **not** part of the `verify` lake target and cannot break `make test`.
  `capped.sh` puts the run in a systemd user scope with a hard cgroup memory limit and
  no swap: a breach OOM-kills that scope alone. Do NOT substitute `ulimit -v` for Lean --
  it caps address space, and Mathlib mmaps its `.olean` files.

## Provenance

Session of 2026-09-01, owner-requested ("spawn some agents to be wildly creative on my
ideas"). Owner picked every seed; the AI picked none. Each essay states its seed and
which owner-authored file or SE post it grew from.

Second session, 2026-09-04: the FHE cluster below, owner-seeded on toy homomorphic
encryption, encrypted algorithms, and trustless distributed AI. Written directly rather
than by delegated agents, with prior-art research at the owner's explicit instruction
("don't not-invented-here", "don't blindly trust every publication").

Third session, 2026-09-07: the Bloch Truth cluster below, by four delegated agents.
Owner-seeded on a Spektrum article about the impossibility of a world formula, plus his
own claude.ai conversations on non-binary logic on the Bloch sphere. The seeds are his
2025-08-16 "Falsifiability and Logical Boundaries" thread and six companion threads found
by sweeping the export at his instruction ("there might have been multiple conversations
on that, double-check"), together with the idea's origin quote in his own idea pool at
`~/knowledge/sessions/claude-ai/` -- the pool `id:4bb2` cites. All Lean AND Python ran
under `capped.sh` (cgroup `MemoryMax`, no swap, CPU quota) at his instruction.

## Index

67 pages: 58 essays, 9 infographics. 53 Lean files, two runnable libraries, one runnable
search suite, one citation audit. Every Lean file was re-verified, not merely reported:
`exit 0`, zero `sorry`. Every "finding" below is an AI **recommendation** awaiting the
owner's ruling, never a settled decision. (`citation-audit.md` is the one essay with no Lean
companion, by design: it is an audit artefact, not a dream.)

### Infographics -- session of 2026-09-07

Nine visual summaries, owner-requested, covering all three dreaming sessions. Hand-authored
inline SVG: the site loads no CDN and no charting library, so that is the only thing that
renders. Every page passes `tests/test_dreamed_render.cjs` through both MathJax and KaTeX.
Charts follow the `dataviz` palette, validated rather than eyeballed. **These are figures,
not rulings**: where one carries a verdict it is that figure's reading of the essays, and
`docs/meeting-notes/2026-09-07-1508-bloch-truth-rulings.md` is the only ratified record.

| Figure | Covers | Worth a look for |
|---|---|---|
| [`fig-the-object`](dreamed/fig-the-object.html) | the Bloch Truth geometry | The ball and the triangle either side of a "project out phi" arrow, captioned *the same information, minus the angle*. Draws Goedel's sentence at **both** poles of the true/unprovable ball, which is why that encoding fails. |
| [`fig-cluster-map`](dreamed/fig-cluster-map.html) | all 19 Bloch Truth pages | 19 nodes, 27 edges, six typed edge kinds (corrects, refutes-own-parent, self-refutes, converges-with, adjudicates, builds-on). Lists the five edges dropped for legibility rather than thinning the graph quietly. |
| [`fig-boundary-and-big-five`](dreamed/fig-boundary-and-big-five.html) | undecidability + Reverse Mathematics | The Big Five ladder, `WKL_0` as a hub with seven equivalences radiating out, and conservativity drawn as an **architecture** statement: a strong layer that provably cannot corrupt the weak one below it. Mostly established mathematics, and says so. |
| [`fig-results`](dreamed/fig-results.html) | the cluster's only measurements | The scissors: gain and break-even swap rank between two panels sharing an x-axis. Re-ran the experiment rather than transcribing it. |
| [`fig-wirohsh`](dreamed/fig-wirohsh.html) | the WiRoHSH cluster | **The independence audit.** Only two of five essays bear on `id:ff32`, and the five grounds collapse to two roots, self-reported at `wirohsh-approximation.md:187`. The NO-GO survives on two legs, not five. |
| [`fig-fhe`](dreamed/fig-fhe.html) | the FHE cluster | A latency dot plot with an explicitly **empty lane** for end-to-end pure-FHE generation, and the zkML-versus-siblings overhead disagreement drawn as UNRESOLVED rather than settled. |
| [`fig-thermo-laser`](dreamed/fig-thermo-laser.html) | the entropy and laser wing | The Lambert-W branch panel: one horizontal cut through `u e^u` meeting it twice, `W_0` giving `beta E_1 = 0` exactly and `W_-1` giving 1.000000. Every CAS defaults to the wrong branch, so this is the wing's most practically dangerous finding. |
| [`fig-spine`](dreamed/fig-spine.html) | the QM spine audit | `physics/toesnail.md` as a line-number track with the l.126 asymmetry as a dashed rule, and Goedel I struck through in the omniscience panel as the one place he does **not** reach. |
| [`fig-wings-and-corpus`](dreamed/fig-wings-and-corpus.html) | corpus, wings, neighbouring repos | Grouped by **evidence type, not topic**, and argues why. The DAG bound (propagation caught, origination structurally invisible) scored on the real `edot` incident at 4 caught / 2 not. |

### Bloch Truth cluster -- session of 2026-09-07

Seeded on the owner's own backburner project "Bloch Truth" / "Bloch Truth Mapping".
Origin quote, `~/knowledge/sessions/claude-ai/2025-08-05_breaking_project_paralysis_cbae6cd6.md:1334`
(his turn, 2025-08-08): *"the Bloch Truth (might need a better name) might be useful for
the AI logic core in the second (ZFC?) layer where incompleteness applies (core layer
should only be complete, e.g. ZF without C)"*. All four essays bear on `id:4bb2`, which
`TODO.md` records as BLOCKED for want of a thesis statement.

| Essay | Lean | Headline claim (UNRATIFIED) |
|---|---|---|
| [`weltformel-impossibility`](dreamed/weltformel-impossibility.html) | `lean/Weltformel.lean` | The Spektrum piece reports Faizal-Shabir-Khan (EPL 148, 2024) and Faizal-Krauss-Shabir-Marino (JHAP 5(2), 2025). **Neither proves a theorem about physics**: both quote 1931-1974 logic plus asserted premises. Two located errors, quoted: P2 p. 4's *"any sentence S with K(S) > K_F is undecidable"* is false as written (counterexample `r = r`), and P1 p. 7 calls a **universe** inconsistent, a category error carrying its whole escape from Lucas-Penrose. Three impossibility claims get three verdicts; only **no self-certification** is established, and it limits self-reference, not physics. Cubitt-Perez-Garcia-Wolf (Nature 528, 2015) is a sharper honest bound. Fair credit: the Tarski step genuinely beats Goedel I here, surviving loss of effective axiomatizability. `omniscience.md`'s objection **transfers and gains force**. |
| [`logic-bloch-poles`](dreamed/logic-bloch-poles.html) | `lean/LogicBloch.lean` | The poles should be **provable / not provable**, the only exclusive-and-exhaustive assignment matching a two-outcome procedure; its cost is that the south pole conflates refutable with independent. **`true` vs `unprovable` is refuted**: Goedel's sentence is both at once. `false = e^{iπ}|1>` encodes nothing (global phase). The two-axis reading survives the density matrix exactly: `p(true) = (1+z)/2`, `S(ρ) = h((1+r)/2)`, `\|z\| ≤ r`. **The ball cannot represent a glut** -- Belnap's `B` sits above both T and F in the information order and nothing sits above a pure state, so the ball is Kleene, not Belnap. The equator is maximum certainty about an *orthogonal* question, not indeterminacy; the centre is no information. Goedel buys the z-diameter and nothing else. |
| [`logic-bloch-gates`](dreamed/logic-bloch-gates.html) | `lean/LogicGates.lean` | Read off the gates, the ball carries three structures and only one is a truth value. **Central negative finding: no rotation-covariant order on the equator exists**, so the angle cannot be a Kleene/Priest third value (machine-checked via torsion). Full CNOT Bloch action derived and checked to 1.7e-16: radius loss equals correlation gained, `r' = sqrt(1-C²)`. Phase kickback is the `b_x = -1` corner of that same formula, not a separate effect. The **implication reading fails twice**: the target back-acts on the control, and `(H⊗H) CNOT (H⊗H)` is CNOT reversed exactly. "Why a third qubit for AND" is answered by counting: three wires is a proven minimum. Kochen-Specker needs dimension ≥ 3, so contextuality is unavailable until CNOT. |
| [`logic-qutrit-su3`](dreamed/logic-qutrit-su3.html) | `lean/LogicQutrit.lean` | **The owner's dimension count was right**: pure qutrit states are `CP²`, real dim 4, on `S⁵`; the prior AI turn's "correction" was wrong the other way. **Main claim: the qutrit Bloch body is not a ball.** `det ρ ≥ 0` has no qubit analogue and reads `\|n₃\| + p_undec ≤ 1` -- polarisation plus undecidability weight cannot exceed 1. Machine-checked witness `diag(-1/6, 7/12, 7/12)` at 75 % of maximum Bloch length. The antipode of a pure logical value is **not a value**, so a three-valued state space has no *distinguished* negation. Colour not flavour, and the owner's own same-day group-theory thread had it right. Confinement language recommended dropped for **superselection**. |

#### Second wave, same session: the mixed-state fork and its follow-ons

The owner asked whether the Bloch **equator** can mean "unprovedness" and the **origin**
maximum non-knowledge, explicitly including mixed states (`r < 1`). That opened a fork on
what the density matrix is a state OF, which two agents argued in opposition and a third
adjudicated. Three further essays chase questions the first wave raised.

| Essay | Lean | Headline claim (UNRATIFIED) |
|---|---|---|
| [`logic-models-ensemble`](dreamed/logic-models-ensemble.html) | `lean/LogicModels.lean` | **Direction (i), the state is over MODELS.** Made precise it is a measure on the Stone space of the Lindenbaum-Tarski algebra, atomless *because* of Goedel-Rosser, hence Cantor space. Delivers the owner's layered architecture as a machine-checked dichotomy: a complete layer's Stone space is a POINT, an incomplete layer's is Cantor space. Central cost, unsoftened: every such state is **diagonal**, so the reachable set is the segment `\|z\| = r` and the ball is mostly empty. Defence: a C*-algebra's state space is a Bauer simplex **iff** the algebra is commutative. Four equator rescues tested; a pincer kills them all (dim >= 3 Kochen-Specker empties the model space, dim = 2 Gleason fails to force the ball). Fatal limit, self-reported: a coherent measure gives probability 1 to every theorem, so (i) has independence but never ignorance. |
| [`logic-epistemic-state`](dreamed/logic-epistemic-state.html) | `lean/LogicEpistemic.lean` | **Direction (ii), the state is over EPISTEMIC STATUS.** Four statuses land at the poles, the equatorial circle and the origin; `\|z\| <= r` is **derived from the simplex, not stipulated**. Its strongest evidence is the owner's own listed status *"probable but undetermined"* (`conv-falsifiability.md:366`), which (i) cannot express at all. Found by trying to prove the opposite: the circle is "unproved and settled", NOT "proved independent", because a *certainly decided, no idea which way* state sits on the same point (`report_conflates`, and it is Ellsberg's known-fair coin). Argues against its own interest that **the quantum structure is not needed**. |
| [`logic-models-vs-epistemic`](dreamed/logic-models-vs-epistemic.html) | `lean/LogicMerge.lean` | **The adjudication.** Recommends building on (ii), replacing the ball with the **report triangle** `{\|z\| <= r <= 1}`, and re-typing (i) as the semantics the report must be sound against. The two reachable sets differ as a proper containment (`equator_separates`). Decisive for the owner's application: inside (i), `z = 0` forces `r = 0`, so "proved undecidable, stop" and "got nowhere yet, spend budget" are the same point. **Largest correction: the cross-essay convergence on encoding (b) is not real** (both are encoding (a); it is shared inheritance of one word from the parent). Also deflates the simplex convergence to one theorem applied four times, and locates three prior-art errors in its siblings. |
| [`logic-bloch-phase`](dreamed/logic-bloch-phase.html) | `lean/LogicPhase.lean` | **What the equatorial phase can carry, given that it cannot be a truth value.** The owner's own suggestion, provability, **fails with a proof**: `□` distributes over `∧`, `∧` is idempotent, an idempotent group element is the identity (`box_phase_trivial`, whose K hypothesis is deliberately unused so nothing about GL can repair it); and GL is complete for **irreflexive** frames, which have no cycles. Ranked winner is **proof-relevance**, which gives **ℤ, not U(1)**. Concrete recommendation, from three independent routes: **look for a ℤ₂ grading, not a U(1) phase.** Girard's *phase semantics* flagged as a false friend. |
| [`logic-beyond-su3`](dreamed/logic-beyond-su3.html) | `lean/LogicBeyondSU3.lean` | **Non-SU(3) homes for a provability-aware logic.** Decisive structural finding: distinct density matrices of equal trace are never Loewner-comparable, so the Bloch body is a **flat antichain** with no meets and hence no residuated implication. **The qutrit carries truth values and no connectives**; Kadison's anti-lattice theorem (1951) kills it on effects too. Ranked: Heyting algebras + Kripke first, **GL as the metalayer** second (decidable in PSPACE while PA is not, Solovay-complete for PA, which *is* the owner's layered architecture already built). Goedel 1932 ends the n-valued programme for every finite n. |
| [`logic-simplex`](dreamed/logic-simplex.html) | `lean/LogicSimplex.lean` | **Builds the object four essays kept pointing at.** Four vertices defended; three is killed twice (dropping *open* forces `r = 1`, and the triple is not closed under conjunction), five is rejected on a stated **crux, not a proof**. The owner's geometry returns exactly, `\|z\| <= r <= 1` from `p >= 0` alone. It **carries connectives** where the ball carries none, but `indep AND indep = open`, so no idempotence, no lattice, no Heyting algebra, and the three-status fragment is **Kleene K3 relabelled**. New: the ball's `r` is a norm, the simplex's is affine, so `report_conflates` is **forced by mixing alone**, not a cost of the report format. |
| [`logic-z2-grading`](dreamed/logic-z2-grading.html) | `lean/LogicZ2.lean` | **Hunts the ℤ₂ its parent recommended, and refutes the recommendation.** The idempotence lemma is uniform in the codomain group, so `{+1,-1}` collapses exactly as `U(1)` does. Stronger and apparently unsourced: `x = x²` forces every odd element into the even part, so **a Boolean ring has no odd part, for any grading group**. The one honest ℤ/2 grading of a Boolean ring *is* the truth value. Winner instead: the **sign character on the permutation of atom occurrences in a proof**, which escapes because it lives on proofs and composes under **cut**, which is not idempotent. Polarity in focused systems loses to the same lemma. |
| [`logic-layered-core`](dreamed/logic-layered-core.html) | `lean/LogicLayered.lean` | **Designs the owner's layered core concretely.** Layer 0 is a decidable quantifier-free constraint language, complete *because* too weak to describe itself; Layer 1 is the incomplete theory; GL sits **beside** as the design-time audit language. Finding the owner most needs: **almost nothing structural is new.** The split is proof-carrying code (Necula-Lee, PLDI 1998); Milawa already built the eleven-level self-verifying tower; Harrison's SRI CRC-053 (1995) names the escape, **partial reflection schemas**. The repo's own Lean kernel is a live instance (Carneiro: a "decidable non-transitive underapproximation"). **The ball does not survive** the design. |
| [`citation-audit`](dreamed/citation-audit.html) | *(none, by design)* | **Verification artefact, not a dream.** Settles a caution the `logic-beyond-su3` draft had recorded: the attributed passage IS real. Sperling and Walmsley, Phys. Rev. A **97**, 062327 (2018) §IV.3 is titled *"True, false, and undecidable"* and puts true and false at the Bloch poles, an undecidable continuum at the equator, and a **double cone** as the convex hull of the classical set. **The geometry is published prior art from 2018; the logic is not.** 37 items audited: 28 CONFIRMED, 5 WRONG, 4 UNRESOLVED. The two Faizal papers came out clean, both quoted lines verbatim on the stated pages. Keynes 1921 ch. VI confirmed against the primary text. All 11 corrections were applied by the coordinator. |

#### Third wave, same session: SPECULATIVE MODE

The owner asked for agents to "dream on creatively, also hallucinate a bit intentionally with
then again sound logic for the investigations". These four essays therefore **invent**
mathematical objects that do not exist and then attack them with real apparatus. Two limits
were held absolutely and are visible in every file: **no invented citations** (where no prior
art was found, the text says so rather than supplying a plausible-looking reference), and
**every invented object is labelled `[INVENTED]` at the point of use** and listed in a numbered
inventory at the top. If a passage carries no such marker, it is established mathematics or a
checked citation. Three of the four kill their own construction, which is the mode working.

Note a shared caveat: this session's WebSearch budget was exhausted before these ran, so
prior-art sweeps used direct page fetches and metadata indexes instead. Each essay states this
and marks what it could not rule out.

| Essay | Lean | Headline claim (UNRATIFIED) |
|---|---|---|
| [`logic-complementarity`](dreamed/logic-complementarity.html) | `lean/LogicComplementarity.lean` | **Invents nine complementary pairs; all nine fail.** The cluster's open challenge was "name a pair of questions about a sentence that cannot be answered simultaneously". They do not exist: every candidate is a two-valued function of a point, conjunction is total in a Boolean algebra, so the joint cell **is** the meet (`no_logical_complementarity`, `no_uncertainty_relation_binary`). Two findings outrun the negative. **The bar and the ball are the same demand**, by published theorem: a state space is a simplex iff all measurements are compatible (Plávala 2016; Kuramochi 2020), so "name a pair" was the ball restated and the cluster ran one argument twice. Its third claim, that **proofs are broadcastable** and therefore refute the ball with no pair required, was **WITHDRAWN 2026-09-07 as invalid**: orthogonal states clone freely in quantum theory, so copying a published proof separates nothing (`review-essays.md` HIGH 1). The invented Adoption Algebra genuinely fails to commute and still dies, because **order-dependence of update is not order-dependence of evaluation**. |
| [`logic-counterfactual-boundary`](dreamed/logic-counterfactual-boundary.html) | `lean/LogicBoundary.lean` | **The undecidability boundary, walked from both sides.** Sharpness splits, and conflating the halves is the standard error. *Expressively* it is not sharp and not even a line: an infinite intermediate zone sits between Presburger and arithmetic and contains an **antichain**, Büchi arithmetic base 2 and base 3 being incomparable by Cobham-Semenov, with Skolem a fourth incomparable point. *In verdict* it is absolutely sharp: interpreting Robinson's Q is a threshold with nothing on it. Sharpest concrete result: **the cliff is reached by adding a SET, not an operation** -- addition plus the bare predicate "is a square" already defines multiplication, machine-checked. Consequence for the owner's architecture: a core that cannot interpret arithmetic **cannot talk about proofs at all**, since a proof is a finite sequence and sequences are pairing. It is a bounded dashboard, not a supervisor, and it cannot even verify that a report is about the sentence it claims. Locates a **fourth channel** (the report index) that `logic-layered-core.md` missed. |
| [`logic-proof-gauge`](dreamed/logic-proof-gauge.html) | `lean/LogicGauge.lean` | **Invents a gauge theory of proofs, then proves it flat.** Propositions as base, proofs as paths, cut as composition, the surviving sign as holonomy. It passes five gauge commitments by computation rather than fiat, and is then **exactly flat**: `flat_iff_exact` says a discrete connection over a nonempty base is flat iff it has a potential, and confluence plus strong normalisation supplies that potential as the normal form. Worse, over a set base holonomy dies on *every* loop. **The punchline retro-corrects its sibling: the sign is a POTENTIAL, not a holonomy** -- the braiding is a second vertex of the proof graph, not a loop in it. Verdict: a reformulation with one useful consequence, neither theory nor costume. Also returns a negative on the forcing-monodromy conjecture via directedness (Hamkins-Löwe S4.2), and demotes its own invented "Fibre-Confluence Pincer" as redundant against Lafont's Appendix B. |
| [`logic-thermodynamics`](dreamed/logic-thermodynamics.html) | `lean/LogicThermo.lean` | **Invents a thermodynamics of proof search, and calls it a costume worn over one real theorem.** The partition function exists **conditionally**: `sum a^n exp(-beta n)` converges iff `beta > log a`, so there is a critical temperature `T_c = 1/log a` above which no Boltzmann distribution over proofs exists (`partition_summable_iff`, proved as an iff). Measured on a concrete tiny Hilbert system (76 axiom instances, exact proof counts to n=26): `a = 2.3445`, `beta_c = 0.8520`, and mean proof length diverges at `T_c`, a genuine Hagedorn signature. But `T_c` **knows nothing about the goal** (the branching factor for proofs of one theorem matches that for all proofs to four digits). Verdict costume, on the repo's own standard: the Landauer floor is 2.871 zJ per settled sentence against ~34 J actually spent, a margin of `10^11` to `10^22`, where [`lasercool.md`](dreamed/lasercool.html) found `10^3` and the bound genuinely bites. **Refutes its own brief's premise**: `r` is not an order parameter (smooth sigmoid in budget, and non-monotone in clause density with a dip at the hardness peak). The quantity that sharpens at the SAT threshold is the truth lean **z**, which corrects four sibling essays. |

### FHE cluster (`crypto/fhe.md`) -- session of 2026-09-04

Companion code: [`fhe-search/`](fhe-search/) -- six stdlib Python scripts, plus
`stage0_logit_gaps.py` which needs torch/transformers and is excluded from the default
run, all under
[`fhe-search/run.sh`](fhe-search/run.sh) and [`capped.sh`](capped.sh), which impose a HARD cgroup
memory cap (`MemoryMax`, no swap) plus a CPU quota, so a runaway search is OOM-killed inside its
own scope and cannot take the machine down. `nice` alone does not do this and `ulimit -v` is wrong
for Lean (Mathlib mmaps its oleans). Every search is exhaustive over its stated space; the
Monte-Carlo experiments are seeded and labelled as such.

| Essay | Headline claim (UNRATIFIED) |
|---|---|
| [`fhe-toy-enumeration`](dreamed/fhe-toy-enumeration.html) | A toy two-operation FHE exists trivially, and is trivially broken. Exhaustively: a strict scheme keeps only $\log_2 k$ key bits on a $k$-bit word (Frobenius) against the OTP's $k$; key entropy and functional completeness are **exactly** incompatible; randomising bought **zero** key ambiguity (mean 1.000). Confirms Boneh-Lipton 1996 rather than discovering it. |
| [`fhe-encrypted-algorithm`](dreamed/fhe-encrypted-algorithm.html) | "Encrypted algorithm" names **three** problems with three answers, separated by who holds the key: private function evaluation (solved, $O(k\log k)$), obfuscation (VBB **impossible**), circuit privacy (a cost). The $2^n$ program-bit floor of `crypto/fhe.md:8` is a **lower bound over all encodings** and is attained. Obliviousness, not cryptography, is the structural tax. |
| [`fhe-llm`](dreamed/fhe-llm.html) | State of the art, concretely: **BERT-base under non-interactive FHE in 37 s on GPU** (NEXUS), **~5 min/token for LLaMA-7B and only via 3-party MPC**, and **no published end-to-end pure-FHE generative datapoint at all**. The gap is autoregression, not encryption. *(Section 4 was rewritten after an adversarial audit found three prior-art errors, all flattering to FHE.)* **The client should own the whole vocabulary boundary** -- saves >1 layer, $31\times$ bandwidth, deletes the vocabulary softmax exactly, removes the tokenizer side-channel class. OTRO/TDXRay is an argument **for** FHE over TEEs, not against. |
| [`model-attestation`](dreamed/model-attestation.html) | The "LLM footprint" exists: **Activation-DiFR** detects a 4-bit swap at AUC>0.999 from **2 output tokens**, and Model Equality Testing found **11 of 31** commercial Llama endpoints deviating from Meta's weights. Derived: a sampled token carries **0.033 bits** of identity evidence, an activation fingerprint **4.98** -- a factor of 150, so text-based verification pays a huge avoidable tax. **Main claim:** under FHE a provider cannot recognise an audit, so encryption makes sampled integrity checking **unevadable** -- reversing "FHE gives no integrity" in the two siblings, which are corrected. Also retracts this batch's gap-gating as non-novel (DiFR got there first). |
| [`zkml-proofs`](dreamed/zkml-proofs.html) | Written by a delegated agent; Lean re-verified by the coordinator (exit 0, zero `sorry`). Argues the zkML gap is **engineering, not structural** ($10^{3.2}$-$10^{3.8}$ overhead, sublinear in model size), which **contradicts** the sibling essays' "~4 orders away". Sharper finding: a zkML proof over *private* weights certifies an existential ("some admissible weights produce this output"), not "the promised model ran" -- so it answers the seed only if zero-knowledge over the weights is dropped, which is the property the provider wanted. |
| [`trustless-distributed-ai`](dreamed/trustless-distributed-ai.html) | Owner's MP3-vs-bit-exact-codec analogy is the same problem, not an analogy: autoregressive decoding **is** predictive coding, so drift compounds (1e-3 per-token divergence reproduces a 4096-token answer 1.7% of the time), and codecs already fixed it by mandating integer transforms. Integer-only transformers exist (I-BERT, INT8 end-to-end, 3.1-3.6$\times$ faster). **Convergence claim:** an integer-only model is both bit-exactly verifiable AND natively evaluable by the *exact* FHE schemes (BFV/BGV) rather than approximate CKKS -- one substrate, both halves of trustlessness. |

### WiRoHSH cluster (`physics/wirohsh.md`)

| Essay | Headline claim (UNRATIFIED) |
|---|---|
| [`wirohsh-splats`](dreamed/wirohsh-splats.html) | The truncated 3D reduction closes: the Wick rotation makes the direction **null**, so the `b_φ` family is redundant and the result is Whittaker 1903. Recommends **NO-GO on `id:ff32`**. |
| [`wirohsh-discontinuities`](dreamed/wirohsh-discontinuities.html) | Nothing is lost to non-holomorphy: the data returns as a **Sato hyperfunction boundary value**. `wirohsh.md:82` is false as written -- the line is analytic vs non-analytic, and a `C^∞` bump is on the wrong side. |
| [`wirohsh-refraction`](dreamed/wirohsh-refraction.html) | The 1+1 conformal-flatness hope is **half true**: rays, Fermat and Snell survive any profile, but a drift `(n'/n)∂_x` kills harmonicity except for `n = A/(x−x₀)²`. Snell/Fresnel **is** the Schwarz reflection principle. |
| [`wirohsh-ladder`](dreamed/wirohsh-ladder.html) | The ladder's parity is **not** Huygens: `d=1` is the ladder's best floor and Huygens' exception. The descent buys nothing and returns `d−2` continuous parameters. |
| [`wirohsh-approximation`](dreamed/wirohsh-approximation.html) | Completes the M-6 analogy as Laurent : two-sided Laplace. A **fifth** independent reason for the `id:ff32` NO-GO: analytic functions have no compact support, so the basis can never localize. |

### Spine and standing open questions

| Essay | Headline claim (UNRATIFIED) |
|---|---|
| [`spine`](dreamed/spine.html) | "Math on demand" fails asymmetrically at l.126. `:79` says ℂ cannot be ordered, `:89` writes `⟪Ψ\|Ψ⟫ > 0`. `:105`'s equality case is the **real** one; over ℂ it is the unit circle. |
| [`time-and-operators`](dreamed/time-and-operators.html) | Three obvious questions force a one-parameter unitary group; Stone then **derives** the Hamiltonian. `t1` at `:59` uses probabilities as coefficients, so it can come from a `U(t)` only if `p ∈ {0,1}`. |
| [`measurement-routes`](dreamed/measurement-routes.html) | All four routes into `## Observe` drafted. Disagrees with `spine.md` on ordering: POVM first, decoherence second. |
| [`omniscience`](dreamed/omniscience.html) | Omniscience fails by **arity**, not capacity (Lawvere). **Gödel I does not apply** to `\|42⟩`, contra corpus row M-5. |
| [`q2-galilei-vs-poincare`](dreamed/q2-galilei-vs-poincare.html) | **Q2.** Decisive asymmetry proved: the Galilei cocycle is not a coboundary, the Poincaré one is. Caveat stated: that is 1+1, where `dim H²(Poincaré) = 1`. |
| [`information-wing`](dreamed/information-wing.html) | **Q9.** Ratify with membership corrected: the wing coheres around `log W`, not "entropy". FHE is out; the one-time pad is in. |
| [`methodology-themes`](dreamed/methodology-themes.html) | **Q10.** "Move the problem, solve, move back" has ~8 instances and was under-ranked by its own note. "Reversibility is sacred" is a slogan (`grep` returns zero hits). |
| [`love-wing`](dreamed/love-wing.html) | **Q11.** The arc's invariant is a **Lyapunov quantity**, not the order parameter; Ott-Antonsen matches the Resogram's `ė` structurally. It breaks at Gottman. |
| [`photon-localizability`](dreamed/photon-localizability.html) | **Q12.** The Gaussian ansatz does not solve the wave equation and a per-index `σ_α` breaks covariance. But NW constrains an *operator*, and `A_μ` is a field. |
| [`q6-q7-q8-apparatus`](dreamed/q6-q7-q8-apparatus.html) | **Q6/Q7/Q8.** Status axis is orthogonal to the tier ladder (25 = 5×5). Q6 should extend `\definition`/`\assumption`. Cross-file `\eqref` renders `(???)` silently, which may settle Q8. |

### Thermodynamics, entropy, and the laser wing

| Essay | Headline claim (UNRATIFIED) |
|---|---|
| [`lasercool`](dreamed/lasercool.html) | The entropy margin is ~10³, not the ~10⁷ folklore implies: `σ_atom ≤ k_B·T_rec/T_D`. Reabsorption is a rate problem, not a second-law problem. |
| [`five-level-laser`](dreamed/five-level-laser.html) | **NO-GO at theorem strength.** Inversion and cooling are mutually exclusive at any pump strength; Scovil-Schulz-DuBois makes lasing-while-cooling require `T/T_p < 0`. |
| [`photon-energy-scaling`](dreamed/photon-energy-scaling.html) | No COP optimum exists (Carnot is the supremum). But the **power** optimum is `hν − μ = [4 + W₀(−4e⁻⁴)]k_BT = 3.920690395 k_BT`, the **Wien law with exponent 4**. |
| [`wick-entropy`](dreamed/wick-entropy.html) | The Laurent index `m` and the Matsubara index `n` are the same basis; reading the polar angle as the thermal circle forces the Unruh temperature. |
| [`lambertw-statistics`](dreamed/lambertw-statistics.html) | The bosonic inversion needs the **`W₋₁`** branch; the principal branch gives `βE₁ = 0` identically. The `N` family is Gentile, not anyons. |
| [`acoustics`](dreamed/acoustics.html) | A 12-row marking inventory proposed (not placed). Impedance matching **decouples** reflection from refraction, which optics cannot do. `acoustics.md` never states its adiabatic assumption. |

### Corpus items ratified for authoring (`id:e552`)

| Essay | Headline claim (UNRATIFIED) |
|---|---|
| [`casimir-field-equations`](dreamed/casimir-field-equations.html) | Row **P-C is wrong about the mechanism**: q/27195 is variational, not an eigenvalue equation, and its accepted answer gets Dirac from the **square root**. `W² = 0` does not follow from masslessness. |
| [`generators-and-bch`](dreamed/generators-and-bch.html) | Row **M-1 mislabels its posts**: 337971 is the curl-generalization question, not the self-answered dilation, and it holds a live 13-year-old gap of the owner's own. |
| [`discrete-noether`](dreamed/discrete-noether.html) | Discrete symmetry gives a **multiplicative** charge against Noether's additive one; Bloch quasi-momentum is the best analogue. |

### Other repos, dreamed here at the owner's request

| Essay | Headline claim (UNRATIFIED) |
|---|---|
| [`mw-collaib-triad`](dreamed/mw-collaib-triad.html) | `.mw` live at 0.12.0; **collAIb dormant 43 days**. A DAG catches propagation but **not origination**, which bounds what `.mw` can promise. Two bugs located in toesnail's own `hooks/post-commit`. |
| [`inflownistration`](dreamed/inflownistration.html) | The universal thesis is an **arity error**: information is three-place, and `T` is the missing decoder argument. Friston himself calls the FEP "almost tautological". |
| [`essay-wing`](dreamed/essay-wing.html) | The 2017 archive is one file, one evening; the concept is **thin**, and the sentence worth keeping is a task-list parenthesis about annotations rotting. |
| [`zelegator-helferli`](dreamed/zelegator-helferli.html) | The eval set is **saturated** (`I = log₂10` exactly), so it cannot score a distilled student. **No shared contract artifact**, with `id:29e3` due at the 2026-09-10 demo gate. |
| [`loderite-lodelore`](dreamed/loderite-lodelore.html) | Honest negative: cubic-26 **beats** BCC-14 on weighted path stretch. Greedy meshing is provably void on whole cells, contra `loderite/ARCHITECTURE.md:76`. |
| [`resogram-library`](dreamed/resogram-library.html) + [`resogram-lib/`](resogram-lib/) | **A runnable library, 39 tests passing.** The resogram is exactly `\|CWT\|²` for a causal kernel, an order-1 gammatone. `Resogram.md:118`'s `e^{+2βt'}` sign leaves a residual the opposite sign cancels. |

### Speculation (owner-authorised 2026-09-01, results still required to be sound)

| Essay | Headline claim (UNRATIFIED) |
|---|---|
| [`why-three-plus-one`](dreamed/why-three-plus-one.html) | `V_eff''(r₀) = (4−d)L²/(mr₀⁴)`, so stability needs `d < 4`. Tegmark disclaims deriving anything and never mentions Huygens tails. **The ladder adds nothing** to the question. |
| [`narrativium-formalized`](dreamed/narrativium-formalized.html) | The simplicity prior **inverts** the myth: a million-to-one chance costs 19-20 bits. Formalisable only as a theorem about bounded describers, which is Pratchett's own reading. |
| [`fhe-counting`](dreamed/fhe-counting.html) | Three counting debts closed with frozen signatures; the fourth is an **identification**, so a proof would only fix a stipulation. Independently **confirms** the `id:76e5` stirling finding. |

### Older index (kept for provenance)

Each row: the essay, the owner-authored thing it grew from, and the single claim it
would most want ratified or rejected.

| Essay | Lean | Seed | Headline claim (UNRATIFIED) |
|---|---|---|---|
| [`wirohsh-splats.md`](dreamed/wirohsh-splats.html) | `lean/Wirohsh.lean` | `physics/wirohsh.md`, truncated mid-formula; ROADMAP `id:ff32` | The 3D reduction closes because the Wick rotation makes the direction **null** (`∇u·∇u = 0`), so `a_φ(x_φ+iz)` is harmonic for any twice-differentiable `a_φ`. The `b_φ` family is redundant (`x_φ̄ = -∂_φ x_φ`), leaving Whittaker's 1903 formula. Recommends **NO-GO on `id:ff32`** as framed, with one gated salvage. |
| [`wick-entropy.md`](dreamed/wick-entropy.html) | `lean/WickEntropy.lean` | physics.SE q/143075 (corpus row P-I) + `physics/entropy.md` | The Laurent index `m` and the Matsubara index `n` are the **same basis** under `z = exp(2π(σ+iτ)/(ħβc))`. Reading the polar angle as the thermal circle forces `β = 2πr/(ħc)`, the Unruh temperature. `N=2` ↔ antiperiodic is an identity at the two limits used and a coincidence as a family. |
| [`omniscience.md`](dreamed/omniscience.html) | `lean/Omniscience.lean` | the `#TODO: try and proof whether omniscience is impossible?` in `physics/toesnail.md`; corpus row M-5 | Omniscience is defeated by **arity, not physics**: a knower inside what it knows has the shape `φ : A → (A → B)`, and Lawvere forbids it. **Gödel I does not apply** to `|42⟩` (contra row M-5, which welds Gödel and Lawvere into one line); Cantor/Lawvere applies directly, Tarski nearly. |
| [`lambertw-statistics.md`](dreamed/lambertw-statistics.html) | `lean/Statistics.lean` | the `\leanc` debt at `physics/entropy.md:59` (ROADMAP `id:37cc`, `id:5d31`) | The bosonic inversion is correct only on the **`W₋₁`** branch; on the principal branch (every CAS default) it collapses to `βE₁ = 0` identically. The fermionic case is genuinely two-valued. The `N` family is **Gentile** statistics, not anyons; the inversion stops closing in `W` at `N ≥ 3`. |
| [`spine.md`](dreamed/spine.html) | `lean/Spine.lean` | `physics/toesnail.md` audited against its own "math on demand" rule | **Before l.126 the maths arrives before the question; after it the questions arrive and no maths does:** four pieces of mathematics arrive before their demand, two demands after it are never paid. `:79` says complex numbers cannot be ordered; `:89` then writes `⟪Ψ\|Ψ⟫ > 0` for one. `:105`'s "parallel or anti-parallel" is the **real** equality case; over ℂ it is the whole unit circle. |
| [`lasercool.md`](dreamed/lasercool.html) | `lean/Lasercool.lean` | physics.SE q/669175 + row P-J (q/817764) + `docs/drafts/q669175-answer-draft.md` | The entropy inequality holds, but the margin is ~10³ (Rb87), not the ~10⁷ folklore implies, because **atoms are bad at shedding entropy**: `σ_atom ≤ k_B·T_rec/T_D = 4ω_rec/Γ`. Reabsorption is therefore a rate problem, not a second-law problem. |

### Findings surfaced, deliberately NOT filed

Each essay carries a "Surfaced for the owner" section. **No FINDING or VERDICT from either batch was written into `TODO.md`,
`ROADMAP.md`, or `REVIEW_ME.md`** -- routing a dreamed finding into a ledger is an owner
decision, and a delegated agent's verdict is a recommendation, never self-settling. Each
batch does get ONE neutral pointer item (`id:2460`, `id:6646`) whose body lists the
pending rulings *as pending*, so the batch is visible to `/relay human` without a verdict
being recorded. An earlier wording here said "nothing from this batch was written into
TODO.md" without that qualifier, which the repo contradicts. The candidates awaiting that ruling are the `id:ff32` NO-GO, the
`lambertw` branch qualifier, the spine's ordering clash and Cauchy-Schwarz equality case,
the four notation snags in `physics/wirohsh.md`, and the critique of the q/669175 draft.

---
title: Citation audit of the Bloch Truth batch (dreamed)
permalink: /dreamed/citation-audit
---

> **DREAMED, UNREVIEWED. NOT OWNER-AUTHORED.** Produced by an AI agent on 2026-09-07, not written
> by the owner and not read by him. See [`docs/dreamed/README.md`](./README.md). This file
> *proposes*; the owner disposes. Nothing here is toesnail theory.
>
> **This is an audit artefact, not an essay.** It carries no Lean companion, states no physics,
> and asserts nothing about the theory. It only checks whether the sibling essays cite the
> literature correctly. Where a sibling is wrong, the correction is written out below for the
> coordinator to apply; this file does not edit any sibling.

# What was checked, and how

Every item below records **how deeply the source was actually read**: full text, abstract only,
or secondary source. The owner's standing instruction is that abstracts and headline numbers
mislead, so a claim that depends on a paper's internals was chased into the internals or else
left UNRESOLVED. Nothing here is asserted from memory. An honest UNRESOLVED appears where the
fetch failed; it is not softened into "probably fine".

---

# 1. The primary question: arXiv:1803.04747

`logic-beyond-su3.md` §10 records a caution: that a search summary attributed to arXiv:1803.04747
a passage about "undecidable" states and a double cone, that the passage **is not in the paper**,
and that the attribution is therefore an unverified search-summary artefact, not to be cited.

**Verdict: the caution is WRONG. It is over-cautious, and expensively so.** The attributed passage
is in the paper, close to word for word, in a section titled *"True, false, and undecidable"*. The
paper is the closest published prior art to the owner's Bloch Truth idea that this batch has
found, and the caution currently instructs the reader to disregard it.

## 1.1 What the paper actually is

| Field | Value |
|---|---|
| Title | *Quasiprobability representation of quantum coherence* |
| Authors | J. Sperling, I. A. Walmsley |
| arXiv | [1803.04747](https://arxiv.org/abs/1803.04747), quant-ph |
| Versions | v1 13 Mar 2018; v2 21 Jun 2018 |
| Journal | **Phys. Rev. A 97, 062327 (2018)**, doi `10.1103/PhysRevA.97.062327` |

Subject: a general construction of quasiprobability representations for arbitrary notions of
quantum coherence. Any state is decomposed over a chosen set of "classical" states; a decomposition
with a non-negative distribution certifies classicality, and a necessarily signed one certifies
nonclassicality. Applications run from spectral decompositions to multipartite entanglement.

Read: abstract page in full, plus the ar5iv full-text rendering
(`https://ar5iv.labs.arxiv.org/html/1803.04747`) queried for content and section structure. The
raw PDF is the fetch that fails; **ar5iv succeeds**, and that is the whole story of the original
false negative.

## 1.2 Is the attributed content present? Yes.

The paper's section list contains, under IV Applications:

> **IV.3 True, false, and undecidable**

and the two sentences the caution says are absent are both there:

- *"This can be compared to a classical ternary logic, which consists of the isolated states
  'false' and 'true' and is extended by including 'undecidable' states."*
- *"In the Bloch-sphere representation, the convex set of classical states defines a double cone
  structure"* (with a reference to Fig. 4).
- *"The latter states |φ⟩ have an equal chance of being true or false and form a continuum."*

The construction: the classical reference set is taken as the two basis states plus the whole
equatorial family of equal superpositions,

$$\mathcal{C} = \{\,\lvert 0\rangle\langle 0\rvert,\ \lvert 1\rangle\langle 1\rvert\,\}
\cup \{\,\lvert \varphi\rangle\langle \varphi\rvert : 0 \le \varphi < 2\pi\,\},\qquad
\lvert \varphi\rangle = \tfrac{1}{\sqrt{2}}\big(\lvert 0\rangle + e^{i\varphi}\lvert 1\rangle\big).$$

Its convex hull is two cones sharing the equatorial disc as their common base: poles as apexes,
equator as rim. That is the "double cone". States inside it decompose with non-negative
coefficients; states outside are certified nonclassical by a negative minimum component, and
Fig. 4 colours the two regions.

The essay's own paraphrase -- *"the convex set of classical states defin[ing] a double cone
structure"* -- is a near-verbatim match to the paper's sentence. That is itself strong evidence
that the original search summary was reading the real text, not confabulating.

Read: ar5iv full-text rendering, section IV.3 queried directly (short quotes only; a verbatim
full-section reproduction was declined by the fetch tool on copyright grounds, so the quotes above
are the sentences it returned, each independently requested).

## 1.3 Where the claim came from

It came from arXiv:1803.04747 itself. None of the four hypotheses was needed:

- **Not a transposed or adjacent arXiv id.** The id is exact and the content is at that id.
- **Not a misattributed undecidability-in-state-space paper.** No substitution is required.
- **Not blended with an AQFT "double cone".** "Double cone" is indeed standard AQFT vocabulary for
  a causally complete region, and that was a reasonable suspicion, but Sperling and Walmsley use
  the phrase in its plain geometric sense for the bicone in the Bloch ball, and they use it in the
  same sentence as "undecidable". There is nothing to disentangle.
- **Not a hallucination.** The summary was right; the verification was wrong.

**Diagnosis of the original failure.** The abstract genuinely does not mention undecidability,
ternary logic, or a double cone -- the content sits in an applications subsection four levels down.
The verifier then tried the PDF, got undecodable binary, and treated "abstract silent + full text
unreadable" as evidence of absence. It is evidence of nothing. The correct move was the ar5iv
rendering, which the owner's own repo already knows about; the search summary was demoted on the
strength of a failed fetch rather than a successful one.

## 1.4 What survives, and what this is worth

**The narrow null result in the same section survives.** `logic-beyond-su3.md` §10 also says:

> **Searched, and NOT found:** any published work putting a *provability predicate*, or the
> provable/refutable/independent trichotomy, on a Bloch ball, a qutrit Bloch body, or any convex
> quantum state space.

That still stands. Sperling and Walmsley put a *labelling* on the Bloch ball -- poles as true and
false, equator as "undecidable" -- as an illustrative choice of classical reference set for a
quasiprobability construction. There is no provability predicate, no arithmetic, no Goedel, no
modal logic, and no claim that the labelling means anything logical. The paper is a quantum-optics
resource-theory paper and the logic vocabulary is an aside.

**But it is much more than nothing, and the caution currently buries it.** What Sperling and
Walmsley have is precisely the owner's Bloch Truth *geometry*, published in Phys. Rev. A in 2018:
true and false at the poles, a continuum of "undecidable" states at the equator, and a named
convex body -- the double cone -- separating states expressible over that set from states that are
not. That bears directly on three sibling findings and should be in front of the owner, not
disclaimed:

- `logic-bloch-poles.md` assigns the poles and reads the equator; Sperling-Walmsley made the same
  assignment first, for different reasons.
- `logic-bloch-gates.md`'s negative result -- no rotation-covariant order exists on the equator --
  is a statement about the same equatorial continuum, and now has a published object to attach to.
- `logic-qutrit-su3.md`'s "the qutrit Bloch body is not a ball" is a claim about the shape of an
  admissible convex body; the qubit case has a published precedent with a shape and a name.

**Recommended reframing, for the owner to rule on:** the honest position is *"the geometry is
published (Sperling-Walmsley 2018, PRA 97 062327); the logic is not"*. That is a stronger and more
defensible claim than either the original "closest prior art in existence" or the current "not in
the paper".

---

# 2. Secondary audit

Prioritised by risk. Quoted text with a page number on a public page is highest, then a flagged
hedge, then a named theorem attributed to a person and year.

## 2.1 The Faizal papers -- quoted text with page numbers

Both PDFs were downloaded and converted to text locally, so page numbers were checked by locating
the quote on the page rather than inferred. **Both quotes are verbatim and both page numbers are
right**, against the arXiv PDF pagination.

| Item | Verdict | Evidence | Depth |
|---|---|---|---|
| P1 identity: Faizal, Shabir, Khan, *Implications of Tarski's Undefinability Theorem on the Theory of Everything*, arXiv:2410.10903 (13 Oct 2024) | **CONFIRMED** | Authors are Mir Faizal, Arshid Shabir, Aatif Kaisar Khan; v1 only | Abstract page |
| P1 venue: EPL 148 (2024), doi `10.1209/0295-5075/ad80c2` | **CONFIRMED**, and can be made more precise: **EPL 148 (2024) 3, 39001** | arXiv journal-ref field | Abstract page |
| P1 quote, "p. 7": *"these criticisms do not apply to the actual $S_{\text{ToE}}$ in the Platonic realm, as it is impossible for actual $S_{\text{ToE}}$ in the Platonic realm to be inconsistent, as this would produce real inconsistencies in the universe/multiverse."* | **CONFIRMED verbatim, page 7 correct** | Located on page 7 of the 11-page arXiv PDF, in the Lucas-Penrose discussion, immediately after "a disjunction holds for human thought, i.e. human thought is either non-algorithmic or inconsistent" | **Full text**, `pdftotext` page split |
| P2 identity: Faizal, Krauss, Shabir, Marino, *Consequences of Undecidability in Physics on the Theory of Everything*, arXiv:2507.22950 (29 Jul 2025) | **CONFIRMED** | Authors are Mir Faizal, Lawrence M. Krauss, Arshid Shabir, Francesco Marino; v1 only | Abstract page |
| P2 venue: J. Holography Appl. Phys. 5(2) (2025) 10-21, doi `10.22128/jhap.2025.1024.1118` | **CONFIRMED** | Journal record at `jhap.du.ac.ir/article_488.html`; volume, issue, pages and DOI all match | Journal landing page |
| P2 quote, "p. 4": *"any sentence $S$ with prefix-free Kolmogorov complexity $K(S) > K_{F_{QG}}$ is undecidable in $F_{QG}$."* | **CONFIRMED verbatim, page 4 correct** | Page 4 of the 14-page arXiv PDF: *"Finally, Chaitin's information-theoretic incompleteness establishes a constant $K_{\mathcal{F}_{QG}}$ such that any sentence $S$ with prefix-free Kolmogorov complexity $K(S) > K_{\mathcal{F}_{QG}}$ is undecidable in $\mathcal{F}_{QG}$"* | **Full text**, `pdftotext` page split |
| P2's $\mathrm{True}(F_{QG})$ definition, "p. 4" | **CONFIRMED**, same page | The definition appears on page 4 | **Full text** |

**One precision worth adding on a public page**, not an error: "p. 4" and "p. 7" are **arXiv-PDF**
page numbers. P2's journal version paginates 10-21, so its p. 4 is journal p. 13. Say which
pagination is meant.

**Two published responses exist and neither essay mentions them.** Surfaced, not filed:

- Aatif Kaisar Khan, *Discussion on the Faizal-Krauss-Shabir-Marino Argument about the Theory of
  Everything*, J. Holography Appl. Phys. **6**(1) (Dec 2025) 126-132, doi
  `10.22128/jhap.2025.3160.1166`. Objects only that the framework risks anthropocentrism; proposes
  a Platonic non-algorithmic understanding generating "it from bit". Note that Khan is a P1
  co-author, so this is not an independent critique.
- Evan Redden, *Provability vs. Execution: A Comment on "Consequences of Undecidability in Physics
  on the Theory of Everything"*, [arXiv:2512.11807](https://arxiv.org/abs/2512.11807)
  (physics.hist-ph). Argues undecidability constrains provability but not computability or
  execution, so incompleteness cannot rule out simulation. Read: **abstract only.**
- A reply by the original authors also exists (`jhap.du.ac.ir/article_2056.html`); **not read.**

**Neither response locates either of the two errors the sibling essay located.** So
`weltformel-impossibility.md`'s two findings are, on the evidence available here, independent and
not scooped. That is a point in the essay's favour, and it should probably say so.

## 2.2 Flagged hedges, chased

| Flagged in | Item | Verdict | Depth |
|---|---|---|---|
| `logic-beyond-su3.md` §10 | arXiv:1803.04747 "not in the paper" | **WRONG** -- see §1 | Full text via ar5iv |
| `logic-epistemic-state.md` §7 | Keynes, *A Treatise on Probability* (1921) ch. VI, weight as a second dimension | **CONFIRMED from the primary text.** Ch. VI is titled *"The Weight of Arguments"*, p. 78. Keynes: the comparison *"turns upon a balance, not between the favourable and the unfavourable evidence, but between the absolute amounts of relevant knowledge and of relevant ignorance respectively"*, and *"New evidence will sometimes decrease the probability of an argument, but it will always increase its 'weight.'"* The two-axis reading is exact. | **Full text** (Project Gutenberg #32625, converted locally) |
| `logic-epistemic-state.md` §7 | arXiv:1703.04382, "probability measures over Heyting algebras", fetch failed twice | **RESOLVED, with a scope correction.** It is Ben Goertzel, *Cost-Based Intuitionist Probabilities on Spaces of Graphs, Hypergraphs and Theorems* (13 Mar 2017, cs.AI). It constructs an intuitionistic probability measure from a cost-based partial order on graph/hypergraph space, via Knuth-Skilling and Heyting algebras on graph space. It is **not** a general theory of probability over intuitionistic propositions, and the abstract does not itself assert $P(\varphi)+P(\neg\varphi) \ne 1$. No journal reference. | Abstract; the specific non-additivity property is **UNRESOLVED** |
| `logic-epistemic-state.md` §7 | *Quantum Reports* 6(2) 2024, physics misconceptions as mixed states, "full text blocked" | **CONFIRMED as to identity.** Chavarría-Garza, Aquines-Gutiérrez, Santos-Guevara, Martínez-Huerta, Morones-Ibarra, Saucedo, *Measuring the Density Matrix of Quantum-Modeled Cognitive States*, Quantum Reports **6**(2) (2024) 156-171, doi `10.3390/quantum6020013`, published 27 Apr 2024. Misconception present/absent are pure states, mixtures in between, n = 282 students. | Abstract + catalogue records; the **Bloch-like interior** sub-claim remains **UNRESOLVED** (MDPI returns 403) |
| `logic-epistemic-state.md` §7 | *"Bloch sphere and undecidability. Explicit null result."* | **WRONG** in light of §1. Sperling-Walmsley 2018 is exactly a Bloch-ball representation with true, false and a continuum of "undecidable" states. The null result must be narrowed to *proof status* / a provability predicate. | -- |
| `logic-models-ensemble.md` §5 | Demski / MIRI logical uncertainty, "primary papers not read in full" | **UNRESOLVED** -- deprioritised against the higher-risk items; not attempted. The hedge in the essay is appropriate and should stay. | Not attempted |
| `logic-beyond-su3.md` sources | Ben Yaacov and Pedersen, "Located for §9; not read in full" | **CONFIRMED as to identity**: *A proof of completeness for continuous first-order logic*, JSL **75**(1) (2010) 168-190, arXiv:0903.4051. Content still not read in full; the essay's hedge is correct and should stay. | Catalogue records |
| `logic-qutrit-su3.md` sources | Bigaj, "Located, not read in full" | **CONFIRMED as to identity**: T. Bigaj, *Three-valued Logic, Indeterminacy and Quantum Mechanics*, J. Phil. Logic **30** (2001) 97-119, doi `10.1023/A:1017571731461`. Hedge correct, keep it. | Catalogue records |

## 2.3 Named theorems, spot-checked

| Attribution as it appears | Verdict | Correct citation and evidence | Depth |
|---|---|---|---|
| "Ore's theorem (1951): every element of an infinite symmetric group is a commutator, so the group is perfect" (`logic-bloch-phase.md` §5.3) | **CONFIRMED** | Oystein Ore, *Some Remarks on Commutators*, Proc. AMS **2**(2) (Apr 1951) 307-314. His Theorem 6, p. 313: *"Any one-to-one correspondence of an infinite set to itself is a commutator."* That is exactly the essay's use. Guard against a different, wrong statement sometimes attached to the same citation: $S_n$ is **not** perfect (its derived subgroup is $A_n$); Ore's finite result is about $A_n$, and the finite-simple-group version is the Ore *conjecture*, which he raised only as a question. The essay does not make that error. | **Full first page and pp. 313-314** of the original scan |
| "Kadison's anti-lattice theorem (1951)" | **CONFIRMED** | R. V. Kadison, *Order properties of bounded self-adjoint operators*, Proc. AMS **2** (1951) 505-510. $\inf\{S,T\}$ exists in $B(H)_{sa}$ iff $S$ and $T$ are comparable. | Author's publication list + p. 1 of Foulis-Pulmannová arXiv:1706.01719 |
| "Goedel 1932: IPC has no finite characteristic matrix" | **CONFIRMED** | K. Gödel, *Zum intuitionistischen Aussagenkalkül*, Anzeiger der Akademie der Wissenschaften in Wien **69** (1932) 65-66; repr. Ergebnisse eines math. Kolloquiums 4 (1933) 40; Collected Works I, 222-225. Covers positive logic too. | Secondary (arXiv:1903.04625, relevant passage in full) |
| "Solovay (1976), arithmetical soundness and completeness of GL" | **CONFIRMED** | R. M. Solovay, *Provability Interpretations of Modal Logic*, Israel J. Math. **25** (1976) 287-304. | SEP *Provability Logic* bibliography + Springer record |
| "Feferman (1960), *Arithmetization of metamathematics in a general setting*" | **CONFIRMED** | S. Feferman, Fund. Math. **49**(1) (1960) 35-92. Intensionality is the paper's own point: which formula presents the axiom set changes what $\mathrm{Con}_T$ says, and he builds a non-standard numeration $\pi^*$ to prove it. | Feferman's own retrospective *My route to arithmetization*, pp. 1-4 in full |
| "Chang's completeness theorem for MV-algebras" | **CONFIRMED**, two papers not one | C. C. Chang, *Algebraic analysis of many valued logics*, Trans. AMS **88** (1958) 467-490 (introduces MV-algebras); *A new proof of the completeness of the Łukasiewicz axioms*, Trans. AMS **93** (1959) 74-80 (the completeness theorem proper). The essay cites only 1958 for both. | Secondary (Horn's JSL review, JSL 36:1 (1971) 159-160) |
| "Gleason: $\dim \ge 3$" | **CONFIRMED** | A. M. Gleason, *Measures on the closed subspaces of a Hilbert space*, J. Math. Mech. **6**(4) (1957) 885-893. Dimension $\ge 3$; dimension 2 has counterexamples. | Full encyclopedia article + article scan front matter |
| "Kochen-Specker (1967): $\dim \ge 3$" | **CONFIRMED** | S. Kochen and E. P. Specker, *The Problem of Hidden Variables in Quantum Mechanics*, J. Math. Mech. **17**(1) (1967) 59-87; original construction uses 117 directions in $\mathbb{R}^3$. **Nuance:** the companion claim that dimension 2 *admits* a non-contextual hidden-variable model rests on Bell's explicit spin-$\tfrac12$ model, and that model is non-contextual but **state-dependent**. If any sibling asserts a state-*independent* model in $d=2$, it overstates. `logic-bloch-gates.md` §5.3 says only that the theorem is false at $d=2$ and a model exists, which is safe. | SEP entry (relevant sections) + Mermin arXiv:1802.10119 in full for the $d=2$ model |
| "Cubitt, Perez-Garcia, Wolf, Nature 528 (2015) 207-211" | **CONFIRMED** | *Undecidability of the spectral gap*, Nature **528**(7581) 207-211, 10 Dec 2015, doi `10.1038/nature16059`. Verified from the article's own page footers for 207-210; p. 211 from ADS/PubMed metadata. Scope, quoted: *"families of quantum spin systems on a two-dimensional lattice with translationally invariant, nearest-neighbour interactions, for which the spectral gap problem is undecidable"* -- so **2D**, as `weltformel-impossibility.md` §6.1 has it. Full version arXiv:1502.04573, later Forum of Mathematics Pi (2022). | **Published PDF**, abstract and "Precise statement of results" |
| "E. D. Vol, arXiv:1205.6898 (2012)" and "Published (*Int. J. Theor. Phys.* **52**, 514-523, 2013)" | **CONFIRMED** | *Quantum theory as a relevant framework for the statement of probabilistic and many-valued logic*, submitted 31 May 2012, v1 only; published Int. J. Theor. Phys. **52**(2) (2013) 514-523, doi `10.1007/s10773-012-1355-8`. Łukasiewicz three-valued logic is treated at length in §2, and `diag(1,0,0)` / `diag(0,1,0)` are identified with true and false. `logic-models-vs-epistemic.md` §1.4's reading -- diagonality is a founding stipulation, not a result -- is supported by the text. | **Full text** (PDF extracted and grepped) |
| "zero citations" for Vol (`logic-models-vs-epistemic.md` §1.4) | **UNRESOLVED** | No citation-count source was fetched. A bare "zero citations" on a public page is a claim about a live database and will rot. Recommend softening to "very little cited" or dropping it. | Not verified |
| "Ellsberg 1961" | **CONFIRMED** | Daniel Ellsberg, *Risk, Ambiguity, and the Savage Axioms*, Quarterly J. Economics **75**(4) (1961) 643-669. | Catalogue records only |
| "Josang's subjective logic, *Int. J. Uncertainty, Fuzziness and Knowledge-Based Systems* 9(3)" | **CONFIRMED**, with a spelling correction | Audun **Jøsang**, *A Logic for Uncertain Probabilities*, IJUFKS **9**(3) (2001) 279-311; earliest version *Artificial Reasoning with Subjective Logic*, 2nd Australian Workshop on Commonsense Reasoning, Perth, 1997; book *Subjective Logic*, Springer, 2016. Core object: $\omega_x = (b_x, d_x, u_x, a_x)$ with **$b+d+u = 1$** -- the base rate $a_x$ is *not* part of the sum. | **Full text** of the 2001 preprint; the additivity form taken from a secondary statement because the preprint's glyph encoding mangles formulae |
| "Arrighi and Dowek's `Lineal`" | **CONFIRMED** | P. Arrighi and G. Dowek, *Lineal: A linear-algebraic λ-calculus*, arXiv:quant-ph/0612199 (Dec 2006), LMCS **13**(1:8) (2017) 1-33. | Abstract + records |
| "The $\mathcal{L}^{\mathbb{C}}$ programme (Diaz-Caro and Dowek, *Towards a Computational Quantum Logic*, 2025)" | **WRONG on authorship of the cited paper** | The 2025 overview is by **Alejandro Díaz-Caro alone**: *Towards a Computational Quantum Logic: An Overview of an Ongoing Research Program*, [arXiv:2504.07609](https://arxiv.org/abs/2504.07609), CiE 2025, LNCS **15764**, 34-46, doi `10.1007/978-3-031-95908-0_3`. The *programme* is joint with Dowek, whose source paper is A. Díaz-Caro and G. Dowek, *A linear linear lambda-calculus*, Math. Struct. Comp. Sci. **34** (2024) 1103-1137, doi `10.1017/S0960129524000197` (arXiv:2201.11221). **Second precision:** the calculus is $\mathcal{L}^{S}$ over a semiring $S$ of scalars; $\mathcal{L}^{\mathbb{C}}$ is the $S = \mathbb{C}$ instance. The logical fragment is IMALL, and the essay's "intuitionistic linear logic augmented with sums and scalars, categorical semantics using biproducts" is right. The essay's quoted subtitle *"an overview of an ongoing research program"* is exact. | **Full text** of the overview PDF |
| "Nakayama, *A comparison of two topos-theoretic approaches to quantum theory*, arXiv:1010.2031" | **WRONG author** | The paper is by **Sander Wolters**, 11 Oct 2010 (rev. Aug 2011), 62 pp, math-ph. The verbatim quote the essay uses -- *"the (complete) Heyting algebra of closed open subobjects of the spectral presheaf"* -- **is** in that paper's abstract, and so is the Isham-Döring / Heunen-Landsman-Spitters contrast. Only the author name is wrong. | Abstract page in full + independent search confirmation |
| "Baltag and Smets: LQP, *Math. Struct. Comp. Sci.* 16(3), 2006" | **CONFIRMED** | *LQP: The Dynamic Logic of Quantum Information*, MSCS **16**(3) (2006) 491-525. | Publisher record |
| "Baltag and Smets, *Synthese* 179(2), 2012" | **WRONG year** | Synthese **179**(2) is *Quantum logic as a dynamic logic*, 285-306, **2011**, doi `10.1007/s11229-010-9783-6`. The 2012 Baltag-Smets Synthese paper is a *different* one: *The dynamic turn in quantum logic*, Synthese **186**(3) (2012) 753-773. Volume and year have been crossed. | Publisher and repository records |
| "Beklemishev and Gabelaia, *Topological interpretations of provability logic*, arXiv:1210.7317" | **CONFIRMED** | L. Beklemishev and D. Gabelaia, submitted 27 Oct 2012, math.LO. Survey covering Simmons and Esakia, the Cantor derivative on scattered spaces, and GLP's topological completeness -- exactly as used. | Abstract in full |
| "a quantum treatment of the *semantic* liar, arXiv:quant-ph/0007047" | **CONFIRMED** | D. Aerts, J. Broekaert, S. Smets, *The Liar-paradox in a Quantum Mechanical Perspective*, Foundations of Science **4**(2) (1999) 115-132. | Abstract in full |

## 2.4 Tally

| Verdict | Count |
|---|---|
| **CONFIRMED** | 28 |
| **WRONG** | 5 |
| **UNRESOLVED** | 4 |

(37 items in total across §2.1 to §2.3.)

WRONG: the arXiv:1803.04747 caution; the `logic-epistemic-state.md` Bloch-undecidability null
result; the Wolters/"Nakayama" author; the Díaz-Caro/Dowek authorship of the 2025 overview; the
Baltag-Smets Synthese volume-year pairing.

UNRESOLVED: Vol's citation count; the *Quantum Reports* paper's Bloch-interior claim; whether
arXiv:1703.04382 asserts non-additive intuitionistic probability; the Demski/MIRI logical-
uncertainty primaries.

Nothing was left as "probably fine".

---

# 3. Corrections recommended

Exact file, section, and replacement text. **This file applies none of them.** The coordinator
applies them; the owner may of course reject any.

### C1. `docs/dreamed/logic-beyond-su3.md` §10, the paragraph beginning "**One negative worth recording as a caution.**"

Replace the whole paragraph with:

> **One near-miss found, and it is closer than expected.** Sperling and Walmsley,
> *Quasiprobability representation of quantum coherence*
> ([arXiv:1803.04747](https://arxiv.org/abs/1803.04747), Phys. Rev. A **97**, 062327, 2018), carry
> a section titled *"True, false, and undecidable"* (§IV.3). They take as their classical reference
> set the two basis states plus the whole equatorial family of equal superpositions, note that
> *"this can be compared to a classical ternary logic, which consists of the isolated states
> 'false' and 'true' and is extended by including 'undecidable' states"*, that *"the latter states
> $\lvert \varphi \rangle$ have an equal chance of being true or false and form a continuum"*, and
> that *"in the Bloch-sphere representation, the convex set of classical states defines a double
> cone structure"*. So the **geometry** of the owner's Bloch Truth mapping -- true and false at the
> poles, an "undecidable" continuum at the equator, a named convex body separating classical from
> nonclassical -- is published prior art from 2018. What is *not* there is any logic: no provability
> predicate, no arithmetic, no modal operator, no claim that the labelling means anything. The
> logic vocabulary is an illustrative aside in a quantum-optics resource-theory paper. The null
> result above therefore stands as stated -- nothing puts a *provability predicate* on a convex
> quantum state space -- but the honest summary of the prior art is **"the geometry is published,
> the logic is not."**

### C2. `docs/dreamed/logic-beyond-su3.md`, "Surfaced for the owner" item 11

Replace item 11 in full with:

> 11. **PRIOR ART LOCATED, and it is closer than this essay first reported.** §10. Sperling and
>     Walmsley (arXiv:1803.04747, Phys. Rev. A **97**, 062327, 2018) §IV.3 *"True, false, and
>     undecidable"* already places true and false at the Bloch poles, an "undecidable" continuum at
>     the equator, and a **double cone** as the convex hull of that classical set. An earlier draft
>     of this essay reported that passage as absent from the paper; that was an error, caused by
>     checking the abstract and a failed PDF fetch instead of the full text. The geometry is prior
>     art; the *logic* is not -- there is no provability predicate anywhere in it. Genuine
>     additional prior art: provability has a standard topological semantics (Esakia, Simmons;
>     Beklemishev-Gabelaia) and a standard Stone-dual one. **Ruling:** whether the project positions
>     itself explicitly as adding a provability reading to a published Bloch geometry, which the
>     evidence now supports.

### C3. `docs/dreamed/logic-epistemic-state.md` §7, the paragraph beginning "**Bloch sphere and undecidability.** Explicit null result."

Replace the first two sentences with:

> **Bloch sphere and undecidability.** Narrowed null result. A Bloch-ball representation with true
> and false at the poles and an "undecidable" continuum at the equator **does exist in the
> literature** -- Sperling and Walmsley, Phys. Rev. A **97**, 062327 (2018), §IV.3, where its convex
> hull is a double cone. What searches did not find is any representation of a *mathematical
> proposition's proof status*: no provability predicate, no arithmetic, no settledness dimension.

### C4. `docs/dreamed/logic-epistemic-state.md` §7, the Keynes sentence

Replace *"the primary text could not be fetched and this is flagged **unverified**"* with:

> the primary text confirms it: ch. VI is titled *"The Weight of Arguments"* (p. 78), and Keynes
> writes that the comparison *"turns upon a balance, not between the favourable and the unfavourable
> evidence, but between the absolute amounts of relevant knowledge and of relevant ignorance
> respectively"*, adding that *"new evidence will sometimes decrease the probability of an argument,
> but it will always increase its 'weight.'"* The two-axis claim is a century old.

Consequential edits in the same file: item 7's *"(unverified) Keynes 1921"* becomes *"Keynes 1921"*,
and "Surfaced for the owner" item 4 ("Verify the Keynes attribution against the primary text") is
now discharged and should say so.

### C5. `docs/dreamed/logic-epistemic-state.md` §7, the arXiv:1703.04382 sentence

Replace *"could not be fetched and is reported as an **unverified lead**"* with:

> resolves to Ben Goertzel, *Cost-Based Intuitionist Probabilities on Spaces of Graphs, Hypergraphs
> and Theorems* (arXiv:1703.04382, 2017), which builds an intuitionistic probability measure from a
> cost-based partial order on graph and hypergraph space. It is a construction on a specific space
> rather than a general theory of probability over intuitionistic propositions, and whether it
> yields $P(\varphi) + P(\neg\varphi) < 1$ was not verified beyond the abstract.

Consequential edit: "Surfaced for the owner" item 5 ("Chase arXiv:1703.04382 ... the fetch failed
twice") should be updated to record that the identifier resolved and what it turned out to be.

### C6. `docs/dreamed/logic-beyond-su3.md`, "Sources consulted", the Nakayama entry

Replace *"K. Nakayama"* with **"S. Wolters"**. Also fix the in-text mention in §2.4: *"Nakayama's
comparison paper states it plainly"* becomes *"Wolters's comparison paper states it plainly"*. The
quotation and the arXiv id are correct as they stand.

### C7. `docs/dreamed/logic-bloch-phase.md` §7 (and its §"Surfaced" echo), the $\mathcal{L}^{\mathbb{C}}$ bullet

Replace with:

> - **The $\mathcal{L}^{S}$ / $\mathcal{L}^{\mathbb{C}}$ programme** (Díaz-Caro and Dowek):
>   intuitionistic multiplicative-additive linear logic augmented with sums and scalars, with
>   categorical semantics using biproducts, so that $\sum_i \alpha_i t_i$ is a proof of a
>   superposition type. The calculus is $\mathcal{L}^{S}$ over a semiring $S$ of scalars;
>   $\mathcal{L}^{\mathbb{C}}$ is the $S = \mathbb{C}$ instance. Source paper: A. Díaz-Caro and
>   G. Dowek, *A linear linear lambda-calculus*, Math. Struct. Comp. Sci. **34** (2024) 1103-1137.
>   The overview cited here, *Towards a Computational Quantum Logic: An Overview of an Ongoing
>   Research Program* (CiE 2025, LNCS 15764, 34-46; arXiv:2504.07609), is by **Díaz-Caro alone**.
>   Its own subtitle is *"an overview of an ongoing research program"*, and that framing is what was
>   verified, not any specific theorem in it.

### C8. `docs/dreamed/logic-epistemic-state.md` §7, the Baltag-Smets citation line

Replace *"*Synthese* 179(2), 2012"* with **"*Synthese* **179**(2), 285-306, 2011"**. If the 2012
paper was the one intended, the correct reference is *The dynamic turn in quantum logic*, Synthese
**186**(3) (2012) 753-773; both are legitimate, but the volume and the year as currently paired do
not exist.

### C9. Minor, all files: name spelling

"Josang" should be **"Jøsang"** (`logic-epistemic-state.md` and `logic-models-vs-epistemic.md`,
several occurrences). Low stakes, but it is a living author's name on a public page.

### C10. Minor, `docs/dreamed/logic-beyond-su3.md` "Sources consulted", the Chang entry

Chang's *completeness* theorem is the 1959 paper, not the 1958 one. Suggest: *"C. C. Chang,
'Algebraic analysis of many valued logics', Trans. AMS **88** (1958) 467-490 (MV-algebras), and 'A
new proof of the completeness of the Łukasiewicz axioms', Trans. AMS **93** (1959) 74-80 (the
completeness theorem)."*

### C11. Minor, `docs/dreamed/weltformel-impossibility.md`, the P1/P2 table and the quote sites

Two precisions, neither an error:

- Give P1's full locator: **EPL 148 (2024) 3, 39001**.
- Say which pagination "p. 4" and "p. 7" refer to. Both are correct against the **arXiv PDF**;
  P2's journal version paginates 10-21, so its p. 4 is journal p. 13. Suggested wording: "P2
  p. 4 (arXiv PDF pagination; journal p. 13)".

---

# 4. Surfaced for the owner

Recommendations only. A delegated agent's verdict is never self-settling, and none of this has
been written into `TODO.md`, `ROADMAP.md` or `REVIEW_ME.md`.

1. **The Sperling-Walmsley find changes the batch's prior-art story, and the owner should rule on
   how it is framed.** The available framings are: (a) the geometry is published and Bloch Truth
   adds the provability reading; (b) Bloch Truth is a fresh construction that happens to coincide
   geometrically. On the evidence, (a) is the defensible one. This bears directly on `id:4bb2`,
   which `TODO.md` records as BLOCKED for want of a thesis statement -- "add a provability predicate
   to a published Bloch geometry" is a candidate thesis statement, and it is now supported rather
   than speculative. **Ruling needed:** which framing, and whether it unblocks `id:4bb2`.

2. **The failure mode that produced the false caution is worth a rule, not just a fix.** "Abstract
   is silent + full-text fetch failed" was treated as evidence of absence. It is evidence of
   nothing. The cheap mechanical guard: when a PDF fetch returns undecodable binary, try the ar5iv
   HTML rendering (`https://ar5iv.labs.arxiv.org/html/<id>`) before recording a negative, and if
   both fail, record UNRESOLVED rather than ABSENT. **Ruling needed:** whether this becomes a
   standing instruction. Note the shape of the near-miss: the caution was written *in compliance
   with* the owner's check-the-real-scope rule and still reached the wrong answer, because the rule
   says read past the abstract and the agent could not, and then concluded anyway.

3. **Two published responses to the Faizal papers exist** (§2.1) and neither sibling essay mentions
   them. Neither locates the two errors `weltformel-impossibility.md` locates, so that essay's
   findings appear independent -- which strengthens the open question of whether to report them to
   the authors. **Ruling needed:** whether to cite the responses, and whether that changes the
   already-open report-or-record call.

4. **A live-database claim on a public page.** "Zero citations" for Vol (§2.3) was not verified and
   will rot regardless. **Ruling needed:** soften or drop.

5. **What this audit did not cover.** The batch carries hundreds of references; this pass checked
   thirty-seven items chosen by risk. Unchecked in bulk: every citation in `logic-bloch-poles.md`,
   `logic-bloch-gates.md` and `logic-models-ensemble.md` that was not flagged and not a named
   theorem. Given that two wrong author attributions and one wrong volume-year turned up in a
   sample of this size, the base rate of citation error in the batch is **not** negligible, and a
   full sweep before any public write-up is worth its cost. **Ruling needed:** whether to commission
   one -- which is the same call `logic-beyond-su3.md` item 11 and `logic-qutrit-su3.md` item 10
   already put to the owner.

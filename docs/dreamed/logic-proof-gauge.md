---
title: A gauge theory of proofs
permalink: /dreamed/logic-proof-gauge
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This file *proposes*; the owner disposes. Nothing here is toesnail theory, and nothing may be
> promoted into `physics/` or `essays/` without the owner authoring the move himself. The `\veq`
> badges below claim something about [`docs/dreamed/lean/LogicGauge.lean`](lean/LogicGauge.lean)
> **only**, and are deliberately not wired into `physics/*.toml` or `tests/test_verify.sh`.

> **THIS ESSAY INVENTS MATHEMATICS ON PURPOSE.** It was written under an explicit licence to
> construct objects that do not exist and then investigate them rigorously. Every invented object
> is listed in the Inventory below and marked **[INVENTED]** where it is first used. Established
> mathematics is cited; where I looked for prior art and found none, the essay says "no prior art
> found" rather than claiming novelty. **No citation here is fabricated**, and §8.3 states exactly
> which references were verified in this session and which were not.

**Seed.** Two findings in the sibling essays, joined at the owner's instruction. From
[`logic-z2-grading.md`](logic-z2-grading.md) §4.2, the one surviving $\mathbb{Z}_2$ in the whole
cluster: the sign character on the permutation of atom occurrences in a proof, which escapes that
essay's collapse lemma because it lives on **proofs** and composes under **cut**. From
[`logic-bloch-phase.md`](logic-bloch-phase.md) §6, the highest-ceiling and least-developed
candidate: **holonomy over a family of theories**, flagged there as passing its filters by
construction and therefore proving little.

The intuition to develop, in the owner's framing: if a proposition is a point and a proof is a
path and cut is composition of paths, then a sign that changes under braiding is a **holonomy**,
and the question is whether there is a genuine connection whose curvature means something logical.

---

# Inventory of Invented Objects

Nine constructions below are mine. None is established mathematics, none is claimed to model
anything, and each is marked **[INVENTED]** where it is first used.

| # | Name | What it is |
|---|---|---|
| **I1** | **The proof graph** $\mathcal{P}(\Gamma)$ | base space: vertices are proofs of one fixed sequent $\Gamma$, edges are single cut-elimination steps |
| **I2** | **The occurrence fibre** $\mathcal{O}(\Gamma)$ | fibre: the finite set of atom occurrences in $\Gamma$ |
| **I3** | **The transport character** $w(p,q)$ | connection: the permutation of $\mathcal{O}(\Gamma)$ that a rewrite $p \to q$ induces, and its sign |
| **I4** | **The Cut Connection** | the triple (I1, I2, I3) presented as a principal bundle with connection |
| **I5** | **Cut curvature** $F(p,q,r)$ | the failure of I3 to chain around a triangle |
| **I6** | **The Normalisation Gauge** | the potential supplied by the normal-form map of a confluent, strongly normalising system |
| **I7** | **The Fibre-Confluence Pincer** | my argument that curvature and a well-defined fibre are mutually exclusive. §4.3 demotes it: prior art kills the same case harder |
| **I8** | **Theory-space transport** | the same construction with theory presentations as vertices and interpretations as edges |
| **I9** | **Cut Gauge**, axioms CG1 to CG5 | the theory, named and axiomatised in §7 so someone else can pick it up or kill it |

Everything else here is either cited or is elementary mathematics discharged in
[`lean/LogicGauge.lean`](lean/LogicGauge.lean).

---

# 0. The headline, stated and not teased

**The gauge theory of proofs is real, it is exactly flat, and the reason it is flat is more
interesting than the theory.** Five results, in the order they matter.

**1. The deflation, and it is a theorem** (§3.1). A discrete connection over a nonempty base is
flat if and only if it comes from a potential, uniformly in the structure group, and a confluent
strongly normalising system hands you the potential for nothing: the normal form. It is also
*worse* than flat. In ordinary gauge theory a flat connection still detects the fundamental group;
here, if transport runs between *any* two proofs, the base is the complete graph on a set, which is
simply connected, and the holonomy detects nothing at all. Both halves are machine-checked.

**2. A located error in a sibling, independent of everything invented here** (§3.2).
[`logic-z2-grading.md`](logic-z2-grading.md) item 10 says every normalisation-invariant is a
function of the normal form, *"which the subformula property makes visible to truth"*. The first
half is right and I prove its geometric form; the second does not follow, because a sequent has
many cut-free proofs and the subformula property constrains which *formulas* occur, not which
*proof* you hold. That essay's own surviving candidate is the counterexample. Read correctly, the
argument does not vacate proof invariants, it **classifies** them.

**3. A second correction to the same sibling, found by computing** (§1.3). Its semantic
justification, *"on a two-dimensional $V$ the braiding has determinant $-1$"*, is true at
$\dim V = 2$ and **not robust**: $\det(\tau) = (-1)^{n(n-1)/2}$, which is $+1$ whenever
$n \equiv 0, 1 \pmod 4$, verified by exact computation for $n = 1 \dots 8$. Dimension is not a
logical datum, so the semantic witness is unsafe; the syntactic one is fine.

**4. Where curvature could live, and why it does not** (§4.2). Curvature needs non-confluent
cut-elimination, which in the standard example needs the structural rules of classical sequent
calculus. My **[I7]** pincer says those rules destroy the fibre, but published mathematics kills
the case harder and I report that in preference to my own argument: the example in Lafont's
appendix to *Proofs and Types* identifies **all** proofs of a given sequent. Where confluence
fails, the invariant is not curved, it is constant. That is the same collapse shape as the
sibling's idempotence lemma, arriving from the opposite direction.

**5. A negative answer to the sibling's forcing conjecture** (§4.4). Forcing extensions are
**directed** (product forcing), which is the frame condition behind Hamkins and Löwe's theorem that
the ZFC-provable modal logic of forcing is **S4.2**. A directed poset is a filtered category and
the nerve of a filtered category is contractible, so the base is simply connected and there is
nothing for monodromy to be. The hedge is stated in §4.4 and not buried.

**Verdict, §7, not hidden.** Cut Gauge is **not a costume and not a theory**. It is a bookkeeping
device carrying one elementary theorem, two located corrections and one unperformed calculation,
and I recommend against spending a session on it beyond the corrections.

---

# 1. Setting the geometry up honestly

## 1.1 The thing that usually kills it: what does "nearby" mean?

A connection compares fibres over *nearby* points. Propositions have no topology. You can give
them one by hand (the Stone topology on the Lindenbaum-Tarski algebra is the canonical choice, and
[`logic-models-ensemble.md`](logic-models-ensemble.md) uses it), but a Stone space is totally
disconnected: no nontrivial paths, hence no transport, hence every connection on it is vacuous.
That is the graveyard, and most gauge-flavoured proposals about logic die in it without noticing.

**I do not give propositions a topology.** The base is not propositions. It is **proofs**, and
"nearby" is the relation the proof system already supplies: two proofs are adjacent when one
rewrites to the other in a **single** cut-elimination step. **[INVENTED, I1]** That is not
arbitrary, and the reason matters: it is the same relation whose reflexive-transitive-symmetric
closure *defines proof identity* in the standard sense (Straßburger's survey of Hilbert's 24th
problem is the entry point). Any theory of proofs is already committed to it. I add no structure; I
read an existing structure as a graph.

What that buys and costs:

- **Buys** a combinatorial base with genuine loops. A rewrite graph has cycles, from **critical
  pairs**: two redexes in one proof, reduced in either order, converging. Those diamonds are the
  plaquettes.
- **Costs** the smooth picture entirely. No infinitesimals, no tangent spaces, no connection
  1-form, no covariant derivative. The right established analogy is **lattice gauge theory**, where
  transport lives on links and curvature on plaquettes and the continuum is never mentioned. That
  analogy is exact rather than decorative, and everything below is a lattice construction.

## 1.2 The dictionary

| Gauge object | Logical reading | Status |
|---|---|---|
| **Base** | $\mathcal{P}(\Gamma)$: proofs of a fixed sequent, edges are single reduction steps | **[INVENTED, I1]** |
| **Fibre** | $\mathcal{O}(\Gamma)$: the finite set of atom occurrences in $\Gamma$ | **[INVENTED, I2]** |
| **Structure group** | $\mathrm{Sym}(\mathcal{O}(\Gamma))$, or its abelianisation $\{+1,-1\}$ | **[INVENTED, I2]**; the abelianisation being $\mathbb{Z}/2$ is standard |
| **Bundle** | $\mathcal{P}(\Gamma) \times \mathcal{O}(\Gamma)$, canonically trivial: every proof of $\Gamma$ has the same endsequent, hence the same occurrences | **[INVENTED, I4]** |
| **Connection** | $w(p,q) \in G$, the permutation of occurrences induced by the rewrite $p \to q$ | **[INVENTED, I3]** |
| **Gauge transformation** | a relabelling $A : \mathcal{P}(\Gamma) \to G$ of occurrences, chosen independently at each proof | **[INVENTED, I4]** |
| **Curvature** | $F(p,q,r) = w(p,q)\,w(q,r)\,w(p,r)^{-1}$ | **[INVENTED, I5]** |
| **Holonomy** | the ordered product of $w$ along a closed walk | **[INVENTED, I4]**; the algebra is elementary |

Two honest observations before anything is proved.

**The bundle is canonically trivial.** All fibres are literally the same finite set, so there is a
canonical flat reference connection, $w \equiv \mathrm{id}$, and $w$ measures deviation from a
preferred trivialisation. In real gauge theory the connection is extra data because the bundle is
*not* canonically trivial. This is the single largest structural disanalogy and no vocabulary
repairs it. §7 counts it against the construction.

**The structure group is not a free choice, and this is where the construction inherits genuine
rigidity.** For a base with at least two occurrences, the sign is the **unique** nontrivial
homomorphism $\mathrm{Sym}(\mathcal{O}) \to \mathbb{Z}^\times$:

$$ f : \mathrm{Sym}(\mathcal{O}) \to \mathbb{Z}^\times, \ f \ne 1
   \;\Longrightarrow\; f = \mathrm{sgn} \veq{sign-unique}\lean $$

(`sign_unique`, with `holonomy_character_dichotomy` giving the two-element classification and
`sign_ne_trivial` showing it is not degenerate). The proof is three standard facts pointed at each
other: all transpositions are conjugate, conjugacy is trivial in a commutative target, and
transpositions generate. Two people looking independently find **the same** sign, on the nose and
not merely up to a global flip. That upgrades criterion (d) of
[`logic-z2-grading.md`](logic-z2-grading.md) §1 from taste to theorem, and it is the strongest
structural fact in this essay.

## 1.3 The minimal witness, and a correction to how the sibling justified it

The identity and the braiding on $A \otimes A \multimap A \otimes A$ prove the same sequent and
carry opposite sign:

$$ \mathrm{sgn}(\mathrm{id}) = +1 \ne -1 = \mathrm{sgn}(\tau) \veq{braiding}\lean $$

(`identity_and_braiding_differ`, stated in Lean about $\mathrm{Sym}(\{0,1\})$; identifying that
group element with a braiding in a monoidal category is the essay's reading and is **not**
formalised). No provability measurement separates these two proofs. The sign does.

The sibling justifies the sign **semantically**: *"in any model where $A$ denotes a space $V$ ...
on a two-dimensional $V$ the braiding has determinant $-1$: it fixes the three-dimensional
symmetric part and negates the one-dimensional antisymmetric part."* That is correct at
$\dim V = 2$ and **it does not generalise**. The swap on $V \otimes V$ has eigenvalue $+1$ on
$\mathrm{Sym}^2 V$ of dimension $n(n{+}1)/2$ and $-1$ on $\Lambda^2 V$ of dimension $n(n{-}1)/2$,
so

$$ \det(\tau_{V \otimes V}) = (-1)^{n(n-1)/2}, \qquad n = \dim V $$

which has period 4 in $n$. I built the $n^2 \times n^2$ permutation matrix and computed its
determinant as an exact cycle parity for $n = 1 \dots 8$, and it agrees: $+1, -1, -1, +1, +1, -1,
-1, +1$. **In a four- or five-dimensional model the braiding's determinant is $+1$ and the
semantic witness reports nothing.** Since the dimension of an interpreting space is not a logical
datum, the sibling's semantic route is not a safe justification of the sign.

This does not damage the sibling's conclusion, only its argument. The *syntactic* witness is
robust: the transposition of two occurrences has sign $-1$ in $\mathrm{Sym}(\mathcal{O})$ for every
$\mathcal{O}$ with at least two elements, full stop, and by $\veq{sign-unique}$ that character is
unique. **Lean the syntax, not the semantics.** I found no prior art stating the determinant
formula in a proof-theoretic context, and I am not claiming the formula itself is new: it is a
standard consequence of the symmetric/antisymmetric decomposition, and I re-derived it here rather
than cite it.

---

# 2. Testing the analogy where it can break

A gauge theory makes commitments. Naming something a connection and not checking them is how a
costume is made. Five commitments, each discharged in Lean rather than asserted.

| Commitment | Statement | Verdict |
|---|---|---|
| **Endpoint-composable** | $\mathrm{hol}(p,\ell)\cdot\mathrm{hol}(\mathrm{end}(p,\ell),m) = \mathrm{hol}(p,\ell \mathbin{+\!\!+} m) \veq{concat}\lean$ (`hol_concat`) | passes, for arbitrary $w$ |
| **Genuinely path-dependent** | $\mathrm{hol}(0,[2]) \ne \mathrm{hol}(0,[1,2])$, $F(0,1,2) = -1 \veq{curved}\lean$ (`wEx_path_dependent`, `wEx_curved`) | passes |
| **Contractible loop trivial** | $w(q,p) = w(p,q)^{-1} \Rightarrow \mathrm{hol}(p,[q,p]) = 1 \veq{backtrack}\lean$ (`hol_backtrack`) | passes |
| **Curvature is the smallest holonomy** | $F(p,q,r) = \mathrm{hol}(p,[q,r])\cdot\mathrm{hol}(p,[r])^{-1} \veq{curv-hol}\lean$ (`curv_eq_triangle_holonomy`) | passes, exactly, not to first order |
| **Bianchi** | $F(q,r,s) - F(p,r,s) + F(p,q,s) - F(p,q,r) = 0 \veq{bianchi}\lean$ (`bianchi`) | passes, and is **thin evidence** |

Three of these deserve a sentence each.

**Path-dependence is the one that matters**, because without it the framework would be a costume
with nothing inside. The witness `wEx` transports $-1$ along every edge between distinct points of
a three-element base; `wEx_not_exact` then says it admits no potential at all. So flatness is a
hypothesis with content and not a theorem of the framework, which is what §3 needs for its
conclusion to mean anything.

**Curvature being the smallest loop's holonomy is where most discrete analogies fudge**, since a
graph has no infinitesimals. Here it is an identity, not an approximation, and that is exactly the
lattice-gauge-theory situation: on a lattice the curvature *is* the plaquette holonomy, with no
limit taken.

**Bianchi is a low bar and I flag it as such.** It is $\delta^2 = 0$ for the simplicial coboundary
and holds for *any* function of pairs whatsoever, so it says nothing about logic and nothing about
the invention. It is here because the essay claims the analogy is structural rather than verbal,
and this is one of the few places that claim can be made checkable at all. (`acurv_eq_curv` records
that the additive spelling is the same object transported along `Multiplicative`, so the statement
cannot be accused of being about a different thing.)

**Five commitments, five passes**, which is the moment to become suspicious, exactly as
[`logic-bloch-phase.md`](logic-bloch-phase.md) §6.1 was suspicious of holonomy passing filters it
was built to pass. §3 asks the construction to do something it was not built to do.

---

# 3. What is the curvature? The confluence problem, worked out

The tension, stated as sharply as I can make it, because the essay lives or dies on it.
**Confluence and strong normalisation say every proof has a unique normal form.** An invariant
preserved by rewriting is then a function of the normal form; a function of the normal form is a
function on the base alone; and a connection whose transport is a difference of values of a
function on the base is exact, hence flat. The gauge theory looks doomed before it starts.

Worked out, that intuition is **correct**, and its correct form is a theorem.

## 3.1 The flatness theorem

$$ \text{Flat}(w) \;\Longleftrightarrow\; \exists\, A : B \to G,\ \
   w(p,q) = A(p)^{-1} A(q) \veq{flat-exact}\lean $$

(`flat_iff_exact` over a nonempty base, with `flat_of_exact` and `exact_of_flat` as the halves.)
Three things about it.

**It is uniform in the structure group.** No property of $G$ is used: not commutativity, not
finiteness, not smallness. No cleverer structure group rescues anything. That is the same shape as
the sibling's own `phase_trivial_of_idempotent`, which was uniform in the codomain and thereby
killed the $U(1) \to \mathbb{Z}_2$ retreat. Both essays' central lemmas fail the same way for the
same reason: the obstruction never mentioned the group.

**The potential is exactly the normalisation gauge. [INVENTED, I6]** Read $A(p)$ as the transport
from $p$ to its normal form, which a confluent, strongly normalising system supplies canonically.
Then $w(p,q) = A(p)^{-1}A(q)$ says "to compare two proofs, normalise both and compare the
results", which is precisely what confluence licenses. The flatness theorem is not an accident of
the discrete setting: it is the geometric restatement of *unique normal forms*.

**It is worse than flat, which I did not expect.** In ordinary gauge theory a flat connection is
still interesting: its holonomy is a homomorphism $\pi_1(B) \to G$ and detects the fundamental
group. Here, if transport runs between *any* two proofs, the base is the complete graph on a set,
and

$$ \text{Flat}(w) \ \wedge\ \mathrm{end}(p,\ell) = p \;\Longrightarrow\;
   \mathrm{hol}(p,\ell) = 1 \veq{loop-trivial}\lean $$

(`hol_loop_trivial_of_flat`: *every* loop, not merely every contractible one). The consolation
prize a flat connection normally comes with is unavailable. If nontrivial flat holonomy is wanted,
the base must be **restricted** to actual rewrite steps, so the graph has cycles that are not
filled in.

## 3.2 The sibling's confluence-vacuity argument, and where it overreaches

[`logic-z2-grading.md`](logic-z2-grading.md) §4.1 argues, and repeats in item 10:

> in a confluent, strongly normalising system, "invariant under normalisation" and "function of
> the normal form" are the same condition, so there is no room for a non-trivial invariant that is
> not simply a property of the normal proof

and item 10 continues: *"which the subformula property makes visible to truth."*

**The first half is right and I have proved its geometric form. The second half does not follow.**
The subformula property says a cut-free proof contains only subformulas of its endsequent. It
constrains the *formulas* in a normal proof. It says nothing about **which** normal proof you have,
and a sequent generally has many: in multiplicative linear logic the cut-free proofs correspond to
admissible axiom linkings, and there are typically several. The identity and the braiding are both
normal, both have the subformula property, and $\veq{braiding}$ says they differ. So:

- "invariant under normalisation" $\Rightarrow$ "function of the normal form": **true**, and it is
  the flatness theorem;
- "function of the normal form" $\Rightarrow$ "visible to a truth or provability measurement":
  **false**, because provability sees the endsequent and the normal form is finer than the
  endsequent.

The distinction inverts the reading of the whole result. The sibling used the argument to *reject*
a candidate. Read correctly it *predicts the shape* of any legitimate candidate: a
normalisation-invariant proof invariant must be a function on normal proofs, and the sign of the
axiom linking is one. That is a classification, not a vacuity, and the surviving candidate
satisfies it rather than escaping it. The prior art confirms the classification rather than the
vacuity: Hughes' combinatorial proofs and Girard's Geometry of Interaction execution formula are
both invariants defined on or preserved by normalisation, and both exist.

## 3.3 So the sign is a potential, not a holonomy

Honest consequence, and it is a demotion of the sibling's recommended winner. Given the
classification, the occurrence-permutation sign of a proof is a function $A$ on normal proofs, and
the transport $w(p,q) = A(p)^{-1}A(q)$ built from it is exact by construction. There is a genuine
$\mathbb{Z}_2$-valued invariant of proofs, the sibling was right about that, and it is a
**0-form**, not a connection.

That is also the correct answer to the owner's framing question. A sign that changes under braiding
is not a holonomy: it is a value that differs at two points. It *looks* like a holonomy because the
braiding reads naturally as a path from the identity proof to itself, and that reading is exactly
what the flatness theorem forbids. **The braiding is not a loop in $\mathcal{P}(\Gamma)$. It is a
second vertex.**

There is one genuine bridge in the prior art that keeps this from being a pure deflation, and it is
worth the owner's eye. In the categorical formulation of Geometry of Interaction, the **cut
operator literally is a tensor of symmetries**: Hamano and Scott's Definition 3.21 defines
execution as a trace of $(\mathrm{Id} \otimes \sigma)\circ\pi$ where $\sigma$ is built from the
symmetry morphisms $s_{U,U}$. So the swap whose sign this essay is chasing is not an analogy for
cut; in that formalism it *is* cut. I found nobody who has attached a determinant or a sign to it,
and §1.3 is why one should be careful before doing so.

---

# 4. Where nontrivial holonomy could genuinely live

Three places, in decreasing order of how much I believe them.

## 4.1 Restrict the edges: the rewrite graph has a fundamental group

§3.1 is stated over a base where every ordered pair is an edge. A real rewrite graph is not like
that: its edges are single reduction steps and its cycles are the **critical pairs**. This is where
the construction becomes non-vacuous, and it turns "is there curvature?" into a finite question:

> **The Cut Connection is flat if and only if the occurrence-permutation sign is preserved by
> every critical-pair resolution.** **[INVENTED framing, I5]**

For any rewriting system with finitely many critical pairs that is a decidable check, one diagram
at a time, because the generating cycles of a locally confluent rewrite graph are exactly the
confluence diagrams. **This is the one calculation this essay recommends, and I did not do it.**

**Conjecture CG-1, labelled as conjecture.** For multiplicative linear logic proof nets,
cut-elimination is confluent and I expect the axiom linking to be preserved by every reduction
step, hence the Cut Connection there to be flat and the sign to be a potential, which is §3.3
again. What makes this plausible rather than idle is that the standard invariant of MLL
cut-elimination, Girard's execution formula, is by design invariant under reduction, and invariance
under reduction is exactness. I did not verify this and do not report it as verified.

## 4.2 Break confluence, and watch the invariant collapse instead of curve

If normalisation is not confluent there is no normal-form map, so §3.1's potential is unavailable
and flatness is not forced. That is the only structural escape hatch, and it is real: cut
elimination in the **classical sequent calculus** is non-confluent.

It is also a trap, and the prior art says so in terms I could not improve on. The example in
Lafont's appendix to Girard, Lafont and Taylor's *Proofs and Types* builds, from **any two proofs
$\pi$ and $\pi'$ of the same formula $B$**, a single proof that reduces to both, using a right
weakening, a left weakening, a cut and a right contraction. The appendix draws the conclusion
itself:

> More generally, all the proofs of a given sequent $A \vdash B$ are identified. So classical logic
> is inconsistent, not from a logical viewpoint ($\bot$ is not provable), but from an algorithmic
> one.

and

> Of course, our example shows that cut elimination in sequent calculus does not satisfy the
> Church-Rosser property: it even diverges in the worst way!

**Read through the present framework, that is not curvature. It is total degeneracy.** If every
proof of a sequent is identified by the reduction relation, then every reduction-invariant of
proofs is **constant** on that sequent, so $w \equiv 1$, so the connection is flat in the most
uninteresting way available. The escape hatch does not lead to a curved connection; it leads to no
connection at all. The same appendix records Joyal's categorical shadow of the same collapse: a
Cartesian closed category with an initial object $0$ such that $0^A \cong A$ is a poset.

Notice the shape. [`logic-z2-grading.md`](logic-z2-grading.md) §2 killed the propositional
$\mathbb{Z}_2$ because idempotence forces every graded element into the even part. Lafont's example
kills the classical proof-level $\mathbb{Z}_2$ because the reduction relation forces every proof
into one class. **Two different collapses, both structural, both leaving the invariant constant.**
That coincidence is the most informative single fact in this essay after the flatness theorem.

**What does survive is a potential, again.** Hetzl and Straßburger's *Herbrand-Confluence for Cut
Elimination in Classical First Order Logic* (CSL 2012) shows that although classical
cut-elimination is not confluent, it **is** confluent at the level of Herbrand disjunctions. In
gauge language: there is a genuine gauge-invariant observable of the non-confluent reduction, and
by $\veq{flat-exact}$ any such observable is a potential, not a holonomy. That is the third
independent confirmation of §3.1 in this essay, and the first one from published mathematics rather
than from my own construction.

## 4.3 The Fibre-Confluence Pincer, and why I am demoting my own argument

**[INVENTED, I7].** My own reason the recipe fails, offered second because §4.2's is better.

Confluence fails in classical sequent calculus *because of the structural rules*. Weakening
introduces a formula with no premise; contraction identifies two occurrences into one. So a rewrite
step across a structural rule **creates or destroys atom occurrences**, and therefore does not
induce a permutation of a fixed finite set. It induces a partial injection or a surjection. There
is no group, and a bundle whose fibres change size is not a principal bundle and admits no
connection in the sense used here. Hence:

> **Where the fibre is well defined, the connection is flat; where the connection could curve,
> there is no fibre.**

The multiplicative fragment, where occurrences are conserved exactly because there are no
structural rules, is precisely the fragment where confluence holds and §3.1 applies. That is not a
coincidence: resource-conservation makes both statements true at once.

**Demotion, stated plainly.** In the classical case the pincer is **redundant**: Lafont's example
already forces the invariant to be constant, without needing to observe that the fibre is
ill-defined. What the pincer adds is only the further observation that one cannot even *state* the
invariant there. That is a smaller contribution than I thought when I constructed it, and reporting
the stronger published kill in preference to my own argument is the point of looking for prior art
at all.

Two ways the pincer could still be wrong, both worth more than the pincer:

1. **A non-confluent system with conserved occurrences.** If one exists, the pincer breaks and the
   construction becomes interesting. Non-confluence *without* structural rules is the target. I
   found no example and did not search exhaustively.
2. **A structure group that tolerates fibre change.** Replace $\mathrm{Sym}(\mathcal{O})$ with an
   inverse semigroup or a groupoid of partial injections, which is what the maps actually are.
   Transport stops being invertible and holonomy stops being a group element, but the object is not
   nothing. That is the honest generalisation and it is a different essay.

## 4.4 Families of theories: a negative answer to the sibling's conjecture

**[INVENTED, I8]**: vertices are theory presentations or models, edges are interpretations or
forcing extensions, transport is whatever the interpretation does to a chosen structure.
[`logic-bloch-phase.md`](logic-bloch-phase.md) §6.3 conjectured that a closed loop of forcing
extensions returning to the ground model might carry a nonzero invariant, with ground-model
definability as the only reason to think it might. Its own objection, that independence gives a
**disconnected fibre** rather than a loop, stands. Here is a second one, which is sharper.

**Forcing extensions are directed, and a directed base is homotopically trivial.** Given two
set-forcing extensions $V[G]$ and $V[H]$ of a ground model, product forcing gives a common
extension. Directedness is the frame condition of the `.2` axiom
$\Diamond\Box p \to \Box\Diamond p$, and Hamkins and Löwe proved the corresponding completeness
result exactly: if ZFC is consistent, *"the ZFC-provable principles of forcing are exactly those in
the modal theory known as S4.2"*. Now, a directed poset is a filtered category, and the nerve of a
filtered category is contractible. So the base has trivial fundamental group, any flat connection
on it has trivial holonomy, and there is nothing for monodromy to be.

**Two hedges, both load-bearing, stated rather than buried.**

- The argument covers the **upward** multiverse: extensions of one ground model. A loop returning
  to $V$ must also come *down*, through grounds. Ground-model definability is real (Laver 2007,
  and Woodin independently: a model of ZFC is uniformly definable in its set-forcing extensions
  from a ground-model parameter), but the statement I would need is that the collection of grounds
  is downward directed, which is a substantial theorem I **did not verify in this session and do
  not cite**. If the generic multiverse is directed both ways, the argument closes; otherwise this
  section is incomplete rather than wrong.
- "The nerve of a filtered category is contractible" is standard homotopy theory. I report the
  statement, attach no source, and did not re-check one.

**Verdict: probably no, for a better reason than the conjecture feared.** The obstacle is not that
paths are hard to find. It is that the paths that exist are too well behaved, since directedness is
precisely the hypothesis that fills in every loop.

## 4.5 Feferman's presentations: a nontrivial transport that is not curvature

[`logic-bloch-phase.md`](logic-bloch-phase.md) §5.2 records that two extensionally correct
presentations of Peano Arithmetic behave differently, one yielding a provability predicate under
which PA proves its own consistency, and reads that as a confirmed prediction of a gauge reading:
the numbering is the global phase, the relation between presentations is the relative phase, the
derivability conditions are the gauge fixing. Feferman's 1960 paper is about exactly this
dependence on the choice of arithmetisation, so the reading is well founded.

Through the present framework it is a statement about transport being **nontrivial**, which is not
transport being **curved**. A nontrivial but exact transport is a gauge transformation, and a gauge
transformation is by definition empty. Feferman exhibits $w(p,q) \ne 1$ for two presentations. He
does not exhibit a **triangle** of presentations with $F(p,q,r) \ne 1$, and I found no work that
does.

**That triangle is the smallest thing that would make the theory-space half non-vacuous.** Stated
as an open question, **CG-2**, not as a conjecture in either direction.

---

# 5. What the theory forbids

A construction earns the word "theory" if it predicts or forbids something not already visible.
Applying that test without flinching.

**It forbids one thing, and the thing is real.** Let a proof system be confluent and strongly
normalising, let its rewrite graph be connected, and let $\varepsilon$ be a group-valued invariant
of rewrite steps, multiplicative along composed rewrites. Then $\varepsilon$ is a difference of
endpoint values of a function on proofs, so: it **vanishes on every closed rewrite sequence**, so
no cyclic proof transformation can accumulate anything; any proposed "phase acquired by
normalising" is either zero or is not multiplicative; and searching for a proof invariant that is
*not* a function of the normal form is searching for a contradiction. That rules out an entire
family of proposals of the form "normalisation winds something up".

**And in the same breath: this is the same content as "unique normal forms exist"**, restated in
geometric vocabulary. Whether the restatement is a contribution is a judgement, and mine is that it
is a small one. It makes a consequence obvious where it was merely available.

**It predicts one thing, unchecked.** §4.1's critical-pair calculation. If some critical pair
flipped the sign, the construction would immediately be saying something nobody had computed.

**It gives the Bloch picture nothing.** The sign here is a property of a *pair* of proofs of one
sequent. [`logic-bloch-gates.md`](logic-bloch-gates.md) §4.4 found the $\pm 1$ the gates write to
be a property of the **rotation** and not of the point on the ball; this essay agrees and does not
extend it. Nothing here is a coordinate on the ball, nothing is a truth value, and nothing brings a
$U(1)$ back.

---

# 6. Kill your own invention

Stated by me before a reader has to.

1. **The connection is posted in, not forced.** The bundle is canonically trivial (§1.2), so there
   is a preferred flat reference and $w$ measures deviation from it. In real gauge theory the
   bundle is not canonically trivial and that is why the connection is data.
2. **"Cut is composition of paths" is stipulation, and it does all the work.** Nothing here proves
   that cut-elimination induces a permutation of occurrences, that it is independent of the
   reduction strategy, or that it composes. If any of the three fails, **[I3]** is not a connection
   and the essay is about nothing. The Lean file's out-of-scope block says this in as many words.
3. **The one theorem is elementary.** `flat_iff_exact` is a discrete Poincaré lemma over a
   simply-connected base, a first-exercise fact. Its interest is entirely in what it is pointed at.
4. **My pincer is dominated by published mathematics** (§4.3), and my determinant correction (§1.3)
   corrects an *argument*, not a conclusion.
5. **The prior-art sweep behind §8 could not use a general web search engine** and worked from
   bibliographic-metadata APIs instead. Every "no prior art found" below therefore means "nothing
   surfaced whose title or abstract makes the claim", which is weaker than it sounds. Three
   unread leads are named in §8.2 precisely because I could not rule them out.

---

# 7. The theory, named and axiomatised, and the verdict

**[INVENTED, I9]** So that someone else can pick it up or kill it, with nothing hedged.

> **Cut Gauge.** Fix a sequent $\Gamma$ of a proof system $S$.
>
> - **CG1 (base).** $\mathcal{P}(\Gamma)$ is the directed graph whose vertices are the proofs of
>   $\Gamma$ in $S$ and whose edges $p \to q$ are single reduction steps of $S$'s cut-elimination.
> - **CG2 (fibre).** $\mathcal{O}(\Gamma)$ is the finite set of atom occurrences of $\Gamma$. CG2
>   **requires** every reduction step to induce a bijection of $\mathcal{O}(\Gamma)$; a system with
>   weakening or contraction does not satisfy CG2 and is outside the theory.
> - **CG3 (connection).** $w(p,q) \in \mathrm{Sym}(\mathcal{O}(\Gamma))$ is that bijection,
>   composed along composite reductions; $\varepsilon = \mathrm{sgn}\circ w$ is the abelianised
>   connection, and by $\veq{sign-unique}$ it is the only nontrivial abelian one there is.
> - **CG4 (curvature).** $F(p,q,r) = w(p,q)w(q,r)w(p,r)^{-1}$ over the transitive closure. Cut
>   Gauge is **flat at $\Gamma$** when $F \equiv 1$.
> - **CG5 (holonomy).** For a closed walk $\gamma$, $\mathrm{hol}(\gamma)$ is the ordered product
>   of $w$ along $\gamma$. When flat, $\mathrm{hol}$ is a homomorphism
>   $\pi_1(\mathcal{P}(\Gamma)) \to \mathrm{Sym}(\mathcal{O}(\Gamma))$ and nothing more.
>
> **Theorem (flatness).** If $S$ is confluent and strongly normalising on proofs of $\Gamma$ and
> satisfies CG2, then Cut Gauge is flat at $\Gamma$ and $w(p,q) = A(p)^{-1}A(q)$ for $A$ the
> transport to the normal form. Machine-checked in the abstract form $\veq{flat-exact}$.
>
> **Corollary.** Over the transitive closure, holonomy is trivial on every loop
> $\veq{loop-trivial}$. Nontrivial holonomy requires keeping the edge set restricted to single
> steps.
>
> **CG-1 (conjecture).** Cut Gauge is flat at every $\Gamma$ in multiplicative linear logic.
>
> **CG-2 (open).** Do three presentations of one theory exist whose Feferman transports fail to
> chain?

## The verdict

**Is Cut Gauge a theory, a reformulation, or a decoration?** It is a **reformulation with one
useful consequence**.

It forbids exactly one family of proposals ("normalisation winds something up"), and the
prohibition restates unique normal forms rather than adding information. It predicts exactly one
checkable thing, §4.1's critical-pair calculation, and that is unchecked. It explains one thing
that was genuinely confusing: why the sibling's surviving $\mathbb{Z}_2$ *feels* like a holonomy
and is not one, because **the braiding is a second vertex, not a loop**.

It is **not a decoration**, because a decoration would have passed §2's commitments by fiat and
this one passes them by computation, and because it produced two corrections (§1.3, §3.2) and a
negative result (§4.4) that were not visible from the sibling essays.

It is **not a theory**, because after the vocabulary is stripped it contains one elementary lemma,
and because the two places it pointed at for curvature both turned out to be occupied by better
published arguments (§4.2) or by a hedge I could not close (§4.4).

**Would I spend the owner's session on it? No**, with one exception. The three things here worth
an afternoon are §3.2's located error in a sibling, §1.3's determinant correction, and the
observation that Lafont's collapse and the sibling's idempotence collapse are the same shape. None
of the three depends on any of the invented apparatus. Everything else is a well-lit dead end, and
a well-lit dead end is worth writing down once so nobody walks into it twice.

---

# 8. Prior art

## 8.1 What exists, verified in this session

- **Non-confluence of classical cut-elimination, and its collapse.** Jean-Yves Girard, Paul Taylor
  and Yves Lafont, *Proofs and Types*, Cambridge Tracts in Theoretical Computer Science **7**,
  Cambridge University Press, 1989. The example, the "identified" conclusion and the Joyal remark
  are on **p. 150** of Appendix B, *What is Linear Logic?*, which is by **Lafont**. The body text
  does not name him at that line; the attribution rests on the appendix authorship and the index
  entry, so "the example in Lafont's Appendix B" is the safe form. Quoted in §4.2 from the freely
  distributed PDF.
- **The invariant that survives it.** Stefan Hetzl and Lutz Straßburger, *Herbrand-Confluence for
  Cut Elimination in Classical First Order Logic*, CSL 2012, LIPIcs (Schloss Dagstuhl), DOI
  `10.4230/LIPIcs.CSL.2012.320`. Page range unverified.
- **Geometry of Interaction.** Jean-Yves Girard, *Geometry of Interaction 1: Interpretation of
  System F*, in *Logic Colloquium '88*, Studies in Logic and the Foundations of Mathematics,
  Elsevier, 1989, pp. 221-260. **The execution formula's exact original form was not verified**:
  the sweep reached it only through restatements (Seiller, *Interaction Graphs: Additives*,
  arXiv:1205.6557; Abramsky, *Temperley-Lieb Algebra*, arXiv:0910.2737), so no formula is quoted
  here. The categorical form used in §3.3 is Masahiro Hamano and Philip Scott, *On Geometry of
  Interaction for Polarized Linear Logic*, arXiv:1503.00886, Definition 3.21, where the cut
  operator is a tensor of symmetry morphisms.
- **Proof identity and invariants of normal proofs.** Lutz Straßburger, *The problem of proof
  identity, and why computer scientists should care about Hilbert's 24th problem*, Phil. Trans. R.
  Soc. A **377**(2140):20180038 (2019). Dominic Hughes, *Proofs Without Syntax*, Annals of
  Mathematics **164**(3):1065-1076 (2006). (The sibling essay cites Hughes' WoLLIC 2006 paper
  instead; both exist.)
- **Proofs as paths.** Joachim Lambek, *Deductive systems and categories*, Mathematical Systems
  Theory **2**(4):287-318 (1968). R. A. G. Seely, *Locally cartesian closed categories and type
  theory*, Math. Proc. Camb. Phil. Soc. **95**(1):33-48 (1984). Martin Hofmann and Thomas
  Streicher, *The groupoid interpretation of type theory*, in *Twenty-Five Years of Constructive
  Type Theory*, OUP 1998 (page range unverified). Daniel Licata and Michael Shulman, *Calculating
  the Fundamental Group of the Circle in Homotopy Type Theory*, LICS 2013, pp. 223-232. These
  compute a fundamental group of a **type**, not of a proof system, and §1.1 is the whole of the
  distinction.
- **Contextuality as a cohomological obstruction.** Samson Abramsky and Adam Brandenburger, *The
  sheaf-theoretic structure of non-locality and contextuality*, New J. Phys. **13**:113036 (2011).
  Abramsky, Barbosa, Kishida, Lal and Mansfield, *Contextuality, Cohomology and Paradox*, CSL 2015,
  LIPIcs **41**:211-228, which computes a Čech $H^1$ class and proves the Liar cycle of length 4
  corresponds exactly to the PR box. Giovanni Carù, *On the Cohomology of Contextuality*, EPTCS
  **236**:21-39 (2017), which disproves completeness of the invariant. **This is not a
  connection:** an obstruction class is an invariant of a situation, with no transport, no
  composition and no curvature.
- **Modal logic of forcing.** Joel David Hamkins and Benedikt Löwe, *The modal logic of forcing*,
  Trans. Amer. Math. Soc. **360**(4):1793-1817. The S4.2 statement in §4.4 is quoted from the
  abstract. **The year is unresolved**: electronic publication 2007, issue dated 2008, and both
  appear in the wild.
- **Ground-model definability.** Richard Laver, *Certain very large cardinals are not created in
  small forcing extensions*, Annals of Pure and Applied Logic **149**(1-3):1-6 (2007); the
  statement and the independent Woodin attribution as quoted by Victoria Gitman and Thomas
  Johnstone, *On ground model definability*, arXiv:1311.6789.
- **Feferman.** Solomon Feferman, *Arithmetization of metamathematics in a general setting*,
  Fundamenta Mathematicae **49**(1):35-92 (1960).
- **Gauge theory and logic, running the other way.** Urs Schreiber and Michael Shulman, *Quantum
  Gauge Field Theory in Cohesive Homotopy Type Theory*, EPTCS **158**:109-126 (2014). This is the
  only genuine gauge-theory-and-logic prior art the sweep found, and it uses a **logic to formalise
  physical gauge theory**, the inverse of what this essay attempts. Worth stating explicitly,
  because it is the paper a reader will bring up.
- **Differential linear logic.** Thomas Ehrhard and Laurent Regnier, *Differential interaction
  nets*, Theoretical Computer Science (2006). Differentiation exists in proof theory; **no work
  connecting it to curvature was found**.
- **Ore**, *Some remarks on commutators*, Proc. AMS **2**:307-314 (1951), for why CG2's finiteness
  requirement is not a convenience: the infinite symmetric group is perfect and carries no
  character at all.

## 8.2 Honest nulls, and three leads I could not close

**No prior art found**, in indexed titles and abstracts, for: a connection, parallel transport,
holonomy or curvature on a space of proofs; a "sign of a proof", "parity of a proof net" or
"$\mathbb{Z}/2$ grading of proofs"; a fundamental group or fundamental groupoid *of a proof
system*; monodromy of forcing extensions; a Cartan connection in logic; "flat connection
semantics"; a "gauge theory of computation" in any computer-science sense; or anyone naming the
choice of Gödel numbering a gauge freedom.

**Three leads the sweep surfaced and could not close.** Each is an unrefereed preprint whose
abstract sits near this essay's address and whose body was not read. They are listed so nobody
mistakes this essay's nulls for a clean field:

1. **Yingrui Yang, *Logical Foundations of Local Gauge Symmetry and Symmetry Breaking*,
   arXiv:2004.13582**, no journal reference. Its abstract combines gauge symmetry with the
   incompleteness and indefinability theorems and says Gödel numbering is "the key". Whether it
   identifies the numbering *as* the gauge freedom is not settled by the abstract. **This is the
   one item to read before anyone claims priority for the framing in §4.5.**
2. **The "computational paths" line** of de Queiroz, de Oliveira, Ramos, de Veras and coauthors
   (arXiv:1804.01413, arXiv:1906.09107, and later), which treats equality proofs as paths and
   computes fundamental groups from a rewrite structure. That is one conceptual step from §1.1's
   base and is the nearest genuine neighbour found.
3. **Three unread cs.LO preprints** whose abstracts contain "holonomy": arXiv:2607.15629 (a cubical
   formalisation of topos causal models, forcing and a contextuality obstruction) is the one
   closest to §4.4; arXiv:2602.00134 and arXiv:2512.24498 are further away. Also
   arXiv:2510.04716, *Curved Boolean Logic*, whose title alone means nobody should claim novelty
   for "curvature of logic" without reading it.

## 8.3 Citation hygiene

Everything in §8.1 was verified in this session against bibliographic APIs (OpenAlex, arXiv,
Crossref) or by fetching the source itself, except where the entry says otherwise; the unverified
points are named inline rather than smoothed over. **The sweep could not use a general web search
engine**, so §8.2's nulls mean "nothing surfaced in indexed metadata", not "provably nonexistent".

Three statements in this essay are **standard facts given deliberately without a reference**,
because I did not re-verify a page: that the nerve of a filtered category is contractible (§4.4);
that lattice gauge theory puts transport on links and curvature on plaquettes (§1.1); and the
symmetric/antisymmetric decomposition behind §1.3's determinant, which I re-derived by computation
rather than cite. The downward directedness of grounds (§4.4) is flagged as unverified and is used
for nothing. The determinant table in §1.3 is my own exhaustive computation, exact-integer, for
$n = 1 \dots 8$.

---

# 9. Map of the Lean file

[`docs/dreamed/lean/LogicGauge.lean`](lean/LogicGauge.lean), zero `sorry`, checked with
`lake env lean` from `verify/` under the memory-capped wrapper, **exit code 0**.

| Theorem | Statement | Used at |
|---|---|---|
| `curv`, `Flat`, `Exact` | curvature, flatness, and having a potential | §1.2 |
| `flat_of_exact`, `exact_of_flat` | the two halves of the flatness theorem | §3.1 |
| `flat_iff_exact` | they coincide, **uniformly in the structure group** | §3.1, §7 |
| `flat_refl`, `flat_symm` | a flat connection is reflexive and reversible | §2 |
| `acurv`, `acurv_eq_curv`, `bianchi` | additive spelling, its agreement with `curv`, and $\delta^2 = 0$ | §2 |
| `endp`, `hol`, `endp_append` | walks, endpoints, holonomy | §2 |
| `hol_concat` | holonomy is multiplicative along concatenated walks | §2 |
| `hol_exact` | for an exact connection, holonomy depends on endpoints only | §3.1 |
| `hol_loop_trivial_of_flat` | a flat connection over a set base is trivial on **every** loop | §3.1, §7 |
| `hol_backtrack` | a backtracking loop is trivial | §2 |
| `curv_eq_triangle_holonomy` | curvature IS the smallest loop's holonomy, exactly | §2 |
| `wEx`, `wEx_curved`, `wEx_not_flat`, `wEx_not_exact` | a three-point connection that genuinely curves and has no potential | §2 |
| `wEx_path_dependent` | two routes between the same endpoints disagree | §2 |
| `hom_const_on_swaps`, `hom_eq_of_eqOn_swaps` | a hom to an abelian group is constant on transpositions; transpositions generate | §1.2 |
| `holonomy_character_dichotomy` | exactly two homomorphisms $\mathrm{Sym}(\mathcal{O}) \to \mathbb{Z}^\times$ | §1.2 |
| `sign_ne_trivial`, `sign_unique` | the sign is the **unique** nontrivial one | §1.2, §7 |
| `identity_and_braiding_differ` | the minimal witness: identity and braiding differ in sign | §1.3, §3.2 |

**Not** in Lean and carrying no badge: everything about proofs, sequents, cut-elimination,
confluence, strong normalisation, critical pairs, proof nets and linear logic; Lafont's example and
its collapse; Herbrand-confluence; the identification of a permutation with a braiding in a
monoidal category; the determinant formula of §1.3 (that is a Python computation, not a proof);
every claim about weakening and contraction, hence the whole Fibre-Confluence Pincer; every claim
about forcing, directedness and the modal logic of forcing; all cohomology; the Geometry of
Interaction; Feferman's construction; and the entire dictionary of §1.2, which is stipulation
rather than theorem. The Lean file's header carries the same list as an explicit out-of-scope
block.

---

# Surfaced for the owner

Each item is a located claim plus the ruling it needs. **None has been written into `TODO.md`,
`ROADMAP.md`, `REVIEW_ME.md` or any sidecar.** A delegated agent's verdict is a recommendation,
never a settled decision.

1. **A located error in a sibling essay, independent of everything invented here.** §3.2.
   [`logic-z2-grading.md`](logic-z2-grading.md) item 10 says that by confluence every
   normalisation-invariant is a function of the normal form, *"which the subformula property makes
   visible to truth"*. The second clause does not follow: a sequent has many cut-free proofs, the
   subformula property constrains formulas rather than which proof you hold, and that essay's own
   surviving candidate (`identity_and_braiding_differ`) is the counterexample. Read correctly the
   argument **classifies** legitimate proof invariants instead of vacating them. *Ruling:* amend
   the sibling's item 10, or say why the inference stands.

2. **A second correction to the same sibling, from a computation.** §1.3. Its semantic
   justification of the braiding sign, *"on a two-dimensional $V$ the braiding has determinant
   $-1$"*, is true at $\dim V = 2$ and not robust: $\det(\tau) = (-1)^{n(n-1)/2}$, which is $+1$
   for $n \equiv 0, 1 \pmod 4$. Verified by exact computation for $n = 1 \dots 8$. Dimension is not
   a logical datum, so the semantic route is unsafe; the syntactic one (the transposition's sign,
   plus $\veq{sign-unique}$) is. *Ruling:* amend the sibling's §4.2 justification, keeping its
   conclusion.

3. **The gauge theory of proofs is exactly flat, and this is a theorem.** §3.1. A discrete
   connection over a nonempty base is flat iff it has a potential (`flat_iff_exact`), uniformly in
   the structure group; a confluent, strongly normalising system supplies the potential as the
   normal-form map; and over the complete graph on a set, holonomy is trivial on every loop, not
   merely on contractible ones (`hol_loop_trivial_of_flat`). *Ruling:* accept "flat, with no
   fundamental group left to detect" as the answer, or say which restricted edge set is intended.

4. **The sign is a potential, not a holonomy.** §3.3. A demotion of the sibling's recommended
   winner, reached by taking that recommendation seriously. The braiding is a second vertex of the
   proof graph, not a loop in it, so the sign separating it from the identity is a value at a point
   and not a residue around a cycle. *Ruling:* accept the demotion, or state what the loop is.

5. **The sign is canonical, and that survives whatever happens to the rest.** §1.2. For at least
   two atom occurrences the sign is the **unique** nontrivial homomorphism
   $\mathrm{Sym}(\mathcal{O}) \to \mathbb{Z}^\times$ (`sign_unique`,
   `holonomy_character_dichotomy`). Two people looking independently find the same sign, not merely
   the same up to a global flip. That upgrades criterion (d) of
   [`logic-z2-grading.md`](logic-z2-grading.md) §1 from taste to theorem. *Ruling:* record as a
   standing fact about the cluster, or reject as irrelevant now that item 4 demotes the sign.

6. **Where curvature was supposed to live, the invariant collapses instead.** §4.2. Classical
   cut-elimination is non-confluent, which is the only structural escape from flatness, but the
   example in Lafont's Appendix B of *Proofs and Types* identifies **all** proofs of a sequent, so
   every reduction-invariant there is constant, not curved. Its own words: cut elimination *"even
   diverges in the worst way"*. Joyal's categorical shadow (a Cartesian closed category with $0$
   and $0^A \cong A$ is a poset) is the same collapse. **The shape matches the sibling's own
   idempotence collapse**, which is the most informative single fact here after item 3. What
   survives non-confluence is Hetzl and Straßburger's Herbrand-confluence, and by $\veq{flat-exact}$
   any such surviving observable is a potential. *Ruling:* accept that the escape hatch is closed,
   or name a non-confluent system with conserved occurrences.

7. **My own invented argument, demoted by prior art, and offered for attack anyway.** §4.3,
   **[INVENTED]**. The Fibre-Confluence Pincer says weakening and contraction create and destroy
   atom occurrences, so where the connection could curve there is no fibre. In the classical case
   it is **redundant**: item 6 kills the same case harder without it. *Ruling:* whether it is worth
   trying to break. Breaking it needs a non-confluent system with conserved occurrences, and that
   would make this essay's subject interesting rather than dead.

8. **A negative answer to the sibling's forcing-monodromy conjecture.** §4.4.
   [`logic-bloch-phase.md`](logic-bloch-phase.md) item 8 conjectured that a closed loop of forcing
   extensions might carry a nonzero invariant. Forcing extensions are **directed** (product
   forcing), which is the frame condition behind Hamkins and Löwe's S4.2 completeness theorem; a
   directed poset is a filtered category, and the nerve of a filtered category is contractible, so
   the base is simply connected and no monodromy can live there. *Two hedges in the same breath:*
   this covers only the upward multiverse, and the downward statement about grounds is a
   substantial theorem **I did not verify and do not cite**. *Ruling:* accept the conjecture as
   probably dead, or commission the downward half.

9. **The one calculation recommended and not done, and the one open question.** §4.1 **CG-1**:
   flatness of the Cut Connection is equivalent to sign-preservation across every critical pair, a
   finite check for any finite system; for MLL proof nets I expect flatness because the Geometry of
   Interaction execution formula is invariant under reduction, but I did not check it. §4.5
   **CG-2**: Feferman 1960 gives a nontrivial *transport* between two presentations of PA, which is
   a gauge transformation and therefore empty; what is missing is a **triangle** of presentations
   whose transports fail to chain, and I found nothing exhibiting or forbidding one. *Ruling:*
   whether either is worth a session.

10. **Three prior-art leads I could not close, and one framing worth knowing.** §8.2.
    arXiv:2004.13582 is the only paper found at this essay's exact address (gauge symmetry plus
    incompleteness plus Gödel numbering) and its abstract does not settle whether it makes the
    identification; the "computational paths" line of de Queiroz and coauthors is the nearest thing
    to a fundamental group of a proof system; and arXiv:2510.04716, *Curved Boolean Logic*, means
    nobody should claim novelty for "curvature of logic" unread. Separately, Schreiber and
    Shulman's cohesive-HoTT gauge theory (EPTCS 158) is real prior art running the **opposite**
    direction: logic formalising gauge theory, not gauge theory of proofs. *Ruling:* none needed;
    recorded so the nulls in §8.2 are not read as a clean field. **The sweep could not use a
    general web search engine**, so every null is weaker than it looks.

11. **My own verdict, offered for rejection.** §7. Cut Gauge is a **reformulation with one useful
    consequence**, not a theory and not a decoration: one elementary lemma once the vocabulary is
    stripped, plus two corrections and a negative result, none of which needed the invented
    apparatus. **I recommend against spending a session on it**, excepting items 1, 2 and 6, which
    are plain corrections and cost an afternoon between them. *Ruling:* the owner's, and a
    reasonable owner drops the whole line here.

12. **Nine invented objects, listed so none is mistaken for mathematics.** The Inventory at the top:
    the proof graph, the occurrence fibre, the transport character, the Cut Connection, cut
    curvature, the Normalisation Gauge, the Fibre-Confluence Pincer, theory-space transport, and
    the Cut Gauge axioms CG1 to CG5. None is established, none is claimed to model anything, and
    the Lean file proves **none** of them: it proves elementary facts about discrete connections and
    permutation groups, pointed at these readings. *Ruling:* none needed; recorded so a later reader
    cannot mistake the invention for a result.

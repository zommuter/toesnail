---
title: The hunt for a Z2 grading in logic
permalink: /dreamed/logic-z2-grading
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This file *proposes*; the owner disposes. Nothing here is toesnail theory, and nothing may be
> promoted into `physics/` or `essays/` without the owner authoring the move himself. The `\veq`
> badges below claim something about [`docs/dreamed/lean/LogicZ2.lean`](lean/LogicZ2.lean)
> **only**, and are deliberately not wired into `physics/*.toml` or `tests/test_verify.sh`.

**Seed.** Not an owner turn this time, but the single unfollowed recommendation of the direct
parent essay, [`logic-bloch-phase.md`](logic-bloch-phase.md) §8.3, repeated as its item 3 under
"Surfaced for the owner":

> **Look for a $\mathbb{Z}_2$ grading, not a $U(1)$ phase.** Three independent routes land on
> $\{\pm 1\}$ rather than the circle: the gates only ever write $\pm 1$; the finitary renumbering
> group's only character is the sign; and proof-relevance gives a discrete group.

Nobody has looked. The idea's owner-given name is **Bloch Truth**; the siblings are
[`logic-bloch-poles.md`](logic-bloch-poles.md), [`logic-bloch-gates.md`](logic-bloch-gates.md),
[`logic-qutrit-su3.md`](logic-qutrit-su3.md) and
[`weltformel-impossibility.md`](weltformel-impossibility.md).

---

# 0. The headline, stated and not teased

**The parent's recommendation is self-defeating as worded, and the reason is the parent's own
lemma.** A $\{\pm 1\}$-valued invariant that multiplies under conjunction collapses to the constant
$+1$ by exactly the step that killed provability: $f(A) = f(A \wedge A) = f(A)^2$, and an idempotent
element of a group is the identity. Nothing about the circle was doing the work. Passing from
$U(1)$ to $\mathbb{Z}_2$ changes the group and changes nothing about the obstruction, because the
obstruction never mentioned the group.

That is machine-checked below in the codomain the parent asked for, $\mathbb{Z}^\times = \{+1,-1\}$
literally, and again in the weaker *set-level* sense of a grading (a decomposition into even and odd
parts), where it also holds: **a Boolean ring has no nontrivial $\mathbb{Z}_2$-graded decomposition,
and in particular is never a nontrivial super-algebra.**

Then the constructive half. The parent's own filter 3 already said what to do -- *the combining
operation must be a chaining, not a joining* -- and its recommendation then proposed a grading over
conjunction, which is a joining. Fix that and a sign appears. The scoreboard, before the work:

| Candidate | Verdict |
|---|---|
| Sign over conjunction (the parent's wording) | **DEAD**, by the parent's own lemma, machine-checked |
| Negation as an involution (the null hypothesis) | **DEAD as a grading.** A $\mathbb{Z}_2$ *action*, whose sign is the truth value in disguise |
| Parity of proof length / negation depth | **DEAD.** Not invariant under normalisation, and non-elementarily so |
| Sign of a permutation of atom occurrences | **ALIVE, and the only survivor.** Multiplicative under composition, invisible to provability -- but finitary only, and Ore 1951 says why that binds |
| Polarity in focused proof systems | **DEAD as a grading**, alive as a labelling. Idempotent under the connectives, not additive: `N ⅋ N` is negative and `P ⊗ P` is positive |
| $\mathbb{Z}_2$ cohomology / the logical double cover | **ALIVE but not a grading.** An obstruction class, a different animal; highest ceiling, and a proved-incomplete invariant |
| Grassmann / super-algebra parity | **DEAD, instructively.** Boolean rings have characteristic 2, where the sign rule says nothing |
| Rosser's proof ordering | **DEAD as a sign.** A total order, not an involution; it belongs in the parent's candidate 4 |

**The one-sentence answer.** Exactly one candidate passes all four criteria, and it never grades a
*proposition*: it grades **proofs**, as the sign of the permutation they induce on atom occurrences.
Read back into the Bloch picture that is a claim, not a hedge -- the $\pm 1$ the gates write is an
attribute of the **rotation**, not of the point on the ball.

**The second answer, which I did not expect.** The candidate I went in believing would win, polarity
in focused proof systems, **fails on inspection**, and it fails to §2's obstruction rather than to a
technicality. Worse, the genuine $\mathbb{Z}_2$ object in linear logic is linear negation
$(\cdot)^\perp$, an involution, which is §3's null hypothesis arriving for the third time. **Three
of six routes collapse back onto "negation is an involution".** That is the strongest evidence here
that the propositional $\mathbb{Z}_2$ is genuinely empty rather than merely unfound.

---

# 1. What would count as a find

The parent's discipline is inherited: state the filter before the candidates, so a candidate cannot
be talked into passing. A $\mathbb{Z}_2$ grading of logic must supply a map
$\varepsilon : X \to \{+1,-1\}$ from some class $X$ of logical objects, satisfying all four of:

- **(a) Multiplicative under a composition.** There is an operation $\circ$ on $X$ with
  $\varepsilon(x \circ y) = \varepsilon(x)\varepsilon(y)$. Without this $\varepsilon$ is a
  two-colouring, not a grading, and "grading" is exactly the word that promises this.
- **(b) Invisible to the truth value.** Two objects with the same truth value must be able to have
  different signs. A $\mathbb{Z}_2$ you can read off the truth table is the truth table.
- **(c) Not identically trivial.** Some $x$ has $\varepsilon(x) = -1$. Every failure below is a
  *theorem* rather than "we could not find one".
- **(d) About logic rather than imported decoration.** The sign must be determined by the logical
  object, not by a labelling chosen alongside it.

Criterion (d) does silent work, so it gets a sharper form. **Test:** if two people set the
construction up independently, do they get the same sign up to one global flip? If they can disagree
pointwise, the sign was theirs and not the logic's. That test kills the null hypothesis in §3, it
damages polarity in §4.4, and it is why §4.3's double cover is reported as an obstruction rather
than as a grading.

What is *not* required: the grading need not be defined on all of logic. A grading of the proofs of
one formula is a real find. The parent's target was the whole propositional algebra, and that turns
out to be precisely the domain on which no grading can exist.

---

# 2. First: does the parent's own argument kill $\mathbb{Z}_2$ too?

Yes. This section is short because the mathematics is short, which is itself the finding.

## 2.1 The collapse, with the group left arbitrary

The parent formalised, as `box_phase_trivial` and `phase_trivial_of_idempotent`, that a group-valued
$f$ multiplying over an idempotent operation is constant. It then used that against $U(1)$ and, in
the same essay, recommended $\mathbb{Z}_2$. But the lemma never mentions $U(1)$:

$$ \big(\forall a,b:\ f(a \circ b) = f(a)f(b)\big) \ \wedge\ \big(\forall a:\ a \circ a = a\big)
   \;\Longrightarrow\; f \equiv 1 \veq{collapse}\lean $$

for **every** group as codomain, and in particular for $\mathbb{Z}^\times = \{+1,-1\}$
(`units_grading_trivial_of_idempotent`) and for $\mathbb{Z}/2$ written additively
(`zmod2_grading_trivial_of_idempotent`, proved directly rather than transported, so no isomorphism
is smuggled in). Conjunction is idempotent on any meet-semilattice, and the Lindenbaum-Tarski algebra
of any logic worth the name is one:

$$ f(A \wedge B) = f(A)\,f(B) \ \text{ on a meet-semilattice}
   \;\Longrightarrow\; f(A) = +1 \ \ \forall A \veq{nosign}\lean $$

(`no_sign_on_propositions`, with `join_grading_trivial` for disjunction, since accumulating support
is idempotent too). **The parent's headline recommendation, read literally, is refuted by the
parent's own machine-checked lemma.** Saying so is the single most valuable thing this essay does,
and it took four lines of Lean.

## 2.2 The stronger form: no super-algebra either

One might hope a *grading* is weaker than a *homomorphism* and escapes. A $\mathbb{Z}_2$-graded
algebra is a decomposition $R = R_0 \oplus R_1$ with $R_i R_j \subseteq R_{i+j}$: a statement about
subsets, with no sign function assumed. It does not escape:

$$ x \in R_1 \;\Longrightarrow\; x = x \cdot x \in R_0 \;\Longrightarrow\;
   x \in R_0 \cap R_1 = \{0\} \veq{odd}\lean $$

(`odd_part_trivial_of_idempotent`, and `boolean_ring_no_odd_part` with the idempotence hypothesis
written out by hand as the defining law of a Boolean ring, so the reader can see no other
Boolean-algebra fact is in play). **A Boolean ring has no odd part.** The same argument runs for any
grading group, not only $\mathbb{Z}_2$: for $g \ne e$, $x \in R_g$ forces $x = x^2 \in R_{g^2}$ and
$R_g \cap R_{g^2} = \{0\}$.

So the failure is not a shortage of imagination about which two-element group to use. **Idempotence
of the logical connectives is a complete obstruction to grading the algebra of propositions by
anything.**

## 2.3 Why this is a sharpening and not a demolition

The parent's filter 3 stated the escape and its own §8.3 walked past it: *chaining, not joining*.
Composition of proofs is a chaining. In a group the only idempotent is the identity
(`idempotent_only_in_a_group`), so §2.1's hypothesis is unavailable there
(`composition_not_idempotent`) and the collapse has nothing to bite on.

The correction to the parent is one word long. Not *"look for a $\mathbb{Z}_2$ grading"* but *"look
for a $\mathbb{Z}_2$ grading **of proofs**"*. That is the difference between a theorem that a thing
cannot exist and a construction of the thing.

---

# 3. The null hypothesis: is this just negation wearing a hat?

Stated before hunting and tested first, because if every candidate reduces to "$\neg$ is an
involution and involutions generate $\mathbb{Z}_2$", the honest answer is that the grading is empty.
A clean negative here would be a good result.

## 3.1 An action is not a grading

The informal argument conflates two structures pointing in opposite directions.

- A **$\mathbb{Z}_2$-action** on an algebra $B$ is a homomorphism $\mathbb{Z}_2 \to \mathrm{Aut}(B)$:
  a map **into** the automorphisms. Negation supplies one, and its content is `involution_powers`:
  an involution's powers are exhausted by $\{1,\sigma\}$.
- A **$\mathbb{Z}_2$-grading** is a map **out of** $B$, to the group. That is criterion (a), and §2
  proves it does not exist.

This is the same direction-of-arrow distinction that separates "the Bloch ball has a $\mathbb{Z}_2$
symmetry" (it does: the antipodal map) from "a point of the Bloch ball has a sign" (it does not).

## 3.2 The double cover, and why its sign is the truth value

Negation acts **freely** on a non-degenerate Boolean algebra, since $A \leftrightarrow \neg A$ is
inconsistent. So $B \to B/{\sim}$ with $A \sim \neg A$ is a two-to-one map, a double cover of sets,
and a "sign" would be a section: a choice of one of $\{A, \neg A\}$ per pair. Two facts kill it.

**No sign at a fixed point.** A labelling flipping under the involution forces freeness:

$$ s(\sigma x) = s(x) + 1 \ \ \forall x \;\Longrightarrow\; \sigma x \ne x \ \ \forall x
   \veq{fixedpoint}\lean $$

(`no_sign_at_a_fixed_point`). The *only* reason a sign attaches to the pairs at all is that
$A \leftrightarrow \neg A$ is inconsistent. That single fact is the whole nontrivial input of the
negation story, and it is a fact about consistency, not about $\mathbb{Z}_2$.

**The sign is never canonical.** If one flipping labelling exists, so does its pointwise complement,
and they disagree everywhere:

$$ \exists\, s \;\Longrightarrow\; \exists\, t = s + 1,\quad t(x) \ne s(x)\ \ \forall x
   \veq{noncanon}\lean $$

(`sign_never_canonical`). So the sign is defined only relative to a choice of one element per pair.
A *coherent* such choice -- closed under meet, up-closed, deciding every pair -- is exactly an
**ultrafilter**, which is exactly a **model**. The sign of the negation action therefore *is* the
truth value computed in a chosen model. Criterion (b) fails as hard as it can: not "the sign
correlates with truth" but "the sign is truth".

The exhaustive check on the two-element Boolean ring makes the point sharpest. The ring's *additive*
structure (exclusive or) does admit a nontrivial $\mathbb{Z}/2$ homomorphism, unlike the
multiplicative structure of §2, and that homomorphism is the truth value and nothing else:

$$ f(a \oplus b) = f(a) + f(b),\ f(\top) = 1 \;\Longrightarrow\; f = \text{truth value}
   \veq{xor}\lean $$

(`xor_grading_is_the_truth_value`). **The Boolean ring's one genuine $\mathbb{Z}/2$ grading is the
one we are forbidden to use.**

## 3.3 A bonus: the involution already assumed the excluded middle

"Negation is an involution" is classical. Intuitionistically what holds is triple-negation collapse,
$\neg\neg\neg A \dashv\vdash \neg A$, so the operator satisfies $n^3 = n$ rather than
$n^2 = \mathrm{id}$. And $n^3 = n$ gives no group:

$$ \exists\, n:\ n^3 = n \ \wedge\ n^2 \ne \mathrm{id} \veq{cube}\lean $$

(`cube_eq_self_not_involutive`, witnessed by a constant map on `Bool`). So the whole "logic
obviously has a $\mathbb{Z}_2$" intuition is downstream of classical logic. The owner's origin quote
for this project asks for a core layer that is *complete* -- "ZF without C" -- with incompleteness
confined to a second layer. Worth flagging that an intuitionistic core, which he might reach for on
other grounds, is precisely the setting where the free $\mathbb{Z}_2$ evaporates.

**Null hypothesis: confirmed for propositions, untouched for proofs.** Every $\mathbb{Z}_2$ living
on the propositional algebra is negation, and negation's sign is the truth value.

---

# 4. The hunt

## 4.1 Parity of proof length, and depth of negation

The most obvious candidate: $\varepsilon(\pi) = (-1)^{|\pi|}$ for $|\pi|$ the size of a derivation,
the number of negation symbols, or double-negation depth. Criterion (a) is satisfiable -- lengths
add, parity is additive -- so it dies on a different axis, and it dies hard.

**It is not an invariant of the proof, only of the presentation.** Cut elimination changes derivation
size by a non-elementary amount: the Statman-Orevkov lower bounds give cut-free proofs whose size is
a tower of exponentials in the size of the proof with cuts. A quantity that can move by a tower
cannot be relied on to preserve its parity. If a purported invariant is not preserved by
normalisation, it is not an invariant of the thing normalisation identifies, and that thing -- the
proof-up-to-computation -- is the only candidate for "the proof itself".

**There is a general reason, not merely an absence of one, and it explains the shape of the whole
field.** In a confluent, strongly normalising system, "invariant under normalisation" and "function
of the normal form" are the same condition, so there is no room for a non-trivial invariant that is
not simply a property of the normal proof. Hence the invariants proof theory actually built are
defined **on** normal forms, and none of them is a number: Hughes' *combinatorial proofs* (WoLLIC
2006) are graph-theoretic objects, explicitly pitched as *"abstract invariants for sequent calculus
proofs, analogous to homotopy groups as abstract invariants for topological spaces"*, and Girard's
Geometry of Interaction execution formula, the canonical MLL invariant of normalisation, is an
operator. Straßburger's Hilbert's-24th survey (Phil. Trans. R. Soc. A 377, 2019) is the entry point.
**A group-valued invariant of proofs preserved by cut elimination does not appear in that literature
at all.** I found no crisp statement of the vacuity argument in print either; it is elementary, and
offered as an observation, not a citation.

**Negation depth fails earlier.** Classically $\neg\neg A \dashv\vdash A$, so depth is not
well-defined on propositions. Intuitionistically it is nontrivial, and Glivenko's theorem makes it
interesting, but §3.3's $\neg\neg\neg A \dashv\vdash \neg A$ leaves the values $\{A, \neg A,
\neg\neg A\}$ with composition law $n^3 = n$: a three-element monoid, not $\mathbb{Z}_2$.
**Rejected, cleanly.**

## 4.2 The sign of a permutation, and what is being permuted

This is the parent's §5.3 thread, followed rather than named. The parent found that the finitary
symmetric group's abelianisation is $\mathbb{Z}/2$ generated by the sign, and that the *full*
symmetric group on $\omega$ is perfect (Ore 1951), hence carries no character at all. So if a logical
setting hands us a finitary permutation group, its only possible sign is the sign, and the question
becomes: what is permuted? Three answers, of which only the third works.

**Gödel numberings: no, and the obstruction is a theorem.** A renumbering is a permutation of
$\omega$, and the ones that matter (computable bijections) have infinite support. Ore's 1951 result
-- every element of the symmetric group on a countable set is a commutator -- makes that group
**perfect**, so it has no nontrivial homomorphism to any abelian group whatsoever, and in particular
no sign. Parity is not a feature of permutations as such; it is a feature of *finitely supported*
permutations, where the finitary alternating group sits with index two. Any construction wanting a
sign out of renaming must **stay finitary and justify why**, and a Gödel numbering is a bijection
with $\mathbb{N}$, exactly the case that evaporates. A search for a parity of a Gödel-numbering
permutation, or of a variable renaming, returns nothing at all.

**Variable renaming: no.** $\alpha$-conversion permutes a finite set of bound names, so a sign
exists, but every logic worth the name treats $\alpha$-equivalent terms as *identical*. An invariant
distinguishing them is an invariant of a representation the theory has quotiented away. Criterion (d)
fails.

**Occurrences of atoms inside a proof: yes, and this is the find.** In multiplicative linear logic a
proof of `A⊥ ⅋ A` is an axiom link, and a proof of a sequent is, in the proof-net
presentation, a matching on atom occurrences. Composition of proofs is **cut elimination**, and cut
elimination on axiom links is literally composition of the underlying maps. So for the proofs of an
*endo*-formula -- proofs of $X \multimap X$, which compose -- the induced permutation of $X$'s atom
occurrences is multiplicative under cut, and its sign is a $\mathbb{Z}_2$-valued invariant that
multiplies. Criterion (a): satisfied, by a chaining, so §2's collapse does not apply.

The smallest witness settles criterion (b) too. Take $X = A \otimes A$ and consider proofs of
$X \multimap X$. Two of them are the identity and the swap. In any model where $A$ denotes a space
$V$, they denote $\mathrm{id}_{V\otimes V}$ and the braiding $\tau$, and on a two-dimensional $V$ the
braiding has determinant $-1$: it fixes the three-dimensional symmetric part and negates the
one-dimensional antisymmetric part. Determinant is multiplicative under composition. So the two
proofs have **opposite sign**; they prove the **same sequent**, so no truth measurement and no
provability predicate can tell them apart (criterion (b)); the sign is computed from the proof net
rather than chosen (criterion (d)); and it is not constant (criterion (c)).

**All four criteria pass.** This is the essay's positive result, and it is exactly the parent's own
"the only character is the sign" observation, relocated from the renumbering group (where it dies,
because that group is perfect) to the exchange structure of proofs (where it lives).

Three weaknesses, in the same breath. First, the grading is defined on an **endomorphism monoid**,
not on all proofs: a proof of $\vdash \Gamma$ for general $\Gamma$ induces a matching, not a
permutation, and there is no composition to be multiplicative under. So this grades a groupoid, not
a logic. Second, it needs a substructural setting where the exchange structure is *recorded*; in
ordinary sequent calculus exchange is free and the permutation is not part of the proof's identity.
Third, the multiplicativity claim under cut elimination is argued here from axiom-link composition
and from the semantic determinant, and is **not formalised** -- the Lean file proves only that the
sign character on an abstract symmetric group is nontrivial and multiplicative, which is the group
theory and not the proof theory.

## 4.3 Orientation, double covers, and $\mathbb{Z}_2$ cohomology

The highest-ceiling candidate, and the one whose honest verdict is "you are looking for the wrong
kind of object".

$H^1(X;\mathbb{Z}_2)$ classifies double covers; a nonzero class obstructs a global section, i.e. a
consistent global choice of "which sheet". Abramsky and Brandenburger (*New J. Phys.* 13:113036,
2011) cast a measurement scenario as a presheaf of local sections and characterise contextuality as
the obstruction to a global section; Abramsky, Barbosa, Kishida, Lal and Mansfield (*Contextuality,
Cohomology and Paradox*, CSL 2015) compute it as a **Čech $H^1$** class. Three corrections to how the
parent reports this, all of which matter.

**The coefficients are a parameter, not $\mathbb{Z}_2$.** The construction takes coefficients in an
arbitrary commutative ring $R$. $\mathbb{Z}_2$ is the ring for the **Pauli / GHZ / All-versus-Nothing**
cases, where the equations are parity equations; $\mathbb{Z}_3$ serves a ternary example. So
"contextuality is a $\mathbb{Z}_2$ obstruction" is true of a class of models, not of the theory.

**The invariant is incomplete, and the paper's own word for the failure is counter-intuitive.** The
CSL paper flags *"false positives ... which are not bona fide global sections"* -- a formal cocycle
mimicking a global section, which as a *contextuality detector* is a **false negative**: the
obstruction vanishes on a genuinely contextual model. Do not transcribe that polarity carelessly.
Carù (EPTCS 236, 2017) settles it, disproving a standing conjecture: the obstruction is not a
complete invariant for strong contextuality even under symmetry and connectedness restrictions.

**There is already a logical instance, and the parent missed it.** The same CSL paper proves that,
up to rearrangement, the **Liar cycle of length 4 corresponds exactly to the PR box**. Paradoxical
sentence-cycles become Boolean equation systems in which every proper subset is consistent while the
whole is not: the same local-consistency, global-inconsistency signature. So the transfer from
quantum contextuality to logic is not the unbuilt bridge the parent's §6.2 implies. It has been
built, for paradoxes, with $\mathbb{Z}_2$ coefficients. That is the most useful correction this essay
makes to the parent's prior-art sweep.

Two further logical double covers present themselves.

**The negation cover** is §3.2's $B \to B/{\sim}$, whose *coherent* sections are ultrafilters. In
ZFC one always exists (Boolean Prime Ideal theorem), so the obstruction vanishes. **In ZF it need
not**: BPI is not provable from ZF and is strictly weaker than choice. So "does this Boolean algebra
admit a coherent sign?" is non-trivial exactly when the ambient set theory is choiceless, which is
exactly the regime the owner's origin quote names: *"core layer should only be complete, e.g. ZF
without C"*. I flag that convergence as striking and as **unverified against the literature by me**:
I found no one reading BPI as a $\mathbb{Z}_2$ obstruction, and I am not claiming they have.

**The independence cover.** $\mathrm{ZFC} \nvdash \mathrm{CH}$ and $\mathrm{ZFC} \nvdash
\neg\mathrm{CH}$ gives two sheets over one base point. The parent's §6.3 already made the decisive
objection and I endorse it: that is a **disconnected fibre**, not a nontrivial loop, and monodromy
needs a path. Nothing here improves that.

**Verdict: alive, valuable, and not a grading.** An obstruction class is a $\mathbb{Z}_2$-valued
invariant of a *situation*, not a degree function on *objects*; criterion (a) is not merely
unsatisfied but inapplicable, since there is no composition of situations. If the owner wants this,
the target must be renamed from "grading" to "obstruction", and that is a decision, not a
technicality. It is also the candidate with a live defect proved in its own literature.

## 4.4 Polarity in focused proof systems: the expected winner, and it loses

The candidate the parent gestured at in one clause ("a positive/negative distinction of the kind
focused proof search already uses") without checking, and the one I expected to come first. It is
real, established mathematics, and it does not satisfy the criteria. Reporting that is worth more
than the candidate was.

**What is true.** Every formula in a focused system carries a **polarity**. In linear logic
`⊗, ⊕, 1, 0, !` are positive and `⅋, &, ⊥, ⊤, ?` negative; Andreoli (*J. Logic
and Computation* 2(3), 1992) proves focused proof search complete for full linear logic by
alternating an asynchronous phase (decomposing negatives) with a synchronous one. Girard's *On the
unity of logic* (APAL 59, 1993) is the ancestor, Laurent's polarised proof nets and LLP the
systematic development, Liang and Miller (TCS 410(46), 2009) the transfer to intuitionistic and
classical logic as LJF and LKF. **Shift** operators $\uparrow, \downarrow$ move a formula between
polarities and are named exactly that. Polarity is load-bearing, not cosmetic.

**Criterion (a) fails, and it fails to §2's own obstruction.** A grading requires
$\deg(A \odot B) = \deg A + \deg B$; under $\mathbb{Z}_2$-addition that needs *negative* $\odot$
*negative* $=$ *positive*. But `N ⅋ N` is negative and `P ⊗ P` is positive: polarity is
**absorbing**, hence **idempotent**, under the connectives. It is the two-element *semilattice* under
max, not the two-element *group* under $+$, and §2.1 applies verbatim. That is a coincidence worth
noticing: the obstruction found in §2 is not an artefact of classical propositional logic, it reaches
into the substructural setting that was supposed to be the escape.

**Criterion (d) is also shaky.** The shifts are freely available and the polarity of an *atom* is a
**declaration** chosen by the proof-system designer; Liang and Miller's contribution is precisely
that different assignments yield different, equally complete focused systems. A quantity two people
can independently assign differently is theirs, not the logic's.

**What survives is a labelling.** Counting shifts modulo two is genuinely $\mathbb{Z}_2$-valued and
genuinely invisible to provability -- $A$ and $\downarrow\uparrow A$ are provably equivalent with
opposite polarity -- but the shift monoid exists in order to flip polarity, so passing criterion (a)
that way is passing a test you built. The parent penalised its own candidate 5 on exactly this
ground.

**And the genuine $\mathbb{Z}_2$ in linear logic is negation again.** Linear negation
$(\cdot)^\perp$ is an involution on formulas and does flip polarity. That is a $\mathbb{Z}_2$
**action**, which §3.1 already ruled is not a grading. The most promising non-classical setting in
the hunt returns the null hypothesis in a new costume.

**Verdict: dead as a grading, alive as a labelling.** No source calls polarity a
$\mathbb{Z}_2$-grading, across four targeted searches; the literature says "binary classification"
and "polarity shifting". That null is consistent with the analysis rather than an accident of search
terms: polarity is not a grading, so nobody called it one.

## 4.5 Grassmann parity and super-algebra: dead, and instructively

A $\mathbb{Z}_2$-graded algebra *is* a super-algebra, and there the sign rule
$xy = (-1)^{|x||y|}yx$ is a theorem. So: does anything in logic anticommute?

**No, and the reason is arithmetic.** A Boolean algebra is a Boolean ring of **characteristic 2**:
$x + x = 0$, hence $-1 = +1$. The sign rule degenerates to plain commutativity and carries exactly
zero information, because the two signs are the same element of the ring. Two bookkeeping points,
both easy to get wrong: characteristic 2 is a **consequence** of idempotence, not a restatement (the
implication is one-way; $\mathbb{F}_2[t]$ and $\mathbb{F}_4$ are commutative of characteristic 2 and
not Boolean); and being of characteristic 2 is not being $\mathbb{Z}_2$-graded, since the first is a
property of the additive group and the second a decomposition of the ring.

Two independent kills, then: characteristic 2 makes the sign rule vacuous, and §2.2's
`boolean_ring_no_odd_part` shows the odd component is $\{0\}$ regardless. Notice these are different
arguments -- the first says the sign cannot be *seen*, the second says the odd part is *empty* -- and
they agree.

Prior art, negative: no work links proof nets to Clifford or Grassmann algebra; "parity in proof
nets" returns only the *Boolean function* PARITY$_n$ used as a circuit benchmark, a different sense
of the word. The nearest real thing is Smirnov, *Grassmann representation in qubit informatics and
superlogic* (arXiv:1802.01392, 2018), representing qubit gates including Toffoli as differential
operators on Grassmann coherent-state symbols. That is quantum-computation formalism, not proof
theory, and a lone unrefereed preprint. **"Logic is secretly a superalgebra" is a pun**, and
recording the kill is worth more than the candidate was.

## 4.6 Rosser's trick: a real two-valued choice, and it is not a sign

Rosser's 1936 refinement replaces "there is a proof of $A$" with

$$ \mathrm{Prov}_R(\ulcorner A \urcorner) \;\equiv\;
   \exists p\,\big[\mathrm{Proof}(p, \ulcorner A \urcorner) \wedge
   \forall q \le p\ \neg\mathrm{Proof}(q, \ulcorner \neg A \urcorner)\big] $$

buying incompleteness from bare consistency instead of $\omega$-consistency. The two-valued datum is
"which proof comes first", invisible to provability in the ordinary sense. Developed carefully, it
fails, twice.

**It is degenerate on the objects it would grade.** For a consistent theory at most one of $A$ and
$\neg A$ is provable, so for all but a vanishing set of sentences the comparison has no second
argument and no sign is defined. The trick's *content* is that this degeneracy is not provable inside
the theory; it works because the theory cannot see the emptiness, not because there is a sign to see.

**Where the real degree of freedom is, it is not $\mathbb{Z}_2$.** What the predicate depends on is
the **witness comparison**, a total order on proofs. A two-element group is an involution; a total
order is not, and the space of orderings is large. Guaspari and Solovay (Annals of Mathematical Logic
16, 1979) proved the sharp form, and it is not the one usually quoted: **a dichotomy**. Some
"standard" provability predicates have all their Rosser sentences provably equivalent and others do
not, and which case you are in depends on the predicate. (A gap in their proof was repaired by von
Bülow, APAL 2008. The untweaked PA case appears still open; they called it very difficult.) "Rosser
sentences are not unique", unqualified, is half a theorem.

**And the predicate is not a modality at all.** Every Rosser provability predicate fails at least one
of the derivability conditions D2 and D3, and Guaspari and Solovay exhibited one failing both. The
Hilbert-Bernays-Löb package is broken, Löb's axiom unavailable, and PRA already proves the Rosser
consistency statement: Gödel's second incompleteness theorem does not hold for it. Kurahashi (Studia
Logica 108, 2020) pins this down with a Rosser predicate whose provability logic is exactly
$\mathbf{KD}$, consistency and nothing more.

**So Rosser belongs in the parent's candidate 4, not here.** It is a second confirmed instance of the
*gauge* reading, standing beside Feferman 1960: two extensionally correct presentations of the same
provability notion behaving observably differently. As a $\mathbb{Z}_2$ grading, **rejected**.

---

# 5. Prior art, and what is actually new here

**Confirmed prior art, which does most of the work.**

- **Focusing and polarity** (§4.4): Andreoli, *J. Logic and Computation* 2(3):297-347, 1992; Girard,
  *On the unity of logic*, APAL 59:201-217, 1993; Laurent, *Polarized Proof-Nets* (TLCA 1999) and the
  2002 thesis; Laurent, Quatrini and Tortora de Falco, APAL 134(2-3), 2005; Liang and Miller, TCS
  410(46):4747-4768, 2009.
- **Contextuality as a Čech $H^1$ obstruction** (§4.3): Abramsky and Brandenburger, *New J. Phys.*
  13:113036, 2011; Abramsky, Barbosa, Kishida, Lal and Mansfield, CSL 2015, LIPIcs 41:211-228; Carù,
  EPTCS 236:21-39, 2017 (the incompleteness); Abramsky, *Contextuality: At the Borders of Paradox*,
  in Landry (ed.), OUP 2017.
- **Rosser** (§4.6): Rosser, JSL 1(3):87-91, 1936; Guaspari and Solovay, Annals of Mathematical Logic
  16:81-99, 1979; von Bülow, APAL 2008; Kurahashi, Studia Logica 108:597-617, 2020.
- **Ore** (§4.2): *Some remarks on commutators*, Proc. AMS 2:307-314, 1951 -- the source of both the
  finitary restriction and the parent's §5.3.
- **Proof identity** (§4.1): Straßburger, *Phil. Trans. R. Soc. A* 377:20180038, 2019; Hughes,
  *Towards Hilbert's 24th Problem: Combinatorial Proof Invariants*, WoLLIC 2006, ENTCS 165:37-63.
- **Statman-Orevkov** non-elementary speedup (§4.1), standard proof theory, used only to kill a
  candidate.

**Three false friends, recorded so a search does not mistake them for prior art.** "Graded modal
logic" in the Fine 1972 sense (*Notre Dame J. Formal Logic* 13(4):516-520) means a *counting*
modality, $\Diamond_{\ge n}$ = "at least $n$ accessible worlds": a natural-number threshold, no
group, no sign. This is the exact analogue of the parent's finding that Girard's *phase semantics*
is a false friend for "phase". "Graded lattice" means a lattice with a rank function
(Jordan-Dedekind). "Graded Boolean algebra" in the literature is either that or graded Boolean
inverse semigroups and ample groupoids, where the grading lives on a groupoid, not on an algebra of
propositions.

**Four honest nulls.** No source describes polarity as a $\mathbb{Z}_2$-grading, across four targeted
searches. No source links proof nets to Clifford or Grassmann algebra. No group-valued invariant of
proofs preserved by cut elimination appears anywhere. No use of the parity of a Gödel-numbering
permutation or a variable renaming appears anywhere.

**One live lead I did not pursue.** **Graded monads and graded modal type theories** (Katsumata, POPL
2014; Fujii, Katsumata and Melliès, FoSSaCS 2016; Orchard, Liepelt and Eades, ICFP 2019; Gaboardi,
Katsumata, Orchard and Sato, ESOP 2021) are genuinely graded by a monoid or preordered semiring, and
$\mathbb{Z}_2$ -- parity of the number of uses of a resource -- is a formally admissible choice that
nobody appears to have instantiated and studied. That is the one place in this sweep where a
$\mathbb{Z}_2$ grading could exist, be new, and be about logic. It grades *effects and resource use*,
which is once again the presentation layer.

**What is not claimed.** No theorem of this essay is new mathematics. The Lean file is elementary
group theory and its value is entirely in *which* elementary facts are pointed at which claims. The
one statement I could not find in print -- that a Boolean ring admits no nontrivial grading, because
$x = x^2$ forces the odd part to zero -- is elementary, is formalised here
(`boolean_ring_no_odd_part`), and is offered as an observation, not a discovery.

---

# 6. Verdict

**Does a logically meaningful $\mathbb{Z}_2$ grading exist?** Narrowly yes, and much more narrowly
than the parent's recommendation supposes. On propositions: no, and the impossibility is a theorem.
On proofs: one candidate (§4.2), confined to finitely supported permutations and to composable
(endo-)proofs. Polarity (§4.4), which I expected to win and which is far better established, fails
criterion (a) to the same idempotence obstruction that killed the parent's wording; the cohomological
reading (§4.3) survives as an obstruction rather than a grading, and its own literature has proved it
incomplete.

**The most informative single fact is the pattern of the failures.** Negation is an involution (§3);
linear negation is an involution (§4.4); the negation double cover's sections are models (§3.2).
Three of six routes return the null hypothesis, and a fourth dies to §2's lemma. When failures
cluster like that, the honest reading is that the propositional $\mathbb{Z}_2$ is empty rather than
merely unfound -- and that the parent's three converging routes to $\{\pm 1\}$ converged on the
*codomain* while saying nothing about the *domain*, which is where the whole difficulty lives.

**Does the parent's recommendation survive its own idempotence argument?** As worded, no; its
sentence is refuted by its own `phase_trivial_of_idempotent`, which is uniform in the group. As
*intended* -- "the object the gates write is a sign, go find where a sign can live" -- yes, and the
hunt succeeds, but only after moving the domain from propositions to proofs, which the parent did not
say and which its own filter 3 implies.

**Is it worth the owner's time? A qualified yes.** *For:* it converts a loose recommendation into a
decision with a named, citable candidate, retires a whole class of proposals with a four-line proof
rather than with taste, and yields a constraint usable in the Bloch picture. *Against:* the survivor
lives in substructural proof theory, far from the QM-from-bra-ket spine, and is connected to the
Bloch geometry by nothing more than both involving $\{\pm1\}$; its multiplicativity under cut is
argued, not proved; Ore's theorem makes its finitary restriction non-negotiable; and the striking
convergence in §4.3 is precisely the item I could not check against prior art, so it is the one most
likely to be wrong or already known. A reasonable reader could take this essay as a well-evidenced
argument that the line should be **dropped**, since four of six candidates die and the survivor is
narrow. I would not argue hard against that reading.

**Recommendation, for the owner to accept or reject:** adopt "the $\mathbb{Z}_2$ grades proofs, never
propositions" as the corrected form of the parent's item 3; *decide separately* whether the target is
a **grading** (§4.2) or an **obstruction** (§4.3), since those are different mathematics and the
parent's single phrase covers both; and if a session is spent here, spend it on the
$\mathbb{Z}_2$-graded-monad lead in §5, the only place in the sweep where the object could be new,
real, and about logic at once.

---

# 7. Map of the Lean file

[`docs/dreamed/lean/LogicZ2.lean`](lean/LogicZ2.lean), zero `sorry`, checked with `lake env lean`
from `verify/` under the memory-capped wrapper, **exit code 0**.

| Theorem | Statement | Used at |
|---|---|---|
| `idempotent_only_in_a_group` | in a group the only idempotent is the identity | §2.1, §2.3 |
| `grading_trivial_of_idempotent` | multiplicative over an idempotent operation implies constant, for **every** codomain group | §2.1 |
| `units_grading_trivial_of_idempotent` | the same with codomain $\mathbb{Z}^\times = \{+1,-1\}$ literally | §2.1 |
| `zmod2_grading_trivial_of_idempotent` | the same in additive $\mathbb{Z}/2$ spelling, proved directly | §2.1 |
| `meet_grading_trivial`, `join_grading_trivial` | conjunction and disjunction instances on a semilattice | §2.1, §4.4 |
| `odd_part_trivial_of_idempotent` | the set-level grading collapses too: the odd part is trivial | §2.2 |
| `boolean_ring_no_odd_part` | Boolean-ring reading, idempotence written out by hand | §2.2, §4.5 |
| `composition_not_idempotent` | composition of permutations is not idempotent, so §2 does not reach it | §2.3 |
| `sign_mul`, `sign_swap_ne_one` | the sign character is multiplicative and not constant | §4.2 |
| `perm_sign_is_a_nontrivial_z2_grading` | a nontrivial $\{+1,-1\}$ grading of a composition monoid exists | §4.2 |
| `involution_powers` | an involution's powers are exhausted by $\{1,\sigma\}$: the action, not a grading | §3.1 |
| `no_sign_at_a_fixed_point` | a flipping labelling forces freeness, i.e. $A \leftrightarrow \neg A$ inconsistent | §3.2 |
| `sign_never_canonical` | two flipping labellings exist and disagree everywhere | §3.2 |
| `xor_grading_is_the_truth_value` | the Boolean ring's one additive $\mathbb{Z}/2$ grading is the truth value | §3.2 |
| `cube_eq_self_not_involutive` | $n^3 = n$ does not imply $n^2 = \mathrm{id}$ | §3.3 |
| `no_sign_on_propositions`, `sign_on_permutations` | the two verdicts restated side by side | §6 |

**Not** in Lean and carrying no badge: everything about the Bloch sphere, $U(1)$ and quantum
mechanics; all of linear logic, including the claim that the atom-occurrence permutation is
multiplicative under cut elimination and the two-atom braiding example; focusing, polarity and the
shift operators; all cohomology, and the reading of BPI as an obstruction; Statman-Orevkov;
Glivenko; Rosser; Ore's theorem. Those are cited or argued, not formalised. The Lean file's header
carries the same list as an explicit out-of-scope block.

---

# Surfaced for the owner

Each item is a located claim plus the ruling it needs. **None has been written into `TODO.md`,
`ROADMAP.md`, `REVIEW_ME.md` or any sidecar.** A delegated agent's verdict is a recommendation,
never a settled decision.

1. **The parent essay's headline recommendation is refuted by the parent essay's own lemma.** §2.1.
   [`logic-bloch-phase.md`](logic-bloch-phase.md) §8.3 and its item 3 say "look for a
   $\mathbb{Z}_2$ grading, not a $U(1)$ phase". Its own `phase_trivial_of_idempotent` is uniform in
   the codomain group, so a $\{\pm1\}$-valued invariant multiplying over conjunction collapses to
   $+1$ exactly as a $U(1)$-valued one does (`units_grading_trivial_of_idempotent`,
   `no_sign_on_propositions`). *Ruling:* amend the parent's item 3 to name **proofs** rather than
   propositions as the domain, or say what non-idempotent combination of propositions is intended.

2. **The impossibility is stronger than the homomorphism version.** §2.2. Even the set-level notion
   of a grading collapses: a Boolean ring has no odd part, for any grading group, because $x = x^2$
   puts every odd element in the even part (`odd_part_trivial_of_idempotent`,
   `boolean_ring_no_odd_part`). *Ruling:* whether this closes the "grade the propositions" direction
   permanently, or a non-idempotent propositional algebra should be proposed instead.

3. **The null hypothesis is confirmed for propositions.** §3. Negation gives a $\mathbb{Z}_2$
   *action*, not a grading; a sign for the $\{A, \neg A\}$ double cover exists only because
   $A \leftrightarrow \neg A$ is inconsistent (`no_sign_at_a_fixed_point`), is never canonical
   (`sign_never_canonical`), and the Boolean ring's one honest additive $\mathbb{Z}/2$ grading is the
   truth value itself (`xor_grading_is_the_truth_value`), which criterion (b) forbids. *Ruling:*
   accept that the propositional $\mathbb{Z}_2$ is empty, or state what it would be for.

4. **Recommended winner: the sign character on the permutation of atom occurrences.** §4.2. It passes
   all four criteria, the minimal witness being the identity and the braiding on
   $A \otimes A \multimap A \otimes A$, which prove the same sequent and have opposite determinant.
   *Weaknesses in the same breath:* it grades an endomorphism monoid rather than a logic; it needs a
   substructural setting where exchange is recorded; Ore 1951 confines it to finitely supported
   permutations; and multiplicativity under cut elimination is argued, **not formalised**. *Ruling:*
   adopt as the target, or reject for the distance from the spine.

5. **The expected winner loses, to the same lemma.** §4.4. Polarity in focused proof systems
   (Andreoli 1992; Girard 1993; Laurent; Liang and Miller 2009) is real and load-bearing, but it is
   **not a grading**: `N ⅋ N` is negative and `P ⊗ P` is positive, so polarity is absorbing
   under the connectives, hence idempotent, hence killed by §2.1 exactly as the parent's wording was.
   Atom polarities are a designer's declaration, so criterion (d) fails too. The genuine
   $\mathbb{Z}_2$ in linear logic is $(\cdot)^\perp$, an involution, which is item 3 again. *Ruling:*
   accept that the substructural setting is not the escape hatch it looked like, or say which
   polarised system is meant to behave otherwise.

6. **The pattern of the failures is itself the finding.** §6. Three of six routes return "negation is
   an involution"; a fourth dies to the idempotence lemma. The $\mathbb{Z}_2$ attaches to the
   **operation**, never to the proposition, so the $\pm1$ that
   [`logic-bloch-gates.md`](logic-bloch-gates.md) §4.4 found the gates writing is a property of the
   rotation and is not on the ball at all. *Ruling:* accept as a standing constraint on the project
   alongside the parent's "the phase must not be fitted to the truth statistics", or reject. A
   reasonable reading of this essay is that the line should be dropped; that ruling is the owner's
   and is not recorded here.

7. **A convergence I could not check, flagged as such.** §4.3. Coherent sections of the negation
   double cover are ultrafilters; their existence is the Boolean Prime Ideal theorem, which is not
   provable in ZF. So the $\mathbb{Z}_2$ obstruction is non-trivial exactly in the choiceless regime
   named by the owner's own origin quote ("core layer should only be complete, e.g. ZF without C").
   **I found no prior art reading BPI as a cohomological obstruction and claim none.** *Ruling:*
   whether this is worth a session, or is the kind of thing the repo's hard constraint exists to stop.

8. **A target-shape decision the parent's wording hides.** §4.3, §6. A **grading** is a degree
   function multiplying under a composition; an **obstruction class** is a $\mathbb{Z}_2$ invariant
   of a situation with no composition at all. §4.2 supplies the first, §4.3 the second, and the
   phrase "$\mathbb{Z}_2$ grading" covers both. *Ruling:* which one Bloch Truth is asking for,
   decided once, before either is built on.

9. **A correction to the parent's prior-art sweep, in the parent's favour.** §4.3. The parent's §6.2
   treats the transfer of the cohomological reading from quantum contextuality to logic as unbuilt.
   It is partly built: Abramsky, Barbosa, Kishida, Lal and Mansfield (CSL 2015) prove the **Liar
   cycle of length 4 corresponds exactly to the PR box**, with $\mathbb{Z}_2$ coefficients. Two
   further corrections to how that result is usually reported: the coefficients are a parameter (an
   arbitrary commutative ring), not fixed at $\mathbb{Z}_2$; and the invariant is **incomplete**,
   flagged in the paper as "false positives" and settled by Carù (2017), who disproves the
   completeness conjecture. *Ruling:* whether the paradox-as-obstruction result belongs in the essays
   wing on its own merits.

10. **Three candidates rejected with reasons worth keeping.** §4.1, §4.5, §4.6. Proof-length parity
    is not an invariant of the proof: cut elimination moves size non-elementarily (Statman-Orevkov),
    and by confluence every normalisation-invariant is a function of the normal form, which the
    subformula property makes visible to truth. "Logic is secretly a super-algebra" is a pun: a
    Boolean ring has characteristic 2 (a *consequence* of idempotence, not a restatement), so the
    Koszul sign rule degenerates to commutativity. Rosser's comparison is degenerate on consistent
    theories, and its real degree of freedom is a **total order** on proofs, not an involution; it
    joins Feferman 1960 as a second instance of the parent's **gauge** reading. Note also that the
    commonly quoted "Rosser sentences are not unique" is half a theorem: Guaspari and Solovay 1979
    prove a **dichotomy**, and which side a predicate falls on depends on the predicate. *Ruling:*
    none needed; recorded so none is re-proposed.

11. **The one lead worth a session, if any is spent here.** §5. Graded monads and graded modal type
    theories (Katsumata POPL 2014; Fujii-Katsumata-Melliès FoSSaCS 2016; Orchard-Liepelt-Eades ICFP
    2019; Gaboardi-Katsumata-Orchard-Sato ESOP 2021) are graded by a monoid or preordered semiring.
    $\mathbb{Z}_2$, parity of the number of uses of a resource, is admissible and, as far as this
    sweep found, uninstantiated. *In the same breath:* it grades effects and resource use, so it is
    again the presentation layer, and it is further from the spine than anything else here. *Ruling:*
    worth a session, or filed as a curiosity.

12. **Two false friends recorded so a search does not mistake them for prior art.** §5. "Graded modal
    logic" (Fine 1972) means *counting* modalities $\Diamond_{\ge n}$, not a group grading -- the
    direct analogue of the parent's finding about Girard's phase semantics. "Graded lattice" and
    "graded Boolean algebra" mean rank functions and graded inverse semigroups respectively, neither
    related. *Ruling:* none needed.

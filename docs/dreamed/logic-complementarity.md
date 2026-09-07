---
title: Complementarity for logic
permalink: /dreamed/logic-complementarity
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This file *proposes*; the owner disposes. Nothing here is toesnail theory, and nothing may be
> promoted into `physics/` or `essays/` without the owner authoring the move himself. The `\veq`
> badges below claim something about
> [`docs/dreamed/lean/LogicComplementarity.lean`](lean/LogicComplementarity.lean) **only**, and are
> deliberately not wired into `physics/*.toml` or `tests/test_verify.sh`.

> ## SPECULATIVE MODE: this essay invents mathematical objects that do not exist
>
> The owner asked this session's agents to "dream on creatively, also hallucinate a bit
> intentionally with then again sound logic for the investigations". This essay takes that licence
> literally. It **invents** definitions, names and conjectures, and then attacks them with real
> apparatus. Two limits were held absolutely:
>
> 1. **No invented citations.** Every reference below is either checked against a primary source in
>    this session, or inherited from
>    [`citation-audit.md`](citation-audit.md), which checked it. Where no prior art was found, the
>    text says "no prior art found" rather than supplying a plausible-looking one. Where a
>    well-known result could not be checked because this session's search budget ran out, the text
>    says so and declines to name a source.
> 2. **Every invented object is labelled at the point of use** with **[INVENTED]**, and every one is
>    listed in the inventory immediately below. If a section does not carry that marker, you are
>    reading established mathematics or a checked citation.

## Inventory of Invented Objects

Everything in this list is the essay author's coinage, minted for this file on 2026-09-07. None of
it is standard terminology, none of it is drawn from the literature, and no claim is made that any
of it models anything real. The **things they are built out of** (the Rosser ordering, Feferman's
intensionality, nonstandard models, resource bounds) are real and cited; the **framings, names and
pairings** are not.

| # | Invented object | What it is | Where | Fate |
|---|---|---|---|---|
| I1 | **The Complementarity Test (CT1 to CT5)** | five conditions a candidate pair must pass | §1 | survives, and is the essay's main deliverable |
| I2 | **The bi-theoretic pair** | provability in `T` against provability in an incomparable `T'` | §3.1 | dies at CT3 |
| I3 | **The Rosser azimuth** | which of the two proofs the enumeration reaches first, paired with bare provability | §3.2 | dies at CT3 |
| I4 | **The Girth-Existence pair** | shortest proof length against proof existence | §3.3 | dies at CT3; is the trade-off trap in person |
| I5 | **The Feferman pair** | provability under presentation `alpha` against presentation `beta` | §3.4 | dies at CT1, and is a hidden variable, not a context |
| I6 | **The omega-pair** | `T`-provability against truth in a fixed nonstandard model | §3.5 | dies at CT1 and CT3 |
| I7 | **The budget filtration** | a bounded prover's verdict at budget `B` against budget `B'` | §3.6 | dies at CT3, by post-processing |
| I8 | **The Twin-Rosser pair** | provability of `P` against refutability of a construction from `P` | §3.7 | dies at CT3 |
| I9 | **The Search-Order pair** | the verdict of strategy `A` run first against `A` run second | §4 | the act non-commutes; the state space does not |
| I10 | **The Adoption Algebra** `A(T)` | the full construction: operators that adopt an independent sentence as an axiom | §5 | genuinely non-commutative, and it still fails; killed in §5.4 |
| I11 | **Conjecture C-1 (the Disturbance Conjecture)** | the ball is equivalent to "reading a sentence's status necessarily disturbs it" | §6.2 | stated, then refuted in §6.3 |

---

# 0. The verdict, stated and not teased

**No genuine logical complementarity exists among questions about a sentence, the owner's Bloch ball
cannot be resurrected by naming a pair, and this essay converts the cluster's "nobody has named one"
into three equivalent statements of why nobody can.**

1. **The bar and the geometry are the same demand, by a published theorem.** The cluster has been
   treating "name a pair of incompatible questions" and "justify a ball instead of a simplex" as two
   related requests. They are one. Plávala proved that **all measurements in a probabilistic theory
   are compatible if and only if the state space is a simplex**
   ([Phys. Rev. A **94**, 042108 (2016)](https://arxiv.org/abs/1608.05614)), and Kuramochi sharpened
   it to pairs: **compatibility of any pair of two-outcome measurements characterises the Choquet
   simplex** ([Positivity, 2020](https://arxiv.org/abs/1912.00563)). So the owner's missing pair is
   not evidence for the ball. It is *logically equivalent* to the ball. Naming one and defending the
   ball are the same act, and failing to name one and losing the ball are the same failure. (§1.5)

2. **Nine candidates, nine failures, and one theorem kills all nine.** Every candidate in §3 has the
   shape "a two-valued function of a point of an underlying set". Any two such functions admit a
   joint distribution, built from the Boolean meet of the two events. That is machine-checked
   (`no_logical_complementarity`), and it is why the hunt is not merely unsuccessful but doomed:
   **conjunction is total in a Boolean algebra, and the joint cell IS the conjunction**
   (`joint_is_meet`). (§2)

3. **No uncertainty relation is available even in principle, for any pair whatsoever.** On a point
   mass, every question is answered with certainty at once (`no_uncertainty_relation_binary`). A
   qubit has no state sharp for both `sigma_x` and `sigma_z`; a classical state space has such a
   state for every pair. So condition CT4 fails before any candidate is inspected. (§2.3)

4. **The one real escape route is genuine and buys nothing.** Propositions commute, but the ACTS of
   establishing them need not, and §5 builds a full construction, the **Adoption Algebra**, in which
   they demonstrably do not. It fails on a distinction the cluster has not previously drawn:
   **order-dependence of UPDATE is not order-dependence of EVALUATION.** Non-commuting stochastic
   maps on a simplex are ordinary (`escape_route_closed`); they leave the state space a simplex and
   leave every pair of questions jointly answerable. In quantum theory the two coincide because the
   update associated with an effect is determined by the effect. In logic they come apart, and all
   the non-commutativity ends up in the half that does not matter. (§4, §5.4)

5. **WITHDRAWN 2026-09-07, and it was this essay's proudest claim.** It read: a non-simplex state
   space is exactly one in which states cannot be broadcast
   ([Barnum, Barrett, Leifer, Wilce, Phys. Rev. Lett. **99**, 240501
   (2007)](https://arxiv.org/abs/0707.0620)), so choosing a ball asserts that the status of a
   sentence cannot be copied, and it manifestly can, because you publish the proof.
   **The inference does not hold.** Broadcastability is a property of a SET of states, and in
   quantum theory a set of mutually *orthogonal* states can be perfectly cloned. "Proved true" and
   "proved false" are the poles, hence orthogonal, so copying a published proof exhibits exactly
   the case quantum theory also permits and separates nothing. The citation is accurate and its
   scope was misused. Located by a Fable review pass (`review-essays.md`, HIGH 1) and confirmed
   independently by the coordinator. Item 4 of this list, the compatibility-equals-simplex result,
   is unaffected and remains this essay's real contribution. (§6.3)

6. **Recommendation, with its weakness in the same breath.** *Close the search for a complementary
   pair, and record the closure as a theorem rather than as a failure to find.* The weakness that
   would overturn it: everything above is conditional on the state of a sentence being a
   distribution over *something*. A general probabilistic theory need not be. What §6 shows is that
   **nothing in logic supplies the something-else**, not that no such thing could exist. If the
   owner's intended object is the state of a bounded prover's physical memory rather than the state
   of a sentence, the argument does not apply, and then §7 applies instead: that is a quantum
   computer wearing a logician's coat, and it is not a logic.

---

# 1. The bar, stated before anything is invented

The failure mode this section exists to prevent is the one the cluster keeps circling: mistaking a
**trade-off** for a **complementarity**. Trade-offs are everywhere. Time against certainty, axiom
strength against proof length, precision against recall, budget against coverage. None of them is
complementarity, and a candidate that offers one has offered nothing.

## 1.1 The crisp difference

> **A trade-off constrains what an AGENT can DO. A complementarity constrains what the STATE can
> BE.**

Two consequences make this operational rather than rhetorical.

- **A trade-off dissolves when the agent is given more.** Give a prover unbounded time and the
  time-against-certainty trade-off evaporates. Give a quantum experimenter unbounded resources and
  `sigma_x` against `sigma_z` does not move at all. Complementarity is agent-independent.
- **A trade-off can be recorded after the fact; a complementarity cannot.** If the two answers exist
  and you merely could not afford both, then a bookkeeper with a transcript could have written both
  down. Complementarity says the transcript cannot exist.

That second form is the one that becomes a test, because "the transcript cannot exist" is exactly
"there is no joint distribution".

## 1.2 The Complementarity Test **[INVENTED]**

A candidate pair of questions `X`, `Y` about a sentence `P` is **complementary** only if it passes
all five. The test is the essay's own construction; its ingredients are standard.

- **CT1, same object.** Both questions must be about the *same* thing, namely the state of `P`.
  A pair in which one question is about `P` and the other is about a theory, a model, a prover or a
  presentation fails here, because then there is no single state for them to be incompatible
  properties of. This condition eliminates more candidates than any other and is the one most
  easily fudged.
- **CT2, both are genuine observables.** Each must be a function of the state alone: an affine
  functional on the state space, so that mixing states mixes answers. A question whose answer
  depends on facts not carried by the state is not an observable of that state, it is an observable
  of a larger state, and the pair should be re-posed there.
- **CT3, no joint distribution.** There must be no single probability distribution over the four
  answer pairs reproducing both marginals, for at least one state. This is the definition of
  incompatibility and it is what CT4 and CT5 are downstream of.
- **CT4, a genuine uncertainty relation.** There must be a state-independent lower bound on some
  joint measure of spread, valid on *every* state. Equivalently: no state may be sharp for both.
- **CT5, extreme-point excess.** The resulting state space must have more extreme points than any
  single maximal measurement has outcomes. A ball has a sphere of them; a simplex has exactly as
  many as the maximal measurement, which is what makes the decomposition of a mixed state unique.

CT3, CT4 and CT5 are not independent for the classical case; the essay applies all three anyway,
because a candidate that fails different ones for different reasons is diagnostically more useful
than one that fails a single gate.

## 1.3 Three near-misses that the test must reject, and does

- **Constraint on the support of the joint is not an uncertainty relation.** If `P` entails `Q`,
  then the joint cell `(P true, Q false)` is empty. Three of the candidates below produce exactly
  this and it looks impressive. It is entailment, present in every Boolean algebra, and the joint
  still exists.
- **Partiality is not incompatibility.** A question that sometimes has no answer (the Rosser
  ordering when neither proof exists) is a *partial* observable. Adding "undefined" as a third
  outcome makes it total, and the joint reappears on the enlarged outcome set. Partiality costs a
  cell, not a joint.
- **Destructiveness is not complementarity.** A classical measurement can destroy its sample. That
  is a fact about the channel, not about the state space, and it does not produce non-simplex
  geometry. §4 makes this precise and machine-checks it.

## 1.4 What passing would buy

If a pair passed, the payoff is exact and large. The state space acquires extreme points off the
vertex set; the decomposition of a mixed state stops being unique; the sibling essays' report
triangle grows a second axis; and the owner's Bloch ball, with a real azimuth carrying a real
second question, is back. That is why this is the highest-value speculative question in the
cluster, and why a negative has to be argued rather than asserted.

## 1.5 The bar and the ball are the same demand

The cluster has been running two arguments in parallel, and they are one argument.

$$
\text{all pairs of two-outcome questions jointly answerable}
\iff
\text{state space is a simplex}
$$

Left to right for the finite classical case is `no_logical_complementarity` below. Right to left,
in full generality, is the published result: **Plávala**, *All measurements in a probabilistic
theory are compatible if and only if the state space is a simplex*,
[Phys. Rev. A **94**, 042108 (2016)](https://arxiv.org/abs/1608.05614), strengthened to pairs of
two-outcome measurements by **Kuramochi**, *Compatibility of any pair of 2-outcome measurements
characterizes the Choquet simplex*, [Positivity (2020)](https://arxiv.org/abs/1912.00563). Both are
quoted as such (references [20] and [25], and Theorem 7.11) in **Plávala**, *General probabilistic
theories: An introduction*, [Physics Reports (2023), arXiv:2103.07469](https://arxiv.org/abs/2103.07469),
whose Theorem 7.11 reads verbatim:

> There exists a pair of incompatible two-outcome measurements `m1` in `C(K, S2)` and `m2` in
> `C(K, S2)` whenever `K` is not a simplex.

This matters for how the owner should read the rest of the cluster. The adjudicator's closing line,
"name a pair of questions about a sentence that cannot be answered simultaneously", is not a
side-condition on the ball. It is the ball, restated. So a ruling on one is a ruling on both, and
the four essays that landed on a simplex were not four weak arguments but four routes to a
statement that is now known to be equivalent to the thing being decided.

---

# 2. Why the answer is almost certainly no, before any candidate is examined

## 2.1 Conjunction is total, and the joint cell is the conjunction

Propositions form a Boolean algebra. That is not an assumption about logic; it is what the
Lindenbaum-Tarski construction produces from any theory in classical propositional or first-order
logic. In a Boolean algebra, `X and Y` exists for every `X` and `Y`. And the joint distribution of
two two-valued questions is *nothing but* the state's weight on the four meets:

$$
J(b,c) \;=\; \mu\big(X^{b} \wedge Y^{c}\big), \qquad b,c \in \{\text{yes},\text{no}\}
\veq{joint-is-meet}\lean
$$

Machine-checked as `joint_is_meet`, with the marginal property as `joint_marg_left` and
`joint_marg_right`. The headline form is:

$$
\forall\, S,\;\forall\, X,Y : \Omega \to \{0,1\}, \quad
\exists\, J \ge 0 : \textstyle\sum_{b,c} J = 1,\;
\sum_c J(b,c) = \mu_X(b),\; \sum_b J(b,c) = \mu_Y(c)
\veq{no-joint}\lean
$$

as `no_logical_complementarity`. **There is no hypothesis on `X` and `Y`.** They are arbitrary. Any
candidate pair that can be written as two two-valued functions of the same underlying point is
refuted the moment it is written down, without reading what it says.

That is the whole reason the hunt in §3 fails, and it is worth stating in the blunt form: *a
complementary pair for logic would require two questions about a sentence that are not both
properties of the sentence.*

## 2.2 Order does not matter either

`joint_symm` checks that asking `X` then `Y` and asking `Y` then `X` produce the same joint,
transposed. In quantum theory this is precisely where non-commutativity shows up operationally: the
sequential statistics of `sigma_x` then `sigma_z` differ from `sigma_z` then `sigma_x`. Here they
cannot differ, because both are read off one point.

## 2.3 No uncertainty relation, for any pair, ever

$$
\text{for every } \omega, \; \mu^{\delta_\omega}_X\big(X(\omega)\big) = 1
\;\text{ and }\;
\mu^{\delta_\omega}_Y\big(Y(\omega)\big) = 1
\veq{sharp}\lean
$$

`no_uncertainty_relation_binary`. On any point mass both questions are answered with certainty, so
the product of any two spreads is zero somewhere, so no state-independent lower bound exists. CT4 is
unpassable for every candidate of this shape. Compare the qubit, where the corresponding statement
is false and that falsity is the entire content of the uncertainty relation.

## 2.4 What this does and does not establish

It establishes: *if* the state of a sentence is a probability distribution over a set of underlying
points, complementarity is impossible. It does not establish that logic forces such a set. The
sibling essay [`logic-models-ensemble.md`](logic-models-ensemble.md) argues one way to get it
(measures on the Stone space of the Lindenbaum-Tarski algebra) and
[`logic-epistemic-state.md`](logic-epistemic-state.md) argues another (a distribution over four
epistemic statuses). §6 asks what a third option would have to look like.

---

# 3. Nine candidates

Each is named, marked where the framing is invented, and run through CT1 to CT5. The verdicts are
uniform by construction: the test is applied identically to all nine, including the ones the author
wanted to survive.

## 3.1 The bi-theoretic pair **[INVENTED]**

**Definition.** Fix two consistent theories `T`, `T'` that are incomparable, for instance
`ZFC + CH` and `ZFC + not-CH`, or `PA + Con(PA)` and `PA + not-Con(PA)`. Ask
`X = "is P provable in T?"` and `Y = "is P provable in T'?"`.

**Why it looks promising.** The two theories genuinely disagree, they cannot be merged (their union
is inconsistent), and there are sentences on which they give opposite verdicts. "Cannot be merged"
sounds exactly like "cannot be answered simultaneously".

**Verdict: FAIL at CT3, and the reason is a good one to internalise.** The theories cannot be
merged; the *questions* merge fine. Both are properties of the single object `P`, both are
computably enumerable, and a dovetailing search answers both in the limit. The joint is the
four-cell table of §2.1. What "cannot be merged" actually gives is a constraint on the *support*:
if `T` and `T'` disagree on `P` then some cell is empty. §1.3 already rejected that as entailment
wearing a costume.

CT1 passes, CT2 passes, CT3 fails, CT4 fails (`P` = `0 = 0` is sharp for both), CT5 fails.

## 3.2 The Rosser azimuth **[INVENTED name; the ordering is Rosser's]**

**Definition.** Fix the standard enumeration of `T`-proofs. Let `R(P) = 1` if the least proof of `P`
appears before the least proof of `not-P`, and `0` otherwise. Pair `R` with bare provability
`Pr_T(P)`.

**Why it looks promising, and this is the strongest first impression of the nine.** The ordering is
real, not decorative: it is the device by which Rosser (1936) strengthened Gödel's first
incompleteness theorem from omega-consistency to bare consistency. It is genuinely a *second*
question about the same sentence rather than a rephrasing. And it has the right shape for the
owner's picture: it is an **ordering**, and the Bloch equator is a circle, which is what an ordering
wants to live on. If any candidate deserved to be the azimuth, it is this one.

**Verdict: FAIL at CT3.** `Pr_T` and `R` are both functions of one object, the proof enumeration,
and two functions of one object always admit a joint. Two riders, which are the interesting part.

- `R` is **partial**: undefined when neither `P` nor `not-P` is provable, which is the case that
  matters most. §1.3's rule applies. Making it total by adding "undefined" restores a three-outcome
  observable, and a joint exists on the enlarged table.
- The sibling [`logic-bloch-gates.md`](logic-bloch-gates.md) proved that **no rotation-covariant
  order exists on the equator**. The Rosser order is an order, but it is tied to a fixed
  enumeration, and re-Gödel-numbering permutes it. So even if it had passed CT3 it would have
  failed the geometric requirement that essay identified. Two independent obstructions, same
  candidate.

## 3.3 The Girth-Existence pair **[INVENTED]**, and the trade-off trap in person

**Definition.** `X = "does P have a T-proof of length at most n?"` against
`Y = "does P have a T-proof at all?"`.

**Why it looks promising.** The speed-up phenomenon is real: strengthening a theory can shorten
proofs enormously, so there is a genuine and dramatic tension between what a bounded prover can
reach and what is true of the theory. It feels like a resource uncertainty relation.

*(Attribution note, kept deliberately: this phenomenon is standardly attributed to a short 1936
Gödel note on proof lengths, and there is a separate speed-up theorem due to Blum in computability
theory. **This session's web-search budget was exhausted before either attribution could be checked
against a primary source, so no citation is given.** The essay's argument does not depend on the
attribution, and inventing one would be worse than the gap.)*

**Verdict: FAIL at CT3, and this candidate is the trap the whole test exists to catch.** Bounded
provability is a **refinement** of provability, and a refinement and the thing it refines always
have a joint, because one is a coarse-graining of the other.

Apply §1.1's two tests explicitly. *Does it dissolve when the agent is given more?* Yes: with
unbounded budget the tension is gone. *Could a bookkeeper have written both answers down?* Yes,
trivially, by running the unbounded search and recording the length. So it is a trade-off, it is
about the prover, and it says nothing about the state of `P`.

## 3.4 The Feferman pair **[INVENTED name; the intensionality is Feferman's]**

**Definition.** Provability is not a function of the sentence alone. It depends on the
*presentation* of the axiom set: which formula is used to define "is an axiom". Fix two
presentations `alpha`, `beta` of the same theory and ask `X = Pr_alpha(P)`, `Y = Pr_beta(P)`.

**Why it looks promising, and this is the candidate that survives longest.** The intensionality is
completely real and is the subject of **Feferman**, *Arithmetization of Metamathematics in a General
Setting*, [*Fundamenta Mathematicae* **49**: 35 to 92 (1960)](https://plato.stanford.edu/entries/goedel-incompleteness/),
confirmed verbatim against the Stanford Encyclopedia's bibliography in this session. The
Encyclopedia states the point the candidate leans on directly: "the first theorem and its relatives
are *extensional* results, the second theorem is *intensional*: it must be possible to think that
Cons(F) in some sense *expresses* the consistency of F". Presentation-dependence is exactly the
shape of a **context**, and contextuality is the one genuinely quantum-adjacent phenomenon that does
not need a Hilbert space.

**Verdict: FAIL at CT1, then at CT3, and the diagnosis is the useful part.** Presentation-dependence
is a **hidden variable being made explicit**, which is the opposite of contextuality. Both questions
are functions of the enlarged classical point `(P, presentation)`, and a joint exists on that
enlarged space: the pushforward of a state over presentations.

Contextuality proper requires that no global assignment be consistent with all contexts, which is
the Kochen-Specker obstruction (**Kochen and Specker**, *The Problem of Hidden Variables in Quantum
Mechanics*, *Journal of Mathematics and Mechanics* **17**: 59 to 87 (1967), citation confirmed this
session). Here a global assignment exists and is embarrassingly easy to write: pick a presentation
per question and read off the answer. There is nothing to obstruct.

A second, independent block: Kochen-Specker needs Hilbert dimension at least 3, confirmed this
session against the Stanford Encyclopedia entry, which states the theorem for "a Hilbert space of QM
state vectors of dimension `x >= 3`". A pair of questions about one sentence lives at dimension 2 at
best, where the sibling essays already established that Gleason does not force the ball either. The
qubit is the wrong size for contextuality, whichever route you take to it.

## 3.5 The omega-pair **[INVENTED]**

**Definition.** `X = "T proves P"` against `Y = "M satisfies P"` for a fixed nonstandard model `M`
of `T`.

**Why it looks promising.** The divergence is real and is the standard picture of incompleteness.
`M` can satisfy `Prov(⌜P⌝)` by virtue of a nonstandard "proof", a coded object of nonstandard
length that is not a proof at all, while `T` does not prove `P`. The two questions genuinely come
apart.

**Verdict: FAIL at CT1 and CT3.** Coming apart is not incompatibility; it is the two questions being
*different*, which every pair of distinct questions is. For a fixed `M`, both are two-valued
functions of `P` and the joint is the four-cell table again. CT1 fails as well, because `Y` is a
property of the pair `(P, M)`, not of `P`.

Quantifying over `M` instead of fixing one does not help: it delivers a *measure over models*, which
is precisely direction (i) of [`logic-models-ensemble.md`](logic-models-ensemble.md), and that essay
proves the resulting states are diagonal, so the reachable set is a segment. Every road out of this
candidate leads back into the simplex.

## 3.6 The budget filtration **[INVENTED]**

**Definition.** Let `V(B)` be the verdict a fixed resource-bounded prover returns at budget `B`
(one of yes, no, don't-know). Pair `V(B)` with `V(B')` for `B < B'`.

**Why it looks promising.** Budgets are the owner's actual application: a scheduler in a layered
core deciding how much to spend on a sentence. And the essay
[`logic-simplex.md`](logic-simplex.md) §7.2 already identified budget as the missing coordinate.

**Verdict: FAIL at CT3, and this candidate fails the hardest.** The verdicts at increasing budgets
form a **filtration**: `V(B)` is obtained from the `B'` run by stopping early. Stopping early is a
**post-processing** of a single measurement, and post-processings of a single measurement are
always compatible with it and with each other. Plávala's review records this as the known result
(Proposition 7.15 generalises "two measurements are compatible if and only if they are both
post-processings of a single measurement"). The joint here is not merely constructible in the
abstract; it is the *law of the whole search process*, which the prover literally has.

This is the single most efficient kill in the essay, because the same reduction disposes of §3.3
(bounded proof length is a stopping rule) and half of §3.2 (the Rosser order is a stopping rule on
the enumeration). **Anything a prover obtains by stopping one search early is a post-processing of
that search, hence compatible with everything else it obtains the same way.** Three candidates die
to one sentence.

## 3.7 The Twin-Rosser pair **[INVENTED]**

**Definition.** `X = Pr_T(P)` against `Y = "T refutes G(T + P)"`, where `G(S)` is the Gödel sentence
of `S`. The second question is about a sentence constructed *from* `P`, so it is not a rephrasing.

**Why it looks promising.** The dependence is intricate, the second question changes when the first
is answered (adding `P` changes the theory whose Gödel sentence is being built), and it smells like
back-action.

**Verdict: FAIL at CT3.** The construction `P |-> G(T + P)` is a fixed computable function, so `Y`
is a function of `P` exactly as `X` is. The joint exists. The "smell of back-action" is the
observation that the construction is `P`-dependent, which is what a function of `P` is.

## 3.8 The plain pair everyone reaches for first

For completeness, the candidate that comes up in every conversation: **provability against truth**.
It fails CT1 immediately, because truth is a property of `(P, M)` for a model `M` and provability is
a property of `(P, T)` for a theory `T`. There is no common state for them to be incompatible
properties of, and once one is fixed §3.5 applies. Worth stating explicitly because its failure is
the template for the others: **most candidate "pairs" are two questions about two different
objects, and the incompatibility is smuggled in by the ambiguity of the word "about".**

## 3.9 Scoreboard

| Candidate | CT1 | CT2 | CT3 | CT4 | CT5 | Died of |
|---|---|---|---|---|---|---|
| I2 bi-theoretic | pass | pass | **fail** | fail | fail | joint is the four meets |
| I3 Rosser azimuth | pass | pass | **fail** | fail | fail | two functions of one enumeration |
| I4 Girth-Existence | pass | pass | **fail** | fail | fail | refinement, and a trade-off |
| I5 Feferman | **fail** | pass | fail | fail | fail | hidden variable, not a context |
| I6 omega-pair | **fail** | pass | fail | fail | fail | two objects |
| I7 budget filtration | pass | pass | **fail** | fail | fail | post-processing of one search |
| I8 Twin-Rosser | pass | pass | **fail** | fail | fail | fixed computable construction |
| I9 Search-Order | pass | **fail** | fail | fail | fail | see §4 |
| plain provability/truth | **fail** | pass | fail | fail | fail | two objects |

Nine for nine. That uniformity is itself informative and is what §2 predicted.

---

# 4. The escape route: propositions commute, but acts might not

The candidates all failed the same way, and the diagnosis points at the exit. Every one of them was
a *property of the sentence*. What if the non-commutativity does not live between propositions at
all, but between the **acts** of establishing them?

## 4.1 The Search-Order pair **[INVENTED]**

**Definition.** A prover holds a budget. Strategy `A` and strategy `B` each consume budget and each
may return a verdict. Let `X` be the verdict of `A` when `A` is run first, and `Y` the verdict of
`A` when `B` has already run. These are different questions with different answers, and the
difference is order.

This is real. A prover that runs `A` then `B` is genuinely not the same as one that runs `B` then
`A`: budget is consumed, caches are warmed, lemma stores are populated, the search is destructive of
state. Nothing in §2 spoke about dynamics, so §2 does not obviously refute it.

## 4.2 It is real, and it is on the wrong object

The order-dependence is a fact about the prover's *transition*, not about the sentence's *state*.
Formally, the acts are stochastic maps on the state space, and the question is whether
non-commuting stochastic maps make the state space non-classical.

They do not, and this is elementary enough to check outright:

$$
N(p) = 1 - p, \qquad H(p) = \tfrac{1}{2}p, \qquad
N\!\left(H(1)\right) = \tfrac12 \ne 0 = H\!\left(N(1)\right)
\veq{escape}\lean
$$

with both maps carrying the simplex `[0,1]` into itself. Machine-checked as `chan_noncommute` and
`escape_route_closed`. Two stochastic matrices on a classical bit generically fail to commute; this
is unremarkable, it happens in every Markov chain, and no Markov chain has a Bloch ball for a state
space.

## 4.3 The distinction the cluster has not drawn

> **Order-dependence of UPDATE is not order-dependence of EVALUATION.**

In quantum theory the two coincide, and that coincidence is doing more work than it usually gets
credit for. The Lüders update associated with an effect is *determined by the effect*: measuring
`sigma_x` both reads and rotates, with the same operator responsible for both. So non-commuting
observables force non-commuting updates and vice versa, and one can be diagnosed from the other.

In a classical theory with destructive or stateful measurement, they come apart cleanly. The
evaluation map (what a state assigns to a question) stays a commutative algebra of functions; the
update map (what the act does to the state) can be an arbitrary non-commutative monoid of stochastic
maps. All of the Search-Order pair's non-commutativity lands in the update half, which does not
touch the geometry.

This is why "measurement is destructive" is not a route to a ball, and it is why §1.3's third
near-miss is listed there. CT2 is what catches it: `Y` in §4.1 is not a function of the sentence's
state, it is a function of the prover's history.

---

# 5. The full construction: the Adoption Algebra **[INVENTED]**

The Search-Order pair was a sketch. This section builds the best version of the idea properly,
names it, gives it observables, looks for its uncertainty relation, computes its state space, and
then kills it. It is included at length because a well-motivated construction that dies is more
useful to the owner than a vague one that survives by being unexamined.

## 5.1 Definition

Fix a consistent, r.e. theory `T` interpreting enough arithmetic. Let `Th(T)` be the set of
consistent r.e. extensions of `T`.

**Adoption operator.** For a sentence `Q`, define `A_Q : Th(T) -> Th(T)` by

$$
A_Q(S) \;=\; \begin{cases} S + Q & \text{if } S + Q \text{ is consistent}\\[2pt] S & \text{otherwise}\end{cases}
$$

**The Adoption Algebra** `A(T)` is the monoid generated by `{ A_Q : Q a sentence }` under
composition.

**Observables.** For a sentence `P`, the effect `E_P : Th(T) -> {0,1}` with `E_P(S) = 1` iff
`S` proves `P`.

**State.** A probability distribution over `Th(T)`, that is, a credence about which extension the
reasoner is actually working in.

This is not arbitrary. It is the formal shadow of something a working mathematician does constantly:
adopt an independent principle and see what follows. The owner's own layered architecture, a
decidable core consuming reports from an incomplete layer, has exactly this move at its interface.

## 5.2 What genuinely fails to commute

Take `T = ZF`, `Q1 = AC`, `Q2 = "AC fails"`. Then

$$
A_{Q_2}\big(A_{Q_1}(\mathrm{ZF})\big) = \mathrm{ZFC},
\qquad
A_{Q_1}\big(A_{Q_2}(\mathrm{ZF})\big) = \mathrm{ZF} + \neg\mathrm{AC}
$$

because the second adoption is blocked in each case. The two composites are *different theories*,
and they disagree about a great many sentences. So

$$
A_{Q_1} A_{Q_2} \;\ne\; A_{Q_2} A_{Q_1}
$$

**The Adoption Algebra is genuinely non-commutative.** This is not a bookkeeping artefact, not a
budget accident, and not a relabelled cache. Order of commitment changes what is true of the
reasoner's theory, permanently and observably. This is the strongest non-commutativity anywhere in
the cluster, and it is worth saying plainly before it is dismantled.

## 5.3 Looking for the uncertainty relation

Here is the honest attempt to cash it in. Define the "sharpness" of `E_P` in state `mu` as
`|2 mu(E_P = 1) - 1|`. Is there a bound of the form

$$
\text{sharpness}(E_{Q_1}) \cdot \text{sharpness}(E_{Q_2}) \le 1 - \epsilon
$$

on every state? **No, and the counterexample is one line.** Take `mu` to be the point mass on
`ZFC`. Then `E_{AC}` is sharp (value 1) and `E_{\neg AC}` is sharp (value 0). Both maximally sharp,
product 1. `no_uncertainty_relation_binary` is exactly this observation, stated for arbitrary pairs.

The temptation at this point is to say "but you cannot have both AC and not-AC". True, and it is
anticorrelation, not complementarity. Perfect anticorrelation is the *easiest* thing for a joint
distribution to express: put all the weight on the two off-diagonal cells. A joint distribution is
what anticorrelation *is*.

## 5.4 The construction dies, and here is exactly where

The state space of the Adoption Algebra is the set of probability distributions over `Th(T)`. That
is a simplex, whatever `Th(T)` is, and no amount of non-commutativity in the operators changes it.
The operators are stochastic maps *on* that simplex; §4.2 already checked that such maps freely fail
to commute without disturbing the geometry.

Stated as the general lesson, and this is the essay's main positive contribution:

> A non-commutative **monoid of transformations** on a state space is ordinary. What
> complementarity requires is a non-commutative **algebra of observables**, and in the Adoption
> Algebra every observable `E_P` is a two-valued function of a point of `Th(T)`. Those commute by
> `no_logical_complementarity`, unconditionally.

The construction put all its cleverness into the dynamics and none into the observables, and the
geometry is decided entirely by the observables.

## 5.5 The self-attack: did I smuggle in a quantum system?

The question that kills most constructions of this type, applied to my own. Three checks.

- **Did I import a Hilbert space?** No. `Th(T)` is a set, `E_P` is a Boolean function, and the state
  is a probability measure. No complex numbers appear anywhere in the construction, which is
  precisely why it fails: a Bloch ball needs the off-diagonal terms that only a complex (or at least
  a non-commutative) algebra supplies.
- **Did I import non-commutativity by fiat?** No, and this is the construction's one real virtue.
  The non-commutativity of `A_{Q1}` and `A_{Q2}` is derived from a fact about theories (adopting a
  sentence can block a later adoption), not stipulated. That the derived non-commutativity turns out
  to be useless is the finding.
- **Would it have been a quantum system if it had worked?** Yes, and this is the trap the owner
  should hold the whole cluster to. Any construction that *did* produce a non-simplex state space
  for a sentence would owe an account of what physical or computational resource supplies the
  incompatibility. If the answer is "the prover runs on a quantum computer", then the object is a
  quantum computer and the logic is decoration. §7 states this as the standing objection.

---

# 6. What would actually be required, and one conjecture, stated then refuted

## 6.1 The bar, restated as a contrapositive

$$
\text{no joint for } (X,Y)
\;\Longrightarrow\;
\text{no common sample space on which both are two-valued functions}
\veq{bar}\lean
$$

`complementary_pair_needs_no_common_sample_space`. So a genuine pair must give up the thing every
candidate in §3 assumed: that both questions are properties of one underlying point. That is the
only door left, and it is a very small door, because *sentences are their own descriptions*. A
sentence is a finite syntactic object; there is nothing about it that a sufficiently patient
bookkeeper cannot write down.

## 6.2 Conjecture C-1, the Disturbance Conjecture **[INVENTED]**

Here is the strongest reformulation the essay can offer, which is also the fairest way to put the
owner's ball to him as a decidable question rather than a geometric preference.

> **Conjecture C-1 [INVENTED].** The Bloch ball for a sentence is justified if and only if reading
> a sentence's status necessarily disturbs it.

The "if and only if" is not the essay's invention; it is Theorem 7.7 of Plávala's review, whose
equivalent conditions include **(NB1)** the identity channel is measure-and-prepare, **(NB2)** the
identity channel is self-compatible, **(NB3)** a universal broadcasting channel exists, and
**(NB4)** `K` is a simplex. "Measure-and-prepare identity" is exactly "you can read the state
without disturbing it". So a non-simplex state space is precisely one in which reading disturbs.
The invented part is the *application* to logic, and the name.

This is a better question than "name a pair" because it is one the owner can answer from experience
rather than from convex geometry.

## 6.3 C-1 is refuted, and the refutation does not need a candidate pair

The same theorem gives **(NB3)**: a non-simplex state space is one in which states cannot be
broadcast, that is, cannot be copied to two parties such that each holds the original state. The
general no-broadcasting theorem for such theories is **Barnum, Barrett, Leifer and Wilce**,
*Generalized No-Broadcasting Theorem*,
[Phys. Rev. Lett. **99**, 240501 (2007)](https://arxiv.org/abs/0707.0620).

So: **choosing a Bloch ball for a sentence asserts that the status of a sentence cannot be
broadcast.**

It manifestly can. Publish the proof. A proof is a finite object that can be copied, checked
independently by arbitrarily many parties, and leaves every copy in possession of the full status.
Reading a proof does not consume it. Broadcastability of proof is not an incidental feature of
mathematical practice; it is close to the whole point of proof, and it is the property that
distinguishes a proof from an oracle.

This refutation is worth separating out because of what it does *not* need. It does not need a
candidate pair, it does not need the nine failures of §3, and it does not need any assumption about
what `Omega` is. It bears directly on the ball, from the operational side, and it is independent of
everything else in this essay. **It is also, as far as this session found, new to the cluster: no
prior art found for applying the no-broadcasting characterisation to a logical state space.**

## 6.4 The one door that stays open, stated fairly

The argument above is conditional in one place, and honesty requires flagging it rather than burying
it. Everything rests on the state of a sentence being a probability distribution over *something*, a
set of models, a set of verdicts, a set of extensions. A general probabilistic theory need not be
of that form; that is what makes GPTs interesting.

What this essay establishes is that **nothing in logic supplies a non-classical something**. Nine
candidates were tried and each collapsed to functions on a set. The one construction built
specifically to avoid it (§5) put its non-commutativity in the dynamics, where it is free and
useless. And two independent operational tests (no uncertainty relation, broadcastability of proof)
say the object behaves classically.

That is not a proof that no such thing exists. It is a strong prior, three independent
confirmations, and a precise statement of what would have to be produced.

---

# 7. The standing objection, applied to everything including this essay

Any future candidate should be met with one question:

> **Is this about logic, or is it a quantum system with logical labels?**

The test is whether the incompatibility is derived from a property of *sentences* or from a property
of the *machine* the reasoner runs on. If a construction says "the prover's registers are qubits, so
its answers do not commute", the answer is that qubits do not commute and the sentences played no
part; one could relabel the qubits with recipes or with poems and the mathematics would be
unchanged. [`citation-audit.md`](citation-audit.md) already found the geometry published as prior
art in a quantum-optics setting, **Sperling and Walmsley, Phys. Rev. A 97, 062327 (2018) §IV.3**,
where true and false sit at the Bloch poles and an undecidable continuum on the equator. That paper
has a physical system underneath the picture. The logical reading has never had one, and that
absence is what nine candidates just measured.

This essay's own construction (§5) is subjected to the same test in §5.5 and passes the "did not
smuggle" check while failing to deliver, which is the honest combination.

---

# 8. Verdict on the ball

**The owner's Bloch ball cannot be resurrected by naming a pair of complementary questions, and this
essay recommends recording that as closed.**

The recommendation, with the reasons ranked by how much they would cost to overturn:

1. **Hardest to overturn.** Proofs are broadcastable, and a non-simplex state space is exactly one
   whose states are not. This is a single operational fact against a published equivalence, needs no
   candidate pair, and would require denying that a proof can be copied.
2. **Very hard.** No pair of two-valued questions about a sentence can lack a joint distribution, and
   no pair can support an uncertainty relation, both machine-checked. Overturning requires a question
   about a sentence that is not a function of the sentence, and §3.4's most promising attempt at one
   turned out to be a hidden variable.
3. **Hard, and the one to attack if attacking.** The escape via non-commuting acts is genuine
   non-commutativity landing on the wrong object. Overturning it requires an argument that the
   sentence's state, not the prover's history, is what the acts act on. The author tried to build
   that argument in §5 and could not.

**And the weaknesses, in the same breath, because a recommendation without them is a sales pitch.**

- The Lean file is finite and classical. It proves the easy direction of an equivalence whose hard
  direction is taken on published authority.
- Nine candidates is not all candidates. The essay claims a pattern (every candidate reduced to a
  function on a set) and a mechanism (Boolean algebras are commutative), and the pattern is evidence
  for the mechanism rather than a proof of exhaustiveness.
- The whole argument is about the state of a *sentence*. If "Bloch Truth" was always meant to be
  about the state of a *reasoner*, and the reasoner is allowed to be a physical device with genuine
  quantum resources, none of this applies, and §7's objection applies instead. Which of the two the
  owner meant is a question about his intent that no agent can settle, and it is the single input
  that would change the verdict.

---

# Surfaced for the owner

Nothing below has been written to `TODO.md`, `ROADMAP.md` or `REVIEW_ME.md`. A delegated agent's
verdict is a recommendation, never self-settling.

1. **The cluster's open question is closed in the negative, and the closure is a theorem, not a
   failure to find.** Located: §2, `no_logical_complementarity`, `no_uncertainty_relation_binary`.
   Any two two-valued questions about a sentence admit a joint distribution, and every pair has a
   state on which both are sharp. **Ruling needed: accept the closure, or name a question about a
   sentence that is not a property of the sentence.**

2. **The bar and the ball are the same demand, by a published equivalence.** Located: §1.5,
   citing Plávala (Phys. Rev. A 94, 042108, 2016) and Kuramochi (Positivity, 2020) via Theorem 7.11
   of Plávala's Physics Reports review. The adjudicator's "name a pair" and the geometry's "why a
   ball" are not two requests. **Ruling needed: none required, but the cluster's framing should be
   corrected before any of it is promoted, because it currently reads as though the pair were
   evidence for the ball rather than identical to it.**

3. **A refutation of the ball that needs no candidate pair: proofs are broadcastable.** Located:
   §6.3, on Barnum-Barrett-Leifer-Wilce (PRL 99, 240501, 2007) and Theorem 7.7 (NB3, NB4) of the
   review. A ball asserts a sentence's status cannot be copied; publishing a proof copies it. **No
   prior art found for this application, and it is the finding this essay would most want ratified
   or shot down.**

4. **The escape route is real non-commutativity on the wrong object.** Located: §4.3, §5.4,
   `escape_route_closed`. Order-dependence of update is not order-dependence of evaluation; quantum
   theory conflates them because the Lüders update is determined by the effect, and logic does not.
   **Ruling needed: is the "acts, not propositions" line worth pursuing further, or closed?**

5. **The Feferman pair is the best candidate anyone is likely to bring, and it is a hidden variable,
   not a context.** Located: §3.4, on Feferman 1960 (Fund. Math. 49: 35 to 92, confirmed this
   session). Presentation-dependence looks like contextuality and is its opposite; Kochen-Specker
   needs a global-assignment obstruction and dimension at least 3, and neither is available. **Ruling
   needed: none, but this is the objection to keep loaded for the next time intensionality is
   offered as a route to non-classicality.**

6. **Three candidates die to one reduction, which is worth keeping as a tool.** Located: §3.6.
   Anything a prover obtains by stopping a single search early is a post-processing of that search,
   hence compatible with everything else obtained the same way. This disposes of the budget pair,
   bounded proof length, and the Rosser ordering at once.

7. **One attribution was deliberately left unsourced rather than guessed.** Located: §3.3. The
   proof-length speed-up phenomenon is standardly attributed to a 1936 Gödel note, and this
   session's search budget was exhausted before it could be checked against a primary source, so no
   citation is given. **Ruling needed: none, but if the cluster is ever promoted, that attribution
   should be verified rather than inherited.**

8. **The single input that would change the verdict is a question about your intent.** Located: §8.
   If "Bloch Truth" is the state of a *sentence*, the ball is refuted three independent ways. If it
   is the state of a *physical reasoner* with genuine quantum resources, none of this applies and
   §7's objection applies instead: it is then a quantum computer with logical labels, and the logic
   is decoration. **Ruling needed: yours, and only yours.**

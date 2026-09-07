---
title: A state over models
permalink: /dreamed/logic-models-ensemble
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This file *proposes*; the owner disposes. Nothing here is toesnail theory, and nothing may be
> promoted into `physics/` or `essays/` without the owner authoring the move himself. The `\veq`
> badges below claim something about [`docs/dreamed/lean/LogicModels.lean`](lean/LogicModels.lean)
> **only**, and are deliberately not wired into `physics/*.toml` or `tests/test_verify.sh`.

# Provenance, and the fork this essay is one half of

The seed is the owner's standing backburner project **"Bloch Truth"**, named by him on 2025-08-08
(`~/knowledge/sessions/claude-ai/2025-08-05_breaking_project_paralysis_cbae6cd6.md:1334`) and
developed in his 2025-08-16 thread *Falsifiability and Logical Boundaries*. His founding turn there
(`conv-falsifiability.md:46`, verbatim) already contains the word this essay is about:

> Let's use a qubit with the two states (proven) true and (proven) false. What states can it
> describe in superposition or even **statistical mixture**? How to encode that a statement is
> unprovable or that is provable but not yet determined whether it's true or false?

In the session of 2026-09-07 he pushed further, and the push is what produced the fork:

> can the equator be considered any kind of "unprovedness" instead, and the origin as maximum
> non-knowledge? don't just consider pure states but also mixed ones, i.e. Bloch with r<1 as well

Working that through with $\rho = \tfrac12(I + \mathbf{r}\cdot\boldsymbol\sigma)$ and the poles read
as proven-true / proven-false gives three facts and then a question. The facts: the equatorial
**disc** $\{z = 0,\ r \le 1\}$ is *exactly* the set of states with $p(\text{true}) = \tfrac12$, so
"unproved" is an exact characterisation there rather than an approximation; $|z| \le r$ always, so
$r = 0$ forces $z = 0$ and the origin necessarily lies on the equator; and $S(\rho) =
h\!\left(\tfrac{1+r}{2}\right)$ is maximal only at $r = 0$.

The question is what the density matrix is a state **of**, and the two available answers are not
compatible on one qubit:

- **(i) A state over MODELS.** The randomness is over which model of the theory you are in. A
  sentence's truth value is the measure of the models satisfying it. This is the semantics the
  owner's own word "statistical mixture" points at.
- **(ii) A state over EPISTEMIC STATUS.** The randomness is over what a reasoner knows. Low entropy
  is "settled", high entropy is "no idea".

**This essay argues (i), as hard as (i) can honestly be argued.** A sibling agent argues (ii) in
[`logic-epistemic-state.md`](logic-epistemic-state.md) and a third adjudicates. Section 7 is a
dedicated accounting of what (i) costs, written for the adjudicator rather than for the case, and
Section 9 gives a verdict with its weaknesses in the same breath. Sibling essays of the same
cluster: [`logic-bloch-poles.md`](logic-bloch-poles.md) (what the poles should be),
[`logic-bloch-gates.md`](logic-bloch-gates.md) (what the gates say the equator is),
[`logic-qutrit-su3.md`](logic-qutrit-su3.md) (the qutrit),
[`weltformel-impossibility.md`](weltformel-impossibility.md).

---

# 0. The headline, stated and not teased

**Direction (i) is right about the semantics and wrong about the geometry, and both halves are
theorems rather than opinions.**

1. **The rigorous version of "a state over models" is a probability measure on a Stone space, and
   for an incomplete theory that space is Cantor space.** The Lindenbaum-Tarski algebra of PA is
   countable and *atomless* -- atomless precisely because of Goedel, since an atom would be a
   consistent sentence whose extension of PA is complete -- so it is the unique countable atomless
   Boolean algebra and its Stone space is homeomorphic to the Cantor set. The points of that space
   are the complete consistent extensions of the theory. A sentence is a clopen subset. Its truth
   value is that set's measure. Nothing here is analogy; it is Stone duality.

2. **Every state direction (i) can produce is diagonal in the truth basis, and the reachable set is
   exactly the segment $[-1,1]$ on the $z$-axis.** A measure hands you probabilities and nothing
   else, so the off-diagonal entries are identically zero, and mixing cannot create them
   (machine-checked, binary and for arbitrary finite families). The equator's interior, the phase
   $\varphi$, and the whole $x$-$y$ structure are **unreachable**. Under (i) the owner's Bloch ball
   is mostly empty. That is the central cost and it is not softened anywhere below.

3. **The empty ball is not a bug in (i); it is a theorem about logic.** The state space of a unital
   C\*-algebra is a Choquet simplex **if and only if the algebra is commutative**, in which case it
   is a Bauer simplex (Bauer's classical result, restated in
   [Kennedy-Shamovich, *Noncommutative Choquet simplices*](https://arxiv.org/pdf/1911.01023)). A
   Boolean algebra is commutative. So "the state space of a classical logic is a simplex" is forced,
   and reaching for a ball is not a richer picture of the same thing: it **imports
   non-commutativity**, that is, it asserts that some pair of questions about a sentence is not
   simultaneously answerable. Nobody in the seed conversation offered a candidate pair.

4. **The equator cannot be recovered inside (i), and the obstruction is Kochen-Specker.** Four
   rescue routes are tested in Section 5. The only one that genuinely produces off-diagonal terms is
   Birkhoff-von Neumann quantum logic, which buys them by giving up distributivity -- and a
   non-distributive lattice has no Stone space of points at all: for dimension $\ge 3$,
   Kochen-Specker says there are **no** non-contextual two-valued valuations, so the space of
   "models" that (i) is a state over is empty. **The equator and the model space are mutually
   exclusive by a theorem, not by an oversight.**

5. **A complete theory's state space is two points; the segment opens only under incompleteness.**
   If every sentence is provable or refutable, the Lindenbaum algebra is the two-element algebra,
   the Stone space is a single point, the measure is unique, and every sentence sits at a pole. This
   is machine-checked, and it is a direct deliverable for the owner's layered architecture: the
   complete lower layer he wants is exactly the layer whose Stone space is a point.

6. **Where (i) is genuinely and structurally beaten:** a coherent measure assigns probability 1 to
   every theorem, so it **cannot represent uncertainty about the output of a computation you have
   not run**. Direction (i) models *independence*, never *ignorance*. It has no state for "I have
   not checked yet". Section 7 states this without hedging; it is the strongest thing direction (ii)
   has, and it is not a small thing.

**ADDED after publication, 2026-09-07 (see §4.4).** A seventh item belongs on this list, located by
the sibling [`logic-counterfactual-boundary.md`](logic-counterfactual-boundary.md) §2.2 after this
essay was published. **The uncomputability is stacked, and item 6's wall was not the bottom one.**
§4.2 rules out a computable *measure*. One level down, every *point* of the Stone space is an
undecidable set of sentences (Goedel-Rosser), with no exceptions; and read as *models* rather than
as theories, exactly one isomorphism class is computable and every other has both its addition and
its multiplication non-recursive (**Tennenbaum 1959**). That closes the engineering fallback of
"never mind the measure, just pick a completion and believe it" -- which matters, because §4.2's
wall is quoted with a *non-dogmatic* hypothesis and a picked completion is precisely a dogmatic
state, so the fallback slipped past it. §4.4 states this, machine-checks the one part of it that is
not about computability at all, and is candid that the strengthening is smaller than it looks:
nothing in §2, §3 or §5 depends on it.

**The constructive recommendation:** keep (i) as the account of what a *theory* determines about a
*sentence*, and drop the ball for it. (i)'s honest geometry is a **Bauer simplex** over the Cantor
space of completions, which is infinite-dimensional and much richer than a 3-ball -- the richness
just lives in the *correlations between sentences*, not in the geometry of one. And if the owner
wants a genuinely larger truth-value object while staying inside logic, the move with a literature
behind it is **Boolean-valued models** (Scott-Solovay), not a Bloch sphere.

---

# 1. What "a state over models" has to mean before it can be argued

The phrase is used loosely in the seed conversation and in the prior AI turns there. Made precise it
needs three things: a space, a sigma-algebra, and a measure. Direction (i) can supply all three, and
supplying them properly is most of its case.

**The space cannot be "the models".** For a first-order theory the models form a proper class, and
worse, a sentence's truth value is invariant under elementary equivalence: two elementarily
equivalent models agree on every sentence, so nothing about the individual model is visible to the
construction. Any measure over actual models pushes forward along "take the complete theory of the
model", and only the pushforward is doing work.

**So the space is the set of complete consistent extensions.** Write $T$ for the theory (say PA) and
$\mathrm{Sent}$ for its sentences. Two sentences are identified when $T$ proves them equivalent, and
the quotient

$$
B_T \;=\; \mathrm{Sent}/\!\sim_T,\qquad \varphi \sim_T \psi \iff T \vdash \varphi \leftrightarrow \psi
$$

is a Boolean algebra under the induced $\vee, \wedge, \neg$: the **Lindenbaum-Tarski algebra** of
$T$. Its $\top$ is the class of theorems, its $\bot$ the class of refutable sentences, and the
sentences $T$ decides are exactly $\{\bot, \top\}$.

**Stone duality does the rest.** The Stone space $S(B_T)$ is the set of ultrafilters of $B_T$ with
the topology generated by the sets $[\varphi] = \{u : \varphi \in u\}$. An ultrafilter of $B_T$ is
precisely a **complete consistent extension** of $T$: for each sentence it chooses $\varphi$ or
$\neg\varphi$, consistently and deductively closed. By Goedel's completeness theorem each such point
is realised by an actual model. $S(B_T)$ is compact, Hausdorff and totally disconnected, and
$\varphi \mapsto [\varphi]$ is an isomorphism of $B_T$ onto the algebra of **clopen** subsets.

**Which Stone space is it, concretely?** Here the theory's own incompleteness decides the topology,
and the argument is two lines.

- $B_T$ is **countable**, because the language is.
- $B_T$ is **atomless**. An atom would be a nonzero $a = [\varphi]$ with nothing strictly between
  $\bot$ and $a$, which says exactly that $T + \varphi$ decides every sentence, i.e. that
  $T + \varphi$ is *complete*. But $T + \varphi$ is consistent (as $a \ne \bot$), recursively
  axiomatized, and interprets Robinson's Q, so Goedel-Rosser makes it incomplete. Contradiction.

A countable atomless Boolean algebra is unique up to isomorphism (Cantor's back-and-forth), it is
the free Boolean algebra on countably many generators, and its Stone space is a second-countable,
zero-dimensional, compact Hausdorff space with no isolated points, hence homeomorphic to **Cantor
space** $2^{\omega}$ (see
[SEP, *The Mathematics of Boolean Algebra*](https://plato.stanford.edu/archIves/spr2018/entries/boolalg-math/)
and [Cantor algebra](https://en.wikipedia.org/wiki/Cantor_algebra)). The recursive-isomorphism
refinement -- that the Lindenbaum algebra of *any* consistent r.e. theory interpreting
Tarski-Mostowski-Robinson is recursively isomorphic to PA's -- is Pour-El and Kripke's, and this
essay uses only the plain algebraic version.

**The measure.** A finitely additive probability on $B_T$ is a map $p$ with $p(\bot) = 0$,
$p(\top) = 1$, $p \ge 0$ and $p(a \sqcup b) = p(a) + p(b)$ for disjoint $a, b$. On a Stone space this
is automatically better behaved than finite additivity usually is: if a clopen set is the disjoint
union of countably many clopen sets, compactness forces all but finitely many to be empty, so
countable additivity on the clopen algebra is **free**, and Carathéodory then extends $p$ uniquely
to a regular Borel (Radon) probability measure on $S(B_T)$ (this correspondence is standard; see
[Sobota, *Finitely additive measures on Boolean algebras*](https://arxiv.org/pdf/2503.08910) for the
statement and the regularity refinement, that every Borel set is within $\varepsilon$ of a clopen
one).

So direction (i), stated properly, is:

$$
p(\varphi) \;=\; \mu\big([\varphi]\big),\qquad
\mu \in \mathcal{P}\big(S(B_T)\big) = \mathcal{P}\big(2^{\omega}\big)
$$

and the Bloch coordinate is the affine rescaling

$$
z(\varphi) \;=\; 2\mu([\varphi]) - 1 \;\in\; [-1, 1].
$$

**This is the beautiful part and it should be said plainly.** The owner's picture, taken literally
and made rigorous, turns into one of the cleanest correspondences in logic: sentences are clopen
sets, provability is being everything or nothing, independence is being a proper clopen subset, and
"the truth value of $\varphi$" is a *measure of a set*. Nothing was invented to get here.

**Two things the picture immediately gives, for free.**

*The reachable range.* If $T$ decides $\varphi$ then $[\varphi]$ is $\varnothing$ or the whole space
and $z = \mp 1$ for every $\mu$. If $\varphi$ is independent then $[\varphi]$ and its complement are
both nonempty clopen sets, so Dirac measures at points of each are available and every convex
combination of them is a measure: $z(\varphi)$ ranges over **all** of $[-1, 1]$. The segment is
opened by independence and by nothing else.

*The layered core, exactly.* If $T$ is complete then $B_T = \{\bot, \top\}$, its Stone space is a
single point, the measure is unique, and every sentence sits at a pole. This is machine-checked as
`complete_theory_unique` and `complete_theory_poles_only`:

$$
(\forall a \in B,\ a = \bot \vee a = \top)
\;\Longrightarrow\;
\mu = \nu \ \wedge\ z(a) \in \{-1, +1\}
\veq{complete-poles}\lean
$$

and its contrapositive, `undecided_of_strictly_between`, says that a sentence with $-1 < z < 1$ is a
**witness to incompleteness**:

$$
-1 < z(a) < 1 \;\Longrightarrow\; a \ne \bot \ \wedge\ a \ne \top
\veq{undecided-witness}\lean
$$

The owner's 2025-08-08 architecture wanted a complete lower layer and an incomplete upper one. Under
(i) that is not a design preference: it is the statement that the lower layer's Stone space is a
**point** and the upper layer's is a **Cantor set**. The lower layer therefore has no interior state
to report, which is exactly why it can be the consumer rather than the producer of reports. Note
that `logic-bloch-poles.md` §7.1 separately corrects the parenthetical example in that turn: ZF
without C is not a complete core. The correction stands and is orthogonal to this section.

---

# 2. The decisive structural fact: every state is diagonal

This is the section direction (i) does not get to soften.

A qubit density matrix in the truth basis is

$$
\rho \;=\; \frac12\begin{pmatrix} 1 + z & x - iy \\ x + iy & 1 - z\end{pmatrix},
$$

so the off-diagonal entry *is* $(x - iy)/2$. Direction (i) supplies $p(\varphi)$ and nothing else.
There is no second number in a measure. Setting $z = 2p - 1$ leaves $x$ and $y$ with no candidate
value except zero, and no operation available in the semantics can change that:

$$
\rho_\varphi^{\mu} \;=\; \mu([\varphi])\,\ket{0}\!\bra{0} \;+\; \mu([\neg\varphi])\,\ket{1}\!\bra{1}
\qquad\text{always diagonal.}
$$

Mixing model-measures is the only operation (i) has, and it preserves diagonality. Machine-checked
in both the binary and the general finite form (`mix_diagonal`, `diagonal_of_weighted_sum`):

$$
\mathrm{Diag}(a) \wedge \mathrm{Diag}(b) \Rightarrow \mathrm{Diag}\big(t a + (1-t) b\big),
\qquad
\forall i \in s,\ \mathrm{Diag}(f_i) \Rightarrow \mathrm{Diag}\Big(\textstyle\sum_{i \in s} w_i f_i\Big)
\veq{diag-mix}\lean
$$

The reachable set is therefore the segment $\{(0,0,z) : z \in [-1,1]\}$, and that segment has an
intrinsic characterisation inside the ball: it is exactly the locus where the truth lean saturates
the information, $|z| = r$. This is `abs_z_eq_r_iff_diagonal`, an *iff*, not an inequality:

$$
|z| \le r \quad\text{always},\qquad |z| = r \iff x = y = 0
\veq{z-saturates}\lean
$$

**Four consequences, none of them softened.**

1. **The equator's interior is unreachable.** The equatorial disc is $\{z = 0, r \le 1\}$ and (i)
   reaches exactly one of its points, the origin, and reaches that one only when the measure splits
   the completions evenly.
2. **The phase $\varphi$ carries nothing.** Every state (i) produces has $x = y = 0$, at which point
   the azimuth is undefined, not merely uninformative. The seed conversation's phase-encoding
   proposal (`conv-falsifiability.md:550`) has no referent under (i). The sibling
   `logic-bloch-poles.md` refutes it independently, on the flat physical ground that a global phase
   is unobservable; the two refutations are separate and both hold.
3. **Only one gate survives.** The unitaries preserving the reachable segment act on it only
   through $z \mapsto \pm z$: rotations about the $z$-axis (every phase gate, and $H$'s partner
   $S$) fix each reachable point and are therefore invisible, and the only non-trivial action left
   is $z \mapsto -z$, which is exactly complementation in $B_T$:
   $p(\neg\varphi) = 1 - p(\varphi)$, machine-checked as `m_compl`. NOT is meaningful and is
   *precisely* Boolean negation. Hadamard, the phase gates, and everything else in
   [`logic-bloch-gates.md`](logic-bloch-gates.md) act outside the reachable set and have no
   model-theoretic reading at all. This is a strong and testable claim, and it is a genuine
   restriction on the whole cluster.
4. **The radius is redundant.** On the reachable set $r = |z|$, so the pair $(z, r)$ carries no more
   than $z$ does. **This contradicts the candidate thesis of `logic-bloch-poles.md` §7.3**, which
   proposes that the report format is the *pair* $(z, r)$ with $|z| \le r$ enforcing "confidence is
   never cheaper than information". Under (i) the constraint is saturated identically and the pair
   collapses to one number. That essay flags the risk itself ("if no such justification is found,
   the thesis survives in its segment form and the sphere is decoration"); this essay is the
   argument that the risk is realised. The disagreement is located and is item 6 in Section 10.

**Prior art, checked rather than assumed.** The diagonal conclusion is not this essay's invention.
E. D. Vol, [*Quantum theory as a relevant framework for the statement of probabilistic and
many-valued logic*](https://arxiv.org/abs/1205.6898) (2012), proposes exactly this from the other
direction: "we associate with every plausible proposition **diagonal matrix** of its likelihood and
examine it as density matrix of relevant quantum system", and then represents the connectives as
positive maps on those matrices. Someone starting from quantum open-systems theory, with no interest
in Goedel, arrives at the same restriction. That is corroboration for (i)'s structural claim and it
is also a warning: the *diagonal* part is the part that has been found repeatedly, and the ball is
the part that has not. (Read: abstract and the paper's own summary of its proposal, not the full
text.)

---

# 3. So the ball is mostly empty. Is that a bug, or the answer?

The tempting move is to treat the collapse as a defect of (i) and go looking for structure to fill
the ball with. This section argues the opposite: **the collapse is (i) telling the truth about
logic, and the ball was the wrong object from the start.**

## 3.1 A simplex is what a classical state space is, and this is a theorem

The comparison objects are unambiguous. A classical bit's state space is the 1-simplex, a segment
with two extreme points. A classical **trit**'s is the 2-simplex, a triangle with three. A qubit's
is the 3-ball, whose extreme points are the whole sphere.

The difference is not "more room". It is the **uniqueness of decomposition**: a simplex is exactly
the compact convex set in which every point has a unique representation as a mixture of extreme
points. The Bloch ball fails this famously, $I/2$ being $\tfrac12(\ket{0}\!\bra{0} +
\ket{1}\!\bra{1})$ and $\tfrac12(\ket{+}\!\bra{+} + \ket{-}\!\bra{-})$ and uncountably many others.

And the algebraic criterion is exact. **The state space of a unital C\*-algebra is a Choquet simplex
if and only if the algebra is commutative, and then it is a Bauer simplex** -- classical, attributed
to Bauer, and quoted as "an old and well-known fact" in the opening of
[Kennedy-Shamovich](https://arxiv.org/pdf/1911.01023). A Boolean algebra is a commutative object;
its Gelfand-style dual is $C(S(B_T))$, whose state space is $\mathcal{P}(S(B_T))$, a Bauer simplex
whose extreme boundary is the compact set $S(B_T)$ itself.

Read that back into the fork. **Choosing a ball over a simplex is choosing non-commutativity**, and
non-commutativity means: there exist two questions about the sentence that cannot be answered
simultaneously, whose joint statistics are constrained by an uncertainty relation. That is a strong,
contentful claim about logic. It might be true. But it is an *addition*, and the seed conversation
never proposed the second question. `logic-bloch-poles.md` §2 says the same thing from the geometric
side ("what the $x$-observable measures is the open question") and `logic-bloch-gates.md` §0 reports
that the gate analysis found no rotation-covariant order on the equator to support a third truth
value. Three routes, one answer: **the missing thing is a second incompatible question, and nobody
has one.**

## 3.2 The simplex is not the poor relation. It is much bigger.

The honest statement of (i) is not "you get a segment instead of a ball". It is:

$$
\text{one sentence} \;\longrightarrow\; [-1,1],
\qquad
\text{the whole theory} \;\longrightarrow\; \mathcal{P}(2^{\omega}),
$$

an infinite-dimensional Bauer simplex whose extreme points form a Cantor set. A 3-ball has three
real parameters. $\mathcal{P}(2^\omega)$ has infinitely many, and they encode something the ball
cannot express at all: **how sentences correlate**. Whether $\mu([\varphi \wedge \psi])$ exceeds
$\mu([\varphi])\mu([\psi])$ is a fact about the theory that no per-sentence geometry can carry.

So direction (i)'s answer to "your ball is empty" is: the ball was three-dimensional bookkeeping
attached to the wrong index. The state has one coordinate *per sentence* and a full joint
distribution over all of them; the interesting structure was never inside a single sentence's
picture. **The owner's intuition that a truth value should be geometric survives; the claim that the
geometry is a ball does not.**

## 3.3 What the geometry then is, precisely

The state space of the whole theory is the Bauer simplex $\mathcal{P}(2^\omega)$. Its extreme points
are the Dirac measures at completions, so:

| Object | Direction (i)'s reading |
|---|---|
| extreme point $\delta_u$ | a *complete consistent extension* of $T$: every sentence decided |
| a general $\mu$ | a weighting of extensions; the theory as a random completion |
| $\mu([\varphi]) \in \{0,1\}$ for all $\varphi$ | $\mu$ is a Dirac, i.e. the state is "pure" |
| $0 < \mu([\varphi]) < 1$ | $\varphi$ is undecided *by the state*, and $\varphi$ is independent of $T$ |
| $\mu = $ the uniform (coin-flip) measure on $2^\omega$ | maximum entropy over completions |
| convex mixing | pooling two weightings; affine in every $z$ simultaneously |

That table is the whole of (i), and it is complete: there is no residual structure and no undefined
term in it. The construction has the property `logic-bloch-poles.md` §6 praised and then found
insufficient, that a mixture forgets its decomposition, but in the simplex it does **not** forget:
in a simplex the decomposition is unique. Direction (i) therefore has a *sharper* structure than the
ball, not a vaguer one, and one can read the weighting off the state.

---

# 4. Goedel and independence under (i), done carefully

## 4.1 What works

$\mathrm{Con}(\mathrm{PA})$ is a sentence of PA, true in the standard model $\mathbb{N}$ and false
in every model of $\mathrm{PA} + \neg\mathrm{Con}(\mathrm{PA})$, which is consistent by Goedel II.
So $[\mathrm{Con}]$ and its complement are both nonempty clopen subsets of Cantor space, and
$\mu([\mathrm{Con}])$ is a genuine number for each $\mu$, ranging over all of $[0,1]$ as $\mu$
varies. That is a real measure of a real set. Nothing is metaphorical.

It also fixes a confusion the seed conversation had and the sibling essay diagnosed. In
`conv-falsifiability.md` the prior AI put "complete logical agnosticism" at the origin (`:124`) and
then put unprovable sentences on the equator (`:134`) twelve lines later. Under (i) neither is
right, and the correct statement is sharper than either: **an independent sentence occupies the
whole open segment, and *which* point it occupies is a property of $\mu$, not of the sentence.** The
origin is not "unprovable"; the origin is "the completions split exactly evenly on this sentence".
That is a quantitative claim about a measure and it is either true or false of a given $\mu$.

## 4.2 Which measure? The honest answer is that there is no canonical one, and this is a real problem

Direction (i) is only as good as $\mu$, and $\mu$ is not given. This subsection reports what the
literature actually delivers. Where a paper was read only in abstract or summary, that is stated.

**Gaifman (1964), *Concerning measures in first order calculi*** (Israel J. Math.). Gaifman gives
coherence conditions for assigning probabilities to formulas of a first-order language so that the
assignment respects logical relations, calling such an assignment a *measure-model*. The condition
that carries his name ties quantifiers to their instances: $P(\forall x\,\psi(x))$ is the infimum
(dually, for $\exists$, the supremum) over finite conjunctions of instantiations by constants of the
extended language. **This is a constraint, not a selection.** It narrows the admissible measures; it
does not pick one. (Read: secondary summaries and the statement of the condition, not the 1964
paper.)

**Scott and Krauss (1966), *Assigning probabilities to logical formulas***, is the companion
classical reference for the same territory (measures on Boolean algebras of formulas, and the
infinitary extensions). Cited for completeness; not read.

**Hutter, Lloyd, Ng and Uther (2013), *Probabilities on Sentences in an Expressive Logic***
([arXiv:1209.2620](https://arxiv.org/html/1209.2620), J. Applied Logic 11(4)). This is the paper
that makes direction (i)'s bridge explicit and it is worth quoting, because it says the
sentences-to-models correspondence is a *bijection*, which is precisely the Stone-duality statement
of Section 1 in the authors' own vocabulary:

> "Let $\mu:\mathcal{S}\to\mathbb{R}$ be a probability on sentences. Then there exists a unique
> probability $\mu^*:\mathcal{B}\to\mathbb{R}$" on interpretations (their Proposition 31), with the
> converse construction $\mu(\varphi) = \mu^*(\mathrm{mod}(\varphi))$ (Proposition 29).

On the selection problem they prove **existence, not uniqueness**: their Theorem 40 gives a
probability that is both Cournot and Gaifman, and they then reach for a *minimum relative entropy*
principle to pick a least-biased one among the many. They also record that the Gaifman condition is
inconsistent with the strong Cournot principle while compatible with the weak one. (Read: the arXiv
HTML version, targeted at these propositions; proposition numbering is that version's.)

**The computability wall, which is the part that matters most for the owner's AI-core application.**
Coherent distributions assign probability 1 to every theorem. Therefore a coherent $\mu$ assigns
probability 1 to "computation $f$ outputs $x$" whenever it does, *whether or not anyone has run
$f$*. Consequently a coherent distribution **cannot represent uncertainty about the outputs of
computations at all**. Demski's result, as reported in the MIRI literature, sharpens this: an ideal
belief state that is non-dogmatic, Gaifman-inductive and coherent in even a weak sense has **no
computable approximation**, and definable priors satisfying the Gaifman condition run into Tarski's
undefinability theorem. (Reported from
[*Questions of Reasoning Under Logical Uncertainty*](https://intelligence.org/files/QuestionsLogicalUncertainty.pdf)
and the surrounding MIRI summaries; the primary papers were not read in full, and the owner's
standing instruction to check a paper's real scope is why this is flagged rather than asserted
flatly.)

**Garrabrant, Benson-Tilsen, Critch, Soares and Taylor (2016), *Logical Induction***
([arXiv:1609.03543](https://arxiv.org/abs/1609.03543)). The abstract, verbatim on the points that
bear here: "We present a computable algorithm that assigns probabilities to every logical statement
in a given formal language... their beliefs are **coherent in the limit** (whenever $\varphi
\Rightarrow \psi$, $P_\infty(\varphi) \le P_\infty(\psi)$, and so on); and logical inductors
strictly dominate the universal semimeasure in the limit." The structure of that sentence is the
whole point for this essay:

> **The computable object is the *sequence*; the coherent measure is only its limit.** A logical
> inductor is exactly a machine that is *not* in a state of type (i) at any finite time and
> converges to one. Direction (i) describes the limit. Direction (ii) describes the machine.

That is the cleanest statement of the fork available in the literature, and it is not this essay's
invention. It cuts both ways, and Section 7 does not pretend otherwise. (Read: the arXiv abstract
and listed properties; the 130-page paper was not read, and no theorem name from it is cited here.)

## 4.3 Two sentences that must not be conflated

`logic-bloch-poles.md` §6 warns that "independent sentences are in superposition" is a mood rather
than a mechanism, because independence is stable and superposition collapses. Direction (i) agrees
and adds the sharper form: independence is a property of the **pair** $(T, \varphi)$, and $z$ is a
property of the **triple** $(T, \varphi, \mu)$. So $z$ is not a property of the sentence, which is
also the correct answer to the owner's `conv-formal-language.md` question about two sound and
complete systems disagreeing: two such systems are two different $\mu$, and there is no
contradiction to locate because $z$ never claimed to be intrinsic.

## 4.4 The points are uncomputable too, and that is what closes the "just pick a model" fallback

**ADDED after publication, 2026-09-07.** Located by the sibling
[`logic-counterfactual-boundary.md`](logic-counterfactual-boundary.md) §2.2, which observed that
this essay never mentions Tennenbaum's theorem and framed the omission as a **missing
strengthening, not an error**. Nothing above is retracted and §4.2 stands exactly as written. What
follows is a second wall one level down, the reason it is needed rather than decorative, one
machine-checked consequence, and an honest accounting of how much smaller the strengthening is than
it first looks.

### 4.4.1 The theorem

**Tennenbaum's theorem** (Stanley Tennenbaum, 1959; announced as *Non-Archimedean models for
arithmetic*, Notices of the American Mathematical Society **6**, p. 270): *no countable nonstandard
model of first-order Peano arithmetic is recursive.* Sharper, and this is the half that does the
work below: **neither the addition nor the multiplication of such a model can be recursive**, each
operation separately.

"Computable model" needs care here, because the *domain* is not the obstruction. A structure in
PA's language counts as recursive when its carrier can be taken to be $\mathbb{N}$ itself, with the
graphs of $\oplus$, $\otimes$ and $<$ recursive relations on those codes. Listing the elements of a
countable model is therefore always possible; what is impossible is computing its **operations** on
that listing. Up to isomorphism exactly one model of PA is computable, the standard one, against
continuum many countable models in all.

The theorem as stated is about full first-order PA. **How far it descends to weaker fragments was
not established here** and the honesty table in §4.4.5 records what was tried. That matters for the
layered architecture in a specific way: §1 already shows the *complete* core layer has a one-point
Stone space and a unique measure, so nothing in this subsection reaches it. Tennenbaum bites at the
PA-strength upper layer, which is exactly where this essay puts it, and its status in between is
left open.

### 4.4.2 What it closes, and why the closure is needed

§1 opens the segment with **Dirac measures**: "if $\varphi$ is independent then $[\varphi]$ and its
complement are both nonempty clopen sets, so Dirac measures at points of each are available and
every convex combination of them is a measure". A Dirac measure is the natural engineering reading
of *never mind which measure, just pick a completion and believe it*. Two things follow, and the
first is why this subsection is a strengthening rather than a footnote.

**First, the fallback slips §4.2's wall on a hypothesis.** The reported Demski result is about a
belief state that is *non-dogmatic*, Gaifman-inductive and weakly coherent. A Dirac measure is
two-valued: 0 or 1 on every sentence, nothing between. It is the maximally dogmatic state, so the
non-dogmatic hypothesis fails outright and that wall does not touch it. §4.2 fences the
*interesting* measures; the fallback is precisely the retreat to an uninteresting one.

**Second, a different theorem closes it.** A point of $S(B_{\mathrm{PA}})$ is a complete consistent
extension of PA. By Goedel-Rosser together with the essential undecidability of Robinson's Q, no
such extension is decidable, and here there is **no exception at all**: the standard model's own
theory is the worst case, since by Tarski $\mathrm{Th}(\mathbb{N})$ is not merely undecidable but
not arithmetically definable. Pass from the point to a model realising it and Tennenbaum adds the
next layer, with all but one isomorphism class uncomputable in each operation separately.

So the stack is three deep and the layers are logically independent of each other: the measure has
no computable approximation (§4.2), its points are undecidable (Goedel-Rosser), and read as models
all but one are uncomputable (Tennenbaum 1959). A machine can neither sample this space nor name a
point of it.

**One natural compression of that is false and should be avoided.** It is tempting to write "the
points are individually uncomputable, with exactly one exception, the standard model". That mixes
the two levels. The one-exception count belongs to **models**; at the level of **points**, which is
what this essay's Stone space consists of, there is no exception, and $\mathbb{N}$'s point is the
one furthest out of reach. The exception appears only after one has passed to a structure, and the
structure carrying it is not something a machine reaches by *choosing a completion*: reaching it
presupposes the answer to every arithmetical question.

### 4.4.3 One machine-checked consequence, and it is not about computability

The sharpest thing to say against the fallback turns out to need no computability at all. A Dirac
state is two-valued, so under (i) it reports a **pole for every sentence**, including the
independent ones that opened the segment in the first place:

$$
\big(\forall a \in B,\ \mu(a) \in \{0, 1\}\big)
\;\Longrightarrow\;
z(a) \in \{-1, +1\} \ \text{ and }\ r(a) = 1
\veq{dirac-poles}\lean
$$

That is `IsDirac`, `dirac_poles_only` and `dirac_r_one` in
[`lean/LogicModels.lean`](lean/LogicModels.lean), added in the same pass, with the supporting
`m_compl_eq_zero`, `m_inf_eq_one` and `dirac_decides` recording that the measure-one set of a Dirac
state is a complete, consistent, conjunction-closed extension, which is the Stone-space point in
`FinProb` clothing.

Read against `complete_theory_poles_only` this says something the owner's layered architecture
should hear. A Dirac report on an incomplete theory is **indistinguishable, in the report format,
from a complete theory's report**: both give $z = \pm 1$ and $r = 1$ on every sentence. So the
fallback does not merely fail to be computable. It also erases the one distinction §1 sells as
direction (i)'s main deliverable, namely that the interior of the segment is a witness to
incompleteness. Under (i) that interior is available only to genuinely mixed measures, that is,
only to states that are about more than one completion at once.

### 4.4.4 How much smaller this is than it looks

Three limits, stated because a strengthening invites overreach.

1. **It does not touch the central result.** §2's diagonality and the reachable segment
   $|z| = r$ are algebraic: a measure supplies probabilities and nothing else, and no computability
   hypothesis appears anywhere in them. Not a word of §2, §3 or §5 changes. The essay's headline
   cost stands or falls entirely independently of Tennenbaum.

2. **It does not prevent a measure from existing.** The points exist by the Boolean Prime Ideal
   theorem and the Dirac measures at them follow; Stone duality is untouched, and every measure §1
   constructs is still there. What is denied is **algorithmic access**: sampling, naming,
   conditioning. That is a claim about implementations, which is why it lands on the owner's
   AI-core application and nowhere else in the essay.

3. **Tennenbaum is fragile with respect to signature, and an unqualified statement of it would
   over-claim.** Pakhomov, *How to escape Tennenbaum's theorem*
   ([arXiv:2209.00967](https://arxiv.org/abs/2209.00967), 2022), abstract verbatim: *"We construct a
   theory definitionally equivalent to first-order Peano arithmetic PA and a non-standard computable
   model of this theory. The same technique allows us to construct a theory definitionally
   equivalent to Zermelo-Fraenkel set theory ZF that has a computable model."* Maia, *Escaping
   Tennenbaum's theorem and a strong jump inversion theorem*
   ([arXiv:2603.04599](https://arxiv.org/abs/2603.04599), 2026), extends that fragility to
   intermediate strengths with theories definitionally equivalent to "PA plus all $\Pi^0_n$ truths"
   admitting computable nonstandard models, and records that Pakhomov showed it does **not** extend
   to true arithmetic: any nonstandard model of a theory definitionally equivalent to
   $\mathrm{Th}(\mathbb{N})$ is uncomputable.

   Why that does not rescue the fallback, said explicitly. The Goedel-Rosser layer is the one that
   applies to the **points** of this essay's Stone space, it is a statement about the undecidability
   of a set of sentences, and no change of signature touches it. What Pakhomov weakens is the
   model-level layer, and even there the escape buys a structure that is computable in *another*
   signature while PA's own $+$ and $\times$ on it remain non-recursive. The correct form of the
   claim is therefore the point-level one, with Tennenbaum as the model-level corollary rather than
   the load-bearing step.

### 4.4.5 What was verified for this subsection, and what was not

| Claim | Status |
|---|---|
| Tennenbaum 1959: no countable nonstandard model of PA is recursive; neither operation recursive; citation *Non-Archimedean models for arithmetic*, Notices AMS **6** (1959), 270 | **Verified.** Statement, recursive-model definition and citation from the Wikipedia article on the theorem, cross-checked against three independent arXiv abstracts (Hermes-Kirst 2302.14699, Glazer 2311.13699, Reid 1311.6375), which agree on the statement |
| Pakhomov 2022 and Maia 2026, quoted above | **Verified**, abstracts fetched from their arXiv listing pages; quoted text is verbatim from those abstracts. Neither full paper was read |
| Every complete consistent extension of PA is undecidable (Goedel-Rosser, essential undecidability of Q) | **Not re-verified here.** Standard, and it is the same fact §1 already uses to prove the algebra atomless |
| $\mathrm{Th}(\mathbb{N})$ not arithmetically definable (Tarski) | **Not re-verified here.** Standard |
| Whether Tennenbaum holds for $I\Sigma_1$, $I\Delta_0$, or fails for open induction | **Not verified.** No source reached. Tried: the nLab page (404), Kaye's paper page and its PDF (both 404), the SEP incompleteness entry (no mention of Tennenbaum at all), and Glazer's paper, which mentions `IOpen` only in a corollary and cites nothing on recursive nonstandard models of it. A gap in this sweep is not evidence that the fact is unsettled; it is evidence that this pass did not find a source |

**Honesty note.** This session's WebSearch budget was exhausted before this subsection was written,
so every item above was checked by fetching a specific page rather than by search, which is why the
last row reports a gap rather than a negative result.

---

# 5. Four attempts to get the equator back, and what each actually yields

The brief for this essay says to push hard here rather than concede. Pushing hard produced four
candidates and one theorem that kills the general case.

## 5.1 More sentences: correlations are real, and they are still diagonal

The most natural thought is that a single sentence is too small an arena, and that the off-diagonal
structure appears in the *joint* space of several sentences. Correlations are certainly real: for
$\varphi, \psi$ the measure $\mu$ determines $\mu([\varphi \wedge \psi])$ independently of the
marginals, and dependence is generic.

**But classical correlation is diagonal in the product basis.** A measure on $2^{\omega}$ pushed to
$n$ coordinates is a distribution over $\{0,1\}^n$, and the corresponding density operator on
$(\mathbb{C}^2)^{\otimes n}$ is $\sum_{s \in \{0,1\}^n} \mu(s)\,\ket{s}\!\bra{s}$, which is
diagonal. `diagonal_of_weighted_sum` covers exactly this convexity step. The marginal on any one
factor is diagonal too. So the joint picture is a bigger simplex -- the $(2^n - 1)$-simplex on $n$
sentences, growing to $\mathcal{P}(2^\omega)$ in the limit -- and not a bigger ball.

It is worth naming what the ball *would* have added and what is lost by not having it: a mixed
single-sentence state under (i) is a marginal of a classical joint, whereas in quantum theory it can
also be a marginal of an entangled pure state. The Bloch ball cannot tell those apart from the
single-sentence state, so nothing is lost at the level of $\rho$; what is lost is the *possibility*
of the entangled explanation. `logic-bloch-poles.md` item 3 proposes exactly that possibility as its
most promising unexplored direction (entanglement between for-evidence and against-evidence). Under
(i) it is unavailable, and honestly so: **evidence-for and evidence-against are not two questions
about models. They are two questions about a proof search**, which is direction (ii)'s territory.

**Verdict: relocates the question into a bigger simplex; does not rescue the equator.**

## 5.2 Birkhoff-von Neumann: the only route that genuinely produces off-diagonal terms, and it deletes the model space

If the propositions form the lattice of projections on a Hilbert space rather than a Boolean
algebra, states are density matrices and off-diagonal terms are exactly what non-commuting
projections require. This is the honest way to get the equator, and it should be taken seriously
rather than waved at. `logic-bloch-poles.md` §5 sets out the framework and correctly notes that
Birkhoff-von Neumann puts propositions on *subspaces* while the owner puts truth values on *states*.

The obstruction for direction (i) is sharper than that dual-description point, and it is a theorem.

- **Stone duality is a duality for distributive structure.** The whole reason $B_T$ has a *space of
  points* is that it is a Boolean algebra: ultrafilters exist in abundance (Boolean prime ideal
  theorem) and separate elements. A non-distributive orthomodular lattice has no such theory.
- **Kochen-Specker (1967) makes this concrete and total.** For a Hilbert space of dimension $\ge 3$,
  there is **no** assignment of $\{0,1\}$ to the projections that is non-contextual and consistent
  on every orthonormal basis. There are no "models" to be a state over. The set direction (i)
  measures is **empty**.
- **At dimension 2 the valuations exist but the representation is not forced.** Gleason's theorem
  requires $\dim \ge 3$; a qubit admits frame functions not of the form
  $P \mapsto \operatorname{Tr}(\rho P)$, and Bell (1966) gives a non-contextual hidden-variable model
  for a single qubit. So on a qubit one may choose the Bloch ball, but nothing forces it.

Put the two together and direction (i) faces an exact dichotomy, which is worth stating as the
essay's second headline: **at $\dim \ge 3$ the equator exists and the model space does not; at
$\dim = 2$ the model space exists and the ball is not forced. There is no dimension at which you get
both.** The sibling essay reaches the same $\dim = 2$ versus $\dim \ge 3$ boundary from the Gleason
side and recommends it as an argument for the qutrit route; this essay adds that the same boundary
is an argument *against* combining the qutrit route with a model-ensemble semantics.

**Verdict: produces the equator, at the price of the semantics the whole direction is built on.**

## 5.3 Boolean-valued models: the best non-quantum enlargement, and it is still a simplex

Scott and Solovay's Boolean-valued models (and the forcing they present) assign each sentence a
truth value in a **complete Boolean algebra** $\mathbb{B}$ rather than in $\{0,1\}$ or $[0,1]$. This
is genuinely "truth over models" in a richer sense, and it is where independence results actually
live: $\mathrm{CH}$ has an intermediate $\mathbb{B}$-value in a suitable $V^{\mathbb{B}}$.

Two things follow, one encouraging and one limiting.

- *Encouraging.* This is the mathematically serious version of "a sentence's truth value is not a
  bit". It has a large literature, it is the standard technology behind exactly the independence
  phenomena the owner is interested in, and its values form a lattice with real structure rather
  than a single number. **If the owner wants a bigger truth-value object while staying inside logic,
  this is the recommendation with prior art behind it, and it is not the Bloch sphere.**
- *Limiting for the equator.* $\mathbb{B}$ is Boolean, hence distributive, hence commutative, hence
  Section 3.1 applies verbatim: a measure on $\mathbb{B}$ lands in $[0,1]$ and the state space is
  again a Bauer simplex. Boolean-valued models enlarge the **value** space; they do not curve the
  **state** space.

**Verdict: a real and recommended enlargement, orthogonal to the equator question.**

## 5.4 Signed and non-classical measures: the glut, arriving from the other direction

Dropping $\mu \ge 0$ gives a signed measure, hence $z$ outside $[-1,1]$, hence $r > 1$, hence a
density matrix with a negative eigenvalue. That is exactly where `logic-bloch-poles.md` §3.1 places
the Belnap glut $\mathbf{B}$ (evidence for *and* against), and where the owner's own
`conv-blochsphere.md` question about indefinite density matrices points. The cross-essay agreement
is worth recording: two independent routes put paraconsistency at $r > 1$.

But a signed measure is not a state over models in any sense. There is no set whose measure is
negative. The move abandons (i) rather than extending it, and it still does not produce off-diagonal
terms, only out-of-range diagonal ones.

**Verdict: consistent with the cluster, outside direction (i), and still not the equator.**

## 5.5 Summary of the routes

| Route | Off-diagonal terms? | Model space survives? | Net |
|---|---|---|---|
| single sentence, measure on $S(B_T)$ | no | yes | the segment $[-1,1]$ |
| joint over many sentences | no | yes | a bigger *simplex*, correlations included |
| Birkhoff-von Neumann, $\dim \ge 3$ | **yes** | **no** (Kochen-Specker) | equator, no models |
| Birkhoff-von Neumann, $\dim = 2$ | yes | yes | but Gleason does not force the ball |
| Boolean-valued models | no | yes | richer values, same simplex |
| signed measures | no | no | the glut at $r > 1$ |

**The equator is not recoverable inside (i). Reporting that is the point of the section.**

---

# 6. What the Lean file discharges

[`lean/LogicModels.lean`](lean/LogicModels.lean) compiles against the repo's pinned toolchain with
**exit code 0 and zero `sorry`**, checked by

```
cd verify && ../docs/dreamed/capped.sh -m 4G -c 100 -- \
    lake env lean --threads=1 ../docs/dreamed/lean/LogicModels.lean
```

| Handle | Theorem | Content |
|---|---|---|
| `diag-mix` | `mix_diagonal`, `diagonal_of_weighted_sum` | a convex combination of diagonal states is diagonal, binary and for an arbitrary finite family |
| `z-saturates` | `abs_z_le_r`, `abs_z_eq_r_iff_diagonal` | $\|z\| \le r$ always, with equality **exactly** on the diagonal states |
| `complete-poles` | `complete_theory_unique`, `complete_theory_poles_only` | a two-valued algebra has a unique probability, and every sentence sits at a pole |
| `undecided-witness` | `undecided_of_strictly_between` | $-1 < z < 1$ implies the sentence is neither $\bot$ nor $\top$ |
| `dirac-poles` | `dirac_poles_only`, `dirac_r_one` | **ADDED 2026-09-07 with §4.4.** A two-valued (Dirac) state reports $z = \pm 1$ and $r = 1$ on *every* sentence, so picking one completion erases the incompleteness witness |

Plus the supporting facts the essay leans on: `m_compl` ($p(\neg a) = 1 - p(a)$, which is the NOT
gate), `m_le_one`, `m_mono` (a stronger sentence has no more models), `FinProb.mix` (mixtures of
model-measures are model-measures, so the reachable set is convex), `blochOf_diagonal` and
`blochOf_mix` (the assignment is diagonal-valued and affine), and `blochOf_z_mem` ($z \in [-1,1]$).
Added with §4.4: `IsDirac`, `dirac_decides`, `m_compl_eq_zero`, `m_inf_eq_one` and `m_bot_ne_one`,
which together say the measure-one set of a two-valued state is a complete, consistent,
conjunction-closed extension. `#print axioms` on the four headline theorems, and on
`dirac_poles_only`, `dirac_r_one`, `dirac_decides` and `m_inf_eq_one`, returns only `propext`,
`Classical.choice`, `Quot.sound`.

**What it does not prove, and says so in its header.** Nothing about quantum mechanics: `Bloch` is a
bare triple of reals with no positivity constraint, no trace and no Hilbert space. Nothing about
Goedel: `B` is an abstract `BooleanAlgebra`, and that the Lindenbaum algebra of PA is countable and
atomless is argued in Section 1's prose, not in Lean. **No Stone duality**: the correspondence
between finitely additive probabilities on $B$ and Radon measures on $\mathrm{Stone}(B)$ is used as
a cited premise throughout and is proved nowhere in this repo, which is the single largest
unformalized load-bearing step in the essay. The completeness theorems take
$\forall a,\ a = \bot \vee a = \top$ as a *hypothesis*; that Presburger arithmetic satisfies it is
cited, not derived. **And nothing about computability**: the `dirac_*` lemmas added with §4.4 say
what a two-valued state *reports*, never that such a state is unreachable. Goedel-Rosser and
Tennenbaum are cited in the prose and formalised nowhere here.

---

# 7. What direction (i) costs

Written for the adjudicator. Each item is stated at full strength, with no rebuttal attached.

**C1. The ball is mostly empty.** Reachable set: a segment of measure zero in the ball. The equator's
interior, the phase, and every non-trivial gate are unreachable. Machine-checked, Section 2. If the
owner's attachment is to the *ball* rather than to the semantics, (i) is simply not his idea.

**C2. (i) cannot represent ignorance, at all.** This is the serious one. A coherent measure assigns
probability 1 to every theorem of $T$, so under (i) a reasoner "knows" every consequence of its
axioms instantly. There is no state for "the twin prime conjecture, which I have not investigated",
because either it is a theorem (probability 1), refutable (0), or independent (a measure), and none
of those three is *not having looked*. Direction (ii) is about exactly this and (i) has nothing to
say. Worse for the application: the owner's target is an **AI logic core**, which is a bounded
reasoner by construction, and a bounded reasoner's most common state is the one (i) cannot express.

**C3. There is no canonical $\mu$, and any coherent one is uncomputable.** Section 4.2. Choosing the
measure does all the epistemic work and the geometry is bookkeeping. Gaifman's condition constrains
without selecting; Hutter et al. prove existence and reach for minimum relative entropy to select;
the reported Demski result says a non-dogmatic Gaifman-inductive weakly coherent state has no
computable approximation. So (i) is a description of a limit object that no machine occupies.

**AMENDED after publication, 2026-09-07, by §4.4.** As originally written this cost had a hole,
found by [`logic-counterfactual-boundary.md`](logic-counterfactual-boundary.md) §2.2. The Demski
statement carries a **non-dogmatic** hypothesis, and the obvious retreat from an uncomputable
measure is a *dogmatic* one: pick a single completion, put a Dirac measure on it. That retreat
escapes this paragraph as written. It is closed one level down instead, and by a different theorem:
every point of the Stone space is an undecidable set of sentences (Goedel-Rosser, no exceptions),
and read as models all but one isomorphism class has both operations non-recursive (Tennenbaum
1959). The uncomputability is therefore **stacked**, not single. C3's verdict is unchanged and
better supported; §4.4 also gives the retreat a second, purely order-theoretic defect that needs no
computability at all.

**C4. The origin collision the fork anticipated is worse than a collision.** The brief expected
independence and total ignorance to land together at the origin. Under (i) that is not what happens,
and the actual situation is less comfortable: independence spreads over the whole open segment
(Section 4.1), and total ignorance **has no location at all**, because (i) has no ignorance. An
absent state is a bigger problem than an overloaded one.

**C5. The radius is redundant, which deletes the sibling essay's thesis candidate.** Section 2,
consequence 4. On the reachable set $r = |z|$, so the report $(z, r)$ carries exactly one number.
`logic-bloch-poles.md` §7.3's candidate thesis for `id:4bb2` -- offered there as an unblocker --
does not survive direction (i) in its two-coordinate form.

**C6. The diagonal result is prior art.** Vol 2012 reaches the diagonal density matrix for
propositions independently. (i) is not novel at the point where it is strongest, which lowers the
value of "we discovered this" and raises the value of "this keeps being rediscovered".

**C7. The single largest step is unformalized.** Stone duality and the automatic countable
additivity of clopen measures are cited, not proved, and everything in Sections 1, 3 and 5 rests on
them. They are standard and this essay is not doubting them; it is naming the dependency.

---

# 8. What direction (i) buys, stated against the costs

For symmetry, and because Section 7 is deliberately unbalanced.

**B1. It is exact.** No approximation, no analogy, no "can be thought of as". Sentences *are* clopen
sets; truth values *are* measures. The word "statistical mixture" in the owner's founding turn
becomes a technical term with its standard meaning.

**B2. It explains what the poles mean without stipulating it.** $z = \pm 1$ is not a labelling
convention: it is the statement that the clopen set is everything or nothing, i.e. that $T$ decides
the sentence, for **every** measure at once.

**B3. It gives negation for free and exactly.** $p(\neg\varphi) = 1 - p(\varphi)$, machine-checked,
and this is the *only* gate that survives. A theory that predicts which gates are meaningful is
worth more than one that decorates all of them.

**B4. It delivers the layered architecture as a theorem.** Complete layer: Stone space is a point,
unique measure, poles only. Incomplete layer: Cantor space, the full segment. The owner's 2025-08-08
sketch is not just consistent with (i); it is (i)'s own dichotomy, machine-checked as
`complete-poles`. No other reading in the cluster gives the architecture that directly.

**B5. It answers "which theory is this indexed to" structurally.** `logic-bloch-poles.md` item 10
asks the owner to fix the theory. Under (i) the theory is not a nuisance parameter but the whole
object: change $T$ and you change the Stone space. Presburger's is a point, PA's is Cantor space.

**B6. It scales to a real state space.** $\mathcal{P}(2^\omega)$, infinite-dimensional, with
correlations between sentences. The picture gets *bigger*, not smaller, once one stops insisting it
be three-dimensional.

---

# 9. Verdict, as a recommendation with its weaknesses attached

**Recommended, with a substitution and a boundary.**

**Recommend adopting (i) as the semantics of the *theory layer*, and substituting the simplex for
the ball.** A Bloch-valued truth value read as a state over models is exact, machine-checkable, and
gives the poles, negation, the segment and the complete/incomplete dichotomy without stipulation.
Its correct geometry is $\mathcal{P}(S(B_T))$, a Bauer simplex over Cantor space; for a single
sentence that is the segment $[-1,1]$ and nothing more. The ball should be dropped for this layer
rather than defended, and the reason is a theorem (state space is a simplex iff the algebra is
commutative), not a preference.

**The weaknesses, in the same breath.** (i) cannot represent a bounded reasoner's ignorance at all
(C2), it depends on a measure that is neither canonical nor computable (C3), the equator is not
recoverable within it and the obstruction is Kochen-Specker (5.2), and its strongest structural
result was already published in 2012 (C6). If the owner's actual target is the **AI logic core** of
his 2025-08-08 turn, then (i) describes the semantics that core reasons *about* and cannot describe
the core itself.

**What this recommends to the adjudicator, offered and not settled.** The two directions may not be
competing for the same object. Direction (i) fixes what $z$ *means* -- a measure of a set of
completions, with $\pm 1$ at the decided sentences -- and forbids $r$ from carrying anything
independent. Direction (ii) is about a reasoner and needs exactly the coordinate (i) forbids. The
logical-induction framing of Section 4.2 says the same thing in the literature's own words: the
computable object is the sequence, the coherent measure is only its limit. Whether the honest
construction is therefore a **pair** (a type-(i) semantics with a type-(ii) approximation converging
to it) is the merge's call, not this essay's, and this essay does not record it as decided.

---

# 10. Surfaced for the owner

Each item is a located claim plus the ruling it needs. **None of these is decided, and none has been
written into `TODO.md`, `ROADMAP.md` or `REVIEW_ME.md`.** A delegated agent's verdict is a
recommendation, never a self-settling decision.

1. **Adopt "state over models" as a measure on the Stone space of the Lindenbaum-Tarski algebra.**
   Located: §1. Sentences are clopen sets, truth values are their measures, the points are complete
   consistent extensions, and for PA the space is Cantor space because the Lindenbaum algebra is
   countable and atomless (atomless *because* of Goedel-Rosser). **Ruling needed:** accept this as
   the precise form of the owner's "statistical mixture", or state a different intended meaning of
   "model" that this formalisation misses.

2. **Accept that (i) makes the Bloch ball mostly empty, and drop the ball rather than defend it.**
   Located: §2, machine-checked as `diag-mix` and `z-saturates`. Every state (i) can produce is
   diagonal; the reachable set is the segment $|z| = r$. **Ruling needed:** accept the segment, or
   reject (i). There is no third option inside (i), and §5 is the record of four attempts to find
   one.

3. **The correct geometry of a classical logical state space is a simplex, and this is a theorem.**
   Located: §3.1. The state space of a unital C\*-algebra is a Choquet (indeed Bauer) simplex iff the
   algebra is commutative; a Boolean algebra is commutative. **Ruling needed:** accept that choosing
   a ball is choosing non-commutativity, i.e. asserting that two questions about a sentence are not
   simultaneously answerable, and either name the second question or drop the ball.

4. **The equator is unrecoverable inside (i), and the obstruction is Kochen-Specker.** Located: §5.2
   and the table in §5.5. At $\dim \ge 3$ the equator exists and the non-contextual valuations do
   not, so there are no models to be a state over; at $\dim = 2$ the valuations exist but Gleason
   does not force the ball. **Ruling needed:** confirm the dichotomy, or supply a semantics in which
   both survive. This is the sharpest negative result in the essay and it is the one most worth
   attacking.

5. **Boolean-valued models are the recommended enlargement if a bigger truth-value object is
   wanted.** Located: §5.3. Scott-Solovay values in a complete Boolean algebra are where
   independence results actually live, they have a large literature, and they enlarge the value
   space without curving the state space. **Ruling needed:** whether "Bloch Truth" is willing to
   become "Boolean-valued truth" for the theory layer, which is a substantial change of direction
   and is therefore the owner's alone.

6. **Located disagreement with `logic-bloch-poles.md` §7.3.** That essay's candidate thesis for
   `id:4bb2` is that the report format is the pair (truth lean $z$, determinacy $r$) with
   $|z| \le r$. Under (i) the constraint is saturated identically ($r = |z|$ on the whole reachable
   set), so the pair collapses to a single number and the two-coordinate thesis does not survive.
   That essay flags the risk itself in its item 12; this essay is the argument that the risk is
   realised. **Ruling needed:** whether the thesis is amended to a one-coordinate report under (i),
   kept in two-coordinate form on the strength of direction (ii), or held open pending the merge.

7. **The layered architecture is (i)'s own dichotomy, and it is machine-checked.** Located: §1 and
   §8, handles `complete-poles` and `undecided-witness`. A complete layer has a one-point Stone
   space, a unique measure and poles only; an incomplete layer has Cantor space and the full
   segment. **Ruling needed:** whether this is accepted as the formal content of the 2025-08-08
   "core layer should only be complete" sketch. (The separate correction that ZF without C is not a
   complete core belongs to `logic-bloch-poles.md` §7.1 and is not re-litigated here.)

8. **(i) has no state for "I have not checked yet", and the owner's stated application is a bounded
   reasoner.** Located: §7 C2. Coherence forces probability 1 on every theorem. **Ruling needed:**
   whether the AI-logic-core application requires a state of that kind, which would mean (i) cannot
   be the whole construction regardless of how good its semantics is. This is the question the merge
   with [`logic-epistemic-state.md`](logic-epistemic-state.md) turns on, and the ruling is the
   owner's, not the adjudicating agent's.

9. **No canonical measure exists, and any coherent one is uncomputable.** Located: §4.2 and §7 C3.
   Gaifman constrains without selecting; Hutter et al. prove existence and select by minimum relative
   entropy; the reported Demski result denies any computable approximation. **Ruling needed:**
   whether a *stipulated* measure (uniform on completions, a complexity-weighted prior, a
   minimum-relative-entropy choice) is acceptable for the construction's purposes, or whether the
   absence of a canonical one is disqualifying. Note that the essay reports the MIRI results from
   summaries; verifying Demski's exact statement against the primary source is a cheap open task.
   **AMENDED after publication, 2026-09-07 (§4.4), and the ruling this item needs has changed
   shape.** The stipulated-measure menu above omits the option an implementation would reach for
   first: *stipulate a Dirac measure*, that is, pick one completion and believe it. §4.4 shows that
   option is worse than the listed ones, twice over. It escapes the Demski wall quoted here, which
   assumes a **non-dogmatic** state, and is closed instead by Goedel-Rosser at the level of points
   and Tennenbaum at the level of models; and independently of computability it reports $r = 1$ on
   every sentence, so an incomplete theory's report becomes indistinguishable from a complete
   theory's. **The ruling is therefore two-part:** whether a stipulated measure is acceptable at
   all, and, if it is, that the stipulation must be a genuinely mixed one.

10. **Prior art: the diagonal restriction was published in 2012.** Located: §2, E. D. Vol,
    [arXiv:1205.6898](https://arxiv.org/abs/1205.6898). **Ruling needed:** none required, but the
    owner should know that the strongest structural claim of direction (i) is a rediscovery, and may
    wish the cluster's novelty claims worded accordingly.

11. **Only NOT survives as a gate under (i).** Located: §2 consequence 3, supported by `m_compl`.
    Complementation in $B_T$ is exactly $z \mapsto -z$; every other unitary leaves the reachable set.
    **Ruling needed:** whether this is accepted as a *prediction* of (i) that
    [`logic-bloch-gates.md`](logic-bloch-gates.md)'s findings can be tested against, since that essay
    independently found the phase to be invisible to the truth question and found no
    rotation-covariant order on the equator. Two essays converging on "the phase carries nothing" by
    different routes is the cluster's most checkable cross-result.

12. **ADDED after publication, 2026-09-07. The uncomputability is stacked, and a single completion
    is a dogmatic report.** Located: §4.4, added because
    [`logic-counterfactual-boundary.md`](logic-counterfactual-boundary.md) §2.2 found this essay
    never mentions Tennenbaum's theorem. Three independent layers: no computable measure (§4.2), no
    decidable point (Goedel-Rosser, no exceptions, $\mathrm{Th}(\mathbb{N})$ the worst case), and no
    computable model but the standard one, in either operation separately (Tennenbaum 1959). The
    part that is machine-checked is not the computability but its consequence for the report format,
    `dirac_poles_only` and `dirac_r_one`: a picked completion reports $z = \pm 1$ and $r = 1$ on
    every sentence. **Ruling needed:** nothing is overturned, so this needs a ruling only on scope.
    Does the AI-core application accept a semantics whose points a machine can neither name nor
    sample, on the grounds that the core consumes reports rather than models, or does that make
    direction (i) unusable rather than merely idealised? **Two honesty notes attached to the item.**
    The strengthening does not touch §2, §3 or §5, which have no computability content at all; and
    Tennenbaum is fragile with respect to signature, since Pakhomov ([arXiv:2209.00967](https://arxiv.org/abs/2209.00967),
    2022) built a theory definitionally equivalent to PA with a computable nonstandard model, so the
    load-bearing layer is the point-level Goedel-Rosser one, with Tennenbaum as a corollary.

---

# A future `.mw` sketch

What a `.mw` document would carry, in the style of `verify/mirror/resogram_esol.mw`. Sketch of
intent, not a runnable mirror; these are Lean-tier claims and route to the Lean backend.

```computation
# handle: diag-mix. Mixing over models never leaves the truth basis.
Diag(b)     = And(Eq(b.x, 0), Eq(b.y, 0))
mix(t,a,b)  = Bloch(t*a.x + (1-t)*b.x, t*a.y + (1-t)*b.y, t*a.z + (1-t)*b.z)
diag_mix    = Implies(And(Diag(a), Diag(b)), Diag(mix(t, a, b)))
```

```computation
# handle: z-saturates. The reachable set is exactly the saturation locus of |z| <= r.
r(b)        = sqrt(b.x**2 + b.y**2 + b.z**2)
z_saturates = Equivalent(Eq(Abs(b.z), r(b)), Diag(b))
```

```computation
# handles: complete-poles, undecided-witness. Completeness collapses the segment.
z(mu, a)         = 2*mu(a) - 1
complete_poles   = Implies(ForAll(a, Or(Eq(a, Bot), Eq(a, Top))),
                           Or(Eq(z(mu,a), -1), Eq(z(mu,a), 1)))
undecided_witness = Implies(And(Lt(-1, z(mu,a)), Lt(z(mu,a), 1)),
                            And(Ne(a, Bot), Ne(a, Top)))
```

```computation
# handle: dirac-poles. ADDED 2026-09-07 with section 4.4.
# A two-valued (Dirac) state is dogmatic: poles everywhere, radius one everywhere.
is_dirac(mu) = ForAll(a, Or(Eq(mu(a), 0), Eq(mu(a), 1)))
dirac_poles  = Implies(is_dirac(mu),
                       And(Or(Eq(z(mu,a), -1), Eq(z(mu,a), 1)), Eq(r(mu,a), 1)))
```

# Follow-up leads

1. **Verify Demski's uncomputability statement against the primary source.** Item 9. This essay
   reports it from MIRI summaries and flags that. Cheap, and it load-bears in §7 C3.
2. **Formalize the Stone-duality step, or at least the automatic countable additivity of a finitely
   additive measure on a clopen algebra.** Item in §6's "what it does not prove". Mathlib has
   Boolean algebras and measure theory; the missing bridge is the largest unformalized dependency in
   the essay.
3. **Compute the correlation structure that §3.2 claims is the real content.** For two independent
   sentences of PA (say $\mathrm{Con}(\mathrm{PA})$ and a Rosser sentence), work out which joint
   distributions on $\{0,1\}^2$ are realisable by measures on the Stone space. Decidable by
   arithmetic; no owner ruling needed.
4. **Test §5.2's dichotomy against the qutrit essay.** [`logic-qutrit-su3.md`](logic-qutrit-su3.md)
   recommends the qutrit route partly because Gleason bites at $\dim \ge 3$. §5.2 says the same
   dimension is where the model space dies. Whether that is a reason to prefer the qutrit or to
   abandon (i) there is a genuine open question and the two essays disagree in tendency.
5. **Ask whether a Boolean-valued model gives the owner what the phase was supposed to give.** Item
   5. If the answer is yes, the whole $x$-$y$ plane can be retired without loss.

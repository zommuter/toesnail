---
title: The simplex nobody built
permalink: /dreamed/logic-simplex
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This file *proposes*; the owner disposes. Nothing here is toesnail theory, and nothing may be
> promoted into `physics/` or `essays/` without the owner authoring the move himself. The `\veq`
> badges below claim something about [`docs/dreamed/lean/LogicSimplex.lean`](lean/LogicSimplex.lean)
> **only**, and are deliberately not wired into `physics/*.toml` or `tests/test_verify.sh`.
>
> Every verdict below is a **recommendation awaiting the owner's ruling**. A delegated agent's
> conclusion is never self-settling, and nothing here has been written to any ledger.

## Provenance

The owner's backburner idea is **"Bloch Truth"**. Its naming turn, his own words at
`~/knowledge/sessions/claude-ai/2025-08-05_breaking_project_paralysis_cbae6cd6.md:1334` (2025-08-08):

> the Bloch Truth (might need a better name) might be useful for the AI logic core in the second
> (ZFC?) layer where incompleteness applies (core layer should only be complete, e.g. ZF without C)

The vertex set below is driven by his own enumeration, asked on 2025-08-16 at
`conv-falsifiability.md:366`:

> What states can there actually be for statements in terms of complete logic? Proven true, false,
> **probable but undetermined**, unprovable, ....?

This essay exists because four sibling essays in the same cluster arrived, from unrelated premises,
at the same recommendation and none of them then built the thing:

- [`logic-models-ensemble.md`](logic-models-ensemble.md): every state over models is diagonal, the
  reachable set is the segment $\lvert z\rvert = r$, and a C\*-algebra's state space is a Bauer
  simplex exactly when the algebra is commutative.
- [`logic-epistemic-state.md`](logic-epistemic-state.md): concedes the quantum structure is not
  needed, because a classical four-outcome distribution reproduces the entropy behaviour and
  separates two states the qubit conflates.
- [`logic-beyond-su3.md`](logic-beyond-su3.md): a classical simplex meets every desideratum the
  qutrit does, in two real dimensions rather than eight, and the qutrit's headline inequality
  $\lvert n_3\rvert + p_{\text{undec}} \le 1$ **is** the simplex, arriving as componentwise
  $p \ge 0$.
- [`logic-beyond-su3.md`](logic-beyond-su3.md) again, structurally: distinct density matrices of
  equal trace are never Loewner-comparable, so the Bloch body is a flat **antichain**, with no meets
  and hence no implication. It has truth values and no connectives.

Four converging recommendations are not a construction. This file constructs the object and then
tries to break it.

---

# 0. The headline, stated and not teased

**The simplex works, it carries connectives the ball provably cannot, and it costs three things the
cluster has not yet priced.** In order:

1. **Four vertices, not three and not five.** Proved, refuted, independent, open. Three is rejected
   for two independent reasons, both machine-checked: with no open vertex the settledness $r$ is
   identically 1, so the owner's radius has no representation at all; and $\{$proved, refuted,
   independent$\}$ is **not closed under conjunction** (`three_status_collapse`,
   `three_statuses_not_closed`). Five is rejected on a crux rather than a proof, and the crux is
   stated in §1.4 so the owner can overturn it.

2. **His geometry comes back exactly, and $\lvert z \rvert \le r$ is derived rather than imposed.**
   Set $z = a - b$ and $r = a + b + c$ over the weights on (proved, refuted, independent, open).
   Then $\lvert z\rvert \le r \le 1$ is componentwise non-negativity and nothing else
   (`abs_z_le_r`), the four statuses land at north pole, south pole, equatorial circle and origin
   (`vertex_coords`), and $r = 0 \Rightarrow z = 0$ (`r_zero_imp_z_zero`).

3. **The one structural difference decides the whole comparison, and it is not dimension.** On the
   Bloch ball $r$ is a **norm**, so it is convex and mixing two settled states can produce an
   unsettled one. On the simplex $r = 1 - p_{\text{open}}$ is **affine**, so mixing two settled
   states is always settled. That single difference is the entire source of the sibling's
   `report_conflates` cost, and §3 upgrades that cost from an observation to an impossibility:
   **any** mixing-respecting map that puts *open* at the centre and *proved*/*refuted* at the poles
   is non-injective, because in the ball the centre already **is** the even mixture of the poles
   (`conflation_forced`, `conflation_not_injective`). The conflation is forced by convexity, not by
   discarding the azimuth.

4. **Connectives exist, and what they are is a negative result worth having.** The four statuses
   carry a commutative, associative, monotone conjunction with *refuted* absorbing and *proved* as
   unit, agreeing with classical logic on the two located vertices. But
   **independent AND independent = open**, so conjunction is **not idempotent**, so it is not a
   meet, so the statuses carry **no lattice**, hence no Heyting algebra and no Boolean algebra
   (`sand_indep_not_idem`). They are sound abstract transformers, in the abstract-interpretation
   sense, not a logic's connectives. And, said plainly as promised: the three-status fragment
   $\{$proved, refuted, open$\}$ **is exactly Kleene's strong K3 with the third value relabelled**
   (`k3_fragment`). The entire new content of the four-status table is the *independent* row, and
   within it the failure of idempotence.

5. **Goedel 1932 is the ceiling, and it is stated before the tables rather than after.**
   Intuitionistic propositional logic has no finite characteristic matrix, so no table on finitely
   many statuses can *be* intuitionistic logic. The tables below are therefore a logic **of the
   proof-search bookkeeping**, never of provability itself.

6. **The interior is empty under the reading the sibling adopted, and this is the essay's sharpest
   correction to the cluster.** [`logic-epistemic-state.md`](logic-epistemic-state.md) §2.2 defines
   the weights as "the agent **holds** a proof", which is introspectively transparent: an agent
   knows whether it holds a proof. Under that reading every state is a vertex, the interior is
   unreachable, and the object is a four-element set with no convexity at all. The interior is
   populated only under a **predictive** reading, which is precisely the candidate that essay
   dismissed as "subsumed" (its §2.4). §2.1 makes the swap and §7.1 prices it.

7. **Learning is an irreversible monoid, and the gate programme is lost.** A learning map fixes the
   three settled vertices and redistributes the open weight, so the legitimate maps are themselves
   a 3-simplex; $r$ never decreases (`learn_r_mono`) and a step that resolved anything can never be
   undone (`learn_no_undo`). Unitary gates form a group. Nothing in
   [`logic-bloch-gates.md`](logic-bloch-gates.md)'s CNOT/TOFFOLI programme survives, and §6.4 argues
   the loss costs nothing, because the third wire that essay proved necessary was a tax on
   **reversibility**, which learning does not want.

8. **The cheapness argument, deflated.** A four-vertex simplex report is **three** independent
   reals, which is exactly the size of a Bloch vector. The simplex is not smaller than the ball
   here. It is differently shaped, and the shape is the whole argument. §2.5.

---

# 1. The vertex set, chosen and defended

## 1.1 Reading the owner's own list

His four items are: *proven true*, *false*, *probable but undetermined*, *unprovable*. Two things
about that list decide the construction.

**First, "unprovable" is a status and not an absence.** A sentence proved independent of $T$ is in
that condition because somebody proved it so. Cohen's forcing argument for CH is a proof, held or
not held like any other. That is the sibling's decision and this essay keeps it.

**Second, and this is the load-bearing observation, "probable but undetermined" is not a status at
all.** It is a *mixture*. It names a sentence with most of its weight leaning toward proved and some
weight not yet resolved. A four-valued logic cannot express it; a point in the interior of a simplex
expresses it immediately, as $a = 0.9$, $d = 0.1$. **The owner's own enumeration contains an item
that is a point of the body rather than a vertex of it, and that is the argument for using a convex
object rather than a finite value set.** It is also, read carefully, an argument against a *ball*:
he asked for a probability, and a probability lives on a simplex.

So: vertices are terminal verdicts, the interior is uncertainty about which verdict will come.

The vertex set:

| Vertex | Verdict | Weight |
|---|---|---|
| **proved** | a proof of $P$ in $T$ | $a$ |
| **refuted** | a proof of $\lnot P$ in $T$ | $b$ |
| **independent** | a metatheoretic proof that $T$ settles neither | $c$ |
| **open** | no verdict | $d$ |

with $a, b, c, d \ge 0$ and $a + b + c + d = 1$. That is the 3-simplex $\Delta^3$, a tetrahedron.

## 1.2 Three vertices, rejected, with the machine-checked reason

The tempting economy is to drop *open* and keep $\{$proved, refuted, independent$\}$, a 2-simplex.
[`logic-beyond-su3.md`](logic-beyond-su3.md) §8 recommends exactly that, and it is the object that
the qutrit's diagonal plane literally is. Two reasons not to.

**Reason 1: the radius dies.** With $d$ gone, $r = a + b + c = 1$ identically
(`three_status_collapse`). Every state sits on the equatorial circle and there is no "how settled"
axis. That is fatal to the owner's own question, which was:

> can the equator be considered any kind of "unprovedness" instead, and the origin as maximum
> non-knowledge? don't just consider pure states but also mixed ones, i.e. Bloch with $r<1$ as well

He asked for $r < 1$. The 2-simplex has no $r < 1$.

**Reason 2: the three statuses are not closed under conjunction.** If $P$ and $Q$ are both
independent of $T$, the status of $P \land Q$ is not determined: take $Q = P$ and it is independent,
take $Q = \lnot P$ and it is refuted. So the guaranteed status is *neither*, and the table needs a
value for "nothing guaranteed" (`three_statuses_not_closed`). That value is *open*. The fourth
vertex is forced by the connectives, entirely independently of the radius argument.

**What three would have bought.** Exact agreement with the qutrit's diagonal plane, so that
$\lvert n_3 \rvert + p_{\text{undec}} \le 1$ would be *the same inequality* rather than an analogue,
and a two-dimensional report instead of a three-dimensional one. Both are real, and neither survives
the two reasons above.

## 1.3 Five vertices, rejected on a crux the owner can overturn

[`logic-epistemic-state.md`](logic-epistemic-state.md) §5.1 argues that carrying both this essay's
independent-versus-open separation **and** Belnap's glut needs five statuses, hence a 4-simplex, and
calls it "the object nobody has built". The fifth is "the agent believes $T$ inconsistent".

**The argument against it is a type argument, and it is short.** If $T$ is inconsistent, then $T$
proves everything, so *every* sentence is simultaneously proved and refuted. The fifth weight is
therefore the same number for every sentence: it is a property of the **theory**, not of the
sentence. A per-sentence coordinate that is constant across sentences is not a coordinate; it is a
parameter of the whole reporting layer, and it belongs outside the simplex, attached to the layer.

**What five would have bought, stated at full strength.** Belnap-Dunn's `FOUR` is a **bilattice**:
it has both a truth order and an information order, and both are lattices, with meets and joins in
each. The four-status domain built here has an information order that is merely a flat poset, and
§4.3 shows its conjunction is not a meet. Adding a top to the information order is exactly the move
that would restore lattice structure. That is a serious prize and the essay does not pretend
otherwise.

**The crux, so the owner can rule against this essay cleanly.** Belnap's setting is a *database with
multiple sources*, where "told $P$" and "told $\lnot P$" arrive from different informants and the
inconsistency is **local to a sentence**. If the owner's layered core consumes reports from one
fixed classical theory, the glut is global and five vertices are degenerate. If it consumes reports
from several mutually untrusted reasoners, which is the natural architecture for an AI core, the
glut is per-sentence and **five is right and this essay is wrong**. The question is about his
intended architecture and no agent can answer it. It is item 3 in "Surfaced for the owner".

## 1.4 What the choice is not

It is not a claim that four is the number of *epistemic distinctions*. The prior AI turn that
answered him listed a dozen, including "conjectured true", "unknown decidability" and "true in
system A, false in system B". Most of those are mixtures (conjectured true is a lean), one is a
different sentence (system-relativity means the report is indexed by $T$, so it is a family of
simplices rather than a bigger one), and one, "meaningless / ill-formed", is a genuine fifth status
that this essay also declines, for the same reason as the glut: it is a property of the *language*,
checked once, not a verdict of the proof search.

---

# 2. The owner's geometry, recovered inside the simplex

## 2.1 The coordinates, and what the weights are weights of

$$
z \;=\; a - b, \qquad r \;=\; a + b + c \;=\; 1 - d
$$

$z$ is the **truth lean**: located-proved minus located-refuted. $r$ is the **settledness**:
everything except no-verdict.

**What the distribution is over, stated exactly, because the sibling got this wrong.** Fix an agent,
a theory $T$, a sentence $P$, and a resource horizon $B$. The weights are the agent's credences over
which verdict its own proof search returns by $B$. They are *predictive*, not introspective.

The distinction matters more than it looks. [`logic-epistemic-state.md`](logic-epistemic-state.md)
§2.2 sets $a$ = "the agent **holds** a proof of $P$ in $T$". An agent knows whether it holds a proof.
So under that reading $a \in \{0,1\}$, likewise $b$ and $c$, and every state is a vertex: the
simplex has no interior, the convexity is decoration, and the object reduces to a four-element set.
That essay then dismisses the predictive alternative, its candidate B, as "subsumed" (its §2.4).
**It is not subsumed. It is the reading that populates the interior**, and without it neither this
essay's §5 nor the owner's own "probable but undetermined" has a referent. That is a located
disagreement with a sibling and it is item 1 in "Surfaced for the owner".

Two smaller readings also populate the interior and are compatible with the above: an agent with a
large unretrieved lemma store is genuinely uncertain about its own holdings, and an agent that
distrusts its own past proofs has credence rather than certainty in them. Both are second-order and
neither is needed if the predictive reading is adopted.

## 2.2 The constraint, derived

$$
\lvert z \rvert \;\le\; r \;\le\; 1
\veq{zr-cone}\lean
$$

The proof is one line and uses nothing but $p \ge 0$: $\lvert a - b\rvert \le a + b \le a + b + c$,
and $a+b+c = 1-d \le 1$ (`abs_z_le_r`, `r_le_one`). **This is the payoff sentence for the owner.**
The Bloch ball enforces $\lvert z\rvert \le r$ too, because a component of a vector never exceeds
its norm, but there it is a fact about Euclidean geometry that happens to coincide with what a
report needs. Here it *is* what a report needs: a layer may not claim more confidence than it has
settled. The constraint is a soundness norm and it is free.

Its corollary is the second half of his question, and it is also free:

$$
r = 0 \;\Longrightarrow\; z = 0
$$

An agent with no verdict cannot lean (`r_zero_imp_z_zero`). The origin is on the equator by
necessity, so "equator = unprovedness" and "origin = maximum non-knowledge" are one proposal and its
consequence, not two independent proposals.

## 2.3 Poles, equator, origin

$$
\text{proved} \mapsto (1,1), \quad
\text{refuted} \mapsto (-1,1), \quad
\text{independent} \mapsto (0,1), \quad
\text{open} \mapsto (0,0)
\veq{vertex-coords}\lean
$$

Machine-checked as `vertex_coords`. Read back into his picture:

| Bloch object | What it becomes on the simplex | Survives? |
|---|---|---|
| north pole | the *proved* vertex | yes |
| south pole | the *refuted* vertex | yes |
| the $z$ diameter | the proved-refuted edge | yes |
| radius $r$ | $1 - p_{\text{open}}$ | yes, but see §3 |
| the equator (circle $r=1$) | the opposite face $d = 0$: all verdicts settled, lean unresolved | yes |
| the origin | the *open* vertex | yes |
| the equatorial **disc** interior | states with $z = 0$, $0 < r < 1$: partially settled, balanced | yes |
| the azimuth $\varphi$ | **nothing** | no |
| interference between statuses | **nothing** | no |
| non-unique decomposition of a mixture | replaced by unique decomposition | no, and §5 argues this is a gain |

**What was never real.** The azimuth. Four separate analyses in this cluster now report it carrying
nothing: [`logic-bloch-poles.md`](logic-bloch-poles.md) on the flat ground that a global phase is
unobservable, [`logic-models-ensemble.md`](logic-models-ensemble.md) because every model-state is
diagonal so the azimuth is undefined rather than uninformative,
[`logic-bloch-gates.md`](logic-bloch-gates.md) because no rotation-covariant order exists on the
equator, and [`logic-bloch-phase.md`](logic-bloch-phase.md) because provability-as-phase fails twice
and the surviving candidates land on $\{\pm 1\}$ rather than the circle. Dropping the azimuth is
therefore not this essay's sacrifice. It was already gone.

## 2.4 The two-number report, and what it still loses

$(z,r)$ is two numbers and $\Delta^3$ is three-dimensional, so the report discards one dimension.
What it discards is exactly the sibling's `report_conflates`: at $(0,1)$ sit both
$(0,0,1,0)$, proved-independent, and $(\tfrac12,\tfrac12,0,0)$, "certainly decided, no idea which
way". Confirmed here as `report_conflates`.

**On the simplex this is repairable and it costs one number.** Report all four weights instead of
$(z,r)$. On the ball it is **not** repairable, and §3 is why.

## 2.5 The deflation the cluster owes itself

[`logic-beyond-su3.md`](logic-beyond-su3.md) sells the simplex partly on size: two real dimensions
against the qutrit's eight. At four vertices that argument shrinks to nothing. $\Delta^3$ is
**three**-dimensional; a Bloch vector is three reals; the report costs the same either way. The
simplex is not cheaper than the ball here. Its advantage is entirely in the *shape*: four extreme
points instead of a continuum, and an affine rather than convex settledness. Say it that way, or the
comparison flatters.

---

# 3. The difference that decides everything: $r$ is a norm there and affine here

## 3.1 The statement

On the Bloch ball $r = \lVert \vec{n} \rVert$. A norm is convex, so

$$
r\big(t\rho_1 + (1-t)\rho_2\big) \;\le\; t\,r(\rho_1) + (1-t)\,r(\rho_2),
$$

with strict inequality whenever the two Bloch vectors point in different directions. Mixing two
maximally settled states can therefore produce a completely unsettled one, and in the case that
matters it does: $\tfrac12\lvert 0\rangle\langle 0\rvert + \tfrac12\lvert 1\rangle\langle 1\rvert$
is the maximally mixed state, $r = 0$. **The even mixture of the two poles is the centre.**

On the simplex $r = 1 - d$ is **affine**, so mixing two settled states is exactly as settled as the
mixture says. The even mixture of *proved* and *refuted* has $d = 0$, hence $r = 1$: certainly
decided, no idea which way.

These are not two conventions. They are two different answers to a substantive question the owner
has to rule on: **is "50/50 between proved and refuted" a state of high information or of no
information?** The ball says no information. The simplex says maximal information about
decidedness and none about direction. For a scheduler in a layered core the simplex answer is the
useful one, because "this will certainly be settled, I just do not know which way" and "I have got
nowhere" call for different actions.

## 3.2 The conflation is forced, not incurred

The cluster has been reading `report_conflates` as a cost of the two-number *report*. It is worse
than that, and the sharpening is this file's centrepiece.

Let $f$ be **any** map from the status simplex into a real vector space that respects mixing, and
that realises the owner's proposal: proved at $P$, refuted at $R$, open at the origin, where the
origin is the midpoint of $P$ and $R$ because that is what the Bloch ball's centre is. Then

$$
f\big(\tfrac12,\tfrac12,0,0\big) \;=\; \tfrac12 P + \tfrac12 R \;=\; f(0,0,0,1)
\veq{conflation-forced}\lean
$$

so $f$ is not injective (`conflation_forced`, `conflation_not_injective`). The azimuth is nowhere in
this argument. **No amount of extra Bloch structure repairs it**, because the obstruction is the
one-line fact that in the ball the centre already is the even mixture of the poles, while on the
simplex *open* is a fourth extreme point and no mixture of the other three.

The Lean statement was checked non-vacuous: replacing *open* by *proved* on the right leaves an
unprovable goal, as it must.

## 3.3 Consequence: the simplex is not a sub-object of the ball

Extreme points are preserved by affine isomorphism. $\Delta^3$ has four; the Bloch ball has a
continuum arranged as a sphere. There are of course affine injections of a tetrahedron into a ball,
but none of them is *the owner's* embedding, by §3.2. So the honest statement is not "the simplex
sits inside the ball"; it is **"the two bodies have the same dimension and incompatible extreme-point
structure, and the owner's intended correspondence is the one that cannot exist."**

---

# 4. Connectives: the decisive test the ball failed

## 4.1 The ceiling, stated before the tables

**Goedel 1932** exhibited a strictly descending chain of logics $G_2 \supset G_3 \supset \dots$ all
containing intuitionistic propositional logic, and thereby proved IPC has **no finite characteristic
matrix**. Any scheme that assigns each sentence a value from a fixed finite set and computes
connectives by table is such a matrix. So:

> Nothing in this section is intuitionistic logic, and nothing in it can be. The tables below are a
> logic **of the proof-search bookkeeping**: they compute what is guaranteed about a compound given
> what is guaranteed about its parts. They are not a semantics for provability.

That is the honest frame, and it is also the useful one, because "what is guaranteed given what is
known" is precisely what a scheduler in a layered core needs to compute cheaply.

## 4.2 The tables

Negation is forced: independence of $P$ is independence of $\lnot P$, and having no verdict about
$P$ is having none about $\lnot P$.

| $\lnot$ | proved | refuted | indep | open |
|---|---|---|---|---|
| | refuted | proved | indep | open |

Conjunction, read as *the best status guaranteed*:

| $\land$ | proved | refuted | indep | open |
|---|---|---|---|---|
| **proved** | proved | refuted | indep | open |
| **refuted** | refuted | refuted | refuted | refuted |
| **indep** | indep | refuted | **open** | open |
| **open** | open | refuted | open | open |

Every entry is a soundness claim about $T$, and each one is short. *Refuted* is absorbing because a
proof of $\lnot P$ is a proof of $\lnot(P \land Q)$ whatever $Q$ is. *Proved* is a unit because with
$T \vdash P$ we have $T \vdash P \land Q$ iff $T \vdash Q$, and $T \vdash \lnot(P\land Q)$ iff
$T \vdash \lnot Q$, so $P \land Q$ inherits $Q$'s status exactly. The bold entry is the interesting
one: with $P$ and $Q$ both independent, $Q = P$ makes $P \land Q$ independent and $Q = \lnot P$
makes it refuted, so **nothing is guaranteed** and the honest value is *open*.

Disjunction is defined by De Morgan rather than tabulated, so the duality is a theorem and not an
assumption. Checked: commutative, associative, *refuted* is its unit, *proved* is absorbing, and
$\lnot(x \lor y) = \lnot x \land \lnot y$ (`sor_comm`, `sor_assoc`, `sor_refuted_unit`,
`sor_proved_absorbing`, `de_morgan`).

Restricted to $\{$proved, refuted$\}$ the tables are the ordinary two-valued ones
(`classical_on_located`), so this is a conservative extension of classical logic and not a rival to
it.

## 4.3 The decisive negative: conjunction is not idempotent

$$
\text{indep} \land \text{indep} \;=\; \text{open} \;\ne\; \text{indep}
\veq{and-nonidem}\lean
$$

`sand_indep_not_idem`. $P \land P$ has the status of $P$, and the table cannot deliver that, because
the table sees two statuses and cannot know they belong to the same sentence. Consequences, stated
without softening:

- **Conjunction is not a meet.** A meet is idempotent by definition.
- **So the four statuses carry no lattice**, hence no Heyting algebra, no Boolean algebra, no
  residuation, and therefore **no implication defined as a residual**. The seed hoped the simplex
  would carry `implies`. It does not carry a residuated one.
- **This is not a repairable defect of the table.** It is the standard relational-versus-
  non-relational split in abstract interpretation: a domain that abstracts each variable separately
  cannot express dependencies between variables. Relational domains exist and are well understood.
  They are not one simplex per sentence, which is what this construction is.
- **What survives is soundness.** The table is monotone in the information order (flat, with *open*
  at the bottom and the three verdicts incomparable above it): learning more about $P$ and $Q$ never
  invalidates a previously computed status for $P \land Q$ (`sand_mono`, `sor_mono`). Negation is an
  order isomorphism of that order (`sneg_info_iso`), which is the arithmetic form of the sibling's
  lattice-side `neg_monotone_K`: negation moves the lean and cannot move the information.

So the answer to the seed's decisive test is: **yes, the simplex carries connectives where the ball
carries none, and they are abstract transformers rather than a logic's connectives.** That is a real
improvement over an antichain and it is much less than "the simplex is a logic".

## 4.4 It is Kleene K3 with a relabelled third value, and here is where

The seed asked for this said plainly if true. It is true, of a fragment. Drop *independent*, and the
table on $\{$proved, refuted, open$\}$ is exactly Kleene's strong three-valued matrix with *open* in
the role of the undefined value:

| Kleene | this table |
|---|---|
| $\mathbf{T} \land \bot = \bot$ | proved $\land$ open = open |
| $\mathbf{F} \land \bot = \mathbf{F}$ | refuted $\land$ open = refuted |
| $\bot \land \bot = \bot$ | open $\land$ open = open |
| $\mathbf{T} \lor \bot = \mathbf{T}$ | proved $\lor$ open = proved |
| $\mathbf{F} \lor \bot = \bot$ | refuted $\lor$ open = open |
| $\lnot \bot = \bot$ | $\lnot$ open = open |

`k3_fragment`, and the fragment is genuinely closed (`k3_fragment_closed`), so it is a sub-table
rather than a coincidence of six entries.

**Therefore the entire novel content of the four-status table is the *independent* row.** And within
that row, the only entry not fixed by the *proved*-unit and *refuted*-absorbing laws is
indep $\land$ indep, which is the non-idempotent one. The construction's whole logical novelty is a
single table cell, and that cell is the one that breaks lattice structure. This is a deflating
result and it is the most useful thing in the section.

It also sharpens a cluster verdict. [`logic-bloch-poles.md`](logic-bloch-poles.md) concluded the
Bloch ball "is Kleene, not Belnap", because Belnap's glut sits above both $\mathbf{T}$ and
$\mathbf{F}$ in the information order and nothing sits above a pure state. The simplex reaches the
same verdict from the other side: it is Kleene **plus one extra maximal element**, and that element
buys a status the ball cannot express while buying no lattice structure at all.

---

# 5. Convexity, which is the one thing a truth table does not have

## 5.1 What a mixed status means, and the extension

Under the predictive reading of §2.1, an interior point is a credence over verdicts. Given states
$p = (a,b,c,d)$ for $P$ and $q = (a',b',c',d')$ for $Q$, the natural extension of the table pushes
the *product* distribution forward through it. Writing the resulting weights:

$$
w_{\text{pr}} = a a', \qquad
w_{\text{rf}} = b + b' - b b', \qquad
w_{\text{ind}} = a c' + c a'
\veq{and-weights}\lean
$$

with $w_{\text{open}}$ the remainder (`wRf_inclusion_exclusion`). **The proved-weight multiplies and
the refuted-weight adds by inclusion-exclusion**, which is exactly what independent events do, and
is the sanity check that the table's absorbing and unit laws were the right ones. In report
coordinates,

$$
z(P \land Q) \;=\; a a' - \big(b + b' - b b'\big)
$$

(`zAnd_formula`).

## 5.2 Forced, or a choice? A choice, and a known-false one

The extension is the unique one that is **affine in each argument separately** and agrees with the
table on vertices: separate affineness pins a bilinear map down completely once the sixteen vertex
values are given. So it is forced *given that axiom*.

The axiom is a substantive assumption and it is **stochastic independence of the two uncertainties**.
For logically related $P$ and $Q$ it is false, and knowably so: the search for $P$ and the search for
$Q$ share lemmas, share a budget, and in the case $Q = P$ are the same search. That case is exactly
where §4.3's non-idempotence bites, and it is not a coincidence: **the failure of idempotence and
the falsity of the independence axiom are the same fact seen at the vertices and in the interior.**

The honest repair is a joint distribution on pairs of statuses, which has 15 free parameters against
the $3 + 3 = 6$ of the two marginals. That is the classical analogue of the seed conversation's
entanglement enthusiasm, and §7.3 says what it does and does not recover.

## 5.3 Two findings about settledness under conjunction

**Conjunction destroys settledness.** Two sentences each *proved independent* have $r = 1$, and
their conjunction has $r = 0$: nothing whatever is guaranteed (`and_of_two_independents`). For a
scheduler that is an operational statement, not a curiosity: compound queries over independent
sentences are strictly worse-known than their parts, so a core should not form them.

**And conjunction can create settledness.** A *refuted* conjunct settles the conjunction however open
the other one is: $r = 0$ for the open conjunct, $r = 1$ for the conjunction
(`and_can_increase_settledness`). So $r$ is not monotone under $\land$ in either direction. This is
reported as an anti-theorem because the tempting claim, "the compound is never better known than its
parts", is false and it would have been easy to assert.

## 5.4 Does convexity earn the simplex's keep over a plain truth table?

**Qualified yes, and the qualification is §5.2.** What convexity buys, concretely: a report can say
"$P \land Q$ will be proved with weight 0.42" where a table can only say "open", and a scheduler can
rank open sentences by how close to settled they are. What it costs: the only extension that is
mathematically forced is the one whose independence assumption is false in the application. So the
interior is genuinely useful for *reporting* and genuinely unreliable for *composing*. A core should
propagate the marginals for ranking and refuse to trust a composed weight as a probability.

That is a narrower claim than the cluster's framing implies, and it is the essay's own view of where
its object is weakest.

---

# 6. Dynamics: what learning does

## 6.1 The legitimate maps

Assume knowledge is monotone: a verdict once reached is not withdrawn. Then the three settled
vertices are **absorbing**, a learning map fixes them, and it is determined entirely by how it
redistributes the open weight. So a learning map is a point $(\alpha,\beta,\gamma,\delta)$ of a
3-simplex, acting as

$$
(a,b,c,d) \;\longmapsto\; (a + d\alpha,\; b + d\beta,\; c + d\gamma,\; d\delta).
$$

`step`. This is a column-stochastic map on $\Delta^3$ whose matrix is the identity on three columns.
**The legitimate learning maps are themselves a 3-simplex**, which is a pleasing self-similarity and
also the exact answer to "which stochastic maps are legitimate": those, and no others, under
monotonicity.

## 6.2 Learning increases settledness

$$
r(s) \;\le\; r(\text{step}(L, s)), \quad\text{with equality iff } d = 0 \text{ or } \delta = 1
\veq{learn-mono}\lean
$$

`learn_r_mono`, `learn_r_eq_iff`. This is the simplex form of the sibling's report that learning is
a non-unital channel increasing $r$, and here it is one line rather than a channel calculation: $r$
is $1-d$, and $d$ is multiplied by $\delta \le 1$.

It also gives the right reading of $\delta$: **the fraction of the open case the step failed to
resolve**. A step with $\delta = 1$ is a wasted budget slice.

## 6.3 Learning is a monoid with no inverses, so the gate programme is lost

Composition of learning maps is a learning map, and a step that resolved anything is never undone:
once weight has left *open*, no further learning returns the state to total ignorance
(`learn_no_undo`). So the dynamics is an **irreversible monoid**.

Unitary gates form a **group**. [`logic-bloch-gates.md`](logic-bloch-gates.md)'s whole programme,
CNOT with its exact bookkeeping $r' = \sqrt{1-C^2}$, phase kickback, TOFFOLI, and the counting
argument that three wires is a proven minimum for AND, is a programme about reversible computation.
**None of it has an analogue here, and this essay's recommendation is to accept the loss rather than
look for one.**

## 6.4 Why the loss costs nothing

The strongest-looking casualty is that essay's "why a third qubit for AND", answered there by
counting: a reversible two-input AND is impossible, so an ancilla wire is forced. On the simplex,
conjunction is a map $\Delta^3 \times \Delta^3 \to \Delta^3$, it is not required to be invertible,
and no ancilla appears. **The third wire was a tax on reversibility, and learning does not want to be
reversible**, because forgetting a proof is exactly what monotone knowledge forbids. So the counting
theorem is true and inapplicable, which is the best possible way for a result to be lost.

What is genuinely lost with reversibility: any interference story, and with it any use for the
azimuth. §2.3 already reported four independent findings that the azimuth carries nothing, so this
loss was already realised elsewhere in the cluster.

---

# 7. Attacking the construction

The seed asked for the harshest available review of this object. Seven attacks, in descending order
of how much damage they do.

## 7.1 The interior may not exist

§2.1's whole case rests on the predictive reading. If the owner insists the weights are what the
agent *holds*, the interior is empty and the object degenerates to the four-element set of §4, whose
entire novelty is one table cell (§4.4). **This is the attack most likely to succeed**, because the
introspective reading is the one his own words ("proven true", "unprovable") most naturally support,
and only his third item ("probable but undetermined") pulls the other way. If he rules for the
introspective reading, §5 and §6 both go, and what remains is a four-valued abstract domain, which
is a smaller and much less interesting result. It is item 1 in "Surfaced for the owner".

## 7.2 The bounded-agent problem, which the measure objection becomes

[`logic-models-ensemble.md`](logic-models-ensemble.md) §4.2 reports the computability wall: a
coherent probability assignment gives probability 1 to every theorem, hence cannot represent
uncertainty about the output of a computation at all, and Demski's result says a non-dogmatic,
Gaifman-inductive, weakly coherent belief state has no computable approximation. **Does this apply
to any measure-based object, including this one?**

Partly. It is *deflected* on the main point: the weights here are not credences that $P$ is a
theorem, they are credences about which verdict *this agent's search* returns by a horizon, which is
a fact about a computation and about which a bounded agent can be genuinely uncertain. Coherence in
Gaifman's sense does not bind them.

But a sharper variant bites. The state is only meaningful for a **resource-bounded** agent, and the
simplex has **no resource parameter**. Nothing in $(a,b,c,d)$ records the horizon $B$, and the same
sentence has a different state at every $B$. So the object is a *snapshot*, and the literature that
does this properly, Garrabrant et al.'s logical induction, makes the primary object the **sequence**
and derives coherence only in the limit. A snapshot lacks exactly the property that makes the
sequence work. **Recommendation: the missing coordinate is budget, and the honest form of this
object is a trajectory on the simplex indexed by budget, not a point.** That is item 4 in "Surfaced
for the owner". A second variant is worse and is left open: an agent predicting its own future
output faces the standard reflection problem, so calibration of $a$ about the agent's own search
cannot be required.

## 7.3 No entanglement, and the owner's own examples did not need it

The seed conversation was enthusiastic about entangled propositions: $\lvert 00\rangle +
\lvert 11\rangle$ as "either both provable or both not", $\lvert 01\rangle + \lvert 10\rangle$ as
exclusive provability, and "logical entanglement networks" of proof dependencies.

**Every joint distribution on pairs of statuses is separable**, by definition: a classical joint is a
mixture of products. So no Bell violation, no Tsirelson bound, no monogamy, and no analogue of the
gates essay's $r' = \sqrt{1-C^2}$.

**But correlation survives, and correlation is what his examples actually described.** "Either both
proved or both open" is the classical joint $p(\text{pr},\text{pr}) = p(\text{opn},\text{opn}) =
\tfrac12$, which the simplex pair carries exactly. Proof dependencies are correlations. What is
genuinely lost is the *distinction* between $\lvert 01\rangle + \lvert 10\rangle$ and the
corresponding mixture, and that distinction is only visible in a second, complementary measurement
basis. This cluster has no candidate for a second question:
[`logic-bloch-gates.md`](logic-bloch-gates.md) proved no rotation-covariant order exists on the
equator. **So the loss is real and currently un-cashable**, which is the fairest thing that can be
said about it.

## 7.4 No phase, so a sibling's entire subject vanishes

[`logic-bloch-phase.md`](logic-bloch-phase.md) is 41 KB on what the Bloch phase could be. On a
simplex there is no phase, so that question does not merely go unanswered, it stops being
well-posed. In fairness to that essay: it *also* concluded that provability-as-phase fails twice,
that its strongest candidate (proof-relevance) hands you $\mathbb{Z}$ which is blind to the roots of
unity, and that three independent routes land on $\{\pm 1\}$ rather than on the circle. A
$\{\pm 1\}$-valued invariant is not a phase; it is a second bit, and a second bit can be carried by
a second simplex coordinate. **So the recommended reading is that the phase programme survives the
move to a simplex in its $\{\pm 1\}$ form and dies in its $U(1)$ form.** That is a claim about
another agent's essay and it is offered to the owner as such, not as a finding about that essay.

## 7.5 The vertices may be unobservable in practice

*Independent* requires a metatheoretic independence proof. For the overwhelming majority of
sentences no such proof exists or ever will, and the same is true of a verdict of any kind. So in
practice $d \approx 1$ for nearly everything, the interesting structure lives on a measure-zero set
of sentences, and the object is useful only if the core's attention is restricted to sentences with
plausible verdicts. That is probably fine for a scheduler and it should be said rather than
discovered.

## 7.6 The report is three reals, not two, and the cluster keeps saying two

§2.4: reporting $(z,r)$ re-incurs the conflation. The fix is to report all four weights, which is
three independent reals, which is what a Bloch vector costs. Anyone selling the simplex on economy
(§2.5) is selling the two-vertex-fewer version, which §1.2 rejects.

## 7.7 Non-idempotence is a real defect and this essay does not fix it

§4.3. $P \land P \ne P$ is a defect by any standard, and the standard repair, a relational domain, is
not a per-sentence simplex. The construction is therefore sound and coarse, and coarseness is a
property a scheduler can live with only if it is told about it. It is item 6 in "Surfaced for the
owner".

---

# 8. Serving the stated application

The naming turn asks for a **layered** system: a complete lower layer, an incomplete upper layer,
and Bloch-valued truth carrying the upper layer's indeterminacy.

## 8.1 The report format

Concretely, per sentence, the upper layer hands the core:

```
P : (a, b, c, d)     four non-negative weights, sum 1, at horizon B
```

and the core computes $z = a-b$, $r = 1-d$ as needed. Three admissibility checks are pure geometry
and cost the core nothing:

1. $p \ge 0$ and $\sum p = 1$: a malformed report is rejected by arithmetic.
2. $\lvert z \rvert \le r$: a layer may not claim more lean than it has settled. Free, by §2.2.
3. $r$ never decreases between reports at increasing budget, unless the layer declares a retraction.
   This is `learn_r_mono`, and a violation is a bug in the layer, detectable by the core.

The two reports the scheduler must distinguish, which every ball-based reading collapses:

| Report | $(z,r)$ | Weights | Core's action |
|---|---|---|---|
| "proved undecidable here" | $(0,1)$ | $(0,0,1,0)$ | stop; escalate theory or branch |
| "got nowhere yet" | $(0,0)$ | $(0,0,0,1)$ | allocate more budget |
| "certainly decided, unknown which" | $(0,1)$ | $(\tfrac12,\tfrac12,0,0)$ | worth budget; the search will terminate |

The third row is the one §3.2 proves no Bloch reading can separate from the first.

## 8.2 Complement or competitor to Heyting plus GL?

[`logic-beyond-su3.md`](logic-beyond-su3.md) §12 recommends Heyting algebras for the layer and
provability logic GL for the core. **This essay's recommendation is that the simplex complements
that pair and competes with neither**, because the three objects live at different levels:

- A **Heyting algebra**'s elements are propositions, and its order is entailment. It answers "what
  follows from what".
- **GL**'s formulas are about $\Box$, it is decidable while PA is not, and it answers "what can the
  core safely reason about provability".
- The **simplex**'s points are epistemic states about *one* proposition. It answers "what has this
  layer established about this sentence, and how confident is it".

They compose in the obvious direction: GL is the core's calculus, the Heyting algebra is the layer's
semantics, and the simplex is the **interface** between them, which is exactly the role the sibling
assigned to "the report" in its own ranking table. There is one point of genuine friction, and it
should be stated rather than smoothed: §4.3 shows the *statuses* carry no Heyting structure, so the
simplex cannot be read as a quantitative Heyting algebra, and any attempt to make the report's
connectives agree with the layer's entailment will fail at indep $\land$ indep. The interface is
one-directional: statuses are computed from proofs, never proofs from statuses.

---

# 9. What the Lean file discharges

[`lean/LogicSimplex.lean`](lean/LogicSimplex.lean), `exit 0`, zero `sorry`, checked under
`capped.sh` at 4 GB. Only these carry `\veq` badges above.

| Theorem | Claim |
|---|---|
| `abs_z_le_r`, `r_le_one`, `r_nonneg` | $\lvert z\rvert \le r \le 1$ from $p \ge 0$ alone |
| `r_zero_imp_z_zero` | the origin is on the equator by necessity |
| `vertex_coords` | the four statuses at $(1,1)$, $(-1,1)$, $(0,1)$, $(0,0)$ |
| `three_status_collapse` | dropping *open* forces $r \equiv 1$ |
| `report_conflates` | the $(z,r)$ report is not injective |
| `conflation_forced`, `conflation_not_injective` | **the conflation is forced by mixing alone**, azimuth irrelevant |
| `sand_comm`, `sand_assoc`, `sand_proved_unit`, `sand_refuted_absorbing` | the conjunction table is well behaved |
| `sor_*`, `de_morgan` | disjunction, defined by duality, is too |
| `classical_on_located` | conservative extension of two-valued logic |
| `sand_mono`, `sor_mono`, `sneg_info_iso` | soundness in the information order |
| `sand_indep_not_idem`, `sand_not_idempotent` | **no lattice, hence no Heyting algebra** |
| `three_statuses_not_closed` | the second, independent argument for four vertices |
| `k3_fragment`, `k3_fragment_closed` | the three-status fragment **is** Kleene K3 |
| `wRf_inclusion_exclusion`, `zAnd_formula` | the multilinear extension's arithmetic |
| `and_of_two_independents` | conjunction destroys settledness |
| `and_can_increase_settledness` | and can create it, so $r$ is not monotone under $\land$ |
| `learn_r_mono`, `learn_r_eq_iff` | learning never decreases settledness |
| `learn_no_undo` | learning is irreversible: a monoid, not a group |
| `dual_z`, `dual_r` | negation moves the lean and fixes the settledness |

Explicitly **not** discharged, and the file's header says so: nothing about provability, Goedel or
arithmetic; nothing showing the connectives are a logic; nothing about density matrices; nothing
justifying the independence assumption behind the multilinear extension.

---

# Surfaced for the owner

Each item is a located claim plus the ruling it needs. Nothing has been written to `TODO.md`,
`ROADMAP.md` or `REVIEW_ME.md`.

1. **The interior is empty under the sibling's own definition.** Located:
   [`logic-epistemic-state.md`](logic-epistemic-state.md) §2.2 defines $a$ as "the agent **holds** a
   proof", which an agent knows, so $a \in \{0,1\}$ and every state is a vertex. That essay then
   dismisses the predictive alternative as "subsumed" (§2.4). This essay's §2.1 argues the
   predictive reading is not subsumed but load-bearing, and that your own "probable but undetermined"
   has no referent without it. **Ruling needed: predictive or introspective?** If introspective,
   §5 and §6 of this essay both fall.

2. **"Probable but undetermined" is a mixture, not a status.** Located: your `conv-falsifiability.md:366`
   list, third item. This essay reads it as an interior point, which is the argument for a convex
   object rather than a four-valued logic. **Ruling needed: did you mean a degree, or a fifth
   status?**

3. **Four vertices or five.** Located: §1.3 here against
   [`logic-epistemic-state.md`](logic-epistemic-state.md) §5.1, which calls the five-status object
   "the object nobody has built". This essay rejects the fifth (Belnap's glut) as a property of the
   *theory* rather than of the sentence, but the rejection depends entirely on whether your layered
   core consumes reports from one classical theory or from several mutually untrusted reasoners. In
   the multi-source case **five is right and this essay is wrong**. **Ruling needed: what is the
   reporting architecture?**

4. **The object has no resource parameter and should probably be a trajectory.** Located: §7.2. The
   state is only meaningful for a bounded agent at a horizon $B$, and $B$ appears nowhere in
   $(a,b,c,d)$. Logical induction makes the sequence primary and derives coherence in the limit.
   **Ruling needed: is a budget-indexed trajectory on the simplex the right object, rather than a
   point?**

5. **The conflation is forced, which is stronger than the cluster has been saying.** Located: §3.2,
   `conflation_forced`. The cluster reads `report_conflates` as a cost of the two-number report; it
   is an impossibility for any mixing-respecting map realising your poles-and-origin proposal,
   because in the ball the centre already is the even mixture of the poles. **Ruling needed: accept
   that the ball cannot host the reading, and drop it, or reject one of the two placements.**

6. **Connectives exist and are not a logic.** Located: §4.3, `sand_indep_not_idem`. The four
   statuses carry sound, monotone, classical-on-the-poles connectives, but conjunction is not
   idempotent, so there is no lattice, no Heyting algebra and no residuated implication. The seed
   hoped for `implies`. **Ruling needed: is a sound-but-coarse abstract domain enough for the core,
   or is a relational domain required?**

7. **The whole novelty is one table cell.** Located: §4.4, `k3_fragment`. The three-status fragment
   is exactly Kleene K3 relabelled, so everything new lives in the *independent* row, and within it
   in indep $\land$ indep. **Ruling needed: is that enough to justify the object, or does this
   deflate "Bloch Truth" to "K3 plus one value"?**

8. **The gate programme is lost and this essay recommends accepting the loss.** Located: §6.3,
   §6.4, `learn_no_undo`, against [`logic-bloch-gates.md`](logic-bloch-gates.md)'s CNOT/TOFFOLI
   analysis. Learning is an irreversible monoid; gates are a group. The "three wires for AND"
   counting theorem is true and inapplicable, because the third wire is a reversibility tax.
   **Ruling needed: confirm the gate line is closed, or say what it was for.**

9. **The economy argument does not hold at four vertices.** Located: §2.5, against
   [`logic-beyond-su3.md`](logic-beyond-su3.md) §8's "two real dimensions instead of eight". A
   four-vertex simplex report is three reals, exactly a Bloch vector's cost. **Ruling needed: none
   required, but the cluster's framing should be corrected before any of it is promoted.**

10. **Entanglement is lost and your own examples did not use it.** Located: §7.3, against the
    $\lvert 00\rangle + \lvert 11\rangle$ passage in `conv-falsifiability.md`. Correlation is
    preserved and reproduces "either both provable or both not" exactly; what is lost needs a second
    complementary question, for which this cluster has no candidate. **Ruling needed: is the
    interference picture what "Bloch Truth" is *for*? If yes, the simplex is the wrong object and
    this essay should be rejected wholesale.**

11. **A candidate thesis statement for `id:4bb2`, offered as a candidate only.**
    `TODO.md` records the Bloch Truth item as BLOCKED for want of a thesis statement. This is the
    third candidate this cluster has produced and it is deliberately narrower than the other two:

    > **Candidate thesis (simplex).** *The state of a sentence, for a bounded reasoner, is a
    > probability distribution over four terminal verdicts: proved, refuted, independent, open.*
    > The truth lean $z = a-b$ and the settledness $r = 1-d$ are read off it, the constraint
    > $\lvert z\rvert \le r$ is componentwise non-negativity, learning is a stochastic map fixing
    > the three settled vertices, and the verdicts carry sound monotone connectives that are Kleene
    > K3 plus one non-idempotent value. It is not a logic, it is what a layer reports to a core.

    **Ruling needed: yours, and only yours.** No agent verdict in this cluster is self-settling and
    none has been filed.

---

# A future `.mw` sketch

```
# handle: zr-cone. The owner's constraint, derived from non-negativity.
# a, b, c, d >= 0 and a + b + c + d = 1;  z = a - b;  r = a + b + c.
verify lean: abs (a - b) <= a + b + c  and  a + b + c <= 1

# handle: vertex-coords. The four statuses in (z, r).
verify lean: (1,1), (-1,1), (0,1), (0,0)

# handle: conflation-forced. No mixing-respecting map places open at the
# midpoint of proved and refuted and stays injective.
verify lean: f (1/2, 1/2, 0, 0) = f (0, 0, 0, 1)

# handle: and-nonidem. The single cell that costs the lattice.
verify lean: sand indep indep = opn

# handle: and-weights. Proved multiplies, refuted adds by inclusion-exclusion.
verify lean: wRf p q = b + b' - b * b'

# handle: learn-mono. Learning never decreases settledness.
verify lean: r s <= r (step L s)
```

# Follow-up leads

1. **Build the budget-indexed trajectory** of §7.2 and ask whether the natural limit theorems of
   logical induction have simplex forms. This is the largest open piece.
2. **Build the joint version** of §5.2: two sentences, 15 parameters, and check whether the
   correlations that proof dependency actually produces are expressible and whether they repair
   idempotence for $Q = P$.
3. **Price the five-vertex object** properly, as the sibling asked: is any convex body with five
   extreme points a quantum state space? The answer is expected to be no, and knowing it would close
   §1.3 either way.
4. **Test the $\{\pm 1\}$ phase claim** of §7.4: add a second binary coordinate to the simplex and
   see whether [`logic-bloch-phase.md`](logic-bloch-phase.md)'s surviving candidates land in it.

# Sources consulted

- K. Goedel, *Zum intuitionistischen Aussagenkalkül*, Anzeiger der Akademie der Wissenschaften in
  Wien **69** (1932) 65-66; reprinted Ergebnisse eines mathematischen Kolloquiums 4 (1933) 40;
  Collected Works I, 222-225. The chain $G_2 \supset G_3 \supset \dots$, hence no finite
  characteristic matrix for IPC. Cited for the ceiling in §4.1; the result is quoted, not proved
  here. Reference verified against the sibling [`citation-audit.md`](citation-audit.md), which
  records it CONFIRMED from a secondary source carrying the relevant passage in full.
- S. C. Kleene, strong three-valued tables (1938, and *Introduction to Metamathematics* 1952).
  §4.4's identification is against the standard tables.
- N. Belnap, *A useful four-valued logic* (1977) and J. M. Dunn's four-valued semantics: the
  bilattice `FOUR`, its glut, and the multiple-source database setting that §1.3's crux turns on.
- P. Cousot and R. Cousot, *Abstract interpretation* (1977): the flat domain, sound abstract
  transformers, and the relational-versus-non-relational split that §4.3 and §7.7 invoke.
- S. Garrabrant, T. Benson-Tilsen, A. Critch, N. Soares, J. Taylor, *Logical Induction*
  (arXiv:1609.03543): the sequence-not-snapshot point of §7.2. Abstract and stated properties only;
  the 130-page paper was not read and no theorem name from it is cited.
- A. Demski and the MIRI *Questions of Reasoning Under Logical Uncertainty* material, as reported in
  [`logic-models-ensemble.md`](logic-models-ensemble.md) §4.2, for the computability wall. Reported
  at second hand there and at third hand here, and flagged as such.
- D. Ellsberg, *Risk, Ambiguity, and the Savage Axioms*, Quarterly Journal of Economics **75**(4)
  (1961) 643-669: risk versus ambiguity, for the naming of the second inhabitant of the equatorial
  circle, via [`logic-epistemic-state.md`](logic-epistemic-state.md) §4.
- Sibling essays in this cluster, all dreamed and all unreviewed:
  [`logic-bloch-poles.md`](logic-bloch-poles.md), [`logic-bloch-gates.md`](logic-bloch-gates.md),
  [`logic-bloch-phase.md`](logic-bloch-phase.md), [`logic-qutrit-su3.md`](logic-qutrit-su3.md),
  [`logic-models-ensemble.md`](logic-models-ensemble.md),
  [`logic-epistemic-state.md`](logic-epistemic-state.md),
  [`logic-beyond-su3.md`](logic-beyond-su3.md),
  [`logic-models-vs-epistemic.md`](logic-models-vs-epistemic.md).

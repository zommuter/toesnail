---
title: Models or knowledge, adjudicated
permalink: /dreamed/logic-models-vs-epistemic
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This file *proposes*; the owner disposes. Nothing here is toesnail theory, and nothing may be
> promoted into `physics/` or `essays/` without the owner authoring the move himself. The `\veq`
> badges below claim something about [`docs/dreamed/lean/LogicMerge.lean`](lean/LogicMerge.lean)
> **only**, and are deliberately not wired into `physics/*.toml` or `tests/test_verify.sh`.
>
> **This file adjudicates a fork; it does not settle it.** Two sibling agents argued opposite halves
> of a question the owner opened on 2026-09-07, and he asked for a third to merge them. An
> adjudicator's output is a reasoned recommendation with its weaknesses attached. Nothing below is
> decided, nothing has been written to any ledger, and a delegated agent's verdict is never
> self-settling.

## Provenance and remit

The owner's question, verbatim, asked while reading
[`logic-bloch-poles.md`](logic-bloch-poles.md):

> can the equator be considered any kind of "unprovedness" instead, and the origin as maximum
> non-knowledge? don't just consider pure states but also mixed ones, i.e. Bloch with $r<1$ as well

It forks, because it does not say what the density matrix is a state **of**. Two agents took the two
answers:

| | [`logic-models-ensemble.md`](logic-models-ensemble.md) | [`logic-epistemic-state.md`](logic-epistemic-state.md) |
|---|---|---|
| shorthand | **(i)** a state over MODELS | **(ii)** a state over EPISTEMIC STATUS |
| randomness over | which complete extension of the theory obtains | what the agent has established |
| reachable set claimed | the segment $\lvert z\rvert = r$ | the wedge $\lvert z\rvert \le r \le 1$ |

The yardstick is not "which essay reads better". It is the owner's own stated application, from the
turn that named the idea
(`~/knowledge/sessions/claude-ai/2025-08-05_breaking_project_paralysis_cbae6cd6.md:1334`, 2025-08-08,
his words):

> the Bloch Truth (might need a better name) might be useful for the AI logic core in the second
> (ZFC?) layer where incompleteness applies (core layer should only be complete, e.g. ZF without C)

A layered reasoner: a decidable core consuming reports from an incomplete layer. Every judgement
below is made against that target and says so. Both essays were written by agents instructed to argue
a side, so their load-bearing arithmetic is re-derived here from scratch in
[`lean/LogicMerge.lean`](lean/LogicMerge.lean), with definitions duplicated rather than imported, and
their prior-art claims were sent back to the primary sources.

---

# 0. The recommendation, stated and not teased

**Recommendation: build on (ii), and replace the ball with the report triangle. Keep (i), but not as
a rival state space: re-type it as the semantics the report has to be sound against.**

1. **The two reachable sets really are different, and the difference is a proper containment.**
   (i)'s segment sits inside (ii)'s wedge, and $(z,r) = (0,1)$ is in the wedge and not the segment,
   machine-checked both ways. The essays are not in error about each other; the object they are
   readings *of* is what has to be chosen (§2.1).

2. **Under (i), the one distinction the stated application needs is provably absent.** Inside (i),
   $z = 0$ forces $r = 0$. The core's scheduler must tell "I proved this is undecidable here, stop
   asking" from "I have got nowhere yet, spend more budget"; under (i) both are the origin. That is a
   theorem about the reading, not an inconvenience of it, and it decides the fork for this
   application (§2.3, `models_z_zero_forces_origin`).

3. **The claimed cross-essay convergence on encoding (b) does not survive checking.** Both essays are
   reported as independently confirming that the poles should be `provable` against `not provable`.
   Neither does: under (i) the poles are provable and refutable, under (ii) proved and refuted. Both
   are encoding **(a)**. What they share is the word "provability" inherited from the parent essay
   (§3).

4. **The owner's own question dissolves the argument that produced encoding (b).**
   `logic-bloch-poles.md` §1 argues from a pigeonhole (no injection from three statuses into two
   poles) to encoding (b). The Lean theorem is correct; the inference needs the premise that every
   status sits at a *pole*, and "don't just consider pure states but also mixed ones" retracts it.
   With $r<1$ admitted, three statuses fit with nothing conflated (§4, `enc_injective`).

5. **Four essays in this cluster now land on a simplex and none lands on a ball.** (i) via Bauer,
   (ii) via "a classical four-outcome distribution reproduces everything",
   [`logic-qutrit-su3.md`](logic-qutrit-su3.md)'s $\lvert n_3\rvert + p_{\text{undec}} \le 1$ once you
   notice its diagonal plane *is* a 2-simplex, and [`logic-beyond-su3.md`](logic-beyond-su3.md)
   outright. §2.4 also deflates that honestly: it is one theorem applied four times.

6. **The ball contributes nothing to the report.** The wedge is *exactly* the ball's $(z,r)$ shadow,
   checked in both directions. What the ball has beyond it is the azimuth, which four analyses now
   report as carrying nothing (§5).

**The weakness the recommendation is most likely to die of, in the same breath.** (ii) severs the
concrete Goedel picture. Under (i), "true in the standard model, false in a nonstandard one" *is* the
mixed state, and the geometry pictures incompleteness directly; under (ii), Goedel supplies the
inhabitation of one vertex and nothing else. If that picture is what "Bloch Truth" is *for*, this
recommendation is wrong and (i) wins. That is a question about the owner's intent, which no agent can
answer.

---

# 1. What was re-checked, and what the checks found

## 1.1 (i)'s diagonality and segment: CONFIRMED, and smaller than it looks

A measure over completions hands you one number, $p = \mu([\varphi])$. The state is
$\operatorname{diag}(p, 1-p)$, its Bloch vector is $(0,0,2p-1)$, and its length is

$$
\sqrt{0^2 + 0^2 + z^2} = \lvert z\rvert
\veq{diag-norm}\lean
$$

so $\lvert z\rvert \le r$ is saturated identically (`diag_nrm_eq_abs_z`, `modelReport_mem`).
Confirmed. What the confirmation does *not* establish is any of (i)'s grandeur: the result is an
identity about square roots, and Stone duality, Cantor space and the Bauer simplex are all downstream
of one observation, that a measure is one number per sentence. (i) says so itself ("There is no
second number in a measure"), and the honesty should be taken at face value.

## 1.2 (ii)'s four corners: CONFIRMED

With $z = p_{\text{pr}} - p_{\text{rf}}$ and $r = p_{\text{pr}} + p_{\text{rf}} + p_{\text{ind}}$
over the four-status simplex,

$$
\text{proved} \mapsto (1,1),\quad \text{refuted} \mapsto (-1,1),\quad
\text{independent} \mapsto (0,1),\quad \text{open} \mapsto (0,0)
\veq{four-corners-check}\lean
$$

re-derived as `vertex_coords`, exactly as claimed. The arithmetic is elementary enough to survive any
adversarial reading: (ii)'s headline is not in doubt.

## 1.3 (ii)'s `report_conflates`: CONFIRMED, and worse than (ii) says

$$
\text{report}(0,0,1,0) = \text{report}(\tfrac12,\tfrac12,0,0) = (0,1),\qquad
(0,0,1,0) \ne (\tfrac12,\tfrac12,0,0)
\veq{conflation-check}\lean
$$

Confirmed. Stated affinely, independence is the **midpoint of the top edge** of the report triangle,
not an extreme point of it, which is why an even mixture of proved and refuted reaches it
(`independent_is_midpoint`).

The essay reports this against itself, to its credit. The adjudication adds one thing it does not
say. §2.3's scheduler argument is (ii)'s strongest card, a distinction (ii) makes and (i) cannot. But
`report_conflates` is a *second* operational distinction that (ii) also fails, and it fails it
against a **classical four-outcome distribution**, not against (i). "Stop asking" and "this is a coin
flip, guess" are as different for a scheduler as the pair (ii) wins on. So the two-number report wins
one and loses one, and the loss is to the simplex it is a projection of. That is not a reason to
prefer (i); it is a reason to prefer the simplex over the report, which §5 acts on.

## 1.4 The prior-art claims, sent back to the primary sources

**Vol, [arXiv:1205.6898](https://arxiv.org/abs/1205.6898), (i)'s claimed rediscovery: SUBSTANTIALLY
WEAKER THAN CLAIMED.** The abstract is verbatim as (i) quotes it, but the word doing the work is
*associate*: **diagonality there is a founding stipulation, not a result.** The paper picks diagonal
matrices and then chooses connective maps $\rho \mapsto G\rho G^{T}$ that preserve diagonality. It
reproduces Boolean, probabilistic and three-valued Lukasiewicz logic, and contains no model theory,
no arithmetic and no incompleteness. Published (*Int. J. Theor. Phys.* **52**, 514-523, 2013), with
**zero citations**. So it is prior art for "propositions as density matrices" and not for (i)'s actual
claim, that a model-ensemble semantics **forces** diagonality. §7 C6 overstates the collision.

**Bauer via [Kennedy-Shamovich](https://arxiv.org/pdf/1911.01023): CONFIRMED, citation misplaced.**
The suspected counterexample does not exist; their introduction states it: "in contrast to Bauer's
characterization of state spaces of unital commutative C\*-algebras, **the state space of a unital
noncommutative C\*-algebra is never a simplex**". Two repairs for (i) §3.1: Bauer's theorem proper
belongs to Alfsen (*Compact Convex Sets and Boundary Integrals*, Thm II.4.3), and the iff is in the
introduction, not the abstract, whose own theorem is the noncommutative generalisation. The near-miss
worth knowing: the **tracial** state space of a noncommutative C\*-algebra *is* a Choquet simplex.

**PA's Lindenbaum algebra is countable and atomless: CONFIRMED, hypothesis sharpened.** Visser and
Pakhomov ([arXiv:2207.08174](https://arxiv.org/abs/2207.08174), Remark 4.3) state it directly. (i)'s
two-line atomlessness argument is right, but the hypothesis doing the work is **essential
incompleteness**, needing the theory *r.e.* as well as essentially undecidable; it should read
"consistent, r.e., interprets $R$" rather than leaning on Goedel-Rosser alone. One caveat if anything
effective is ever built on the Cantor-space picture: the isomorphism is abstract, and *qua numbered
algebras* a decidable theory's Lindenbaum algebra is not recursively isomorphic to PA's.

**Sawin and Demski, not Demski: (i) §4.2 and §7 C3 are MISATTRIBUTED, and the misattribution inverts
a paper.** The result is **Sawin and Demski (2013)**, *Computable probability distributions which
converge on $\Pi_1$ will disbelieve true $\Pi_2$ sentences*, quoted in the Logical Induction paper
itself. **Demski's own 2012 prior is the opposite case**: MIRI's agenda records it as "coherent and
computably approximable". The sharp form is *computably approximable plus Gaifman-inductive implies
probability 0 on some true $\Pi_2$ sentence*; "no computable approximation" is the right gloss only
once non-dogmatism joins the hypotheses. C3's substance survives; the citation must be repaired.
Garrabrant et al. is confirmed verbatim, including "strictly dominate the universal semimeasure in
the limit".

**Jøsang: CONFIRMED, and (ii) got its own coordinate identification WRONG.** The opinion tuple, the
triangle and the Beta mapping are as (ii) describes, with one bibliographic repair: the general-$W$
form is the 2016 book, and the 2001 paper fixes $W = 2$ for the binary case. (ii)'s claim that Jøsang
has no distinguished $u=0$, $b=d=\tfrac12$ point is confirmed and is *stronger* than stated, since
$u=0$ is a whole edge Jøsang himself calls dogmatic and "unnatural in practical situations". But the
identification "Jøsang's $u$ is (ii)'s $1-r$" is false:

$$
u \;=\; p_{\text{ind}} + p_{\text{open}}, \qquad 1 - r \;=\; p_{\text{open}},
\qquad u = 1-r \iff p_{\text{ind}} = 0
\veq{josang-gap}\lean
$$

`josang_gap`, `josang_eq_iff`, with witness `josang_ne_at_independent`: at proved-independence $u=1$
while $1-r=0$. They agree exactly on the states where (ii) has nothing new to say. So the correct
statement is not "a geometric repackaging of subjective logic" but **subjective logic with $u$ split
into `independent` and `open`**, which is precisely the separation (ii) exists to make and Jøsang
cannot express. (ii) under-claims its own novelty at the point where it concedes the most.

**Keynes: CONFIRMED verbatim, and better than (ii) knew.** *A Treatise on Probability* ch. VI §1: the
comparison "turns upon a balance, not between the favourable and the unfavourable evidence, but
between the absolute amounts of relevant knowledge and of relevant ignorance respectively", and "New
evidence will sometimes decrease the probability of an argument, but it will always increase its
'weight'." §3 adds $V(a/h) = V(\bar a/h)$: weight is invariant under negation while probability is
not, which is (ii)'s `dual_r` a century early. Two flags: Keynes opens "I remain uncertain as to how
much importance to attach to it", and offers no measure of weight, only a partial ordering.

**QBism and Dempster-Shafer: CONFIRMED, one qualification each.** Fuchs and Schack's Born rule is a
coherence relation between *the agent's own* probability assignments, not a map from a state to
outcome probabilities. And Shafer's 1976 book **disavowed** reading
$\mathrm{Bel} \le P \le \mathrm{Pl}$ as bounds on an unknown true probability; the sandwich is
Dempster's reading.

**Net.** Both self-assessments survive in substance and need repairs in detail. (i) is too generous
to Vol and has one wrong citation; (ii) is too harsh on itself by exactly the coordinate it got
wrong. Neither reading is a discovery, and the owner should know that; neither is a duplicate either.

---

# 2. The collisions, adjudicated

## 2.1 One dimension against two: both are right, and the containment is proper

$$
\mathrm{ModelsReach}(z,r) \iff \lvert z\rvert = r \wedge r \le 1,
\qquad
\mathrm{StatusReach}(z,r) \iff \lvert z\rvert \le r \le 1
$$

The first is contained in the second (`models_subset_status`), strictly, with the witness at the
exact point the fork is about:

$$
\mathrm{StatusReach}(0,1) \wedge \neg\,\mathrm{ModelsReach}(0,1)
\veq{reach-differ}\lean
$$

`equator_separates`. So each essay is right about its own set and neither misdescribes the other.

**Where does the extra dimension come from?** Not from "models against knowledge" as such, but from
the **size of the sample space**, and saying so locates the fork more precisely than either essay
does. (i) distributes over a two-outcome partition of one sentence, which is one free parameter; (ii)
over four statuses, which is three, of which two are reported.

And (i) cannot simply enlarge its sample space, for a structural reason worth stating exactly: **a
completion decides every sentence, so "independent" is never an outcome under (i).** Independence is
not a point of (i)'s space; it is a property of the *support* of $\mu$, namely that $[\varphi]$ and
its complement both have positive measure. (i) puts the meta-fact in the **spread**, (ii) puts it in
the **sample space**. That single difference generates the whole dimension gap, and it is the honest
one-line statement of the fork.

**A caution against over-reading the containment.** It is a fact about $(z,r)$ pairs, not about
meanings. An (i)-state with $z = r = 0.4$ (that is, $\mu([\varphi]) = 0.7$) lands on the (ii)-state
$(p_{\text{pr}}, p_{\text{open}}) = (0.4, 0.6)$, whose reading is "40 % chance the agent holds a
proof". Those are not the same claim, and this file does not claim (i) reduces to (ii). In (ii)'s
coordinates, $r = \lvert z\rvert$ holds exactly when $p_{\text{ind}} = 0$ and
$\min(p_{\text{pr}}, p_{\text{rf}}) = 0$, so (i)'s image is the pair of lower edges of the report
triangle, and (i)'s "independent, evenly split" lands on (ii)'s **open**. The collapse of §2.3 is
visible right there in the coordinates.

## 2.2 The §7.3 thesis survives under (ii) and dies under (i)

`logic-bloch-poles.md` proposed that Bloch-valued truth is a **report format**, the pair (truth lean
$z$, determinacy $r$) with $\lvert z\rvert \le r$. (i) argues the pair collapses to one number; (ii)
argues it does not. **Each is right about its own reading**, so the thesis stands or falls with the
fork rather than independently, exactly as that essay's own item 12 anticipated.

One correction that matters to both. The constraint $\lvert z\rvert \le r$ is **not a Bloch fact**.
Under (ii) it is derived from the simplex, $\lvert a-b\rvert \le a+b \le a+b+c$, so "the geometry
enforces it for free" is backwards as an argument for the ball: the simplex enforces it for free
*and derives it*, while the ball happens to satisfy the same inequality for an unrelated reason (a
component never exceeds a norm). Two facts that coincide numerically and share no proof are not
evidence for identifying the objects. (ii) §2.2 calls the coincidence "the soundest thing in the
essay"; read straight it is the reason the ball is *unnecessary*, since the cheaper object already
has the property.

## 2.3 "I have not checked yet": decisive for (ii), and logical induction is not (i)'s rescue

(i) states its own fatal limit at full strength: a coherent measure assigns probability 1 to every
theorem, so it models *independence* and never *ignorance*. Its offered answer is the
logical-induction framing: the computable object is the *sequence*, the coherent measure only its
*limit*.

**That is a good framing and it is not a rescue, for a reason (i) does not state.** A logical
inductor's belief state at finite time is **incoherent**: it may price $\varphi$ and $\neg\varphi$ at
$0.3$ each. An incoherent assignment corresponds to no measure over completions, by the very Stone
correspondence (i) rests on. So a finite-time inductor is not in a type-(i) state at all, and "(i)
plus a convergent sequence" is not (i) with a dynamics; it is (i) plus a *different* object. Naming
the limit does not give the limit a state for the machine's present condition, which is what the
application needs.

The operational form is the sharpest single fact in this adjudication:

$$
\mathrm{ModelsReach}(z,r) \wedge z = 0 \;\Longrightarrow\; r = 0
\veq{models-collapse}\lean
$$

`models_z_zero_forces_origin`. Under (i), unproved forces maximally-ignorant, so the scheduler's two
cases are the same point; under (ii) they are the two ends of the $z=0$ radius
(`status_z_zero_free`). Judged against the owner's stated application that is decisive, by a theorem
rather than by taste.

The honest counterweight, which deserves its weight: **(i) has the better account of what $z$
means.** Under (i), $z = 2\mu([\varphi]) - 1$ is a measure of a set of completions, and $z = \pm 1$ is
not a labelling convention but the statement that the theory decides the sentence, for every measure
at once. Under (ii), $z$ is agent-relative and the label $p(\text{true}) = (1+z)/2$ is a misnomer.
**The resolution recommended here is not to split the difference but to re-type the loser**: (i) is
not a rival state space, it is the *semantics the report must be sound against*. For a sound agent
over a consistent theory, holding a proof implies the sentence holds in every weighted completion, so
(ii)'s report constrains (i)'s $z$ without being it. The map from (ii) to (i) is soundness, and it is
a map rather than an identity, which is exactly why the two reachable sets differ. That relation is a
proposal and is **not** formalised in the Lean file.

## 2.4 The simplex convergence, taken seriously and then deflated

The convergence is the most important thing in the pair, and it is broader than the pair.

| Essay | Route to the simplex |
|---|---|
| (i) §3.1 | a Boolean algebra is commutative, and a unital C\*-algebra's state space is a Bauer simplex iff commutative |
| (ii) §6 | the four statuses are exclusive outcomes of one distribution, so a classical four-outcome model reproduces everything, entropy included |
| [`logic-qutrit-su3`](logic-qutrit-su3.md) §2 | its $\lvert n_3\rvert + p_{\text{undec}} \le 1$ is derived on the diagonal plane, where "positivity is just $p \ge 0$ componentwise": that plane is a 2-simplex |
| [`logic-beyond-su3`](logic-beyond-su3.md) §0 | stated outright: "a classical 2-simplex suffices and the SU(3) apparatus is unnecessary" |

The qutrit row deserves a line more, because the unification is exact and neither essay states it.
(ii)'s cone constraint is $\lvert z\rvert + p_{\text{ind}} \le 1 - p_{\text{open}}$; set
$p_{\text{open}} = 0$ and it *is* the qutrit inequality. **The qutrit's diagonal body is (ii)'s status
simplex with the ignorance vertex deleted.** The qutrit essay's genuine SU(3) result is the separate
"not a ball" witness; its headline inequality never needed SU(3).

**Now the deflation, because the convergence is weaker as evidence than it looks.** These are not
four independent theorems. They are one theorem, "a commutative or exclusive outcome structure has a
simplex state space", applied four times. What is genuinely independent is the *hypothesis check*:
four routes each looked for a non-commuting pair of questions about a sentence and none found one.
That is the load-bearing observation, and it is the one worth attacking, because a single named pair
of incompatible questions would restore the ball and overturn all four at once.

The convergence also does **not** settle the fork, and should not be allowed to pretend to. Both
readings are commutative, both give simplices, so the Bauer argument is not an argument for (i) over
(ii) even though (i) quietly presents it as one. It is an argument against the **ball**, under either
reading.

---

# 3. The encoding-(b) convergence does not survive checking

`logic-epistemic-state.md` item 8 calls it "the strongest signal in the cluster": two essays reaching
`logic-bloch-poles.md`'s encoding **(b)**, `provable` against `not provable`, from opposite premises.
Convergence from opposite assumptions would be strong evidence. Neither essay reaches it.

Encoding **(a)** is `proven true` against `proven false`, exclusive but not exhaustive because an
independent sentence maps to neither pole. Encoding **(b)** is `provable` against `not provable`,
exclusive and exhaustive, paying the cost that its south pole **conflates refutable with
independent**. That cost is the test, and it is easy to apply.

- **Under (i):** $z = -1$ means $\mu([\varphi]) = 0$, so $\varphi$ fails in every weighted
  completion, which for a full-support measure is $T \vdash \neg\varphi$. The south pole is
  **refutable**, and an independent sentence sits strictly inside the segment. Encoding (a).
- **Under (ii):** $z = -1$ means $p_{\text{rf}} = 1$, "the agent holds a refutation". The south pole
  is **refuted**, and an independent sentence sits at $(0,1)$ on the equatorial circle, per
  `vertex_coords`. Encoding (a).

Neither south pole conflates refutable with independent, so neither is encoding (b). What (ii)
establishes in its cost 2 is that its axis measures **provedness rather than truth**, which is a
relabelling of encoding (a)'s poles from "proven true / proven false" to "proved / refuted", and
encoding (a) already said that.

**So the convergence is a shared inheritance of the word "provability" from the parent essay, not an
independent arrival at its encoding.** The evidential weight the cluster has assigned to it should be
withdrawn. What survives, and is worth keeping, is the weaker shared finding both essays genuinely do
reach by different routes: **the $z$-axis is about provability, not truth** -- under (i) because
truth is model-relative, under (ii) because a sound agent's proof-holding lean is only a lower bound
on truth-lean. That much is real and independent. It just is not encoding (b).

---

# 4. The owner's own question dissolves the argument that produced encoding (b)

This is the adjudication's main positive finding, and it answers his question most directly.

`logic-bloch-poles.md` §0: "Two antipodal poles are the two outcomes of one sharp measurement, so an
encoding must assign each epistemic status to one of exactly two outcomes. There are three statuses
[...] and there is no injection from three things into two." The pigeonhole is machine-checked there
as `no_two_pole_encoding`, and **the Lean theorem is correct and is not disputed here.**

The inference from it carries a premise: *every status must be assigned to a pole*, that is, to an
outcome of one sharp measurement. The owner's 2026-09-07 instruction retracts exactly that premise.
"Don't just consider pure states but also mixed ones" says the targets are **states**, and the space
of states is not a two-element set. Three things fit into it comfortably:

$$
\text{provable} \mapsto (1,1),\qquad
\text{refutable} \mapsto (-1,1),\qquad
\text{independent} \mapsto (0,1)
\veq{pigeonhole-dissolved}\lean
$$

injective, with all three images admissible (`enc_injective`, `enc_lands`). Nothing is conflated and
nothing is dropped, so the cost encoding (b) was chosen to pay does not have to be paid.

Three qualifications, so this is not read as more than it is. **It does not show encoding (b) is
wrong**, only that one argument for it lapses; (b)'s operational argument, that "does a proof search
halt with a proof" is a two-outcome procedure a machine can actually run while "is it true" is not,
is untouched. **It is available to (ii) and not to (i)**, since the image of `independent` is exactly
the point (i)'s reachable set excludes (`enc_independent_not_models`). And **all three encoded
statuses sit at $r = 1$**: the theory-relative trichotomy has no fourth member for an agent's
ignorance, which is why the fourth vertex and the whole interior are (ii)'s contribution.

Related, and worth recording: the parent essay argues that "proven independent" cannot sit at the
centre, because proving independence is an achievement and should not be the state of maximal
ignorance. **That judgement is vindicated by (ii), and vindicated at the circle rather than at a
pole.** The parent then concluded that a single qubit cannot carry it and reached for two qubits and
Belnap-Dunn; under (ii) one coordinate pair carries it at $(0,1)$ without a second qubit. Its item 3
recommendation is therefore competing with a cheaper answer, and its own §3.1 already found the ball
cannot represent Belnap's glut anyway.

---

# 5. The container: the ball is not it, and what to keep

Everything above points one way, and it should be said plainly. **The report the construction wants
is a point of a triangle.** The admissible pairs form $\{\lvert z\rvert \le r \le 1\}$, a triangle
with vertices $(1,1)$, $(-1,1)$, $(0,0)$, which is a 2-simplex. Under (ii) it is the affine image of
the status 3-simplex, and the map is onto: given admissible $(z,r)$, take
$p_{\text{pr}} = \tfrac{\lvert z\rvert + z}{2}$, $p_{\text{rf}} = \tfrac{\lvert z\rvert - z}{2}$,
$p_{\text{ind}} = r - \lvert z\rvert$, $p_{\text{open}} = 1 - r$.

**And the ball's $(z,r)$ shadow is exactly that same triangle**, checked both directions: every
admissible pair is realised by a genuine Bloch triple, and no Bloch triple reports outside the wedge.

$$
\exists\, b,\ b_z = z \wedge \lVert b\rVert = r
\quad\text{for every }(z,r)\text{ with } \lvert z\rvert \le r \le 1
\veq{ball-shadow}\lean
$$

`ball_shadow`, `shadow_sound`. So the ball and the triangle carry the same report, and everything the
ball has beyond the triangle is the azimuth. On the azimuth the cluster is unanimous by four
independent routes: [`logic-bloch-gates.md`](logic-bloch-gates.md) machine-checks that no
rotation-covariant order on the equator exists; [`logic-bloch-phase.md`](logic-bloch-phase.md) tests
six candidate meanings and finds three routes landing on $\{\pm 1\}$ rather than on a circle; (i)
finds the phase undefined on its whole reachable set; (ii) finds the report map's fibre is an
interval while the ball's is a circle. **The ball is a 3-dimensional object of which the construction
uses 2, and the third has failed four separate auditions.**

The entropy does not save it. $S = h\!\left(\tfrac{1+r}{2}\right)$ is strictly decreasing in $r$,
which (ii) correctly checks, but under (ii) it is a monotone reparametrisation of
$1 - p_{\text{open}}$ and not the entropy of anything in the model: the fine-grained Shannon entropy
of the status distribution at the origin ($p_{\text{open}} = 1$) is **zero**, while
$h(\tfrac12) = \log 2$. The quantum entropy is decoration on a coordinate that already exists, and
(ii) §3 is right that "$r$ measures whether the question is closed" is the honest reading.

**What is worth keeping.** The two-coordinate report itself: the parent's §7.3 thesis is the right
shape and only its container changes. The soundness norm, "a layer may not report more confidence
than it has settled", which is derived rather than stipulated and is *better* justified in the
triangle. The picture, if it helps: nothing stops the owner drawing a ball, since its shadow is the
right triangle; what must change is the *claims*, which have to be made about the triangle. And (i)'s
semantics, which is exact and beautiful and stops competing with (ii) once it is re-typed.

**What is worth retiring.** The claim that the object is a qubit; the azimuth; the appeal to von
Neumann entropy as if it were doing work; and, awkwardly, the name. The owner wrote "(might need a
better name)" himself. That is not authorisation to rename anything and this file does not. It is a
note that the container the name commits to is the part the evidence is against, and he may want to
know that before the name hardens.

---

# 6. What the Lean file discharges

[`lean/LogicMerge.lean`](lean/LogicMerge.lean) compiles against the repo's pinned toolchain with
**exit code 0 and zero `sorry`**, checked by

```
cd verify && ../docs/dreamed/capped.sh -m 4G -c 100 -- \
    lake env lean --threads=1 ../docs/dreamed/lean/LogicMerge.lean
```

`#print axioms` runs in the file on all seven headline theorems and returns only `propext`,
`Classical.choice`, `Quot.sound`.

| Handle | Theorem | Content |
|---|---|---|
| `reach-differ` | `equator_separates`, `models_subset_status` | (i)'s set is properly inside (ii)'s; $(0,1)$ is in one and not the other. **The central fact.** |
| `models-collapse` | `models_z_zero_forces_origin`, `status_z_zero_free` | under (i), $z=0$ forces $r=0$; under (ii) every $r$ is available at $z=0$ |
| `diag-norm` | `diag_nrm_eq_abs_z`, `modelReport_mem` | (i)'s diagonality and segment, re-derived |
| `four-corners-check` | `vertex_coords` | (ii)'s four statuses at $(1,1)$, $(-1,1)$, $(0,1)$, $(0,0)$: **confirmed** |
| `conflation-check` | `report_conflates`, `independent_is_midpoint` | (ii)'s stated cost: **confirmed**, with independence the midpoint of the top edge |
| `pigeonhole-dissolved` | `enc_injective`, `enc_lands`, `enc_independent_not_models` | three statuses inject into the report triangle; available to (ii), not to (i) |
| `josang-gap` | `josang_gap`, `josang_eq_iff`, `josang_ne_at_independent` | (ii) §7's identification of Jøsang's $u$ with $1-r$ is **wrong**; they agree iff $p_{\text{ind}} = 0$ |
| `ball-shadow` | `ball_shadow`, `shadow_sound` | the wedge is exactly the ball's $(z,r)$ shadow, both directions |

**What it does not prove, and says so in its header.** Nothing about quantum mechanics: `Bloch` is
three reals with no positivity, no trace and no Hilbert space, and the identification of
$h((1+r)/2)$ with a von Neumann entropy is asserted in prose across the whole cluster and proved
nowhere in this repo. Nothing about Goedel, Cohen, Stone duality or measure theory: `Status.ind` is a
real number, and the countability and atomlessness of PA's Lindenbaum algebra is (i)'s §1 prose,
still the largest unformalized load-bearing step in the cluster. Nothing about Bauer or C\*-algebras.
And **nothing that decides the fork**. Two things in this essay are also *not* machine-checked and
should be read as prose: the soundness re-typing of §2.3, and the §3 identification of each essay's
poles with encoding (a), which is an argument about what coordinates mean.

---

# 7. The owner's question, answered in his terms

**Yes to both, with three qualifications, and the two answers are one answer.**

**The equator can be unprovedness, but the honest locus is the $z=0$ radius, not the equatorial
disc.** "Neither proved nor refuted" is $p_{\text{pr}} = p_{\text{rf}} = 0$, giving $z = 0$ and
$r = p_{\text{ind}}$, so unprovedness occupies the segment from the origin out to the circle,
sweeping every $r$. The equatorial *disc* is the correct characterisation of the weaker property
$p(\text{true}) = \tfrac12$, exactly and not approximately, and both essays are right about that. But
the disc is mostly unreachable, since the azimuthal directions are never produced by either reading.
In the report triangle the whole of unprovedness is the vertical median from $(0,0)$ to $(0,1)$,
which is a cleaner picture than a disc most of which is empty.

**The origin can be maximum non-knowledge, and it is not a separate choice.** $\lvert z\rvert \le r$
forces $r = 0 \Rightarrow z = 0$, so the origin lies on the equator necessarily; both essays state
this and it is right. Its content depends on the fork, and the phrase he used picks a side: under
(ii) the origin is `open`, the agent holds nothing, which is *exactly* maximum non-knowledge; under
(i) the origin is "the completions split evenly", which is not non-knowledge at all but a precise
fact about a measure. **His own words favour (ii)**, independently of either essay's argument.

**The third qualification is the one to weigh.** The circle at $r=1$, $z=0$ has two inhabitants and
they are different things: a Cohen-style independence proof, and an agent certain the theory decides
the sentence with no idea which way. The two-number report cannot tell them apart, and this is
machine-checked, not conjectured. So "the equator is unprovedness" is true of the *disc* in the weak
sense, true of the *radius* in the strong sense, and **not injective at the circle**. Whether that
matters is an application question: for a scheduler choosing between "stop" and "guess", it matters a
lot.

**And the extension he asked for delivered more than a picture.** Admitting $r<1$ is what makes three
statuses fit without conflation (§4), what separates "proved undecidable" from "not yet looked"
(§2.3), and what shows the ball's third dimension to be unused (§5). The instruction to consider
mixed states was the productive move in this whole cluster.

---

# 8. Recommendation, with its weaknesses in the same breath

**Recommended: build the construction on (ii), in the report triangle, and re-type (i) as the
semantics rather than as a rival state space.** Three moves, the first much bigger than the others.

1. **The state is a distribution over epistemic statuses of one sentence for one agent.** Chosen
   because the stated application is a bounded reasoner reporting to a decidable core, and because
   the one distinction that application needs is provably absent from (i).
2. **The container is a simplex, not a ball.** Status space $\Delta^3$; report the 2-simplex
   $\{\lvert z\rvert \le r \le 1\}$. The ball's shadow is that triangle exactly, so nothing is lost,
   and the azimuth has failed four auditions.
3. **(i) is kept, as soundness.** Sentences as clopen sets and $z$ as a measure of completions is the
   exact account of what a theory determines; a sound agent's report constrains it. The two objects
   have different reachable sets precisely because the map between them is soundness, not identity.

**The weaknesses, at full strength.**

- **The Goedel picture is the price.** Under (ii) incompleteness supplies one vertex's inhabitation
  and nothing else, and the geometry is unchanged if the theory is Presburger and that vertex is
  empty. If concretely picturing incompleteness is what Bloch Truth is for, this recommendation is
  wrong and (i) wins.
- **The two-number report is arguably insufficient for the very application used to justify it.**
  `report_conflates` is real. If the owner rules that separation essential, the report becomes three
  numbers, the object becomes $\Delta^3$, and the geometry disappears entirely.
- **The pigeonhole finding is narrower than it may read.** It shows one argument for encoding (b)
  lapses under mixed states, not that (b) is wrong.
- **Retiring the ball retires the name's own object.** "Bloch Truth" would contain no Bloch sphere.
  His own "(might need a better name)" is the only evidence this is tolerable, and it is not
  authorisation.
- **Neither reading gets its measure for free.** (i) needs a $\mu$ that is neither canonical nor
  computable; (ii) needs a distribution nothing supplies either. (ii) is better off only in that a
  running system plausibly has access to the state of its own proof search, which is an engineering
  claim, not a theorem.
- **The evidence base is two adversarial essays and one adjudicator.** The arithmetic checks are
  elementary and machine-checked, which is where confidence should be highest. The prior-art findings
  rest on a delegated search of primary sources, and §3's encoding argument is prose about what
  coordinates mean, which is where confidence should be lowest and where an owner reading is most
  likely to overturn this file.

---

# 9. Surfaced for the owner

Each item is a located claim plus the ruling it needs. **None is decided, and none has been written
into `TODO.md`, `ROADMAP.md` or `REVIEW_ME.md`.**

1. **The fork: build on (ii), in a simplex.** Located: §0, §8. **Ruling needed:** accept, reject in
   favour of (i), or rule that both are kept as two objects with two jobs and a soundness map between
   them. The last is the option this file thinks most likely right if the recommendation is wrong.

2. **The decisive fact against (i) for the stated application.** Located: §2.3,
   `models_z_zero_forces_origin`. Under (i), $z=0$ forces $r=0$, so "I proved this is undecidable
   here" and "I have got nowhere yet" are the same point. **Ruling needed:** confirm that the layered
   core's scheduler genuinely needs that distinction. If it does not, the strongest argument in this
   file evaporates and (i)'s exactness becomes the better buy.

3. **The claimed encoding-(b) convergence is not real, and two documents should be corrected.**
   Located: §3. Under (i) the south pole is `refutable`, under (ii) `refuted`; neither conflates
   refutable with independent, so neither is encoding (b). **Ruling needed:** confirm the reading,
   and if confirmed withdraw the "strongest signal in the cluster" claim at `logic-epistemic-state.md`
   item 8 and adjust the `README.md` row for `logic-bloch-poles`. This is the finding most worth
   attacking.

4. **The pigeonhole that produced encoding (b) is dissolved by his own question.** Located: §4,
   `enc_injective`. `no_two_pole_encoding` is correct; the inference to (b) needs the premise that
   every status sits at a pole, and "consider mixed ones too" retracts it. **Ruling needed:** whether
   (b) is retained on its surviving operational argument, or whether encoding (a) plus a populated
   interior is now preferred. This reopens `logic-bloch-poles.md` item 1, which is why it is put to
   him rather than acted on.

5. **The ball is the wrong container, and the evidence is four-fold.** Located: §2.4, §5,
   `ball_shadow`. **Ruling needed:** accept the simplex as the container, or name a pair of questions
   about a sentence that cannot be answered simultaneously. A single named pair would restore the
   ball and overturn all four essays at once, which is why the request is put this way round.

6. **`id:4bb2`: one thesis recommended, and it is (ii)'s, amended.** Located: §5, §8, and
   `logic-epistemic-state.md` §9. `TODO.md` records the item BLOCKED for want of a thesis. The
   recommendation:

   > *Bloch-valued truth is the report an incomplete reasoning layer hands a decidable core about its
   > own proof search.* The state is a distribution over the epistemic statuses **proved, refuted,
   > independent, open** of one sentence for one agent; $z = p_{\text{pr}} - p_{\text{rf}}$ is the
   > truth lean, $r = 1 - p_{\text{open}}$ the settledness, and the constraint $\lvert z\rvert \le r$
   > is **derived from the simplex** rather than stipulated. The report lives in a 2-simplex, not a
   > ball. The core reasons about a pair of reals, which is decidable, instead of about the sentence,
   > which is not.

   The two amendments to (ii)'s version are the container and the explicit statement that the
   constraint is derived. `logic-bloch-poles.md` §7.3's version is the same thesis with the crucial
   question ("a state of what?") left open, so it is an earlier draft rather than a rival.
   **Ruling needed:** whether this is the thesis, a near miss, or wrong. Nothing has been written to
   any ledger and the item stays BLOCKED until he rules. Standing risk: if ruling 7 goes the other
   way, the thesis needs a third number and this wording fails.

7. **The conflation may be disqualifying, and it is the ruling most likely to overturn item 6.**
   Located: §1.3, `report_conflates`. The report cannot separate proved independence from a
   known-fair coin, and the failure is to a *classical* four-outcome model, not to (i). **Ruling
   needed:** accept a two-number report that identifies "stop asking" with "guess", or require the
   third simplex coordinate, in which case the object is $\Delta^3$ and no two-dimensional geometry
   survives.

8. **A located arithmetic error in `logic-epistemic-state.md` §7, in that essay's own disfavour.**
   Located: §1.4, `josang_gap`. Jøsang's $u = p_{\text{ind}} + p_{\text{open}}$ while
   $1-r = p_{\text{open}}$; they agree only when the independence weight is zero. (ii) **is**
   subjective logic with $u$ split in two, which is exactly the separation it exists to make.
   **Ruling needed:** none on the mathematics, but its self-assessment as "a geometric repackaging,
   not a new epistemology" is too harsh by one coordinate.

9. **A misattributed citation in `logic-models-ensemble.md` §4.2 and §7 C3.** Located: §1.4. The
   result is **Sawin and Demski (2013)**, not Demski (2012), whose own prior is *coherent and
   computably approximable*. **Ruling needed:** none; a repair, and C3's substance survives it. The
   essay flagged the claim as reported-from-summaries, so the flag worked.

10. **Vol 2012 is weaker prior art than `logic-models-ensemble.md` §7 C6 says.** Located: §1.4.
    Diagonality there is a stipulation, the scope is propositional and many-valued logic, and the
    paper has zero citations. **Ruling needed:** none, but "our strongest structural claim is a
    rediscovery" should soften to "someone reached the same representation by stipulation, in a
    different subject".

11. **The qutrit essay's headline inequality is a simplex fact, and the unification is exact.**
    Located: §2.4. Its diagonal body **is** (ii)'s status simplex minus the `open` vertex. **Ruling
    needed:** none on the mathematics, but `logic-qutrit-su3.md`'s presentation of that inequality as
    an SU(3) result should probably be re-scoped; its genuine SU(3) result is the "not a ball"
    witness.

12. **The one thing that would overturn everything, and nobody has offered it.** Located: §2.4. Every
    route to "the object is a simplex" runs through the same hypothesis: no pair of questions about a
    sentence is incompatible. **Ruling needed:** whether he can name such a pair. He is the only
    person who can, since it is a modelling decision about what a sentence's other observable
    properties are, and the whole ball rests on it.

---

# A future `.mw` sketch

Sketch of intent, not a runnable mirror; these are Lean-tier claims and route to the Lean backend.

```computation
# handle: reach-differ. The two sibling essays describe different sets.
ModelsReach(z, r) = And(Eq(Abs(z), r), Le(r, 1))
StatusReach(z, r) = And(Le(Abs(z), r), Le(r, 1))
containment       = Implies(ModelsReach(z, r), StatusReach(z, r))
separates         = And(StatusReach(0, 1), Not(ModelsReach(0, 1)))
```

```computation
# handles: models-collapse, pigeonhole-dissolved.
collapse = Implies(And(ModelsReach(z, r), Eq(z, 0)), Eq(r, 0))
free     = Implies(And(Le(0, r), Le(r, 1)), StatusReach(0, r))
enc      = {provable: (1, 1), refutable: (-1, 1), independent: (0, 1)}
fits     = And(Injective(enc), ForAll(t, StatusReach(enc[t])))
```

```computation
# handles: josang-gap, ball-shadow.
josangU         = ind + open
agree_iff       = Equivalent(Eq(josangU, 1 - r), Eq(ind, 0))
shadow_complete = Implies(StatusReach(z, r),
                          Exists(b, And(Eq(b.z, z), Eq(norm(b), r))))
shadow_sound    = Implies(Le(norm(b), 1), StatusReach(b.z, norm(b)))
```

# Follow-up leads

1. **Formalise the soundness map from (ii) to (i).** §2.3 proposes it in prose and the Lean file does
   not touch it: for a sound agent over a consistent theory with a full-support measure,
   $p_{\text{pr}} > 0 \Rightarrow \mu([\varphi]) = 1$. If it exists cleanly, the fork becomes a
   two-object construction with a morphism and item 1's third option is the right ruling.
2. **Build the three-number report and see whether any geometry survives.** Item 7, and
   `logic-epistemic-state.md`'s own lead 2.
3. **Repair the two citations.** Items 9 and 10. Both are edits to sibling essays, both cheap, both
   his to authorise.
4. **Attack §3.** The encoding-(a)-not-(b) reading is the least machine-checked argument here.
   Cheapest attack: for each essay, write down what sentence sits at $z=-1$ and check whether an
   independent sentence can.
5. **Ask what happens if he names an incompatible pair.** Item 12. It is the one input that would
   reverse four essays at once, and none of them asked for it directly.

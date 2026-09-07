---
title: The state is a state of knowledge
permalink: /dreamed/logic-epistemic-state
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This file *proposes*; the owner disposes. Nothing here is toesnail theory, and nothing may be
> promoted into `physics/` or `essays/` without the owner authoring the move himself. The `\veq`
> badges below claim something about
> [`docs/dreamed/lean/LogicEpistemic.lean`](lean/LogicEpistemic.lean) **only**, and are
> deliberately not wired into `physics/*.toml` or `tests/test_verify.sh`.
>
> **This essay argues one side of a deliberate fork and is not neutral.** A sibling agent argues
> the other side in `logic-models-ensemble.md`, and a third adjudicates. Read the two together.
> Section 8 is this essay's own list of what its position costs, written so the adjudicator does
> not have to find those costs unaided.

## Provenance

The seed is the owner's standing side project **"Bloch Truth"**, and specifically a question he
asked on 2026-09-07 while reading the sibling essay
[`logic-bloch-poles.md`](logic-bloch-poles.md):

> can the equator be considered any kind of "unprovedness" instead, and the origin as maximum
> non-knowledge? don't just consider pure states but also mixed ones, i.e. Bloch with $r<1$ as well

That question has a clean partial answer and then forks. The clean part first, because it settles
one thing before the argument starts. Writing $\rho = \tfrac12(I + \mathbf{r}\cdot\boldsymbol\sigma)$
for a qubit density matrix:

- The equatorial **disc** $\{z = 0,\ r \le 1\}$ is *exactly* the set of states with
  $p(\text{true}) = \tfrac{1+z}{2} = \tfrac12$. So "unproved", read as "the truth question comes
  back fifty-fifty", is an exact characterisation of the disc and not an approximation.
- $|z| \le r$ always, so $r = 0 \Rightarrow z = 0$: **the origin lies on the equator
  necessarily.** The owner's two suggestions are therefore not two independent design choices.
  The second follows from the first.
- $S(\rho) = h\!\big(\tfrac{1+r}{2}\big)$ is maximal exactly at $r = 0$, so "maximum
  non-knowledge" at the origin is right in the one sense entropy can certify.

The fork is not about any of that. It is about **what the density matrix is a state OF**, and the
two answers give the same geometry completely different content:

| | (i) a state over **models** | (ii) a state over **epistemic status** |
|---|---|---|
| The randomness is over | which model of the theory obtains | what the agent has established |
| A sentence's state is | $\mu(\{M : M \models P\})$ against $\mu(\{M : M \models \neg P\})$ | the agent's weights on proved / refuted / independent / open |
| Every such state is | **diagonal**, so the ball collapses to the $z$-axis | not necessarily diagonal in the truth basis |
| Low entropy means | the models agree | the agent has settled the matter |
| Goedel enters as | the reason the ensemble is mixed | the reason the *independent* status is inhabited |

**This essay argues (ii).** Its case rests on a single observation about the owner's own words,
made in §1, and everything after that is bookkeeping and honesty.

The seed conversations, all owner-authored where quoted:

| Export | Date | What it contributes here |
|---|---|---|
| `conv-falsifiability.md:116` | 2025-08-16 | the origin / equator question the 2026-09-07 turn revisits |
| `conv-falsifiability.md:366` | 2025-08-16 | **the status enumeration**, which is §1's whole argument |
| `conv-peano.md` | 2025-07-24 | sentences "both true and false, or neither" |
| `conv-ternary.md` | 2026-03-31 | the Bloch radius proposed as a *calibrated uncertainty* signal |
| `2025-08-05_breaking_project_paralysis_cbae6cd6.md:1334` | 2025-08-08 | the intended application: the logic core of a layered AI |

# 0. The headline, stated and not teased

**Direction (ii) delivers the separation it was chosen for, and the essay verified it rather than
assuming it, but it delivers a weaker version than the fork's framing promised.** Precisely:

1. **What holds.** Define the state as a distribution over four mutually exclusive statuses --
   proved, refuted, **independent**, open -- with truth lean $z = p_{\text{pr}} - p_{\text{rf}}$
   and settledness $r = p_{\text{pr}} + p_{\text{rf}} + p_{\text{ind}}$. Then the four statuses
   land at $(z,r) = (1,1)$, $(-1,1)$, $(0,1)$, $(0,0)$: north pole, south pole, **equatorial
   circle, origin**. Both middle rows are "unproved", both have $z = 0$, and $r$ alone separates
   them. Machine-checked as `vertex_coords`.
2. **The constraint is derived, not imposed.** $|z| \le r$ falls straight out of the simplex,
   because $|p_{\text{pr}} - p_{\text{rf}}| \le p_{\text{pr}} + p_{\text{rf}} \le r$. The Bloch
   ball enforces exactly that constraint for free and an unconstrained pair of reals does not.
   This is the strongest structural argument in the essay and it is `abs_z_le_r`.
3. **What does NOT hold, and the essay found it by trying to prove the opposite.** The equatorial
   circle is *not* "proved independent". It is "settled but unlocated", and it has a **second
   inhabitant**: an agent who is certain the theory decides the sentence and has no idea which way
   also sits at $(0,1)$. Machine-checked as `report_conflates`. That second inhabitant is
   Ellsberg's known-fair-coin, and the failure to separate it from a Cohen-style independence
   proof is a real loss, stated in full in §4.
4. **The one thing (ii) buys that (i) provably cannot.** Under (i) every state is diagonal, so
   $r = |z|$ and the accessible set is a **one-dimensional segment**. Under (ii) the accessible
   set is the **two-dimensional wedge** $\{|z| \le r \le 1\}$. Independence and openness are the
   same point under (i) -- the centre -- and different points under (ii). §9 argues that this one
   distinction is precisely what a layered reasoner's scheduler needs, which makes (ii) the
   reading that serves the owner's own stated application.
5. **The bill.** (ii) severs the model-theoretic reading, and with it the concrete Goedel picture.
   It also makes $z$ agent-relative rather than a fact about the sentence, and it makes the natural
   dynamics **non-unitary**, which puts it at odds with the whole gate analysis in
   [`logic-bloch-gates.md`](logic-bloch-gates.md). §8 prices all three.
6. **The quantum structure is not needed.** A classical four-outcome distribution reproduces
   everything above, including the entropy behaviour, because the gap between "von Neumann entropy
   of $\rho$" and "Shannon entropy of the truth measurement" is reproduced exactly by the gap
   between a fine-grained classical distribution and its coarse-graining. §6 states this plainly
   because it is (ii)'s largest vulnerability and hiding it would waste the adjudicator's time.

# 1. The argument from the owner's own enumeration

The essay's case for (ii) is one sentence long, and it is his.

On 2025-08-16 he asked, at `conv-falsifiability.md:366`, verbatim:

> What states can there actually be for statements in terms of complete logic? Proven true, false,
> **probable but undetermined**, unprovable, ....?

Look at the third item. "Probable but undetermined" is not a status a sentence has relative to a
theory. It is a status a sentence has relative to an **agent**. If $P$ is provable in $T$, then $P$
is true in every model of $T$, so *any* measure over models assigns it $z = 1$ and puts it at the
north pole, whether or not a proof has ever been found. **Under reading (i), "provable but nobody
has found the proof" and "proved" are the same point, and there is no state space in which they
differ.** The distinction the owner asked for is invisible to the model-ensemble semantics, by a
theorem about soundness rather than by an oversight.

His enumeration mixes two kinds of thing, and this is the fork in embryo: "proven true" and
"unprovable" are theory-relative, "probable but undetermined" is agent-relative. Reading (ii) is
just the decision to take the whole list at face value and let the state range over all four.

The prior AI turn that answered him listed statuses in the same mixed register, and the ones it
listed under "Indeterminate States" -- "provable but undetermined", "disprovable but undetermined",
"unknown decidability", "conjectured true" -- are *all* agent-relative without exception. That turn
then jumped to "we need at least a 4-dimensional logical space", which is the wrong move; §4 shows
the dimension count is subtler and cuts against a qubit.

A second, weaker piece of textual support: in `conv-ternary.md` (2026-03-31) the owner proposed the
Bloch radius as a **calibrated uncertainty signal in a neural network**. Calibration is a property
of a predictor's beliefs. There is no model-theoretic reading of that proposal at all, so his own
later use of the radius is already agent-relative.

# 2. The sample space, four candidates, and which survive

Direction (ii) earns nothing until it says what the distribution is over. This is where the essay
is won or lost, so all four candidates are developed and two of them fail.

## 2.1 Candidate D, the plain Bayesian credence -- **fails, and instructively**

Take the state to be the agent's credence $p$ that $P$ is true. Then $\rho = \operatorname{diag}(p,
1-p)$, whose Bloch vector is $(0,0,2p-1)$, so

$$
r = |z| \qquad\text{for every credence state.}
$$

The accessible set is the $z$-axis segment. **This is geometrically identical to reading (i)**, and
that identity is worth pausing on: the naive epistemic reading and the model-ensemble reading fill
exactly the same one-dimensional set, for different reasons. So (ii) has content only if the
distribution is over something *richer* than the truth value. A credence in $P$ alone is not
richer. It is the same segment with a different label on it.

That also disposes of a QBist reading taken straight (§7): a state that is credence about the
outcome of one binary question is a point on a segment, and the ball's other two dimensions come
from the *other* questions one could ask, not from second-order uncertainty about this one.

## 2.2 Candidate A, a distribution over epistemic statuses -- **survives, and is the essay's choice**

Fix an agent, a theory $T$, and a sentence $P$. Take four mutually exclusive statuses:

| Status | Meaning | Weight |
|---|---|---|
| **proved** | the agent holds a proof of $P$ in $T$ | $a$ |
| **refuted** | the agent holds a proof of $\neg P$ in $T$ | $b$ |
| **independent** | the agent holds a proof that $T$ settles neither | $c$ |
| **open** | the agent holds nothing | $d$ |

with $a,b,c,d \ge 0$ and $a+b+c+d = 1$. Independence is a status *because it is a theorem*: Cohen's
forcing argument for CH in ZFC is a proof, held or not held like any other. That single decision is
the whole thesis, and every result below is a consequence of it rather than evidence for it.

Now define the two coordinates. The truth lean counts only the located statuses; settledness counts
every status except ignorance:

$$
z = a - b, \qquad r = a + b + c = 1 - d
$$

and the constraint is immediate, since $|a-b| \le a+b$ for non-negative $a,b$ and $c \ge 0$:

$$
|z| \;\le\; r \;\le\; 1
\veq{zr-cone}\lean
$$

**The Bloch ball's own geometry enforces exactly this** -- a component of a vector never exceeds
its norm -- for a reason that shares nothing with the argument above. That coincidence is the
soundest thing in the essay: the constraint holds on both sides of the proposed correspondence,
proved twice, once by convexity and once by Pythagoras (`abs_z_le_r`, `zc_sq_le_rsq`).

Its corollary is the answer to the second half of the owner's question:

$$
r = 0 \;\Longrightarrow\; z = 0
\veq{origin-on-equator}\lean
$$

An agent who knows nothing cannot lean. **The origin is on the equator by necessity**, so
"equator = unprovedness" and "origin = maximum non-knowledge" are one proposal and its consequence,
not two proposals (`r_zero_imp_z_zero`).

And the headline, computed rather than asserted:

$$
\text{proved} \mapsto (1,1),\quad
\text{refuted} \mapsto (-1,1),\quad
\text{independent} \mapsto (0,1),\quad
\text{open} \mapsto (0,0)
\veq{four-corners}\lean
$$

North pole, south pole, **equatorial circle, origin** (`vertex_coords`). Both middle entries are
"unproved" in the exact sense of §0: $p(\text{true}) = \tfrac12$. They differ only in $r$, and
$r$ reads as *how settled the unsettledness is*. This is what the owner's question pointed at, and
under (ii) it is where the formalism actually lands.

One more structural fact, cheap and worth having. Let $\text{dual}$ swap $a$ and $b$: it is the
agent's state about $\neg P$, since a proof of $P$ is a refutation of $\neg P$, while independence
and openness are facts about both sentences at once. Then

$$
z(\text{dual}) = -z, \qquad r(\text{dual}) = r
\veq{neg-fixes-r}\lean
$$

**Negation moves the truth lean and cannot move the settledness** (`dual_r`). The sibling essay
proves the same thing on the Belnap side as `neg_monotone_K`; here it arrives from probability
instead of from a lattice. Two independent derivations of "information is an axis negation cannot
move".

## 2.3 Candidate C, a Kripke poset of information states -- **survives, and is the deepest**

This is the strongest available connection and it deserves more than a name-check, because
intuitionistic logic's own semantics is *already* a semantics of growing information.

An intuitionistic Kripke model is a poset $(W,\le)$ of information states with a monotone forcing
relation: $w \Vdash P$ and $w \le v$ imply $v \Vdash P$. **Persistence is the axiom**, and it says
information is never retracted. A node may force neither $P$ nor $\neg P$, and that is exactly how
excluded middle fails; the reading is "not enough evidence here, a later state may settle it".
Negation is a claim about the whole future cone: $w \Vdash \neg P$ iff no $v \ge w$ forces $P$.

Three things follow that (ii) can use and (i) cannot.

**First, the sample space becomes canonical instead of stipulated.** Put a measure on the states
reachable from $w$ at some horizon. Then $a, b$ are the weights of futures in which $P$ or $\neg P$
gets forced, $d$ the weight of futures still open at the horizon, and $c$ the weight in which the
*meta*-fact of independence gets forced. The four statuses of §2.2 are not four labels chosen for
convenience; they are the four ways a forcing relation can stand at a node, once meta-facts are
admitted into the language.

**Second, persistence becomes a monotonicity law on $r$.** Along $\le$ the open weight can only
shrink, so

$$
w \le v \;\Longrightarrow\; r(w) \le r(v),
$$

while $z$ moves either way. **$r$ is a ratchet and $z$ is not.** This is the same asymmetry the
sibling found between Belnap's knowledge order and truth order, arrived at from the semantics of a
logic the owner did not have to import. It is also the structural counterpart of §2.2's
$r(\text{dual}) = r$.

**Third, it tells you when the reading breaks.** Retraction -- an agent finding an error in a proof
it held -- violates persistence, decreases $r$, and takes the state outside any intuitionistic
Kripke model. So (ii) is a *monotone-learning* semantics. An agent that can be wrong needs a
belief-revision layer, and the Bloch geometry says nothing about how to build one.

The honest limitation: Kripke semantics is purely order-theoretic. It supplies the poset and the
persistence law and no numbers at all. The measure over the future cone is an addition, and it is
the same addition (i) has to make when it picks a measure over models. Neither reading gets its
measure for free, and §7 reports one half-verified lead on numeric intuitionistic probability.

## 2.4 Candidate B, a distribution over future knowledge states -- **subsumed**

"Where will the agent be in a year" is candidate C with the poset flattened to a horizon, so it
adds nothing that C does not already carry, and it loses the persistence law. It is mentioned only
because it is the form the idea usually takes informally, and because it makes clear that the
*status* space of candidate A is what one gets by asking what a future knowledge state can look
like. A and C are the same proposal at two levels of resolution.

# 3. What $r$ measures, exactly

The claim under test is "$r$ measures how settled the agent is". Two things have to be true for
that to be more than a slogan.

**It has to be monotone.** For a qubit with Bloch radius $r$ the eigenvalues are
$(1 \pm r)/2$, so the von Neumann entropy is the binary entropy

$$
S(r) = h\!\left(\frac{1+r}{2}\right), \qquad
S \text{ strictly decreasing on } [0,1]
\veq{entropy-anti}\lean
$$

`settledEntropy_strictAntiOn`, imported from Mathlib's `binEntropy_strictAntiOn` with the change of
variable done here. **Strictness is the load-bearing half**: without it there could be a range of
radii that all mean the same amount of settledness, and the coordinate would be a rank rather than
a measure. With it, $r$ and $S$ are order-isomorphic on the admissible range and either may be
quoted. The endpoints are $S(0) = \log 2$, one full bit of ignorance at the origin, and $S(1) = 0$
anywhere on the surface -- **including on the equator**, which is precisely the separation of
"settled" from "true" that (ii) exists to make.

**It has to measure the right thing.** Under candidate A, $r = 1 - d$ is the total weight on
settled statuses, and $S$ is a function of it. So the answer is: $r$ measures *the probability that
the agent has established something*, and the entropy is a monotone reparametrisation of that
probability. It does not measure how much evidence, how strong the belief, or how many bits of
proof. It measures whether the question is closed.

That is a narrower reading than "how settled" suggests in English, and it is the honest one.

# 4. The cost inside the headline: the circle has two inhabitants

The essay tried to prove that the equatorial circle *is* proved-independence, and it is not. The
obstruction is a dimension count and it is worth stating exactly.

The status simplex $\Delta^3$ is three-dimensional; the report $(z,r)$ is two-dimensional; so the
report map discards exactly one dimension. What it discards is meaningful. Fix $z$ and $r$; the
fibre is the interval $a+b \in [\,|z|,\ r\,]$, with $c = r - (a+b)$. The two ends of that interval
are recognisably different epistemic situations, and at $z = 0$, $r = 1$ they are:

$$
\underbrace{(0,0,1,0)}_{\text{proved independent}}
\quad\text{and}\quad
\underbrace{(\tfrac12,\tfrac12,0,0)}_{\text{certainly decided, no idea which way}}
\quad\text{both report } (z,r) = (0,1)
\veq{conflation}\lean
$$

`report_conflates`. Stated affinely, the report map $\Delta^3 \to \{|z| \le r \le 1\}$ is an affine
surjection onto a triangle whose three **extreme** points are proved, refuted and open --
**independence is not an extreme point of the report triangle**, it is the midpoint of the top
edge, which is exactly why a mixture of proved and refuted reaches it.

So the headline survives in this form and no stronger:

> The equatorial **disc** is "unproved"; the equatorial **circle** is "unproved **and settled**";
> the origin is "unproved and **unsettled**". Proved independence is on the circle. It is not
> alone there.

Two consequences.

**The second inhabitant has a name in the economics literature, and it is the classical form of the
same distinction.** "Certainly decided, no idea which way" is a known-fair coin; the origin is an
urn of unknown composition. Ellsberg (1961) calls the pair **risk versus ambiguity**, and the
Ellsberg paradox is the demonstration that people treat them differently, in violation of the
Sure-Thing Principle. So the axis (ii) adds to the truth axis is the risk/ambiguity axis, which is
a real and long-studied distinction. What (ii) does *not* deliver is a third separation, between
ambiguity-free balanced evidence and metamathematical independence.

**If independence must be an extreme point, the qubit is the wrong object.** Extreme points survive
affine isomorphism, so any faithful home for four irreducible statuses needs four extreme points,
and the Bloch ball has a continuum of them arranged as a sphere. That is a 3-simplex, which is a
classical four-outcome distribution -- or, if one insists on a quantum object with the right
convex-geometric shape, a **qutrit-like body**, which is the sibling
[`logic-qutrit-su3.md`](logic-qutrit-su3.md)'s subject. A striking convergence, offered as an
observation and not as a theorem: that essay derives $|n_3| + p_{\text{undec}} \le 1$ for the
qutrit Bloch body (its §2, and its `logic-qutrit-su3.md:204`), and the epistemic simplex satisfies
the identical inequality, since $|a-b| \le a+b = 1 - c - d$ gives $|z| + c \le 1 - d \le 1$. The
same shape of constraint appears on both sides. The bodies are not thereby shown to coincide -- the
qutrit body is eight-dimensional and the epistemic simplex is three-dimensional -- and the essay
does not claim they do.

# 5. Why a qubit at all: the objection answered, and half conceded

The objection in full: four statuses is a four-outcome classical distribution, which lives in a
3-simplex, so where does the ball come from and what does the off-diagonal structure buy?

**Conceded.** No affine isomorphism $\Delta^3 \to$ Bloch ball exists, by the extreme-point argument
of §4. The simplex is not a ball and no map between them is constructed anywhere in this cluster.
The qubit is not forced by (ii) and the essay does not pretend otherwise.

**Answered, in the one respect that survives.** The ball is a *sound* container for the report even
though it is not a faithful one:

- Every epistemically admissible report satisfies $|z| \le r \le 1$, and every Bloch point projects
  to a report satisfying $|z| \le r \le 1$. The two projections agree **exactly**. The wedge is not
  approximately the ball's $(z,r)$ shadow; it is the ball's $(z,r)$ shadow.
- The constraint is the thing worth having, because "a report may not be more confident than it is
  settled" is an epistemic norm that the ball enforces geometrically and a pair of free reals does
  not. §9 makes that the constructive payoff.

**What the ball adds beyond the report is the azimuth $\varphi$, and under (ii) nothing needs it.**
The fibre of the report map over an interior point is an *interval* (§4) and the ball's fibre is a
*circle*, so they are not even homeomorphic; embedding one in the other leaves half the circle
unused and makes the azimuth's meaning depend on an arbitrary cut. That is a defect of the same
kind the sibling found when the seed conversation tried to encode "false" as a global phase.

Worse for the azimuth, and this is an *independent* result from a sibling essay rather than an
argument invented here: [`logic-bloch-gates.md`](logic-bloch-gates.md) machine-checks that **no
rotation-covariant order on the equator exists** (its `no_torsion_of_invariant`), so the angle
cannot be a graded truth value at all, and phase gates act transitively on the equator, so the
truth question is blind to $\varphi$ by construction. Under (i) *and* under (ii), the azimuth is
unearned.

The honest comparative scorecard, then, on the ball's three dimensions:

| Reading | Accessible set | Dimension used | Azimuth |
|---|---|---|---|
| (i) models | the segment $r = \lvert z\rvert$ | 1 of 3 | unused |
| (ii) epistemic status | the wedge $\lvert z\rvert \le r \le 1$ | 2 of 3 | unused |

(ii) uses strictly more of the object than (i) does, and neither uses all of it.

## 5.1 Does (ii) change the Kleene-not-Belnap verdict?

**No, and it supplies an independent reason, which strengthens the sibling's finding rather than
competing with it.** The sibling's argument is geometric: Belnap's glut $\mathbf{B}$ sits strictly
above both $\mathbf{T}$ and $\mathbf{F}$ in the information order, and nothing sits above a pure
state, so the ball has gaps and no gluts. Under (ii) the argument is measure-theoretic and needs no
geometry at all: **the four statuses are outcomes of one probability distribution, hence exclusive
by construction, so no state can carry "proved and refuted at once".** Two routes, same verdict.

But (ii) sharpens the diagnosis in a way worth reporting, because it says Belnap was never the
right four-element set for this job:

| | Belnap-Dunn `FOUR` | (ii)'s statuses |
|---|---|---|
| classical values | $\mathbf{T}$, $\mathbf{F}$ | proved, refuted |
| third | $\mathbf{N}$ (gap): no evidence either way | **independent**: proved that neither is provable |
| fourth | $\mathbf{B}$ (glut): evidence both ways | **open**: no evidence either way |

Belnap's $\mathbf{N}$ is (ii)'s *open*, and Belnap has no independence value: "the agent proved
that no proof exists" is second-order and cannot be written as a pair of evidence bits, because
both bits are $0$ exactly as they are for an untouched conjecture. **The separation (ii) exists to
make is precisely the one Belnap-Dunn cannot make**, and conversely the glut (ii) cannot represent
is precisely the one Belnap can. The two four-element sets overlap in two members and disagree in
two.

To have both distinctions you need five statuses -- proved, refuted, independent, open, and
"the agent believes $T$ inconsistent" -- which is a 4-simplex, hence neither a qubit nor a qutrit.
That is the shape of the object the whole cluster keeps circling, and no essay in it has built one.

# 6. Does the reading need quantum entropy? No, and this is (ii)'s biggest vulnerability

The temptation is to point at the equatorial pure state $\ket{+}$ and say: here is a state with
**zero** von Neumann entropy whose truth measurement is nevertheless uniform, and no classical
distribution over $\{\text{true},\text{false}\}$ can do that, so the qubit is doing real work.

The first half is correct and the conclusion does not follow.

A classical distribution over $\{\text{true},\text{false}\}$ indeed cannot do it. But (ii)'s state
is not over $\{\text{true},\text{false}\}$; it is over four statuses. Coarse-graining that
distribution to the truth question maps independent and open alike onto a fifty-fifty split, so
**the Shannon entropy of the coarse-grained distribution exceeds the Shannon entropy of the
fine-grained one by exactly the amount the quantum story attributes to measuring in a
non-eigenbasis**. The structure that produces the effect is fine-graining versus coarse-graining,
and it is available in any classical probability space.

Concretely, "settled but unlocated" ($a = b = \tfrac12$) has fine-grained Shannon entropy $1$ bit
and coarse truth entropy $1$ bit; "proved independent" ($c = 1$) has fine-grained entropy $0$ and
coarse truth entropy $1$ bit. The gap is the whole phenomenon, and it is the ordinary
data-processing inequality, not a quantum effect. On the quantum side the two are the *same* point
by `report_conflates`, so the qubit does not even reproduce the distinction the classical model
makes for free.

**So: a classical four-outcome model does everything (ii) asks, and does one thing more.** State
this plainly, because the merge agent will find it either way.

What *would* require quantum structure, none of which (ii) supplies a use for:

- **Complementarity.** A second question mutually unbiased with the truth question. §5 reports that
  the gates essay finds the equatorial angle cannot carry an order, so no candidate exists yet.
- **Entanglement between the epistemic states of two sentences.** A genuine surplus with no
  classical counterpart, and the sibling's follow-up lead 3. Nothing in (ii) motivates it, though
  nothing forbids it either.
- **Interference between statuses.** Would require amplitudes rather than weights, and (ii)'s
  statuses are outcomes of a proof search, which is not an interfering process in any sense the
  essay can make precise.

# 7. Prior art: is (ii) a known position?

Searched rather than recalled. Where a source could not be verified against its primary text, that
is said.

**QBism** (Fuchs and Schack, *Rev. Mod. Phys.* 85, 1693, 2013; Fuchs, Mermin and Schack, *Am. J.
Phys.* 82, 749, 2014). QBism holds that a quantum state *is* an agent's personal degrees of belief
about the outcomes of measurements **that agent will perform**, with the Born rule as a normative
coherence constraint rather than an objective law. That is exactly (ii)'s interpretive move, and it
is a well-defended position, so (ii)'s *stance* is not novel. Two differences, both real: QBism is
about **physical measurement outcomes** throughout, with no treatment of logical or mathematical
propositions and none of undecidability that a search could find; and QBist mixedness is ordinary
outcome uncertainty, not a two-tier lean-versus-settled structure. §2.1 also shows that QBism taken
straight lands on the segment, not the ball, when the proposition is a single binary question.

**Epistemic and dynamic epistemic logic** (Hintikka 1962; Fagin, Halpern, Moses and Vardi 1995; van
Ditmarsch, van der Hoek and Kooi 2007). Standard Kripke epistemic logic suffers **logical
omniscience**: the agent knows every consequence of what it knows, which erases "probable but
undetermined" at the semantics level. Fagin and Halpern's awareness logic (*Artificial
Intelligence* 34, 1988) is the standard repair, splitting explicit from implicit belief via an
awareness set. But awareness is a binary set membership, and there is no modality for "aware, and
has proved that no verdict exists". Searches surfaced two recent near-neighbours -- an axiomatised
"Rumsfeld ignorance" of known-unknowns against unknown-unknowns (arXiv:2507.17776, 2025), and a
hyperintensional treatment of ignorance without grasping (arXiv:2603.09569, 2026) -- neither of
which touches formal undecidability. The Stanford Encyclopedia's *Provability Logic* entry records
that combining provability logic with epistemic logic is generally regarded as misguided, because
provability is non-factive and knowledge is factive. **So the gap here is principled and known,
not merely unfilled**, and (ii) is proposing to cross a line the field declines to cross. That is
a reason to be careful, not a reason to stop, but it should be on the table.

**Intuitionistic Kripke semantics.** §2.3's use of it is textbook, and the qualitative reading of
an unsettled node is entirely standard. The numeric layer is not. One lead on probability measures
over Heyting algebras that need not satisfy $P(\varphi) + P(\neg\varphi) = 1$ (arXiv:1703.04382)
resolves to Ben Goertzel, *Cost-Based Intuitionist Probabilities on Spaces of Graphs, Hypergraphs
and Theorems* (2017), which builds an intuitionistic probability measure from a cost-based partial
order on graph and hypergraph space. It is a construction on a specific space rather than a general
theory of probability over intuitionistic propositions, and whether it yields
$P(\varphi) + P(\neg\varphi) < 1$ was not verified beyond the abstract. Baltag, Bezhanishvili, Ozgun and
Smets's topological evidence-and-belief programme is a real adjacent body of work, aimed at Gettier
and defeasibility rather than at undecidability, and carries no probability or entropy.

**Quantum epistemic and doxastic logic** (Baltag and Smets: LQP, *Math. Struct. Comp. Sci.* 16(3),
2006; *Synthese* **179**(2), 285-306, 2011; and the 2023 Wigner's-friend paper). Consistent finding across
twenty years of that programme: **the quantum structure is the OBJECT reasoned about, never the
FORM of the reasoner's belief.** States are subspaces of the Hilbert space of the physical system
under discussion, and where epistemic modalities appear they are ordinary Kripke operators layered
on top. A clean miss rather than a near miss.

**Quantum cognition** (Busemeyer and Bruza, *Quantum Models of Cognition and Decision*, Cambridge
UP, 2012). Cognitive states *are* density operators, and mixed states *do* sit in the interior of
a generalised Bloch body, so the literal machinery of (ii) exists and is used. One paper models
students' physics misconceptions as mixed states in a Bloch-like interior (*Quantum Reports* 6(2),
2024) -- **reported secondhand, full text blocked, not independently confirmed**. Nothing found
uses the radius as a provedness or settledness dial, and none of it concerns mathematical
propositions.

**Jøsang's subjective logic** (*Int. J. Uncertainty, Fuzziness and Knowledge-Based Systems* 9(3),
279-311, 2001; *Subjective Logic*, Springer 2016) is **the closest classical prior art**, and it is
close enough that (ii) should be presented as a variant of it rather than as a discovery. An opinion
is $\omega_x = (b, d, u, a)$: belief, disbelief, uncertainty mass, and base rate, with $b + d + u =
1$. The geometry is an equilateral triangle, a 2-simplex, and the mapping to a Beta distribution is
explicit: $b = \tfrac{p}{p+n+W}$, $d = \tfrac{n}{p+n+W}$, $u = \tfrac{W}{p+n+W}$ for $p$ positive
and $n$ negative observations. This essay originally asserted that **Jøsang's $u$ is (ii)'s
$1 - r$**. The adjudicating sibling `logic-models-vs-epistemic.md` checked that identification and
found it FALSE, machine-checked as `josang_eq_iff`: Jøsang's $u$ corresponds to the *independent*
plus *open* mass, while (ii)'s $1 - r$ is the *open* mass alone, so the two agree only when the
independent mass vanishes. The correction cuts against this essay's own interest, since it means
(ii) UNDER-claimed its novelty here rather than over-claiming it. Two further differences: the geometry is a simplex rather than a ball, keeping the two
polarities as separate coordinates instead of one signed axis; and, decisively, subjective logic
has **no analogue of the $r = 1$, $z = 0$ point as anything but ordinary confident balance**. Its
$b = d = \tfrac12$, $u = 0$ opinion is a known-fair coin. Which is §4's second inhabitant, arriving
from the classical side and confirming that the conflation is not an artefact of the geometry.

**Second-order uncertainty.** Dempster-Shafer (Shafer, *A Mathematical Theory of Evidence*,
Princeton UP, 1976) separates $\mathrm{Bel}(A) \le P(A) \le \mathrm{Pl}(A)$, with the gap read as
residual ignorance and total ignorance as $\mathrm{Bel} = 0$, $\mathrm{Pl} = 1$: the lean-versus-
ignorance split, in an interval rather than a ball, with no entropy. Ellsberg (1961, *QJE* 75(4))
names the risk/ambiguity distinction, which §4 identifies as exactly the circle-versus-origin
contrast. Keynes's *Treatise on Probability* (1921, ch. VI) is reported by several secondary
sources to treat probability and **weight of argument** as two logically independent dimensions of
rational belief, which would be the oldest form of (ii)'s two-axis claim. The primary text confirms
it: ch. VI is titled *"The Weight of Arguments"* (p. 78), and Keynes writes that the comparison
*"turns upon a balance, not between the favourable and the unfavourable evidence, but between the
absolute amounts of relevant knowledge and of relevant ignorance respectively"*, adding that
*"new evidence will sometimes decrease the probability of an argument, but it will always increase
its 'weight.'"* The two-axis claim is a century old.

**Bloch sphere and undecidability.** Narrowed null result. A Bloch-ball representation with true
and false at the poles and an "undecidable" continuum at the equator **does exist in the
literature** -- Sperling and Walmsley, Phys. Rev. A **97**, 062327 (2018), §IV.3, where its convex
hull is a double cone. What searches did not find is any representation of a *mathematical
proposition's proof status*: no provability predicate, no arithmetic, no settledness dimension. The
adjacent genre is Goedel-versus-physics analogy (a quantum treatment of the *semantic* liar,
arXiv:quant-ph/0007047; Kochen-Specker/Goedel structural analogies), which is a different subject
and carries no settledness dimension.

**Verdict, stated as narrowly as the evidence allows.** (ii)'s *stance* is QBism's and is not
novel. (ii)'s *two-axis structure* is Keynes's, Dempster-Shafer's, Ellsberg's and above all
Jøsang's, and is not novel. What no search found is the combination -- an entropy-linked radial
settledness coordinate, applied to a mathematical sentence's proof status, with a distinguished
reading of the $r=1$, $z=0$ locus. And §4 has already shown that the last of those three does not
work as stated. **The defensible claim is that (ii) is a geometric repackaging of subjective logic
applied to proof status, not a new epistemology**, and it should be written up that way.

# 8. The bill: what (ii) gives up

The fork's framing is right that (ii) buys the epistemic separation by giving up the
model-theoretic interpretation. Three costs, priced.

**Cost 1: the concrete Goedel picture is severed, and this is the large one.** Under (i),
$z = 2\mu(\{M \models P\}) - 1$ is a measure over models, and "true in the standard model, false in
a nonstandard one" *is* the mixed state. The geometry pictures incompleteness directly. Under (ii),
incompleteness enters only as the reason the *independent* status is inhabited at all: Goedel and
Cohen supply the existence of the third vertex and nothing else. Nothing about the shape, the
constraint, or the entropy changes if the theory happens to be Presburger arithmetic and the
independent status is empty; the simplex just degenerates to a triangle. **That is a real loss of
content**, and the sibling essay's judgement that "Goedel buys the $z$-diameter and nothing else"
becomes, under (ii), "Goedel buys the inhabitation of one vertex and nothing else". Weaker, not
stronger.

**Cost 2: $z$ stops being a property of the sentence.** Two agents, same sentence, same theory,
different points. That is not incoherent -- it is what "epistemic state" means -- but it dissolves
rather than answers the owner's `conv-formal-language.md` question about two sound and complete
systems disagreeing, since under (ii) the answer is trivially "different agents" and therefore
uninformative. And the label $p(\text{true}) = \tfrac{1+z}{2}$ becomes a misnomer: $z$ is a
lean about *what the agent has proved*, and for a sound agent over a consistent theory that is only
a **lower bound** on truth-lean. Note where this lands: under (ii) the honest name for the $z$-axis
is provability, not truth, which is **exactly the sibling essay's recommended encoding (b)**.
(ii) and the sibling agree on the poles, having got there from opposite ends.

**Cost 3: the natural dynamics is not unitary, which puts (ii) at odds with the gate programme.**
Under (ii), learning increases $r$: the open weight shrinks. Unitary evolution *preserves* $r$
exactly, and noise *decreases* it. So learning is a non-unital channel driving the state toward the
sphere, and the whole apparatus of NOT, CNOT and Toffoli that the owner explored in
`conv-falsifiability.md` is not the epistemic dynamics. The gates sibling is analysing a different
motion from the one (ii) needs.

Against those, one asymmetry runs the other way and should be weighed with them: **(i) has no
dynamics at all.** A measure over models changes when you change the measure, and nothing in the
setup says when or why you would. (ii) has a dynamics, it has a direction (§2.3's ratchet), and it
has a stated failure mode (retraction). Whether one non-unitary dynamics beats no dynamics is the
owner's call and item 7 of §11 puts it there.

# 9. The constructive payoff: a report format for a layered core

The 2025-08-08 naming turn asks Bloch-valued truth to be the logic core of a **layered** system: a
complete lower layer, an incomplete upper layer, and Bloch-valued truth carrying the upper layer's
indeterminacy. Judged against that target, (ii) is the reading that fits, and the argument is
short.

**A layered reasoner's upper layer knows what it has proved. It does not have a measure over
models.** Reading (i) requires a weight $\mu$ over the models of the theory, and there is no
canonical one and no way for a running system to compute one. Reading (ii) requires the layer to
report the state of its own proof search, which is the one thing it definitely has.

**The distinction the core most needs is the one (i) cannot represent.** A scheduler in the core
must tell apart two reports:

| Report | $(z, r)$ | What the core should do |
|---|---|---|
| "I proved this is undecidable here" | $(0, 1)$ | stop asking; escalate to a stronger theory or accept the branch |
| "I have got nowhere yet" | $(0, 0)$ | allocate more budget; ask again later |

Under (i) both are the centre, because an ensemble over models has no way to express "I have a
theorem about the theory" -- and indeed under (i) the accessible set is the segment, on which
$z = 0$ forces $r = 0$, a single point. **The one operational distinction a scheduler needs is the
one that reading collapses.** Under (ii) they are the two ends of a radius. That is the essay's
strongest practical argument, and it is the argument the owner's own stated application makes.

**The cone constraint is a soundness norm, not decoration.** $|z| \le r$ says the upper layer may
not report more confidence than it has settled. A layer that returns $z = 0.9$ with $r = 0.2$ is
making an inadmissible report, and the core can reject it by geometry rather than by policy. This
is what the ball buys over an unconstrained pair of reals, and it is the whole of what it buys
(§5).

**A candidate thesis statement, sharpened from the sibling's.** The sibling
[`logic-bloch-poles.md`](logic-bloch-poles.md) §7.3 proposes: *Bloch-valued truth is a report
format, not a logic* -- the pair (truth lean $z$, determinacy $r$) with $|z| \le r$. Under (ii)
that becomes concrete on three points where the sibling left it open:

> **Candidate thesis (ii)-flavoured.** *Bloch-valued truth is the report an incomplete reasoning
> layer hands a decidable core about its own proof search.* The state is a distribution over
> **epistemic statuses** -- proved, refuted, independent, open -- of one sentence for one agent;
> $z$ is the located weight, $r = 1 - p_{\text{open}}$ the settled weight, and the constraint
> $|z| \le r$ is **derived from that simplex**, not stipulated. The core reasons about the pair of
> reals, which is decidable, instead of about the sentence, which is not. Independence and
> openness, which a truth-valued or model-valued report identifies, are the two ends of the
> $z = 0$ radius.

Three properties, and one of them is a risk:

1. **It says what the state is a state of.** That is the question the sibling's version leaves
   open, and it is the one the merge has to settle.
2. **It derives the constraint.** §2.2. A report cannot be more confident than it is settled,
   because $|a - b| \le a + b + c$.
3. **It is falsifiable within this cluster, and §4 is the crack.** The report does not separate
   proved independence from a known-fair coin. If the owner judges that separation essential --
   and for a scheduler it may well be, since one says "stop" and the other says "this is a coin
   flip, guess" -- then the two-number report is insufficient and the third simplex coordinate must
   be reported too, at which point the object is a 3-simplex and the qubit is gone.

**Relation to `TODO.md:127` (`id:4bb2`).** That item records the "Bloch Truth" essay as **BLOCKED**
because a 2026-07-17 meeting found no thesis statement in 412 session files. The box above is
offered as a candidate unblocker, alongside the sibling's. It is an AI proposal and settles
nothing; item 10 in §11 puts it to the owner, and **nothing has been written to any ledger**.

# 10. What the Lean file actually discharges

[`lean/LogicEpistemic.lean`](lean/LogicEpistemic.lean) compiles against the repo's pinned toolchain
with **exit code 0 and zero `sorry`**, checked by

```
cd verify && ../docs/dreamed/capped.sh -m 4G -c 100 -- \
    lake env lean --threads=1 ../docs/dreamed/lean/LogicEpistemic.lean
```

| Handle | Theorem | Content |
|---|---|---|
| `zr-cone` | `abs_z_le_r` | $\lvert z\rvert \le r$, derived from the simplex. §2.2. |
| `origin-on-equator` | `r_zero_imp_z_zero` | $r = 0 \Rightarrow z = 0$: the owner's two proposals are one. |
| `four-corners` | `vertex_coords` | The four statuses at $(1,1)$, $(-1,1)$, $(0,1)$, $(0,0)$. §0. |
| `neg-fixes-r` | `dual_r` | Negation flips $z$ and fixes $r$. |
| `conflation` | `report_conflates` | **The essay's own stated cost**, machine-checked. §4. |
| `entropy-anti` | `settledEntropy_strictAntiOn` | $h((1+r)/2)$ strictly decreasing on $[0,1]$. §3. |

Plus `r_eq_one_sub_open`, `r_nonneg`, `r_le_one` (the report lands in the admissible range),
`independent_ne_open_in_r` (the headline separation, isolated), the endpoint values
$S(0) = \log 2$ and $S(1) = 0$, and a Part C proving $z^2 \le \lVert\mathbf r\rVert^2$ and its
$r=0$ corollary on a bare Bloch triple -- the same two facts as `zr-cone` and
`origin-on-equator` by proofs that share nothing with them, one convexity and one Pythagoras.

**What it does not prove, and says so in its header:** nothing about quantum mechanics (`Bloch` is
three reals; that $h((1+r)/2)$ *is* the von Neumann entropy is arithmetic about eigenvalues,
asserted in prose here and proved nowhere); nothing about Goedel (no arithmetic, no provability
predicate; `ind` is a real number and the inhabitation of the status it names is Cohen's business);
nothing showing the epistemic simplex is the right sample space; and no map between $\Delta^3$ and
the Bloch ball, since §4 and §5 argue no faithful one exists. `binEntropy_strictAntiOn` is imported
from Mathlib, not reproved.

# 11. Surfaced for the owner

Each item is a located claim plus the ruling it needs. **None of these is decided, and none has
been written into `TODO.md`, `ROADMAP.md`, or `REVIEW_ME.md`.** This essay argues one side of a
fork on purpose; several items below are best ruled on only after reading the sibling.

1. **The fork itself: is the state a state over models or over epistemic status?** Located: the
   Provenance table and §1. The essay's argument for (ii) is that the owner's own status list at
   `conv-falsifiability.md:366` contains "probable but undetermined", which reading (i) *cannot
   express*, because a provable sentence is true in every model whether or not anyone has found
   the proof. **Ruling needed:** which reading the construction commits to, or whether both are
   kept as two different objects with two different jobs.

2. **The headline holds in a weaker form than the fork's framing promised, and the essay reports
   this against itself.** Located: §0 item 3 and §4, machine-checked as `report_conflates`. The
   equatorial circle is "unproved and settled", not "proved independent": a second state,
   *certainly decided, no idea which way*, lands on the same point. That second state is Ellsberg's
   known-fair coin, and Jøsang's subjective logic has the same conflation at $b = d = \tfrac12$,
   $u = 0$. **Ruling needed:** accept a two-number report that identifies independence with a coin
   flip, or require the third simplex coordinate, which costs the qubit (§4).

3. **What (ii) buys over (i), quantified.** Located: §5's scorecard. (i) fills a
   one-dimensional segment; (ii) fills the two-dimensional wedge $|z| \le r \le 1$. Under (i),
   $z = 0$ forces $r = 0$, so independence and openness are the same point. **Ruling needed:**
   whether a factor-of-two gain in used dimension, on an object of dimension three, is worth the
   §8 costs.

4. **The azimuth is unearned under BOTH readings.** Located: §5, resting on
   [`logic-bloch-gates.md`](logic-bloch-gates.md)'s machine-checked `no_torsion_of_invariant` (no
   rotation-covariant order on the equator) and on the interval-versus-circle fibre mismatch.
   **Ruling needed:** none from the owner on the mathematics, but a decision on whether the
   construction should keep a coordinate that three essays now agree carries nothing.

5. **The quantum structure is not needed, and the essay states this against its own interest.**
   Located: §6. A classical four-outcome distribution reproduces the entropy behaviour exactly, by
   coarse-graining, and *additionally* separates the two states that `report_conflates` identifies.
   **Ruling needed:** whether "Bloch Truth" is a claim about quantum structure or a geometric
   packaging of a classical epistemic model. If the latter, the honest name for the object is a
   simplex.

6. **Prior art: (ii) is a repackaging, not a discovery.** Located: §7. QBism (Fuchs and Schack
   2013) already holds that the state *is* an agent's credence, restricted to physical measurement.
   Jøsang's subjective logic (2001, 2016) already carries an explicit ignorance coordinate $u =
   1 - r$ in an explicit geometry. Dempster-Shafer, Ellsberg 1961 and (unverified) Keynes 1921
   already separate lean from weight. **Ruling needed:** whether the project positions itself as a
   variant of subjective logic applied to proof status -- which the evidence supports -- rather
   than as new epistemology, which it does not.

7. **Cost 1 is the one to weigh hardest: (ii) severs the model-theoretic reading.** Located: §8.
   Under (ii), Goedel supplies the inhabitation of one vertex and nothing else, and the geometry is
   unchanged if the theory is complete and that vertex is empty. **Ruling needed:** whether the
   concrete Goedel picture is part of what "Bloch Truth" is for. If yes, that is a strong argument
   for the sibling's reading (i) and against this essay.

8. **Under (ii) the $z$-axis is provability, not truth -- which independently confirms the
   sibling's recommended encoding (b).** Located: §8, cost 2. A sound agent's proof-holding lean is
   a lower bound on truth-lean, so calling $(1+z)/2$ "$p(\text{true})$" overstates it. **Ruling
   needed:** confirm the relabelling. Two essays reaching encoding (b) from opposite premises is
   the strongest signal in the cluster.

9. **Learning is not unitary, so the gate programme analyses the wrong motion for (ii).** Located:
   §8, cost 3. Learning increases $r$; unitaries preserve it and noise decreases it. **Ruling
   needed:** whether the dynamics of interest is gates (in which case (ii) is the wrong reading) or
   learning channels (in which case the gate essay's results are about a different object, however
   correct).

10. **A candidate thesis statement, offered as an unblocker for `TODO.md:127` (`id:4bb2`).**
    Located: §9. *Bloch-valued truth is the report an incomplete layer hands a decidable core about
    its own proof search*, over the four epistemic statuses, with $|z| \le r$ derived from the
    simplex. It sharpens the sibling's version on the one point the sibling leaves open, namely
    what the state is a state of. `id:4bb2` is blocked on the 2026-07-17 finding that no thesis
    exists in 412 session files. **Ruling needed:** whether this, the sibling's, a merge of the
    two, or neither. It is an AI proposal, a delegated verdict is a recommendation and never a
    self-settling decision, and nothing has been written to any ledger.

11. **The persistence law is (ii)'s most under-explored asset.** Located: §2.3. Intuitionistic
    Kripke semantics makes $r$ a **ratchet** along the information order while $z$ moves freely,
    which is exactly the sibling's Belnap knowledge-order asymmetry derived from a logic the owner
    already uses rather than imported. **Ruling needed:** none; this is a mathematical direction
    and the cheapest genuinely new thing in the essay. Whether belief revision (which breaks
    persistence) is in scope is the owner's call.

12. **The five-status object nobody has built.** Located: §5.1. To carry both (ii)'s
    independent-versus-open separation and Belnap's glut you need five exclusive statuses, hence a
    4-simplex, which is neither a qubit nor a qutrit. Three essays in this cluster now circle it.
    **Ruling needed:** whether it is worth constructing, or whether the glut is out of scope (the
    sibling's item 4 asks the same question from the other side).

# A future `.mw` sketch

What a `.mw` document would carry, in the style of `verify/mirror/resogram_esol.mw`. Sketch of
intent, not a runnable mirror; these are Lean-tier claims and route to the Lean backend.

```computation
# handles: zr-cone, origin-on-equator. The cone constraint, derived from the simplex.
# a, b, c, d >= 0 and a + b + c + d = 1.
z       = a - b
r       = a + b + c
zr_cone = Le(Abs(z), r)
origin  = Implies(Eq(r, 0), Eq(z, 0))
```

```computation
# handle: four-corners. The four statuses and where they land.
corners = And(Eq(report(1,0,0,0), (1, 1)),
              Eq(report(0,1,0,0), (-1, 1)),
              Eq(report(0,0,1,0), (0, 1)),
              Eq(report(0,0,0,1), (0, 0)))
```

```computation
# handle: conflation. The stated COST: the report is not injective.
conflation = And(Ne((0,0,1,0), (Rational(1,2), Rational(1,2), 0, 0)),
                 Eq(report(0,0,1,0), report(Rational(1,2), Rational(1,2), 0, 0)))
```

```computation
# handle: entropy-anti. Radius and entropy are order-isomorphic on [0,1].
S            = Lambda(t, binEntropy((1 + t)/2))
entropy_anti = StrictAntiOn(S, Interval(0, 1))
```

# Follow-up leads

1. **Build the five-status object and see what it is.** Five exclusive statuses is a 4-simplex;
   ask which convex body with five extreme points, if any, is a quantum state space. Decidable by
   arithmetic; item 12.
2. **Report the third simplex coordinate and see whether the geometry survives.** If independence
   must be separated from a known-fair coin, the report is three numbers. Does the constraint set
   still have a natural geometric home? Item 2.
3. **Work out the learning channels explicitly.** Under (ii) learning is a non-unital channel
   increasing $r$. Write down the generator, check whether the four statuses are its fixed points,
   and compare with amplitude damping. Item 9.
4. **DISCHARGED, no longer a question.** The Keynes attribution was verified against the primary
   text (*A Treatise on Probability*, 1921, ch. VI, "The Weight of Arguments", p. 78) by the
   `citation-audit.md` sibling, and it holds. The two-axis claim is a century old and the project
   should say so. §7 is updated accordingly.
5. **PARTLY DISCHARGED.** arXiv:1703.04382 resolves to Ben Goertzel, *Cost-Based Intuitionist
   Probabilities on Spaces of Graphs, Hypergraphs and Theorems* (2017). It is a construction on a
   specific space, not a general theory of probability over intuitionistic propositions, so it does
   not settle whether $P(\varphi) + P(\neg\varphi) < 1$ holds in the way §2.3 needs. What remains
   open is only that last question, not the identifier.

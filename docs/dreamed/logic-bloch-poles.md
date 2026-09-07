---
title: What should the poles be? Bloch-sphere logic, honestly
permalink: /dreamed/logic-bloch-poles
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This file *proposes*; the owner disposes. Nothing here is toesnail theory, and nothing may be
> promoted into `physics/` or `essays/` without the owner authoring the move himself. The `\veq`
> badges below claim something about [`docs/dreamed/lean/LogicBloch.lean`](lean/LogicBloch.lean)
> **only**, and are deliberately not wired into `physics/*.toml` or `tests/test_verify.sh`.

## Provenance

The seed is the owner's own standing side project. He named it **"Bloch Truth"** (later **"Bloch
Truth Mapping"**) on 2025-08-08, in a project-management conversation rather than a physics one,
and the naming turn also states what he wanted it *for*
(`~/knowledge/sessions/claude-ai/2025-08-05_breaking_project_paralysis_cbae6cd6.md:1334`,
his turn, 2025-08-08 07:22 UTC, verbatim):

> It is fascinating to me how the project correlate as well: for example the Bloch Truth (might
> need a better name) might be useful for the AI logic core in the second (ZFC?) layer where
> incompleteness applies (core layer should only be complete, e.g. ZF without C), and the
> Lissajous (again better name needed) for Proxypolation

That sentence changes what this essay has to do. The target is not "what do the poles mean" in the
abstract; it is a **layered reasoner** whose lower layer is meant to be well behaved and whose upper
layer is where incompleteness bites, with Bloch-valued truth as the mechanism carrying the upper
layer's indeterminacy. §7 judges the pole assignment against that role, corrects one factual slip in
the parenthesis, and proposes a thesis statement.

The idea's founding *technical* conversation is *Falsifiability and Logical Boundaries*
(2025-08-16), and it is developed across at least five more. Everything quoted below in a
blockquote is the owner's own words from a **human** turn; the assistant turns in those exports
are prior AI output and are treated here as material to check, not as authority. Three of them
are corrected by name.

| Export | Date | What it contributes here |
|---|---|---|
| `conv-falsifiability.md` | 2025-08-16 | The founding turns: poles, origin, equator, the true/unprovable question |
| `conv-blochsphere.md` | 2025-08-09 | Mixed states, and "why must the density matrix be positive semi definite?" |
| `conv-peano.md` | 2025-07-24 | "sentences that are both true and false, or neither" |
| `conv-euclid-set.md` | 2025-08-08 | "are there sensible finite systems that still are incomplete?" |
| `conv-formal-language.md` | 2025-09-21 | Two sound and complete systems disagreeing |
| `conv-ternary.md` | 2026-03-31 | The Bloch ball as a neural-network activation space; radius as calibrated uncertainty |
| `2025-08-05_breaking_project_paralysis_cbae6cd6.md:1334` | 2025-08-08 | The **name** and the **intended application**: the logic core of a layered AI |

The founding questions, verbatim:

> Let's use a qubit with the two states (proven) true and (proven) false. [...] How to encode
> that a statement is unprovable or that is provable but not yet determined whether it's true or
> false?

> What about the Bloch sphere instead of a qutrit? Would the origin encode unprovable or provable
> but not yet determined or something entirely different? What about the circle at z=0 i.e. as far
> from proven truth and falsehood as possible?

> Would a qubit true or unprovable make sense? How could false be encoded there?

This essay answers the first and third; the equator gets a partial answer here and its
gate-theoretic half is [`logic-bloch-gates.md`](logic-bloch-gates.md). The qutrit and the QCD
turn are [`logic-qutrit-su3.md`](logic-qutrit-su3.md). The "world formula is impossible" thread is
[`weltformel-impossibility.md`](weltformel-impossibility.md).

# 0. The headline, stated and not teased

**The poles should be `provable` and `not provable`, not `true` and `false`, and the reason is
counting.** Two antipodal poles are the two outcomes of one sharp measurement, so an encoding must
assign each epistemic status to one of exactly two outcomes. There are three statuses that a
sentence of an arithmetic theory can have (provable, refutable, independent), and there is no
injection from three things into two. Either you conflate two statuses or you drop one, and the
choice of *which* is the whole design question. The pigeonhole itself is machine-checked as
`no_two_pole_encoding`.

**Three further results, each of which cuts against the seed conversation.**

1. **Encoding (c), `|0> = true` against `|1> = unprovable`, is not merely awkward. It is refuted by
   the very object it was invented to model.** Antipodal means orthogonal means mutually exclusive.
   Goedel's sentence for PA is *true in the standard model and unprovable in PA at the same time*,
   so the two proposed poles are not exclusive. The prior AI's three rescue attempts all fail, and
   one of them (`conv-falsifiability.md:519-522`, "false = $e^{i\pi}\ket{1}$") fails for a
   flat physical reason: a global phase is unobservable, so $e^{i\pi}\ket{1}$ and $\ket{1}$ are the
   same state, with the same density matrix and the same Bloch vector. That option encodes nothing
   whatsoever.

2. **The radius carries exactly the von Neumann entropy and the $z$ coordinate carries exactly the
   Born probability, so the owner's two-axis intuition is correct at the level of the formalism,
   not merely the picture.** But the reading has a hard ceiling: in the Belnap-Dunn square the
   *glut* value "both true and false" sits strictly **above** both plain truth and plain falsity in
   the information order, and the Bloch ball has nothing above a pure state. **The ball can
   represent a gap and cannot represent a glut.** The ball is Kleene, not Belnap. If one insists on
   placing the glut anyway, it lands at $r > 1$, which is where positivity fails and eigenvalues go
   negative. That is the owner's own 2025-08-09 question about indefinite density matrices,
   arriving from the other direction.

3. **The Goedel reading buys the $z$-axis diameter and nothing else.** Read a density matrix as an
   ensemble over models of the theory (Con(PA) true in the standard model, false in a nonstandard
   one). Every such ensemble is diagonal in the truth basis, so it fills exactly the segment from
   pole to pole and never leaves it. Every off-axis point of the ball, including the entire equator
   and the whole phase structure the seed conversation spent its time on, has **no model-theoretic
   content at all** under that semantics. Goedel earns you a probability, not a qubit.

**The constructive recommendation:** the object that fits is not one qubit but **two**, one per
polarity, carrying (evidence-for, evidence-against). That is literally the Belnap-Dunn four-valued
square, it is what the owner himself reached for in `conv-peano.md` when he asked for sentences
"both true and false at the same time" *and* sentences that are neither, and its quantum version
has a surplus the classical square lacks: entanglement between the for-evidence and the
against-evidence.

# 1. Four rival encodings, judged by what antipodality commits you to

An encoding is not a labelling exercise. Putting two names at the poles of a Bloch sphere commits
you to three things at once, and they are all consequences of the geometry:

- **Orthogonality.** The poles are eigenvectors of one observable with distinct eigenvalues, so a
  single measurement distinguishes them **perfectly**. No experiment confuses the north pole with
  the south pole.
- **Exclusivity.** No state is both poles. Whatever the two labels mean, nothing can carry both.
- **Outcome-exhaustiveness.** A projective measurement in that basis returns one of exactly two
  answers, always. This is not a claim about the states; it is a claim about the *questions*, and
  it is the point where the law of excluded middle sneaks back in even if the state space is
  non-classical.

Keep exclusivity and outcome-exhaustiveness apart. They are different requirements and the four
candidates fail them differently.

$$
\text{poles }\{p_+,p_-\}\text{ admissible} \iff
\underbrace{p_+ \cap p_- = \varnothing}_{\text{exclusive}}
\;\wedge\;
\underbrace{\text{every status maps to one pole}}_{\text{exhaustive}}
\veq{poles-2}\lean
$$

**(a) `|0>` = proven true, `|1>` = proven false.** Exclusive, in a consistent theory. **Not
exhaustive**: an independent sentence maps to neither pole. This is the seed's opening move and
its defect is precisely the thing the seed then spent six turns trying to patch. Nothing here is
*wrong*; the encoding simply forces every non-classical status into the interior, where it will be
read as *indeterminacy* rather than as the definite fact it usually is. "PA does not decide
Con(PA)" is a theorem, not a fuzziness.

**(b) `|0>` = provable, `|1>` = not provable.** **Exclusive and exhaustive.** Every sentence of a
fixed theory either has a proof or does not, and in the classical metatheory that is a genuine
dichotomy. This is the only one of the four assignments where antipodality is honest, and it is
also the only one that corresponds to an actual two-outcome procedure: run the proof search, ask
whether it halts with a proof. Its cost is exactly the cost the pigeonhole predicts: the south pole
**conflates refutable with independent**. Both are "not provable"; they differ in whether the
*negation* is provable, which is a fact about a second question, not this one.

**(c) `|0>` = true, `|1>` = unprovable.** The owner asked whether this makes sense and where "false"
would then live. **It fails both tests simultaneously**, and the first failure is fatal:

- *Not exclusive.* Goedel's $G_{PA}$ is true in the standard model **and** unprovable in PA. That
  is the whole content of Goedel I. So the two labels are not merely both applicable in some
  contrived case; they are **co-instantiated by the canonical example the construction exists to
  describe.** Antipodal states are perfectly distinguishable, so putting a single sentence at both
  poles is not an approximation, it is a contradiction in the formalism.
- *Not exhaustive.* Nothing carries "false".

The seed's three rescues, each refuted:

| Rescue (`conv-falsifiability.md`) | Why it fails |
|---|---|
| `:514-516` false as $\ket{-} = (\ket{u} - \ket{t})/\sqrt2$ | An equatorial state is not exclusive with either pole. A "false" sentence so encoded returns "true" with probability $1/2$ on the truth measurement. |
| `:519-522` false as $e^{i\pi}\ket{1} = -\ket{1}$ | **Global phase is unobservable.** $-\ket{1}$ and $\ket{1}$ have the identical density matrix $\ket{1}\bra{1}$ and the identical Bloch vector. This encodes nothing. |
| `:524-525` false as a third orthogonal direction | Correct, and it is an admission that the qubit is the wrong object. It is the qutrit, which is the sibling essay's subject. |

The prior AI then wrote, of this encoding, "logical negation of an unprovable statement yields a
true statement" (`:498`). That is false as stated. If $\neg P$ is unprovable, nothing follows about
$P$; both $P$ and $\neg P$ are unprovable exactly when $P$ is independent.

**(d) truth on the $z$-axis, evidential status on the radius.** This is not a rival naming of the
poles; it is a statement about the *other* coordinate, and it is the one this essay endorses. §2
develops it and finds one hard limit.

**Recommendation for §9:** adopt **(b)** for the poles of the first qubit, and recover the sign
with a second qubit rather than with a phase. The pair (does a proof of $P$ exist, does a proof of
$\neg P$ exist) is two independent yes/no questions, which is two qubits, which is
$\mathsf{Bool} \times \mathsf{Bool}$, which is Belnap-Dunn. The three statuses then land as
$(1,0)$, $(0,1)$, $(0,0)$, with $(1,1)$ reserved for the inconsistent theory. Nothing is
conflated, nothing is dropped, and the pigeonhole is satisfied because there are now four
outcomes, not two.

**A caveat the owner raised himself and which limits all of the above.** In `conv-euclid-set.md`
he asked whether "Goedel's incompleteness only messes up with infinities or [whether] there are
sensible finite systems that still are incomplete". The relevant direction for this essay is the
other one: **Presburger arithmetic is complete and decidable**, and so is the first-order theory of
real closed fields (Tarski). Over such a theory the third status is *uninhabited*, the pigeonhole
never bites, and encoding (a) is perfectly adequate. The whole three-status problem is a property
of theories interpreting enough arithmetic, not of logic as such. Any construction here should
state which theory it is indexed to.

# 2. The two coordinates logic keeps conflating

The Bloch **ball** has two independent pieces of data that the picture invites you to merge: the
direction the state leans, and how far out it is. Write $\rho = \tfrac12(I + \mathbf{r}\cdot
\boldsymbol\sigma)$ with $|\mathbf{r}| \le 1$. Then:

$$
p(\text{true}) = \operatorname{Tr}(\rho \ket{0}\bra{0}) = \frac{1 + r_z}{2}
\qquad\text{depends on } r_z \text{ alone}
\veq{z-affine}\lean
$$

$$
S(\rho) = -\operatorname{Tr}\rho\log\rho = h\!\left(\frac{1+|\mathbf{r}|}{2}\right)
\qquad\text{depends on } |\mathbf{r}| \text{ alone}
$$

where $h$ is the binary entropy. This is the test the picture has to pass, and it passes: **which
way it is settled is a function of $z$ only, and how much is settled is a function of $r$ only.**
The owner's two-axis intuition is not a visual analogy; it is exactly what the density matrix says.
The `conv-ternary.md` follow-up, where he proposed the radius as a calibrated uncertainty signal in
a neural network, is the same observation put to work: $1 - S(\rho)$ is the information content and
it lives on the radius.

The two coordinates are also **independent in the way that matters**, and this is the part the seed
conversation missed. Mixing is convex combination of Bloch vectors, and under it:

$$
z\big(t\rho_1 + (1-t)\rho_2\big) = t\,z(\rho_1) + (1-t)\,z(\rho_2)
$$

$$
|\mathbf{r}|^2\big(\tfrac12\rho_1 + \tfrac12\rho_2\big) \ne \tfrac12|\mathbf{r}_1|^2 + \tfrac12|\mathbf{r}_2|^2
\quad\text{(e.g. }\rho_{1,2} = \ket{0},\ket{1}: \ 0 \ne 1)
\veq{r-drop}\lean
$$

**Ignorance moves $z$ exactly as a probability would, and destroys $r$.** That asymmetry is the
whole reason the ball is not a probability simplex, and it is why "as far from proven true as from
proven false" names two genuinely different places:

$$
\underbrace{(1,0,0)}_{\text{equator, } r=1}
\quad\text{and}\quad
\underbrace{(0,0,0)}_{\text{centre, } r=0}
\quad\text{both have } z = 0
\veq{equator-vs-centre}\lean
$$

**The centre** is the maximally mixed state, $\rho = I/2$. Every measurement in every basis returns
$1/2$. It is not "unprovable"; it is **no information at all**, which is the right home for an
*open* question (Goldbach, before anyone proves anything) and the wrong home for a *proven
independent* sentence, because proving independence is an achievement and the state that records
it should not be the state of maximal ignorance. The prior AI got this right at
`conv-falsifiability.md:124` and then contradicted itself twelve lines later by putting unprovable
sentences on the equator (`:134`). Both cannot be true. The essay's view: **neither is, and the
reason is §1's pigeonhole.** "Proven independent" is a fact about the *pair* of questions "is $P$
provable" and "is $\neg P$ provable", so it is a two-qubit fact, and forcing it into one qubit is
what generates the contradiction.

**The equator** is where the seed conversation's speculation is thinnest and where a clean answer
is available for free, from Birkhoff-von Neumann rather than from any new idea. A pure equatorial
state such as $\ket{+}$ is not indeterminate. It is the **definite, sharp answer to a different
question**: it is an eigenstate of $\sigma_x$ with eigenvalue $+1$. Its relation to the truth
question is *complementarity*, and the $z$- and $x$-bases are mutually unbiased, which is exactly
the statement that knowing the answer to the $x$-question tells you nothing about the $z$-question.
So:

> **The equator is not "maximum uncertainty". It is maximum certainty about something orthogonal to
> truth.**

That is a testable reading rather than a mood, and it explains, without inventing anything, why the
equator is "as far from both poles as possible": it is the locus of questions maximally unbiased
relative to the truth question. What that orthogonal question *is* -- what property of a sentence
the $x$-observable measures -- is the open question, and it is the one the gate analysis in
[`logic-bloch-gates.md`](logic-bloch-gates.md) is best placed to answer, since a gate acts on the
state and its fixed points expose what is being asked.

One further geometric fact worth having, because it constrains any reading: the ball's two
coordinates are **not** free of each other. $|z| \le |\mathbf{r}|$ always, so **a confident truth
value requires high information**. There is no state that is certainly true and uninformative. In
the Belnap square this constraint does not hold, and that difference is the subject of §3.

# 3. The actual non-classical logics, with the right names

This is where an essay like this usually waves. The four ternary logics below are genuinely
different and differ in ways that decide the question at hand.

All four share the same three values, written $\mathbf{T}$, $\mathbf{U}$, $\mathbf{F}$, and (except
Bochvar) the same negation $\neg\mathbf{T} = \mathbf{F}$, $\neg\mathbf{U} = \mathbf{U}$,
$\neg\mathbf{F} = \mathbf{T}$.

**Kleene's strong K3.** Conjunction is $\min$ and disjunction is $\max$ under
$\mathbf{F} < \mathbf{U} < \mathbf{T}$. Only $\mathbf{T}$ is designated.

| $\wedge$ | T | U | F |     | $\vee$ | T | U | F |
|---|---|---|---|---|---|---|---|---|
| **T** | T | U | F |     | **T** | T | T | T |
| **U** | U | U | F |     | **U** | T | U | U |
| **F** | F | F | F |     | **F** | T | U | F |

$\mathbf{U}$ is a **gap**: neither true nor false. Excluded middle fails, since
$\mathbf{U} \vee \neg\mathbf{U} = \mathbf{U}$, which is not designated. K3's sharpest property is
that it has **no tautologies at all**: assign $\mathbf{U}$ to every atom and every formula
evaluates to $\mathbf{U}$.

**Priest's LP.** *The same tables*, with the third value designated as well. That single change
converts the gap into a **glut**: $\mathbf{U}$ (usually written $\mathbf{B}$) is *both* true and
false. LEM is restored, since $\mathbf{B} \vee \neg\mathbf{B} = \mathbf{B}$ is now designated, and
**explosion fails**: $\mathbf{B} \wedge \neg\mathbf{B} = \mathbf{B}$ is designated, but it does not
entail an arbitrary $\mathbf{F}$-valued sentence. The price is that **modus ponens fails** in LP
(take $A = \mathbf{B}$, $B = \mathbf{F}$: then $A$ and $A \to B$ are both designated and $B$ is
not). K3 and LP are the same tables read with two different designation sets, and they lose
opposite halves of classical logic. That duality is not an accident and reappears in §3's Lean
theorems as `lem_fails` and `glut_designated`.

**Łukasiewicz Ł3.** Kleene's negation, conjunction, disjunction, but a different implication:
$\mathbf{U} \to \mathbf{U} = \mathbf{T}$ rather than $\mathbf{U}$. So $A \to A$ is a tautology and
Ł3, unlike K3, is not tautology-free, while LEM still fails. If the intended reading of the third
value is "not yet determined" and one wants self-implication to remain valid, Ł3 is the correct
ternary logic and K3 is not.

**Bochvar B3.** The third value is **infectious**: any compound with a $\mathbf{U}$ constituent is
$\mathbf{U}$, so $\mathbf{T} \vee \mathbf{U} = \mathbf{U}$, unlike Kleene. Bochvar's reading is
*meaningless* or *paradoxical*, not merely unknown, and the system comes with an external assertion
connective for talking about meaningfulness from outside. If the third value is meant to be
"ill-formed", Bochvar is the right system and Kleene is wrong, because Kleene's tables let a
meaningless disjunct be absorbed by a true one.

**The choice among these is a modelling decision, not a mathematical one, and it is the owner's to
make.** The relevant fact is that the seed conversation's third value drifted between *unknown*
(Ł3), *definitely undecidable* (K3-ish), and *paradoxical* (Bochvar) across turns, and those
require three different logics.

## 3.1 Belnap-Dunn FDE: the sharpest available comparison

The decisive observation is that the owner did not actually ask for three values. In
`conv-peano.md` he asked for

> plain English sentences that a) are both true and false at the same time or b) neither

which is a glut **and** a gap, in one breath. That is **four** values, and the system is
Belnap-Dunn first-degree entailment. Its values are pairs of evidence bits:

$$
v(P) = (\,\text{has evidence for},\ \text{has evidence against}\,) \in \{0,1\}^2
$$

$$
\mathbf{N} = (0,0), \quad \mathbf{T} = (1,0), \quad \mathbf{F} = (0,1), \quad \mathbf{B} = (1,1)
$$

and the point is that these four carry **two different partial orders**:

- the **truth order** $\le_t$: more evidence for, less against.
  $\mathbf{F} <_t \mathbf{N} <_t \mathbf{T}$ and $\mathbf{F} <_t \mathbf{B} <_t \mathbf{T}$, with
  $\mathbf{N}$ and $\mathbf{B}$ **incomparable**.
- the **knowledge order** $\le_k$: more evidence of either sign.
  $\mathbf{N} <_k \mathbf{T} <_k \mathbf{B}$ and $\mathbf{N} <_k \mathbf{F} <_k \mathbf{B}$, with
  $\mathbf{T}$ and $\mathbf{F}$ **incomparable**.

Drawn together they make a square, Ginsberg's bilattice `FOUR`, with $\mathbf{F}, \mathbf{T}$ on
one diagonal and $\mathbf{N}, \mathbf{B}$ on the other. **That is exactly the two-axis structure
the owner drew on the Bloch ball**, with $\le_t$ the $z$-axis and $\le_k$ the radius. The two
orders are genuinely distinct relations and neither is total:

$$
\mathbf{T} \le_k \mathbf{B} \quad\text{but}\quad \mathbf{T} \not\le_t \mathbf{B}
\veq{two-orders}\lean
$$

$$
\mathbf{N} \not\le_t \mathbf{B} \ \wedge\ \mathbf{B} \not\le_t \mathbf{N}
\veq{not-total}\lean
$$

The knowledge-order operations have the names the analogy needs: the meet $\otimes$ is
**consensus** (keep only what both sources assert), the join $\oplus$ is **gullibility** (believe
everything either source asserts). All four operations are monotone in both orders, which is
Ginsberg's *interlacing* condition, machine-checked in the companion file.

**Now the map to the Bloch ball, done carefully, including where it breaks.**

*What works.* The convex-combination reading is the obvious bridge and it does carry the knowledge
order in the right direction on half the square. A mixture is less informative than its
constituents; $\otimes$-like consensus lowers you toward the centre; the centre is $\mathbf{N}$; the
poles are $\mathbf{T}$ and $\mathbf{F}$. Under this map:

| FDE | Bloch |
|---|---|
| $\mathbf{N}$, no evidence | centre $(0,0,0)$, $\rho = I/2$, maximal entropy |
| $\mathbf{T}$ | north pole, pure |
| $\mathbf{F}$ | south pole, pure |
| $\le_t$ | the $z$ coordinate |
| $\le_k$ | the radius $|\mathbf{r}|$ |
| $\otimes$ consensus | mixing toward the centre |
| $\mathbf{B}$, glut | **nowhere** |

*Where it breaks, decisively.* $\mathbf{B}$ must satisfy $\mathbf{T} <_k \mathbf{B}$ and
$\mathbf{F} <_k \mathbf{B}$: the glut is **strictly more informative than either plain truth
value**. In the Bloch ball, the pure states already sit at the maximum radius $|\mathbf{r}| = 1$.
There is nothing above them. **The ball's information order has the pure states as its top elements
and therefore has no room for a glut at all.** The ball is a bounded-above information structure
with a single top *layer*; `FOUR` has a single top *point* that is not any of the classical values.

Two consequences follow, and both are stronger than the usual hand-wave:

1. **The Bloch ball is a Kleene structure, not a Belnap structure.** It can represent gaps and
   cannot represent gluts. Any claim that "the Bloch ball generalizes four-valued logic" is
   therefore false as stated; it generalizes the gap half.
2. **If you insist on placing $\mathbf{B}$, it lands outside the ball.** The glut is "evidence for
   *and* evidence against", i.e. the two probabilities sum to more than one, i.e.
   $|\mathbf{r}| > 1$, i.e. $\rho$ acquires a **negative eigenvalue**. The owner asked precisely
   this in `conv-blochsphere.md`:

   > Why does the density matrix need to be positive semi definite? What would happen if it were
   > negative or indefinite?

   The answer that essay's assistant turn gave is the standard one (negative probabilities). Read
   through the present analogy it becomes a claim worth stating: **the paraconsistent glut is
   exactly where positivity fails.** This is a located analogy, not a theorem, and it is offered as
   such. It is also not idle: negative quasi-probability is the standard resource marker in
   quantum computation (Wigner negativity, the Spekkens-Ferrie results), so "gluts are the
   non-classical resource" has a precise formal shadow.

*Is the ball a continuous bilattice?* Not obviously, and the burden is on the proposal. A bilattice
needs both orders to be lattices, so $\le_k$ needs binary joins. Mixing gives a *meet*-like
operation toward the centre, but the join, "the least state at least as informative as both", has
no canonical convex-geometric candidate: two distinct pure states have no common upper bound in
purity at all. **The knowledge order on the ball is a meet-semilattice with no joins**, which is
half of a bilattice. That is the concrete open question §9 hands back.

# 4. Why a qubit is not a probability, stated in the geometry

The classical comparison object is a simplex. A classical bit's state space is the 1-simplex, a
segment with **2** extreme points. A classical trit's is the 2-simplex, a triangle with **3**. A
qubit's is the 3-ball, whose extreme points are the entire sphere $S^2$: a **continuum**.

The temptation is to read that as "uncountably many sharp propositions", and then either to
celebrate it or to call it a reductio. Both readings are wrong, for the same reason:

**The extreme points are not alternatives.** In a simplex the extreme points are mutually
*distinguishable*: a classical trit's three vertices can be told apart by one measurement with
certainty. On the sphere, only *antipodal* pairs are perfectly distinguishable. Any two
non-orthogonal pure states cannot be told apart reliably by any measurement whatsoever. So a
qubit has a continuum of sharp states but still only **two** perfectly distinguishable ones, the
same as a classical bit. The continuum is not extra logical capacity; it is extra *structure* on
the same capacity, namely which questions are compatible with which.

The second difference is the one that actually decides things, and it is a characterisation
theorem rather than an observation:

> **A simplex is exactly the convex body in which every point has a unique decomposition into
> extreme points.**

The Bloch ball is not a simplex, so decomposition is **not** unique: $\rho = I/2$ is
$\tfrac12\ket{0}\bra{0} + \tfrac12\ket{1}\bra{1}$ **and** $\tfrac12\ket{+}\bra{+} +
\tfrac12\ket{-}\bra{-}$ and uncountably many other ensembles, all the same state. **The density
matrix forgets which ensemble produced it.** §6 shows that this is exactly the right feature for
one logical purpose and exactly the wrong one for another.

Finally, the surplus over probability is the **phase**. A classical mixture of the two poles fills
the $z$-axis diameter and no more, machine-checked in `axis_from_poles` and
`equator_not_from_poles`. The whole rest of the ball, the entire $x$-$y$ structure the seed
conversation attached meanings to, is unreachable by any classical mixture of true and false. It is
genuinely new structure, and it is therefore genuinely in need of a logical interpretation that
does not already exist elsewhere. That is the honest form of the seed's question about the equator,
and it is unanswered here.

# 5. This is not Birkhoff-von Neumann quantum logic, and the difference matters early

The single most likely misreading of the whole "Bloch Truth Mapping" idea is that it is quantum
logic. It is not, and the distinction is clean:

| | Birkhoff-von Neumann (1936) | The owner's construction |
|---|---|---|
| A **proposition** is | a closed subspace / projection $P$ | a *sentence of a formal theory* |
| Its **truth value** lives | nowhere; the lattice is the logic | in the *state* $\rho$ |
| The **state** does | assign probabilities $\operatorname{Tr}(\rho P)$ to propositions | *carry* the truth value |
| **Negation** is | orthocomplement $P^{\perp}$ | the antipodal map on states |
| The interesting failure is | **distributivity** | (to be determined) |

Birkhoff and von Neumann put propositions on **subspaces**; the owner puts truth values on
**states**. These are dual descriptions of the same geometry doing two different jobs, and mixing
them produces nonsense quickly.

The BvN lattice's characteristic property is worth stating precisely, because it holds already on a
qubit. Take $a = \operatorname{span}\ket{0}$, $b = \operatorname{span}\ket{+}$,
$c = \operatorname{span}\ket{-}$. Then $b \vee c$ is the whole space, so $a \wedge (b \vee c) = a$;
but $a \wedge b = a \wedge c = 0$, so $(a \wedge b) \vee (a \wedge c) = 0 \ne a$. **Distributivity
fails.** What survives is *orthomodularity*: if $a \le b$ then $b = a \vee (b \wedge a^{\perp})$.

This is worth taking seriously as a rival, because it delivers something the state-based reading
does not. Under BvN, a proposition of a qubit is a ray, so it is a **point on the Bloch sphere**,
and its negation is the **antipode**. The equator relative to a chosen truth-question is then the
set of propositions **mutually unbiased** with respect to it: propositions whose probability is
exactly $1/2$ in both pole states. That is the §2 reading of the equator, arrived at from the
lattice side, and it required no new invention at all.

**Gleason's theorem** is the other thing to know, and its fine print is decisive here. Gleason
(1957): for a Hilbert space of dimension **at least 3**, every (countably additive) probability
measure on the projection lattice has the form $P \mapsto \operatorname{Tr}(\rho P)$ for a unique
density matrix. It **fails at dimension 2**. A qubit admits frame functions that are not of that
form, and correspondingly a single qubit admits a non-contextual hidden-variable model (Bell 1966;
Kochen-Specker 1967 require $\dim \ge 3$ too).

Two consequences the owner should have on the table:

1. **On a single qubit, choosing the Bloch ball as the space of logical states is an assumption,
   not a theorem.** Gleason does not force it. So "why a density matrix and not some other
   assignment" has no answer at dimension 2.
2. **At dimension 3 it does.** For a qutrit, Gleason bites and the density matrix is forced, and
   Kochen-Specker says no non-contextual value assignment exists. So the qutrit is not merely a
   bigger qubit for this purpose: it is the first dimension at which the representation stops
   being a modelling choice. That is a substantive argument *for* the qutrit route, and it belongs
   to [`logic-qutrit-su3.md`](logic-qutrit-su3.md).

# 6. Goedel, honestly

Take the strongest form of the analogy and see how much survives.

**Where it fails outright.** Independence is a **stable** property of a theory-sentence pair. PA
does not decide Con(PA), today, tomorrow, and whether or not anyone looks. A superposition, by
contrast, is defined by what happens when you *do* look: it collapses, irreversibly and
probabilistically. The single feature that makes a qubit a qubit is the feature independence does
not have. So "independent sentences are in superposition" is a mood, not a mechanism, and the seed
conversation's placement of unprovable sentences on the equator (`conv-falsifiability.md:134`)
inherits that defect.

**Where the centre does better than the equator.** For an *open* question, the centre is right:
maximum entropy, no information, every measurement fifty-fifty. But for a **proven independent**
sentence the centre is wrong for the opposite reason: independence is a hard-won meta-theorem, so
the state recording it should be *informative*, not maximally ignorant. Neither the centre nor the
equator is the home of a Goedel sentence, and §1 explains why not: "provably independent" is a
conjunction of two facts about two different questions, hence a two-qubit fact. Forcing it into one
qubit is what produces the seed conversation's self-contradiction between `:124` and `:134`.

**Where the analogy genuinely earns its keep: mixtures over models.** This is the defensible
reading and it is worth stating carefully. Con(PA) is true in the standard model $\mathbb{N}$ and
false in some model of $\mathrm{PA} + \neg\mathrm{Con}(\mathrm{PA})$. Given a weight $\mu$ over
models, the sentence's state is

$$
\rho_P \;=\; \mu(\{M : M \models P\})\,\ket{0}\bra{0} \;+\; \mu(\{M : M \models \neg P\})\,\ket{1}\bra{1}
$$

This is a **genuine** density matrix and its logical reading is exact: $z = 2\mu(P) - 1$ is the
model-measure of truth, and the state is mixed precisely when the theory fails to decide $P$. A
sentence the theory proves gets a pure pole; an independent sentence gets a genuinely mixed state.
Everything the owner wanted from "statistical mixture" is delivered.

**And the bill.** Every such $\rho_P$ is **diagonal in the truth basis**, so it lies on the
$z$-axis and nowhere else. The model-ensemble semantics fills exactly the segment from pole to
pole, and no off-axis point is ever produced. Machine-checked as `axis_from_poles` and
`equator_not_from_poles`. Therefore:

> **Under the mixture-over-models reading, the equator, the phase, and the entire $x$-$y$ structure
> of the Bloch ball carry no model-theoretic content whatsoever.** Goedel buys you a segment. The
> ball is surplus, and the surplus needs an independent justification that Goedel does not supply.

Two further honest points about that reading:

- It **requires a measure over models**, and there is no canonical one. Choosing $\mu$ is doing the
  work; the geometry is bookkeeping.
- §4's non-uniqueness cuts both ways here. A density matrix forgets its ensemble, so $\rho_P$ does
  not remember *which* models were weighted. For a logician that is arguably **correct** (a theory
  does not determine its models either), and it is the nicest structural match in the whole essay.
  It also means the state cannot be inverted back to model-theoretic information, so nothing beyond
  $\mu(P)$ is recoverable, which is another way of saying the ball is surplus.

This connects to the owner's own question in `conv-formal-language.md`:

> Are there examples of two sound and complete formal systems that do however provide contradicting
> results (i.e. true in one but false in the other)?

Soundness and completeness are always relative to a semantics, so a disagreement of that kind is a
disagreement *between* semantics, not a contradiction within one. In the present picture, two such
systems are two different measures $\mu$, hence two different $z$ values for the same sentence, and
the "contradiction" is the observation that $z$ is not a property of the sentence alone. That is a
feature of the encoding worth stating explicitly.

**Consistency with [`omniscience.md`](omniscience.md).** That sibling essay argues that Goedel I
does **not** apply to the owner's $\ket{42}$, because applying it would need the large extra
premise that $\ket{42}$-knowledge is a recursively axiomatized arithmetic theory. Nothing here
disagrees. This essay applies Goedel I to **PA**, which is such a theory by hypothesis, so the
premise is discharged rather than smuggled. The two essays also reach the same shape of conclusion
by different routes: in both, the Goedel invocation is the weakest link and the real content is
elsewhere. There it is Lawvere's diagonal; here it is counting and convexity. Both sit in Lean
files that state, explicitly, that they contain no Goedel.

# 7. The intended application: a layered logic core

The 2025-08-08 naming turn asks Bloch-valued truth to serve as the logic core of a **layered**
system: a complete lower layer, an incomplete upper layer, and Bloch-valued truth carrying the
upper layer's indeterminacy. That is a much sharper target than the seed conversation's, and the
pole assignment should be judged against it. Three things follow, one corrective and two
constructive.

## 7.1 "ZF without C" does not buy completeness

The parenthetical premise is "core layer should only be complete, e.g. ZF without C". Dropping the
axiom of choice does not do that, and the reason is short:

- **Goedel I applies to ZF exactly as to ZFC.** Its hypotheses are consistency, effective
  axiomatization, and the interpretation of enough arithmetic (Robinson's Q suffices). ZF meets all
  three, and AC is nowhere in the list. So ZF, if consistent, is incomplete.
- **The independence of AC from ZF *is* an incompleteness of ZF.** Goedel 1938 (the constructible
  universe $L$) shows $\mathrm{Con}(\mathrm{ZF}) \to \mathrm{Con}(\mathrm{ZFC})$, so ZF does not
  refute AC. Cohen 1963 (forcing) shows ZF does not prove it. Together, AC is a sentence ZF neither
  proves nor refutes. **"ZF without C" is therefore an *instance* of the phenomenon it was chosen
  to avoid, not an escape from it**, and its most famous undecided sentence is C itself.

This is one slip in a parenthesis written during a project-management conversation, not a defect in
the idea. The architecture survives it intact, because a complete core is available; it just has to
be chosen for a different reason.

## 7.2 What a complete core would actually be

The property the core needs is **completeness and decidability**, and that is a property of
*expressive weakness*, not of axiom count. Set theory cannot supply it at any C, because
interpreting arithmetic is precisely what forfeits it. Real candidates, all classical results:

| Core candidate | Status | Source |
|---|---|---|
| Propositional logic | complete, decidable (co-NP-complete) | Post 1921 |
| **Presburger arithmetic** (naturals with $+$, no $\times$) | complete, decidable | Presburger 1929 |
| **Real closed fields** (hence school algebra and much geometry) | complete, decidable | Tarski 1948, quantifier elimination |
| **Tarski's elementary geometry** | complete, decidable | Tarski 1959 |
| Algebraically closed fields of fixed characteristic | complete, decidable | Tarski |
| Dense linear orders without endpoints | complete, decidable | Cantor |

The owner's own `conv-euclid-set.md` (2025-08-08, the same day as the naming turn) asks how the
Euclidean axioms relate to ZF(C), and the answer relevant here is exactly this table's fourth row:
**elementary geometry is complete and decidable while set theory is neither.** The core he wanted
already exists in his own question from that day. Multiplication is where the boundary sits:
Presburger is complete, and adding $\times$ makes it Peano and incomplete.

So the layering is achievable. The rule is: **the core is chosen for decidability, and everything
that interprets arithmetic goes upstairs.**

## 7.3 A candidate thesis statement for "Bloch Truth"

Given 7.1 and 7.2, the upper layer is incomplete by construction, and the interesting question
becomes what it can *tell the core*. A decidable core cannot reason inside an incomplete layer; it
can only consume that layer's reports. What must such a report contain? Two things, and only two:
which way the upper layer leans, and how settled that lean is. Those are exactly the two Bloch
coordinates §2 isolated, and they are the two coordinates the density matrix actually separates.

> **Candidate thesis.** *Bloch-valued truth is a **report format**, not a logic.* It is the claim
> that a layer which cannot decide its own sentences should hand a decidable consumer a **pair**:
> a truth lean $z$, read as a Born probability $p = (1+z)/2$, and a determinacy $r$, read through
> the von Neumann entropy $S = h((1+r)/2)$, with the constraint $|z| \le r$ enforcing that
> confidence is never cheaper than information. The core then reasons about the *report*, which is
> a pair of reals and therefore stays inside a decidable theory of the reals, rather than about the
> undecidable sentence.

That thesis has three properties worth noting, and they are why it is offered rather than a looser
formulation:

1. **It is falsifiable within this cluster.** §6 shows that a mixture over models fills only the
   $z$-axis. So the *minimal honest* version of the report is a segment, $r = |z|$, and the ball is
   an extension requiring separate justification. If no such justification is found, the thesis
   survives in its segment form and the sphere is decoration. That is a real risk to the idea and
   it should be stated as one.
2. **It explains the constraint $|z| \le r$ instead of merely noting it.** A report cannot be more
   confident than it is informed. The geometry enforces that for free, which is the strongest
   argument in the essay for the Bloch ball over an unconstrained pair of numbers.
3. **It is consistent with the `conv-ternary.md` neural-network turn**, where the owner proposed
   the Bloch radius as a calibrated uncertainty signal. Under this thesis those are the same
   proposal: in both cases $r$ is the layer's report of its own determinacy, and the consumer is
   whatever sits downstream.

**Does the recommended pole assignment serve the role?** Encoding (b) does, and encoding (a) does
not. The core's question to the upper layer is operational: "does a proof exist?", a question with
two outcomes that the upper layer can actually attempt. "Is it true?" is not such a question, since
truth is model-relative and the upper layer cannot answer it at all. And the two-qubit form of
recommendation 3 is precisely what a layered reporter needs, because a core must distinguish "the
upper layer refuted it" from "the upper layer could not settle it", and those differ only in the
second qubit.

**Relation to `TODO.md:127` (`id:4bb2`).** That item records the "Bloch Truth" essay as **BLOCKED**
because a 2026-07-17 meeting found no thesis statement in 412 session files. The box above is
offered as a candidate unblocker. It is an AI proposal and settles nothing: whether it is *the*
thesis is the owner's ruling, and item 12 in §9 puts it there.

# 8. What the Lean file actually discharges

[`lean/LogicBloch.lean`](lean/LogicBloch.lean) compiles against the repo's pinned toolchain with
**exit code 0 and zero `sorry`**, checked by

```
cd verify && ../docs/dreamed/capped.sh -m 4G -c 100 -- \
    lake env lean --threads=1 ../docs/dreamed/lean/LogicBloch.lean
```

It proves three small, real things and states loudly what it does not prove.

| Handle | Theorem | Content |
|---|---|---|
| `poles-2` | `no_two_pole_encoding` | No injection from three statuses into two poles. §1's pigeonhole. |
| `two-orders` | `orders_differ` | $\le_t$ and $\le_k$ on `FOUR` are distinct relations, witnessed by $\mathbf{T}, \mathbf{B}$. |
| `not-total` | `leT_not_total` | Neither order is total, so no single scalar carries either faithfully. |
| `z-affine` | `zc_mix_affine` | $z$ is affine under mixing. |
| `r-drop` | `rsq_not_affine` | $|\mathbf{r}|^2$ is not, witnessed by the equal mixture of the poles. |
| `equator-vs-centre` | `equator_two_kinds` | Two points with $z = 0$ and different radius. |

Plus the FDE facts the essay leans on: both orders are partial orders, all four bilattice
operations are interlaced, negation is antitone for $\le_t$ and **monotone** for $\le_k$ (which is
why information is an axis negation cannot move), `lem_fails` at the gap and `glut_designated` at
the glut.

**What it does not prove, and says so in its header:** nothing about quantum mechanics (`Bloch` is
a bare triple of reals with no positivity constraint and no Hilbert space), nothing about Goedel
(no arithmetic, no provability predicate; `Status.independent` is an opaque constructor and its
inhabitation for PA is Goedel's business), no bilattice structure on the continuous ball, and no
orthomodularity. §5's non-distributivity example is cited from the literature and computed by hand
above, not machine-checked.

# 9. Surfaced for the owner

Each item is a located claim plus the ruling it needs. **None of these is decided, and none has
been written into `TODO.md`, `ROADMAP.md`, or `REVIEW_ME.md`.**

1. **Adopt encoding (b) for the poles: `provable` against `not provable`.** Located: §1. It is the
   only one of the four candidates that is both exclusive and exhaustive, and the only one matching
   a real two-outcome procedure. **Ruling needed:** accept the cost (the south pole conflates
   refutable with independent) or reject the encoding.

2. **Retire encoding (c), `true` against `unprovable`, as refuted rather than merely awkward.**
   Located: §1, and the answer to the owner's own question at `conv-falsifiability.md:462`. Its
   poles are co-instantiated by the Goedel sentence, so they are not exclusive, and all three
   rescues in the export fail, one of them (`:519-522`) because global phase is unobservable.
   **Ruling needed:** confirm the refutation, or state a reading of "true" under which $G_{PA}$ is
   not true.

3. **The right object is two qubits, not one, and it is Belnap-Dunn.** Located: §1 and §3.1. The
   pair (proof of $P$ exists, proof of $\neg P$ exists) is two questions, four outcomes, and it
   satisfies the pigeonhole exactly. The owner's own `conv-peano.md` request for sentences that are
   both true and false *and* sentences that are neither is a four-valued request, not a
   three-valued one. **Ruling needed:** whether "Bloch Truth Mapping" is willing to become a
   two-qubit construction. If yes, the entanglement between for-evidence and against-evidence is
   new structure with no classical counterpart, and is the most promising unexplored direction in
   the whole cluster.

4. **The Bloch ball cannot represent a glut.** Located: §3.1. FDE's $\mathbf{B}$ is strictly above
   both $\mathbf{T}$ and $\mathbf{F}$ in the information order, and the ball has nothing above a
   pure state. The ball is Kleene, not Belnap. **Ruling needed:** accept the restriction (the
   construction models gaps only), or accept the $r > 1$ reading in which the glut is exactly where
   positive semidefiniteness fails, which is the owner's own `conv-blochsphere.md` question
   answered from the logic side.

5. **The equator means "a different question", not "indeterminate truth".** Located: §2, §5. A pure
   equatorial state is a sharp eigenstate of $\sigma_x$ and is mutually unbiased with respect to the
   truth question. **Ruling needed:** what proposition-property the $x$-observable measures. Handed
   to [`logic-bloch-gates.md`](logic-bloch-gates.md), which can read it off the gate fixed points.

6. **The centre is "no information", and it is the home of an OPEN question, not of a proven
   independent one.** Located: §2, §6. The seed's export asserts both readings twelve lines apart
   (`:124` versus `:134`) and they are incompatible. **Ruling needed:** confirm that proving
   independence is informative and therefore cannot sit at maximum entropy.

7. **Goedel buys the $z$-axis diameter and nothing else.** Located: §6, machine-checked as
   `axis_from_poles` and `equator_not_from_poles`. Every ensemble over models is diagonal, so the
   equator and the phase have no model-theoretic content. **Ruling needed:** whether the surplus
   structure is to be justified independently (from proof dynamics, from gate action, from
   something else) or dropped, in which case a probability suffices and no qubit is needed.

8. **Is the knowledge order on the ball a genuine lattice?** Located: §3.1, unresolved. Mixing
   supplies a meet-like operation but two distinct pure states have no upper bound in purity, so
   the ball looks like a meet-semilattice with no joins, which is half a bilattice. **Ruling
   needed:** none from the owner; this is a mathematical question, decidable by writing the
   candidate join down and checking interlacing. Cheapest open item in the essay.

9. **Gleason does not apply at dimension 2, and does at dimension 3.** Located: §5. On a single
   qubit the density matrix is a modelling choice, and a non-contextual hidden-variable model
   exists (Bell 1966). On a qutrit both facts reverse. **Ruling needed:** whether this is accepted
   as a positive argument for the qutrit route in
   [`logic-qutrit-su3.md`](logic-qutrit-su3.md), rather than the QCD analogy, which is decoration
   by comparison.

10. **State which theory the construction is indexed to.** Located: §1, prompted by the owner's own
    `conv-euclid-set.md` question. Presburger arithmetic is complete and decidable, so the third
    status is uninhabited there and encoding (a) is fine. The whole problem is a property of
    theories interpreting enough arithmetic. **Ruling needed:** fix the theory, or state that the
    construction is meant to range over theories, in which case the theory is a second index and
    the state space is a family.

11. **"ZF without C" is not a complete core.** Located: §7.1, against
    `~/knowledge/sessions/claude-ai/2025-08-05_breaking_project_paralysis_cbae6cd6.md:1334`
    ("core layer should only be complete, e.g. ZF without C"). Goedel I needs consistency,
    effective axiomatization and enough arithmetic; AC is not among its hypotheses, so ZF is
    incomplete if consistent. And the independence of AC from ZF (Goedel 1938, Cohen 1963) is
    itself an incompleteness of ZF, so the chosen core's most famous undecided sentence is the very
    axiom that was dropped. **Ruling needed:** replace the core with a decidable theory (§7.2's
    table; Tarski's elementary geometry and Presburger are the obvious two), or state a different
    sense of "complete" that ZF does satisfy. The architecture is unaffected either way; only the
    example changes.

12. **A candidate thesis statement for "Bloch Truth", offered as an unblocker for
    `TODO.md:127` (`id:4bb2`).** Located: §7.3. *Bloch-valued truth is a report format, not a
    logic*: the pair (truth lean $z$, determinacy $r$) with $|z| \le r$ is what an incomplete layer
    hands a decidable core, so the core reasons about a pair of reals instead of about an
    undecidable sentence. `id:4bb2` is blocked on the 2026-07-17 finding that no thesis exists in
    412 session files. **Ruling needed:** whether this is the thesis, a near miss, or wrong. It is
    an AI proposal and nothing has been written to `TODO.md`; a delegated verdict is a
    recommendation, never a self-settling decision. Note also that §6 puts a real risk on it: if
    the off-axis structure never earns a justification, the honest thesis is about a *segment* and
    the sphere is decoration.

13. **Which ternary logic, if the two-qubit route is rejected?** Located: §3. K3, Ł3 and Bochvar
    give three different answers for the same three values, and the seed conversation used all
    three readings in different turns. **Ruling needed:** the intended meaning of the third value
    (unknown, undecidable, or meaningless), which fixes the logic; it is a modelling decision and
    therefore the owner's, not the AI's.

# A future `.mw` sketch

What a `.mw` document would carry, in the style of `verify/mirror/resogram_esol.mw`. Sketch of
intent, not a runnable mirror; these are Lean-tier claims and route to the Lean backend.

```computation
# handle: poles-2. Three statuses, two antipodal outcomes, no injection.
Status = {provably_true, provably_false, independent}
poles  = Not(Exists(e, And(Maps(e, Status, Bool), Injective(e))))
```

```computation
# handles: z-affine, r-drop. The two coordinates behave differently under mixing.
rho(t, a, b) = t*a + (1-t)*b
z_affine     = Eq(z(rho(t,a,b)), t*z(a) + (1-t)*z(b))
r_drop       = Not(Eq(rsq(rho(Rational(1,2), north, south)),
                      Rational(1,2)*rsq(north) + Rational(1,2)*rsq(south)))
```

```computation
# handles: two-orders, not-total. FOUR carries two distinct, non-total orders.
two_orders = And(leK(T, B), Not(leT(T, B)))
not_total  = And(Not(leT(N, B)), Not(leT(B, N)))
```

# Follow-up leads

1. **Compute the candidate knowledge-order join on the ball and test interlacing.** Decidable by
   arithmetic alone, no owner ruling needed. Item 8.
2. **Read the $x$-observable off the gate fixed points.** Handed to
   [`logic-bloch-gates.md`](logic-bloch-gates.md); the $\sigma_x$ eigenstates are exactly the
   NOT-invariant states, which the seed conversation already noticed without drawing the
   conclusion.
3. **Two-qubit FDE: what does entanglement between for-evidence and against-evidence mean?** The
   product of two Bloch balls is 6-dimensional; the joint state space is 15-dimensional. The
   difference is the surplus, and it has no classical Belnap counterpart. Item 3.
4. **Does a Ł3 reading survive on the ball?** Ł3 differs from K3 only in implication, and no
   implication has been given a Bloch reading anywhere in the cluster. Decidable by trying.
5. **Check whether the negative-eigenvalue reading of the glut lines up with Wigner negativity as a
   resource.** If it does, "paraconsistency is the non-classical resource" becomes a sharper claim
   than an analogy. Item 4.

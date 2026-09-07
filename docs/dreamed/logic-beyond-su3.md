---
title: "Beyond SU(3): what else can carry a logic of provability?"
permalink: /dreamed/logic-beyond-su3
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This file *proposes*; the owner disposes. Nothing here is toesnail theory, and nothing may be
> promoted into `physics/` or `essays/` without the owner authoring the move himself. The `\veq`
> badges below claim something about [`lean/LogicBeyondSU3.lean`](lean/LogicBeyondSU3.lean)
> **only**, and are deliberately not wired into `physics/*.toml` or `tests/test_verify.sh`.

# Seed and provenance

The owner's instruction this session, verbatim:

> "Also explore non-SU(3) representations of non-trivial logic that considers provability /
> undecidability etc"

The direct predecessor is [`logic-qutrit-su3.md`](logic-qutrit-su3.md), which took the qutrit
route: three basis states $\ket{\text{proven true}}$, $\ket{\text{proven false}}$,
$\ket{\text{undecidable}}$, mixed states as a convex body in the 8-dimensional Gell-Mann space, and
one theorem worth the trip, that the body is **not** a ball. Its sibling
[`logic-bloch-poles.md`](logic-bloch-poles.md) fixed the pole assignment and showed the ball is
Kleene rather than Belnap; [`logic-bloch-gates.md`](logic-bloch-gates.md) read the gates and found
no rotation-covariant order on the equator. The application all three are aimed at is the owner's
own, stated on 2025-08-08 in
`~/knowledge/sessions/claude-ai/2025-08-05_breaking_project_paralysis_cbae6cd6.md:1334`:

> "the Bloch Truth (might need a better name) might be useful for the AI logic core in the second
> (ZFC?) layer where incompleteness applies (core layer should only be complete, e.g. ZF without C)"

So the target is a **layered** reasoner. This essay asks what other mathematics could carry that
upper layer, and it ends with a ranking rather than a menu, because the owner asked for a
recommendation. A sibling agent is developing the "state over models" reading in
`docs/dreamed/logic-models-ensemble.md`; §4 here treats Stone duality as a *representation* and
leaves the ensemble semantics to that file.

# 0. The headline, stated and not teased

**Recommendation: Heyting algebras win, and the reason is a structural gap in the qutrit that has
nothing to do with dimension counting.**

A qutrit gives you truth *values* and no *connectives*. That is not a modelling gap to be filled
later; it is a theorem. Take the natural order on quantum states, the Löwner order
$\rho \le \sigma \iff \sigma - \rho \ge 0$. On density matrices it collapses instantly: if
$\rho \le \sigma$ and $\operatorname{Tr}\rho = \operatorname{Tr}\sigma = 1$, then
$\sigma - \rho \ge 0$ has trace zero, hence is zero. **Distinct density matrices are never
comparable.** The Bloch body is an antichain: as an ordered structure it is flat, so it has no
meets, no joins, and therefore no residuated implication of any kind. One step up, on the *effects*
$[0, I]$ where a non-trivial order does live, Kadison's anti-lattice theorem (1951) says
$\inf\{S,T\}$ exists in $B(H)_{sa}$ **iff** $S$ and $T$ are comparable, so that order is not a
lattice either as soon as $\dim H \ge 2$. There is no $\wedge$ to be residuated against, so there
is no $\to$.

A Heyting algebra is *defined* by having exactly that missing arrow: $a \Rightarrow b$ is the
largest $c$ with $c \wedge a \le b$. It is the algebra of "provable" rather than "true" under the
Brouwer-Heyting-Kolmogorov reading, its Kripke semantics is literally a poset of information states
ordered by *knowledge grows*, and its topos semantics replaces the two-element truth object by an
object $\Omega$ that is a Heyting algebra. Three further facts settle the ranking:

1. **Gödel 1932: intuitionistic propositional logic has no finite characteristic matrix.** No
   assignment of finitely many truth values, three included, has exactly the intuitionistic
   theorems as its tautologies. A trit cannot be the semantics of constructive provability, and
   neither can a 27-valued anything. This is the single hardest result against the whole
   $n$-valued programme, and it predates every candidate in this essay.
2. **Provability logic GL is about provability by construction, not by analogy**, and it is
   **decidable (PSPACE-complete)** while the theory it describes is not. Solovay (1976) proved
   $\mathrm{GL} \vdash A$ iff $\mathrm{PA} \vdash f(A)$ for every arithmetical realisation $f$. If
   the owner wants a *decidable core reasoning about an undecidable layer*, that pair of facts is
   the layered architecture, already built, already complete, already sound.
3. **The physics community that owned the orthomodular lattice moved to Heyting algebras.** The
   topos approaches to quantum theory (Isham-Döring; Heunen-Landsman-Spitters) replace the
   orthomodular lattice of projections with "the (complete) Heyting algebra of closed open
   subobjects of the spectral presheaf". If the aim is a logic *for quantum-flavoured states*, the
   people who tried hardest ended up where §2 ends up.

The negative result the essay owes the owner: **for everything on his own list except one item, a
classical 2-simplex suffices and the SU(3) apparatus is unnecessary.** The one item is Gleason's
theorem forcing the density-matrix form at $\dim \ge 3$, and that only binds if you have already
accepted the quantum measurement postulates, which a logic has no reason to accept. §8 states this
carefully, because it is the most expensive thing in the essay if true.

Full ranking with the criterion in §12.

# 1. The yardstick, stated before the candidates

A survey that grades candidates against criteria invented afterwards proves nothing. So the
desiderata come first, and they are read off the owner's own stated application, not chosen for
convenience.

| | Desideratum | Where it comes from |
|---|---|---|
| **D1** | "Not settled" is a first-class status, not a probability and not ignorance | `conv-falsifiability.md`: "how to encode that a statement is unprovable" |
| **D2** | Distinguish *proven independent* from *no idea* | `logic-qutrit-su3.md` §6.2; the two land in the same place under an ensemble reading |
| **D3** | Carry a **degree** of settledness, continuously | the origin turn's interest in mixed states; `conv-ternary.md`'s calibrated-uncertainty reading of the radius |
| **D4** | Present a **decidable** interface to a consumer | the origin turn: "core layer should only be complete" |
| **D5** | Be **about** provability, not analogous to it | the whole point of the exercise |
| **D6** | Support the **connectives**, so one can reason *in* it rather than merely label with it | implicit in "logic core"; a labelling scheme is not a logic |

D6 is the one the qutrit fails, and it is the one this essay adds. The three sibling essays all
graded the Bloch/qutrit picture on D1-D5 and found it strong on D1 and D3, mixed on D2, absent on
D4, and weak on D5. None of them asked D6, and D6 is where the argument actually ends.

**Why D6 is not negotiable.** A logic core has to compute. Given the layer's verdict on $\varphi$
and its verdict on $\psi$, it must produce a verdict on $\varphi \wedge \psi$ and on
$\varphi \to \psi$. A state space with no operations supporting that is a *reporting format*, which
is exactly the honest thing `logic-bloch-poles.md` §7.3 proposed the Bloch ball be. That proposal
survives this essay untouched; what does not survive is calling it a logic.

# 2. Candidate 1: Heyting algebras and intuitionistic logic

## 2.1 What the object is

A **Heyting algebra** is a bounded lattice $(H, \wedge, \vee, \bot, \top)$ with a binary operation
$\Rightarrow$ satisfying the residuation law

$$ c \le (a \Rightarrow b) \quad\Longleftrightarrow\quad c \wedge a \le b \ltag{residuation} $$

so $a \Rightarrow b$ is the **relative pseudocomplement**: the largest truth value whose conjunction
with $a$ stays below $b$. Negation is defined, not primitive: $\neg a := (a \Rightarrow \bot)$.

Two consequences, and the contrast between them is the whole subject.

**Non-contradiction survives.** $a \wedge \neg a = \bot$ holds in *every* Heyting algebra, with no
hypothesis. Constructive logic never gave up the law that a proof of $a$ and a proof of $\neg a$
together are absurd. In Lean this is `heyting_noncontradiction`, a one-liner.

**Excluded middle does not.** $a \vee \neg a = \top$ is an extra assumption, and assuming it
destroys everything else:

$$ (\forall a,\ a \vee \neg a = \top) \;\Longrightarrow\; (\forall a,\ \neg\neg a = a) \ \text{and}\ \forall a,\ \text{$a$, $\neg a$ are complements} \veq{heyting-collapse}\lean $$

That is the **collapse theorem**, `heyting_lem_forces_dne` and `heyting_lem_forces_isCompl`. The
proof is four lines: cut the assumed unit $a \vee \neg a$ with $\neg\neg a$, distribute (a Heyting
algebra is automatically distributive), kill the $\neg\neg a \wedge \neg a$ branch by
non-contradiction, and what remains is $\neg\neg a = \neg\neg a \wedge a \le a$. A Heyting algebra
satisfying excluded middle **is** a Boolean algebra. So intuitionistic logic is not "classical logic
with a rule removed and nothing put back"; it is the exact structure that has room for an
intermediate status at all, and the room closes the instant you assume every sentence is decided.

**The negation hierarchy has exactly two levels.** $\neg\neg\neg a = \neg a$ is an intuitionistic
theorem (`heyting_triple_compl`). So "not refutable" is a genuinely new status while "not not
refutable" is not a third one. That is a real answer to a question the seed conversation kept
circling: the tower of hedges does not go on forever.

## 2.2 The concrete countermodel, and its honest limit

The three-element chain $0 < 1 < 2$ carries a Heyting structure in which the middle element behaves
exactly as wanted. Its negation is $\bot$, because from "not settled here" no contradiction follows:

$$ 1^{c} = 0, \qquad 1 \vee 1^{c} = 1 \ne \top, \qquad 1^{cc} = \top \ne 1 \veq{lem-fails}\lean $$

`chain3_compl_mid`, `chain3_lem_fails`, `chain3_dne_fails`, all by `decide`. Excluded middle fails
and double negation elimination fails, concretely, in an algebra with three elements.

This chain is, up to isomorphism, three things at once, and each identification is worth naming:

- the frame of **open sets of the Sierpiński space** $\{\emptyset, \{1\}, \{0,1\}\}$;
- the algebra of **up-sets of the two-world Kripke frame** $w_0 \le w_1$, i.e. "one state of
  information, and one strictly better one";
- the three-element **Gödel chain** $G_3$.

**And now the limit, stated because the essay would otherwise overclaim.** The chain still
satisfies *weak* excluded middle $\neg a \vee \neg\neg a = \top$ and the Gödel-Dummett
**prelinearity** axiom $(a \Rightarrow b) \vee (b \Rightarrow a) = \top$ (`chain3_weak_lem`,
`chain3_prelinearity`, both `decide`). So it is a model of Gödel logic $G_3$, strictly *between*
intuitionistic and classical logic, not a countermodel for every non-classical principle one might
want. To refute weak excluded middle you need a **non-directed** frame: $w_0 \le w_1$, $w_0 \le w_2$
with $w_1, w_2$ incomparable, where $a := \{w_1\}$ has $\neg a = \{w_2\}$, $\neg\neg a = \{w_1\}$
and $\neg a \vee \neg\neg a = \{w_1,w_2\} \ne \top$. That branching frame is stated here and is
**not** in the Lean file.

## 2.3 Kripke frames: the information order is the owner's $r$ axis, made honest

This is the sharpest available link between candidate 1 and the owner's own picture, so it gets its
own treatment rather than a sentence.

A **Kripke model** for intuitionistic logic is a poset $(W, \le)$ of *information states* with a
valuation satisfying **persistence**: if $w \Vdash p$ and $w \le v$ then $v \Vdash p$. Once
established, always established. The clauses that make it intuitionistic rather than classical are
the two that quantify over the future:

$$ w \Vdash A \to B \iff \forall v \ge w,\ (v \Vdash A \Rightarrow v \Vdash B), \qquad w \Vdash \neg A \iff \forall v \ge w,\ v \nVdash A \ltag{kripke} $$

**Read that second clause slowly.** $\neg A$ at $w$ does not say "$A$ is false here". It says "$A$
will never be established, no matter how much more you learn". That is *exactly* the distinction
the qutrit essay's §6.2 was reaching for between **proven independent** and **no idea**: refutation
is a claim about every future information state, ignorance is a claim about the present one. Kripke
semantics builds that distinction into the definition of $\neg$, at zero cost, with no third basis
vector.

**The correspondence with the Bloch reading, stated precisely and with its failure.** The partial
order $\le$ on $W$ *is* "knowledge grows", and it is what `logic-bloch-poles.md` §2 isolated as the
radius $r$: the ball's centre is no information, the boundary is maximal information. The
correspondence is real and it is also **not an isomorphism**, in a way that favours Kripke on two
counts and the ball on one.

| | Bloch radius $r$ | Kripke order $\le$ |
|---|---|---|
| shape of "more informed" | a **total** order on $[0,1]$ | an arbitrary **partial** order |
| branching futures | impossible: $r$ is a scalar | native, and it is exactly what refutes weak excluded middle (§2.2) |
| what "maximally informed" means | one point per direction, a pure state | a maximal world; there may be many, and they are the **complete consistent extensions** (§4) |
| quantitative degree | yes, $r$ is a real number | no, $\le$ is qualitative |
| Belnap glut | **impossible**, nothing sits above a pure state (poles essay, result 2) | equally impossible, and for the same reason: persistence is monotone |

The **one thing the ball has and Kripke lacks is D3**, a quantitative degree. The two things Kripke
has and the ball lacks are branching (D2, sharpened) and the connectives (D6). §5 asks whether a
structure can have all three.

Both semantics are **sound and complete** for intuitionistic propositional logic (Kripke 1965 for
frames; the Lindenbaum-Tarski construction gives the algebraic side), and IPC has the finite model
property and is **decidable**, PSPACE-complete. That is D4, satisfied.

## 2.4 Topos semantics: the truth object is not $\{0,1\}$

In a topos, the role of the two-element set of truth values is played by the **subobject
classifier** $\Omega$, and in a general topos $\Omega$ is an internal **complete Heyting algebra**
rather than a Boolean algebra. Subobjects correspond to propositions and the logical operations are
categorical constructions, so the internal logic of any topos is intuitionistic; it is classical
exactly when $\Omega \cong 1 + 1$.

Two special cases matter here.

**Presheaf toposes over a poset.** The Kripke-Joyal semantics of the functor topos
$[\mathcal{C}, \mathbf{Set}]$ *is* Kripke semantics, with $\mathcal{C}$ the poset of information
states. So §2.3 and §2.4 are not two candidates, they are one candidate in two languages, and the
translation is exact rather than analogical. That matters for the owner's economy: adopting the
Kripke reading costs nothing extra if he later wants the categorical one.

**The topos approach to quantum theory.** This is the fact that decides the essay's comparison with
candidate 5. Isham-Döring (contravariant, on the spectral presheaf) and Heunen-Landsman-Spitters
(covariant, on the poset of commutative subalgebras) both build a topos out of a quantum system, and
both replace the orthomodular lattice with a Heyting algebra. Wolters's comparison paper states it
plainly: "the intuitionistic logic of this approach is given by the (complete) Heyting algebra of
closed open subobjects of the spectral presheaf". The Heunen-Landsman-Spitters information order
also matches physical intuition directly: a smaller commutative subalgebra is *lower* in the Kripke
model's information order. **The field that owns quantum logic migrated from candidate 5 to
candidate 1.** That is prior art the owner should have, and it is an argument he cannot get from
inside the Bloch picture.

## 2.5 Gödel 1932: the result that ends the $n$-valued programme

In 1932 Gödel gave a short argument that **intuitionistic propositional logic has no finite
characteristic matrix**: there is no realisation with finitely many truth values whose tautologies
are exactly the intuitionistically provable formulas. He did it by exhibiting the chains $G_2
\supset G_3 \supset G_4 \supset \dots$ (each $G_n$ the $n$-element chain, maximal element
designated), producing a strictly descending chain of logics all containing IPC, hence also showing
there are countably many intermediate logics.

**What that costs the qutrit.** Any scheme that assigns each sentence a value from a fixed
$n$-element set and computes connectives by tables is an $n$-valued matrix. If the intended logic is
constructive provability, Gödel 1932 says no such table exists, for $n = 3$ and for every finite
$n$. The qutrit's three basis states are not a counterexample only because they are not a *logic* in
the first place: they carry no connectives (§0), so there is no matrix to test. That is the same gap
seen from the other end.

**What it does not cost.** $G_3$, the chain of §2.2, is a perfectly good logic; it is just not IPC.
If the owner is content with a linearly ordered degree of settledness and no branching, Gödel logic
is available, complete, decidable, and much simpler than anything quantum. That is a live option and
§12 ranks it.

## 2.6 Cost

Honestly stated, because candidate 1 is the recommendation. **No quantitative degree**: a Heyting
element is a status, not a number, so D3 fails unless the algebra is chosen $[0,1]$-valued (Gödel
logic) or one moves to candidate 4. **No negation-as-involution**: $\neg\neg \ne \mathrm{id}$ is
the point, so the tidy antipodal symmetry is gone (the qutrit loses this too, and worse:
`logic-qutrit-su3.md` §2.3 proved the antipode of a pure state is not a state at all). **It models
provability only under the BHK *reading***: a Heyting algebra contains no provability predicate, it
is the algebra of *constructions*, which is the right shape but an interpretation rather than a
formalisation. Candidate 2 closes exactly that gap, which is why §12's recommendation is a pair.
And **undecidability is not represented as such**: an intermediate element says "not established
here", not "provably not establishable anywhere". §3 and §4 do that.

# 3. Candidate 2: provability logic GL

## 3.1 What the object is

$\mathrm{GL}$ (Gödel-Löb) is the modal logic obtained from $\mathbf{K}$ by adding **Löb's axiom**

$$ \Box(\Box A \to A) \to \Box A \ltag{loeb} $$

with the reading $\Box A = \mathrm{Prov}_T(\ulcorner A \urcorner)$, "$A$ is provable in $T$". The
whole structure rests on the **Hilbert-Bernays-Löb derivability conditions**, which PA's provability
predicate satisfies: (1) if $T \vdash A$ then $T \vdash \Box A$; (2)
$T \vdash \Box(A \to B) \to (\Box A \to \Box B)$; (3) $T \vdash \Box A \to \Box\Box A$.

This is the one candidate in the survey that is **about** provability by construction rather than by
analogy (D5, satisfied outright). $\Box$ is not a metaphor for epistemic hedging; it is the
arithmetised provability predicate, and $\Box \bot$ is literally the sentence "$T$ is inconsistent".

## 3.2 Löb's rule and Gödel II in three lines

From Löb's axiom plus modus ponens and necessitation, **Löb's rule** follows: if $T \vdash \Box A
\to A$ then $T \vdash A$. Necessitate the hypothesis to get $\Box(\Box A \to A)$, detach
$\eqref{loeb}$ to get $\Box A$, detach the hypothesis to get $A$. Then set $A := \bot$. Since
$\mathrm{Con}_T$ *is* $\Box\bot \to \bot$:

$$ T \nvdash \bot \;\Longrightarrow\; T \nvdash \mathrm{Con}_T \veq{loeb-g2}\lean $$

`loeb_rule`, `godel_two`. Gödel's second incompleteness theorem is a corollary of Löb's axiom at one
instance. The same instance gives `no_global_reflection`: a consistent system cannot prove the
reflection schema $\Box A \to A$ for every $A$.

**Read as a slogan for the layered core:** a theory that can prove "if I can prove it, it is true"
has thereby already proved it. Self-trust is never free, and an upper layer cannot certify its own
soundness to a lower one. That is the sharpest available statement of what the owner's architecture
must live with, and it is three lines of modal bookkeeping.

**What the Lean file does not do**, said plainly so the badge is not over-read: it proves nothing
about PA. The hard half of the real theorem is that PA's $\mathrm{Prov}$ satisfies the derivability
conditions, which requires arithmetisation of syntax and is formalised nowhere in this repo. The
file proves the modal half, over an abstract `GLSystem`, plus a non-vacuity witness.

## 3.3 The fact the owner will want: GL is decidable, PA is not

Three results, all classical:

- **Segerberg (1971).** GL is modally complete with respect to **finite transitive irreflexive
  trees**. Irreflexivity is the modal shadow of Löb's axiom; it is why $\Box$ has no fixed point and
  why the frames are converse well-founded.
- **Decidability.** That completeness yields a decision procedure by depth-first search through
  irreflexive transitive trees of bounded depth. **GL is decidable, and PSPACE-complete.**
- **Solovay (1976).** Arithmetical soundness *and* completeness:
  $\mathrm{GL} \vdash A$ **iff** $\mathrm{PA} \vdash f(A)$ for every arithmetical realisation $f$.
  Solovay's construction simulates a finite Segerberg tree inside PA. His second theorem identifies
  the logic of *arithmetical truth* rather than provability as $\mathrm{GLS} = \mathrm{GL} + (\Box A
  \to A)$, which is sound but **not closed under necessitation** -- exactly the asymmetry §3.2 turns
  into Gödel II.

**Why this is the headline for the owner's application.** He asked for a layered system: a complete,
decidable core and an incomplete upper layer, with the core reasoning *about* the upper layer. That
is not an aspiration to be engineered. It is Solovay's theorem. GL is a **decidable, complete,
finitely axiomatised propositional logic that is provably exactly the logic of an undecidable,
incomplete theory's provability predicate.** The core can decide any GL question in PSPACE and its
answers are guaranteed correct about PA. Nothing else in this survey delivers D4 and D5
simultaneously, and this delivers them with a completeness theorem.

## 3.4 The topological semantics, which is where geometry legitimately enters

Since the owner's instinct is geometric, the honest geometric home for provability is not a Bloch
ball but a **scattered topological space**. Simmons and Esakia found in the 1970s that $\Diamond$,
consistency, has the properties of the **Cantor derivative** (derived-set operator) on a scattered
space, so $\Box A = A \cup \mathrm{int}\,A$ in the derivative sense. Beklemishev and Gabelaia's
survey (arXiv:1210.7317) records that topological semantics is strictly more powerful than Kripke
semantics here: the polymodal system GLP is **Kripke incomplete but topologically complete**.

**This is the answer to "has anyone put provability on a geometry", and it is yes, on a topology,
not on a metric ball.** The relevant structure is order-theoretic and separation-theoretic
(scatteredness, ordinals with the interval topology), not metric or convex. That is a real
prior-art finding and it argues against the Bloch route on its own preferred ground.

## 3.5 Cost

**Propositional only.** GL is the logic of a *sentence's* provability status, with no quantifiers
and no term structure; the quantified version is far worse behaved (Vardanyan: the quantified
provability logic of PA is $\Pi^0_2$-complete, hence not recursively axiomatisable). **No degree**:
$\Box A$ is a sentence, not a number, so D3 fails entirely. **Theory-relative by construction**:
$\Box$ is $\mathrm{Prov}_T$ for a *fixed* $T$, a virtue for honesty and a cost for a system meant to
reason across theories. And **$\Box$ is not a truth value**: GL is a logic *about* provability whose
own truth values are the classical two, so if the owner wanted the third status to live in the
*values*, GL puts it in the *modality* instead. That is a genuine design fork, and §12 says which
way to take it.

# 4. Candidate 3: the Lindenbaum-Tarski algebra and Stone duality

Kept short, and cross-referenced rather than duplicated: the sibling
`docs/dreamed/logic-models-ensemble.md` develops the *state over models* semantics. Here the
question is only what this object says as a **representation**.

**The object.** For a theory $T$, quotient the sentences by provable equivalence:
$\varphi \sim \psi$ iff $T \vdash \varphi \leftrightarrow \psi$. The result
$\mathcal{L}(T)$ is a **Boolean algebra**, and it is the syntax's own algebra: $[\varphi] \wedge
[\psi] = [\varphi \wedge \psi]$, $\top = [\text{any theorem}]$, $\bot = [\text{any refutable
sentence}]$.

**Stone duality (1936).** Every Boolean algebra is the algebra of clopen sets of a unique compact
Hausdorff totally disconnected space, its **Stone space** of ultrafilters. For $\mathcal{L}(T)$ the
ultrafilters are exactly the **complete consistent extensions** of $T$. So:

| logic | topology |
|---|---|
| a sentence $\varphi$ | a **clopen** subset $[\varphi] \subseteq S(T)$ |
| $T \vdash \varphi$ | $[\varphi] = S(T)$ |
| $T \vdash \neg\varphi$ | $[\varphi] = \emptyset$ |
| **$\varphi$ independent of $T$** | $[\varphi]$ is a **proper non-empty clopen set** |
| $T$ complete | $S(T)$ is a **single point** |
| $T$ consistent | $S(T) \ne \emptyset$ |
| compactness theorem | $S(T)$ is **compact** |

**That row four is the cleanest representation of undecidability in the whole survey.** No third
truth value, no extra dimension, no stipulation: a sentence is independent exactly when it *splits*
the space of completions, and the degree to which it splits it is a genuine geometric fact about a
genuine space. Incompleteness is *disconnectedness*.

**And the space is identifiable.** The Lindenbaum algebra of any consistent r.e. theory
interpreting Robinson arithmetic is the **countable atomless Boolean algebra** (atomless precisely
because Gödel applies again to $T + \varphi$ for every consistent $\varphi$, so no minimal non-zero
element exists). That algebra is unique up to isomorphism, and its Stone space is the **Cantor
set**. So:

> The space of complete consistent extensions of PA is homeomorphic to the Cantor set.

Perfect, compact, totally disconnected, no isolated points, and every sentence is a clopen piece of
it. If the owner wants a *space* for his logic, this is the one arithmetic actually hands him, and
it is not a ball. Its total disconnectedness is the exact opposite of the Bloch ball's convexity,
and that is not a defect of either: convexity encodes *mixing*, and the Stone space encodes
*deduction*. They are different jobs, which is §11's theme.

**Cost.** D3 fails (there is no degree, only clopen or not), and D6 succeeds but classically: the
algebra is Boolean, so excluded middle holds and the intermediate status lives in the *space*, not
in the *values*. Adding a measure on the Stone space is what recovers a degree, and that is the
ensemble reading the sibling file develops.

# 5. Candidate 4: MV-algebras and effect algebras

This is the candidate that most directly answers the owner's interest in a **continuous** degree of
settledness, so it gets a fair hearing.

## 5.1 MV-algebras

Chang introduced MV-algebras in 1958 to give an algebraic completeness proof for Łukasiewicz
infinite-valued logic. The standard MV-algebra is $[0,1]$ with $x \oplus y = \min(1, x+y)$ and
$\neg x = 1 - x$. **Chang's completeness theorem**: an equation holds in $[0,1]$ iff it holds in
every MV-algebra, so $[0,1]$ plays for MV-algebras the role $\{0,1\}$ plays for Boolean algebras.
Mundici's categorical equivalence with lattice-ordered abelian groups with strong unit gives the
structure theory.

**What is attractive.** A truth value is a real number in $[0,1]$: D3 is satisfied natively and
continuously, which no other candidate manages. Negation is a genuine involution, $\neg\neg x = x$,
so the tidy antipodal symmetry the Bloch picture wanted is *restored*, and restored on an interval
rather than a sphere. Łukasiewicz implication $x \to y = \min(1, 1 - x + y)$ is residuated, so D6
holds. Tautologyhood in $\text{Ł}_\infty$ is decidable (co-NP-complete), so D4 holds.

**What is fatal for the owner's reading, and it is fatal.** The MV value is a **degree of truth**,
not a degree of settledness, and the difference is not philosophical. Łukasiewicz is truth-functional:
$v(\varphi \wedge \psi)$ is a function of $v(\varphi)$ and $v(\psi)$ alone. Provability is not. Take
$\varphi$ independent of $T$, and set $\psi := \neg\varphi$, also independent. Then $\varphi \wedge
\psi$ is *refutable*, while $\varphi \wedge \varphi$ is independent, and the two inputs have the
same values. **No truth-functional assignment can represent independence.** This is the same
objection that kills naive three-valued readings, and it applies with equal force at $n = \infty$;
in fact Gödel 1932 (§2.5) is the sharpest form of it, since it rules out finite matrices for IPC
outright.

So MV-algebras are the right answer to a *different* question: graded, vague, or fuzzy predicates,
where truth-functionality is appropriate. They are the wrong answer to provability. **Recommendation:
reject as the logic; keep as the report codomain**, where a real number in $[0,1]$ is exactly what
`logic-bloch-poles.md` §7.3's report format needs.

## 5.2 Effect algebras, and why they are the honest quantum entry

An **effect algebra** (Foulis-Bennett 1994) is a set with a partial binary $\oplus$, a zero and a
unit, generalising both Boolean algebras and the interval $[0, I]$ of quantum **effects**: positive
self-adjoint operators below the identity. Effects are the *unsharp* propositions of quantum theory,
projections being the sharp ones.

Three facts, in the order that decides the comparison.

1. **This is where the quantum order actually lives.** §0 showed the density matrices form an
   *antichain* under Löwner. The effects do not: $[0,I]$ is a genuinely non-trivially ordered set.
   So if one wants an order-theoretic logic out of quantum mechanics, it must be built on effects,
   not on the Bloch body. **That is a structural correction to the whole "Bloch Truth" framing**,
   and it is free: it says the truth values should be the *questions* (effects), with the state
   assigning each a number, which is the Birkhoff-von Neumann side of §6 generalised to unsharp
   propositions.
2. **But $E(H)$ is not an MV-algebra.** MV-algebras are exactly the lattice-ordered effect algebras
   with the Riesz decomposition property. By Kadison's anti-lattice theorem $E(H)$ is not
   lattice-ordered for $\dim H \ge 2$: $\inf\{S,T\}$ exists iff $S \le T$ or $T \le S$. So the
   quantum interval $[0,I]$, despite looking like the Łukasiewicz interval $[0,1]$, **fails to be
   Łukasiewicz**, and it fails for the same reason the qutrit fails D6. The resemblance is a
   coincidence of notation.
3. **What it does buy.** Effect algebras give an honest home for *degrees of confirmation* attached
   to sharp questions, with the quantum probability rule $\operatorname{Tr}(\rho E)$ built in. If
   the owner wants his radius $r$ to be a real quantum quantity rather than a decoration, this is
   the structure to attach it to.

# 6. Candidate 5: orthomodular lattices, and the construction that is not the owner's

## 6.1 The distinction, made sharp

`logic-bloch-poles.md` §5 already draws it and it is worth restating because it is the most common
misreading of the whole project:

| | Birkhoff-von Neumann (1936) | The owner's construction |
|---|---|---|
| a **proposition** is | a closed subspace / projection $P$ | a **sentence** of a formal theory |
| its **truth value** lives | nowhere: the lattice *is* the logic | in the **state** $\rho$ |
| the **state** does | assign probabilities $\operatorname{Tr}(\rho P)$ | *carry* the truth value |
| **negation** is | orthocomplement $P^\perp$ | the antipodal map on states |
| the characteristic failure is | **distributivity** | (none identified) |

BvN puts propositions on subspaces; the owner puts truth values on states. **They are dual
descriptions of one geometry doing two different jobs**, and the qutrit essay's positivity
constraint lives on the state side while every logical operation lives on the subspace side. That
split is exactly why the qutrit has values without connectives.

## 6.2 Is an orthomodular lattice a better home for undecidability than SU(3)?

The question deserves a direct answer, and it is **no, for three reasons, but it is a better home
than the state-space reading for a different one.**

**Better, in one respect.** An OML *has* connectives. $\wedge, \vee, {}^\perp$ are the lattice
operations on projections, so D6 is at least partly satisfied where the Bloch body satisfies it not
at all. The characteristic property is the failure of distributivity: with $a = \mathrm{span}\ket{0}$,
$b = \mathrm{span}\ket{+}$, $c = \mathrm{span}\ket{-}$, one has $b \vee c = \top$ so $a \wedge (b
\vee c) = a$, while $a \wedge b = a \wedge c = \bot$, so $(a \wedge b) \vee (a \wedge c) = \bot \ne
a$. What survives is orthomodularity: $a \le b \Rightarrow b = a \vee (b \wedge a^\perp)$.

**Worse, first: the implication is broken, and the exact form of the breakage matters.** An OML has
no canonical conditional. Kalmbach classified the polynomial implications satisfying the
Birkhoff-von Neumann requirement ($a \to b = \top$ iff $a \le b$) and found **exactly five**, all
distinct, all collapsing to material implication in the Boolean case. Malinowski's negative results
show the deduction theorem fails for the logics these determine. The one genuine residuation is the
Sasaki adjunction, and its fine print is the point: the Sasaki hook is right adjoint to the **Sasaki
projection** $\varphi_a(x) = a \wedge (a^\perp \vee x)$, which is neither commutative nor associative
and is therefore not a conjunction. So an OML has an implication only against a "conjunction" that
is not one. Compare a Heyting algebra, where residuation against the honest $\wedge$ is the
definition.

**Worse, second: it drops the wrong classical law.** An OML keeps $a \vee a^\perp = \top$ (it is an
ortholattice) and gives up **distributivity**. Intuitionistic logic keeps distributivity and gives
up $a \vee \neg a = \top$. For a logic of provability, excluded middle is precisely the law that
must go, because "provable or refutable" is exactly what Gödel denies; distributivity is not in
dispute at all. **Quantum logic weakens the axiom the owner needs to keep and keeps the axiom he
needs to weaken.** That single sentence is the essay's verdict on candidate 5 and it is why the
topos migration of §2.4 happened.

**Worse, third: it forbids truth-value assignments outright.** Kochen-Specker (1967): for
$\dim H \ge 3$ there is no assignment of $\{0,1\}$ to all projections respecting the lattice
operations. The lattice is *designed* to have no valuations. That is fine for physics and fatal for
a logic core, which must assign statuses.

# 7. Candidate 6: realizability and the effective topos

Directly relevant, because **undecidability is a computability notion, not a logic notion**, and
this is the candidate that builds computability into the truth values.

**The object.** In Kleene's 1945 number realizability every predicate is assigned a set of
**realizers**, natural numbers coding computations. Hyland (1982) showed this fits as the internal
logic of an elementary topos, the **effective topos** $\mathbf{Eff}$, built from the partial
combinatory algebra of Kleene's first algebra; the same construction over an arbitrary pca gives the
realizability toposes.

**Why it is the right shape for the owner's question.** A truth value in $\mathbf{Eff}$ is not a
number and not a status: it is a *set of programs that witness the claim*. So:

- "Established" means **a computation exists**, which is what a proof search actually produces;
- "Not established" is the honest absence of a witness, with no commitment to refutability;
- Undecidability is not an extra value bolted on. It is the *empty realizer set for both
  $\varphi$ and $\neg\varphi$*, and this is representable because $\mathbf{Eff}$'s internal logic
  is intuitionistic, so that configuration is consistent.

**The striking part, and it is a genuine one.** $\mathbf{Eff}$ validates principles that are
*false* classically: Church's thesis in its internal form ("every function $\mathbb{N} \to
\mathbb{N}$ is computable") holds internally, and Markov's principle holds. So the effective topos
is not merely a weaker classical universe; it is a universe where "computable" is the default and
non-computable objects do not exist. For a system whose whole subject is what a machine can settle,
that is arguably the *correct* ambient logic rather than a restriction of one.

**Cost.** It is heavy. There is no small presentation, no truth table, no three-element chain to
hand a downstream consumer, and no decidable interface: D4 fails badly, since the internal logic of
$\mathbf{Eff}$ is not decidable and its objects are not finitely presentable. It is a *foundation*,
not a *format*. **Recommendation: adopt as the intended semantics, do not implement.**

# 8. Candidate 7: the simplex, and the negative result the essay must not dodge

The classical alternative, taken seriously, because if it suffices then everything above the fold
is unnecessary.

**The object.** A classical trit's state space is the **2-simplex** $\Delta_2 = \{(p_1,p_2,p_3) :
p_i \ge 0, \sum p_i = 1\}$: a filled triangle, 2 real dimensions, 3 extreme points. The qutrit's
pure states are $\mathbb{CP}^2$, 4 real dimensions, a continuum of extreme points, and its mixed
states an 8-dimensional convex body.

Now go through the desiderata honestly.

| | Does a simplex suffice? |
|---|---|
| **D1** first-class "not settled" | **Yes.** Vertex 3 is a vertex like any other. |
| **D2** independent vs no idea | **Yes**, exactly as well as the qutrit: vertex 3 versus the barycentre. This is `logic-qutrit-su3.md` §6.2's recommended two-axis reading, and it needs no complex amplitudes. |
| **D3** degree of settledness | **Yes.** The distance from the barycentre is a perfectly good continuous determinacy, and the Shannon entropy $H(p)$ plays the role the von Neumann entropy played. |
| **D4** decidable interface | **Yes**, and better: the report is three reals with one linear constraint. |
| **D5** about provability | No, and the qutrit is no better. |
| **D6** connectives | **Yes**, and this is the decisive one: the three *vertices* carry a finite value set on which K3, Ł3, or $G_3$ tables can be defined directly, while the *interior* carries mixing. The simplex separates the two jobs cleanly. The qutrit cannot: its extreme points are a continuum, so there is no finite vertex set to put a truth table on. |

**And the qutrit's own headline theorem survives the demotion.** `logic-qutrit-su3.md` §2.2 proved
$\lvert n_3 \rvert + p_{\text{undec}} \le 1$ and read it as a hard kinematic trade-off with no qubit
analogue. Look at where it came from: in the $(n_3, n_8)$ plane, "positivity is just $p \ge 0$
componentwise", and the section is *the probability simplex* inscribed in the Bloch ball. **The
constraint is the simplex.** It is the statement that a probability vector has non-negative entries,
which is true of the classical trit for free and needs no $\det\rho \ge 0$, no $d_{abc}$, and no
SU(3). What the qutrit machinery adds is the *circumscribed ball* and the discovery that most of it
is empty. That is a genuine and pretty finding about qutrit geometry. It is not a finding about
logic, because the logic never needed the ball.

**So the negative result, stated as plainly as it deserves:**

> For every desideratum on the owner's own list except D5, which the qutrit fails too, a classical
> 2-simplex does the job, with two real dimensions instead of eight, with a finite extreme-point set
> that can actually carry truth tables, and with the qutrit essay's headline inequality as an
> immediate consequence rather than a theorem.

**What the qutrit buys that the simplex does not**, stated fairly, three things:

1. **Non-unique decomposition.** A point of a simplex has exactly one representation as a mixture of
   extreme points; a density matrix has infinitely many. Whether that is a feature depends entirely
   on whether "this state came from *this* ensemble of models" is supposed to be meaningful. If it
   is, the simplex is *right* and the qutrit is wrong.
2. **Gleason's theorem at $\dim \ge 3$.** From `logic-bloch-poles.md` §5: for $\dim H \ge 3$ every
   probability measure on the projection lattice is $\operatorname{Tr}(\rho \cdot)$ for a unique
   $\rho$, so the density-matrix form is *forced* rather than assumed. This is the strongest
   available argument for the qutrit and it should be stated at full strength. Its fine print is
   equally important: Gleason's hypothesis is that the propositions form the projection lattice of a
   Hilbert space, i.e. candidate 5, and §6.2 gives three reasons a logic of provability should not
   adopt candidate 5. **The argument is valid and its premise is the thing in dispute.**
3. **Interference and entanglement.** Real structure with no classical analogue, and
   `logic-bloch-gates.md` found the entanglement bookkeeping exact ($r' = \sqrt{1 - C^2}$). Whether
   a logic has any use for it is unestablished, and that essay's implication reading failed twice.

# 9. Candidate 8: other Lie and algebraic options, honestly sorted

**Real options.**

- **Two qubits / $SU(2) \times SU(2)$, i.e. Belnap-Dunn quantised.** This is
  `logic-bloch-poles.md`'s own constructive recommendation: one qubit per polarity, carrying
  (evidence-for, evidence-against). It is the right move for a specific reason: the four-valued
  Belnap-Dunn square is genuinely a **bilattice**, with a truth order and an information order that
  are independent, and two qubits carry two independent Bloch vectors plus a correlation. That is
  the only proposal in the whole cluster that gets a *glut* as well as a *gap*, which the single
  ball provably cannot (poles essay, result 2). It costs 15 Bloch parameters instead of 8.
- **$SU(N)$ for $N$ statuses.** Mathematically fine and logically empty. Everything §0 says about
  the qutrit's missing connectives holds verbatim at every $N$, and the positivity constraints get
  *worse*: the insphere-to-outsphere ratio is $1/(N-1)$, so the body is relatively thinner and the
  fraction of the naive ball that is actually a state shrinks. More statuses buy more forbidden
  combinations, not more logic.
- **Continuous logic (Ben Yaacov, Berenstein, Henson, Usvyatsov; completeness with Pedersen 2010).**
  Truth values in $[0,1]$, formulas as uniformly continuous $[0,1]$-valued functions, connectives
  from a suitable set of continuous functions, quantifiers as $\sup$ and $\inf$. This is a *real*
  and well-developed logic with a completeness theorem, built for metric structures. Its value here
  is that it is the mature form of the "truth is a real number" instinct, and it shows what such a
  logic looks like when done properly: the truth value is a *distance*, and the logic is
  approximate rather than uncertain. Same objection as MV-algebras applies (truth-functional, so it
  cannot represent independence), but it is the right thing to read before building anything
  $[0,1]$-valued.

**Numerology, and the essay should say so.** $SU(2) \times U(1)$ "because electroweak" carries no
logical content beyond "a qubit plus a phase", and `logic-qutrit-su3.md` §3 already showed that
phase encodes nothing at the poles (a global phase is unobservable) and is undefined at the pole
where it is most wanted. Exceptional groups, $E_8$ and octonions contribute to a logic only through
the geometry of their homogeneous spaces, and no desideratum in §1 asks for a bigger symmetry
group. "Confinement" and its relatives were already ruled mood by `logic-qutrit-su3.md` §5, which
recommends **superselection** as the honest import; nothing here changes that.

# 10. Prior art: has anyone put provability on a Bloch-like geometry?

Reported explicitly because the owner's standing instruction is to check before importing, and
because a negative deserves to be as clearly stated as a positive.

**Searched, and found, with real content:**

- **Provability on a *topological* geometry: yes, and it is standard.** Simmons and Esakia, 1970s:
  $\Diamond$ is the Cantor derivative on a scattered space. Beklemishev-Gabelaia's survey
  (arXiv:1210.7317) is the entry point. Abashidze and Blass independently proved ordinal
  completeness results for GL under the interval topology. So "provability has a geometry" is a
  settled research area, and the geometry is order-topological, not convex-metric.
- **Provability on a *Stone* geometry: yes, and it is 1936.** §4. Undecidability as
  disconnectedness, the space of completions of PA as the Cantor set.
- **Quantum-state geometry for logic: yes, but as quantum logic, not provability logic.** The topos
  programmes of §2.4 are the live modern form, and they moved away from the state space to a
  presheaf whose logic is Heyting.

**Searched, and NOT found:** any published work putting a *provability predicate*, or the
provable/refutable/independent trichotomy, on a Bloch ball, a qutrit Bloch body, or any convex
quantum state space. Consistent with `logic-qutrit-su3.md` §4.1's finding on the QCD side.

**One near-miss found, and it is closer than expected.** Sperling and Walmsley,
*Quasiprobability representation of quantum coherence*
([arXiv:1803.04747](https://arxiv.org/abs/1803.04747), Phys. Rev. A **97**, 062327, 2018), carry
a section titled *"True, false, and undecidable"* (§IV.3). They take as their classical reference
set the two basis states plus the whole equatorial family of equal superpositions, note that
*"this can be compared to a classical ternary logic, which consists of the isolated states
'false' and 'true' and is extended by including 'undecidable' states"*, that *"the latter states
$\lvert \varphi \rangle$ have an equal chance of being true or false and form a continuum"*, and
that *"in the Bloch-sphere representation, the convex set of classical states defines a double
cone structure"*. So the **geometry** of the owner's Bloch Truth mapping -- true and false at the
poles, an "undecidable" continuum at the equator, a named convex body separating classical from
nonclassical -- is published prior art from 2018. What is *not* there is any logic: no provability
predicate, no arithmetic, no modal operator, no claim that the labelling means anything. The
logic vocabulary is an illustrative aside in a quantum-optics resource-theory paper. The null
result above therefore stands as stated -- nothing puts a *provability predicate* on a convex
quantum state space -- but the honest summary of the prior art is **"the geometry is published,
the logic is not."**

An earlier draft of this section reported that passage as absent from the paper. That was an
error: the abstract genuinely is silent and a PDF fetch returned binary, and "abstract silent plus
full text unreadable" was read as evidence of absence. The ar5iv rendering settles it in one
fetch. The correction is recorded rather than quietly applied, because the failure mode is the
interesting part.

# 11. Agreements and conflicts with the qutrit essay

Stated per claim, as required.

**Agreements.** The qutrit's positivity constraint $\lvert n_3 \rvert + p_{\text{undec}} \le 1$ is
correct and §8 agrees with its derivation. "There is no distinguished negation on a three-valued
state space" (`logic-qutrit-su3.md` §4.4, qualified form) is confirmed from a completely different
direction: in a Heyting algebra $\neg$ is canonical and definable ($a \Rightarrow \bot$) *and* not
an involution. Both essays reach "no tidy antipodal negation", one by $\mathbf{3} \not\cong
\bar{\mathbf{3}}$, the other by $\neg\neg a \ne a$; the Heyting route is the better one because it
says what negation *is* instead of only what it fails to be. Both essays correct the origin quote's
"ZF without C" premise identically, and §3.3 supplies the layered architecture that correction was
reaching for.

**Conflicts.**

- **`logic-qutrit-su3.md` §6.2 recommends keeping the qutrit** ("that keeps the qutrit, so item 2
  bites"). This essay recommends against, on D6. The disagreement is substantive rather than
  emphasis; both are AI recommendations and neither is settled.
- **It calls $\det\rho \ge 0$ "a theorem about three-valued quantum logic".** §8 disputes the
  *logic* half: it is a theorem about three-level *quantum states*, whose logical reading presumes
  that logical values are density matrices, which is the question at issue.
- **`logic-bloch-poles.md` §5 argues Gleason at $\dim \ge 3$ is "a substantive argument for the
  qutrit".** §8 accepts it as valid and locates the load-bearing premise: Gleason's hypothesis is
  the projection lattice, i.e. candidate 5, and §6.2 gives three reasons not to build a provability
  logic there. The argument transfers the question rather than settling it.

# 12. The ranking, with the criterion stated

**The criterion.** Rank by how many of the six desiderata in §1 a candidate satisfies *without
stipulation*, breaking ties by whether the candidate is about provability (D5) or merely compatible
with it, and breaking remaining ties by implementation cost for a layered core.

| Rank | Candidate | D1 | D2 | D3 | D4 | D5 | D6 | Verdict |
|---|---|---|---|---|---|---|---|---|
| **1** | **Heyting algebra + Kripke semantics** (§2) | yes | yes | no | yes | reading | **yes** | the logic |
| **2** | **Provability logic GL** (§3) | yes | yes | no | **yes** | **yes** | yes | the metalayer |
| **3** | Lindenbaum-Tarski + Stone (§4) | yes | yes | no | no | yes | classically | the semantics |
| **4** | Classical 2-simplex (§8) | yes | yes | **yes** | yes | no | yes | the report |
| 5 | Realizability / effective topos (§7) | yes | yes | no | no | yes | yes | the foundation |
| 6 | MV / effect algebras (§5) | no | no | **yes** | yes | no | yes | wrong question |
| 7 | Two qubits, Belnap-Dunn (§9) | yes | yes | yes | no | no | partly | the interesting rival |
| 8 | SU(3) qutrit (predecessor) | yes | partly | yes | no | no | **no** | values without connectives |
| 9 | Orthomodular lattice (§6) | no | no | no | no | no | partly | weakens the wrong axiom |

**The recommendation is a pair, not a single winner, and the pairing is the point.**

> **Use a Heyting algebra for the upper layer's truth values and GL for what the core is told about
> them.** The upper layer reasons intuitionistically, so "not established" is a first-class status
> with real connectives and $\neg$ means "will never be established". The core reasons in GL about
> that layer's $\Box$, which is decidable in PSPACE and, by Solovay, exactly correct about what the
> upper layer can prove. The interface between them is the pair
> $(\text{lean}, \text{determinacy})$ that `logic-bloch-poles.md` §7.3 already proposed, now carried
> by a 2-simplex (§8) rather than a Bloch ball, because the simplex has the vertices the tables need.

That gives the owner: D1 from the Heyting middle element, D2 from the Kripke $\forall v \ge w$
clause, D3 from the simplex report, D4 from GL's PSPACE decidability, D5 from GL by construction,
D6 from residuation. Every one is discharged by a candidate that is standard, complete, and
decades old.

**What is lost by not taking SU(3):** interference, entanglement, non-unique ensemble
decomposition, and the pretty fact that the Bloch body is not a ball. If the owner values those as
*content* rather than as *tooling*, the ranking changes and he should say so; that is a
direction-of-the-theory call, and it is his.

# 13. Lean attestation

File [`docs/dreamed/lean/LogicBeyondSU3.lean`](lean/LogicBeyondSU3.lean), namespace
`Toesnail.LogicBeyondSU3`. Command, from `verify/`:

```
../docs/dreamed/capped.sh -m 4G -c 100 -- lake env lean --threads=1 ../docs/dreamed/lean/LogicBeyondSU3.lean
```

**Exit status 0, no output, no `sorry`, no warnings.**

| theorem | statement |
|---|---|
| `heyting_noncontradiction` | $a \wedge \neg a = \bot$ in every Heyting algebra, no hypothesis |
| **`heyting_lem_forces_dne`** | **§2.1**: excluded middle everywhere $\Rightarrow$ $\neg\neg a = a$ |
| **`heyting_lem_forces_isCompl`** | **§2.1**: and then $a$, $\neg a$ are genuine Boolean complements |
| `heyting_triple_compl` | $\neg\neg\neg a = \neg a$: the negation hierarchy has two levels |
| `chain3_compl_mid` | in the three-chain, $1^c = 0$ |
| **`chain3_lem_fails`**, **`chain3_dne_fails`** | **§2.2**: $1 \vee 1^c = 1 \ne \top$ and $1^{cc} = \top \ne 1$ |
| `chain3_not_boolean` | excluded middle fails somewhere in the chain |
| `chain3_weak_lem`, `chain3_prelinearity` | the honest limit: the chain is Gödel logic $G_3$, not IPC |
| `GLSystem.loeb_rule` | **§3.2**: Löb's rule from Löb's axiom, in three steps |
| **`GLSystem.godel_two`** | **§3.2**: a consistent GL system does not prove its own consistency |
| `GLSystem.no_global_reflection` | it cannot prove $\Box a \to a$ for every $a$ |
| `boolModel`, `boolModel_consistent` | the axiom bundle is non-vacuous (degenerate witness) |

**What is NOT proved**, so the badges are not over-read: nothing about PA (the derivability
conditions, the hard half of Gödel II, are not formalised); not Solovay's arithmetical
completeness, not Segerberg's modal completeness, not GL's PSPACE-completeness; not Gödel 1932's
no-finite-matrix theorem; not Chang's completeness theorem, not Stone duality, not Gleason, not
Kadison's anti-lattice theorem, not Kochen-Specker; nothing about SU(3), the qutrit body, or any
Hilbert space. The branching-frame countermodel to weak excluded middle (§2.2) is stated in prose
only. The three `\veq` badges are scoped to that file per `docs/dreamed/README.md` and are **not**
sidecar attestations.

# Surfaced for the owner

Each item is a located claim plus the ruling it needs. **None has been written into `TODO.md`,
`ROADMAP.md` or `REVIEW_ME.md`, and none is a decision.**

1. **HEADLINE. The qutrit carries truth values and no connectives, and this is a theorem, not a
   gap.** §0. Distinct density matrices are never Löwner-comparable (equal trace plus positivity
   forces equality), so the Bloch body is an antichain: no meets, no joins, no residuated
   implication. One level up, Kadison's anti-lattice theorem (1951) says $\inf\{S,T\}$ exists in
   $B(H)_{sa}$ iff $S, T$ are comparable, so the effects are not a lattice either. **Ruling:**
   accept or reject D6 (§1) as a binding requirement on the Bloch Truth carrier. If it binds, the
   qutrit is a report format and not a logic, which is what `logic-bloch-poles.md` §7.3 already
   proposed calling it.

2. **RECOMMENDATION. Heyting algebra for the layer, GL for the core, simplex for the interface.**
   §12. Six desiderata, all discharged by standard decades-old mathematics; GL is decidable in
   PSPACE and, by Solovay 1976, arithmetically complete for PA. **Ruling:** this is a
   direction-of-the-theory decision and it is entirely the owner's. It **conflicts** with
   `logic-qutrit-su3.md` §6.2's recommendation to keep the qutrit, and the conflict is substantive.

3. **The Kripke $\neg$ clause already does the job the third basis state was invented for.** §2.3.
   $w \Vdash \neg A$ iff no future state forces $A$. That is precisely "proven independent" versus
   "no idea", built into the definition of negation, with a *partial* order that supports branching
   futures where the Bloch radius (a scalar, hence total) cannot. **Ruling:** whether to adopt the
   information-order reading of $r$ as *the* interpretation, and accept that it is a partial order
   rather than a number.

4. **Gödel 1932 ends the $n$-valued programme, for every finite $n$.** §2.5. Intuitionistic
   propositional logic has no finite characteristic matrix. Any scheme assigning each sentence a
   value from a fixed finite set and computing connectives by tables cannot be constructive
   provability. **Ruling:** whether this is accepted as decisive against three-valued carriers
   generally, or whether the owner intends a logic other than constructive provability (Gödel logic
   $G_3$ is a live and much cheaper option, §2.2).

5. **NEGATIVE RESULT the essay would most like tested. A classical 2-simplex suffices.** §8. Every
   desideratum except D5 (which the qutrit fails equally) is met by a filled triangle with three
   vertices, in two real dimensions instead of eight, *and* the simplex has a finite extreme-point
   set that can carry truth tables while $\mathbb{CP}^2$ cannot. The qutrit essay's headline
   inequality $\lvert n_3 \rvert + p_{\text{undec}} \le 1$ **is** the simplex, arriving as
   componentwise $p \ge 0$. **Ruling:** if accepted, the SU(3) apparatus is decorative for this
   application. If rejected, the owner should name which of interference, entanglement, or
   non-unique ensemble decomposition (§8) he wants as content.

6. **Quantum logic weakens the wrong axiom.** §6.2. An orthomodular lattice keeps $a \vee a^\perp =
   \top$ and gives up distributivity; a provability logic needs to give up exactly $a \vee \neg a$
   and has no quarrel with distributivity. Plus: Kalmbach's five polynomial implications with no
   canonical choice, the Sasaki adjunction residuating against a non-commutative non-associative
   "conjunction", and Kochen-Specker forbidding truth-value assignments outright at $\dim \ge 3$.
   **Ruling:** whether to record "the Bloch Truth project is not quantum logic and should not be
   compared to it" durably, as `logic-bloch-poles.md` §5 also urges.

7. **The strongest argument FOR the qutrit, with its premise located.** §8, item 2. Gleason at
   $\dim \ge 3$ forces the density-matrix form rather than assuming it, which is genuinely
   substantive and is `logic-bloch-poles.md` §5's best point. But Gleason's hypothesis is that the
   propositions form the projection lattice of a Hilbert space, i.e. candidate 5, and item 6 gives
   three reasons not to build a provability logic on candidate 5. **Ruling:** the argument is valid
   and its premise is the thing in dispute; the owner should decide whether he is committing to the
   quantum measurement postulates for a logic.

8. **The topos programmes already made this move, in the owner's own subject.** §2.4.
   Isham-Döring and Heunen-Landsman-Spitters both replace the orthomodular lattice with a Heyting
   algebra, and the covariant approach's information order matches physical intuition directly.
   **Ruling:** whether to read the relevant literature before further Bloch-side development, since
   it is the closest thing to a completed version of this project that exists.

9. **PA's space of completions is the Cantor set, and independence is disconnectedness.** §4. The
   Lindenbaum algebra of any consistent r.e. theory interpreting Robinson arithmetic is the
   countable atomless Boolean algebra (atomless *because* Gödel applies again to $T + \varphi$), and
   its Stone space is the Cantor set. A sentence is independent exactly when its clopen set is
   proper and non-empty. **Ruling:** whether this replaces the ball as the project's picture. It is
   a real space, arithmetic hands it over for free, and it is totally disconnected where the ball is
   convex. Cross-reference `docs/dreamed/logic-models-ensemble.md` before ruling.

10. **MV-algebras answer a different question and should be kept for the report, not the logic.**
    §5.1. Chang's completeness theorem makes $[0,1]$ the standard MV-algebra, so a continuous degree
    is native. But Łukasiewicz is truth-functional and provability is not: $\varphi$ and
    $\neg\varphi$ both independent gives $\varphi \wedge \neg\varphi$ refutable while $\varphi
    \wedge \varphi$ is independent, from identical inputs. **Ruling:** accept the split use
    (codomain yes, logic no), or reject.

11. **PRIOR ART LOCATED, and it is closer than this essay first reported.** §10. Sperling and
    Walmsley (arXiv:1803.04747, Phys. Rev. A **97**, 062327, 2018) §IV.3 *"True, false, and
    undecidable"* already places true and false at the Bloch poles, an "undecidable" continuum at
    the equator, and a **double cone** as the convex hull of that classical set. An earlier draft
    of this essay reported that passage as absent from the paper; that was an error, caused by
    checking the abstract and a failed PDF fetch instead of the full text. The geometry is prior
    art; the *logic* is not -- there is no provability predicate anywhere in it. Genuine
    additional prior art: provability has a standard topological semantics (Esakia, Simmons;
    Beklemishev-Gabelaia) and a standard Stone-dual one. **Ruling:** whether the project positions
    itself explicitly as adding a provability reading to a published Bloch geometry, which the
    evidence now supports.

12. **A cheap experiment, if the owner wants one.** §2.2's three-element chain is a complete,
    decidable, three-valued Heyting algebra that is *not* Kleene, *not* Łukasiewicz, and *not* the
    qutrit: it is Gödel logic $G_3$, and it is the up-sets of a two-world Kripke frame. It costs
    nothing to implement (three elements, four operations, all `decide`-able, already checked in
    Lean here) and it would let the owner feel the difference between a gap with connectives and a
    trit without them before committing to any architecture. **Ruling:** worth building, or not.

# Sources consulted

- P. Blackburn, M. de Rijke, Y. Venema, and the Stanford Encyclopedia entry *Provability Logic*
  (R. Verbrugge), read for §3: Löb's axiom, the Hilbert-Bernays-Löb derivability conditions,
  Segerberg's 1971 modal completeness for finite transitive irreflexive trees, GL's PSPACE
  decidability, Solovay's 1976 arithmetical soundness and completeness, and GLS as the logic of
  arithmetical truth.
- L. Beklemishev and D. Gabelaia, *Topological interpretations of provability logic*,
  arXiv:1210.7317. Consulted for §3.4: Simmons and Esakia on the Cantor derivative and scattered
  spaces, and GLP's Kripke incompleteness with topological completeness.
- K. Gödel, *Zum intuitionistischen Aussagenkalkül* (1932), via the *First-order Gödel logics*
  survey (Baaz, Preining, Zach, arXiv:math/0601147) and the SEP Gödel entry. Used for §2.5: no
  finite characteristic matrix for IPC, the $G_n$ chains, countably many intermediate logics, and
  Dummett's LC / prelinearity.
- C. C. Chang, *Algebraic analysis of many valued logics*, Trans. AMS **88** (1958) 467-490
  (MV-algebras), and *A new proof of the completeness of the Łukasiewicz axioms*, Trans. AMS **93**
  (1959) 74-80 (the completeness theorem). Plus Mundici's MV-algebra tutorial.
  Used for §5.1: Chang's completeness theorem and the equivalence with lattice-ordered abelian
  groups with strong unit.
- D. J. Foulis and M. K. Bennett, *Effect algebras and unsharp quantum logics*, Found. Phys. **24**
  (1994) 1331. Used for §5.2.
- R. V. Kadison, *Order properties of bounded self-adjoint operators* (1951), the anti-lattice
  theorem: $\inf\{S,T\}$ exists in $B(H)_{sa}$ iff $S$ and $T$ are comparable. Located via
  secondary sources (arXiv:1912.09070, arXiv:1706.01719), not read in the original.
- G. Birkhoff and J. von Neumann (1936); G. Kalmbach on the five polynomial implications; the JSL
  negative results on the deduction theorem for quantum logic; S. Kochen and E. Specker (1967).
  Used for §6.
- J. M. E. Hyland, *The effective topos* (1982), via the nLab and Wikipedia entries and the
  realizability-topos literature. Used for §7.
- S. Wolters, *A comparison of two topos-theoretic approaches to quantum theory*,
  arXiv:1010.2031, for §2.4's verbatim "the (complete) Heyting algebra of closed open subobjects of
  the spectral presheaf" and the Isham-Döring / Heunen-Landsman-Spitters contrast.
- Stone (1936) and the standard Lindenbaum-algebra facts for §4, including that the Lindenbaum
  algebra of a consistent r.e. theory interpreting Robinson arithmetic is the countable atomless
  Boolean algebra whose Stone space is the Cantor set.
- I. Ben Yaacov, A. Berenstein, C. W. Henson, A. Usvyatsov, *Model theory for metric structures*
  (2008), and Ben Yaacov-Pedersen, *A proof of completeness for continuous first-order logic*, JSL
  **75** (2010). Located for §9; not read in full.
- Sibling dreamed essays: [`logic-qutrit-su3.md`](logic-qutrit-su3.md),
  [`logic-bloch-poles.md`](logic-bloch-poles.md), [`logic-bloch-gates.md`](logic-bloch-gates.md),
  [`weltformel-impossibility.md`](weltformel-impossibility.md), and `logic-models-ensemble.md`
  (in progress in a parallel session).
- The owner's own chats: *Falsifiability and Logical Boundaries* (2025-08-16), *Mathematical Group
  Theory Overview* (2025-08-16), *Gödel's incompleteness theorem reimagined* (2025-10-09),
  *Formal language and grammar* (2025-09-21), and the "Bloch Truth" origin turn of 2025-08-08.
  Assistant turns there are prior AI output, not authority.

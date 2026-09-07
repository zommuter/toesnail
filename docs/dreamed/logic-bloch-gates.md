---
title: What the gates say the equator is
permalink: /dreamed/logic-bloch-gates
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This file *proposes*; the owner disposes. Nothing here is toesnail theory, and nothing may be
> promoted into `physics/` or `essays/` without the owner authoring the move himself. The `\veq`
> badges below claim something about [`docs/dreamed/lean/LogicGates.lean`](lean/LogicGates.lean)
> **only**, and are deliberately not wired into `physics/*.toml` or `tests/test_verify.sh`.

**Seed (owner-authored, verbatim, chat export "Falsifiability and Logical Boundaries",
2025-08-16):**

> Use the quantum gates to infer a clearer meaning of the Bloch equator. Start with the simple
> NOT, what should happen to the phase angles and what could that logically state? Then continue
> with CNOT, what happens to the controlledly inverted qubit in dependence of the controlling
> qubit and how can that be interpreted? Finally do the same for the TOFFOLI gate

**Provenance.** The owner keeps a standing backburner project he calls **Bloch Truth Mapping**:
put "proven true" and "proven false" at the poles of a qubit and ask what the rest of the ball
means. This essay works only the *gate* half. Four owner-authored exports feed it; only his own
turns are treated as source:

| Export | Date | What it supplies |
|---|---|---|
| "Falsifiability and Logical Boundaries" | 2025-08-16 | the seed above, plus the poles/equator setup |
| "Bloch Sphere and Qubits" | 2025-08-09 | the gate and density-matrix refresher, and *"Why is the third qubit needed for AND?"* |
| "Invertible Functions Bit Mapping Problem" | 2025-09-09 | his own reversibility census, and *"only $(2^2)! = 12$ of them are actually invertible -- I wonder if all of them can be expressed via the TOFFOLI gate?"* |
| "Formal language grammar limitations" | 2025-09-21 | the computability framing behind §5.4 |

The assistant turns in those exports are prior AI output with no authority; this essay disagrees
with them in four located places (§6.1). Siblings cover the rest of Bloch Truth Mapping:
[`logic-bloch-poles.md`](logic-bloch-poles.md) (the poles; Kleene, Priest, Belnap),
[`logic-qutrit-su3.md`](logic-qutrit-su3.md) (qutrit, SU(3), QCD, Goedel),
[`weltformel-impossibility.md`](weltformel-impossibility.md).

---

# 0. The headline, stated and not teased

**Read off the gate action rather than assigned by fiat, the Bloch ball carries three separate
structures, and exactly one of them is a truth value.**

1. **The $z$ coordinate is the truth value**, and it is *fuzzy*: every computational-basis
   measurement returns $p = (1+z)/2 \in [0,1]$, with NOT acting as $p \mapsto 1-p$. That is
   Lukasiewicz's $[0,1]$, not Kleene's three-element set.
2. **The radius $r$ is how much is settled**, and CNOT trades it for correlation at an exact
   rate: for a pure product input the target's radius after CNOT is $r' = \sqrt{1-C^2}$ with $C$
   the output pair's concurrence. Entanglement makes each part *less* settled while the pair is
   fully settled (§3.2).
3. **The equatorial angle $\varphi$ is not a truth value**, and this is the central *negative*
   finding. Every phase gate $R_z(\theta)$ leaves $p$ exactly fixed while rotating $\varphi$, so
   $\varphi$ is invisible to the truth question by construction. Worse for the ternary reading:
   **no ordering of the equator survives the phase gates.** Kleene, Lukasiewicz, Priest and
   Belnap each put their extra value in an *order*; a circle admits no rotation-covariant order,
   because such an order forbids elements of finite order and the roots of unity are exactly
   that. Machine-checked as `no_torsion_of_invariant`.

What survives of the seed's intuition is a **modality**, not a value: $\varphi$ is relative,
meaningful only between two propositions, which is the shape of a context rather than a truth
degree. §2.3 stress-tests it: three tests pass, the ordering test fails.

Two sharp corrections to the seed conversation. **First**, $\ket{+}$ and $\ket{-}$ are the
*fixed points* of NOT and also the poles of the conjugate basis, so a "proposition equivalent to
its own negation" is not a paradox but a settled truth value **of a different question**.
**Second**, the $-1$ that NOT puts on $\ket{-}$ is global only while the qubit is alone; make it
a CNOT target and it becomes *phase kickback*, a $Z$ on the control. The conclusion acts back on
the premise, and the control/target asymmetry that looks like implication is a basis artefact:
conjugating CNOT by Hadamards exchanges control and target exactly.

One hard limit, stated up front because it is easy to overclaim. **Kochen-Specker needs
dimension $\ge 3$.** A single qubit admits an explicit non-contextual hidden-variable model (Bell
1966; Kochen and Specker 1967), so nothing about one qubit's equator can be argued from
contextuality. That reading only becomes available at CNOT, in dimension 4 (§5.3).

---

# 1. NOT, and the fact that it has a conjugate

## 1.1 Two negations, not one

$$ X = \begin{pmatrix} 0 & 1 \\ 1 & 0\end{pmatrix}, \qquad
   Z = \begin{pmatrix} 1 & 0 \\ 0 & -1\end{pmatrix}, \qquad
   H = \frac{1}{\sqrt2}\begin{pmatrix} 1 & 1 \\ 1 & -1\end{pmatrix} $$

Write $\rho = \tfrac12(\mathbb{1} + \vec a \cdot \vec\sigma)$, $|\vec a| \le 1$. Conjugation by a
Pauli is the $\pi$ rotation about that Pauli's axis:

$$ X:\ (a_x,a_y,a_z) \mapsto (a_x,-a_y,-a_z), \qquad
   Z:\ (a_x,a_y,a_z) \mapsto (-a_x,-a_y,a_z) $$

The seed asks what happens to the phase angles. $X$ maps $\ket 0 \leftrightarrow \ket 1$
antipodally, but it does **not** fix the equator pointwise: it flips $a_y$ too. On the equator
($a_z = 0$, $a_x = \cos\varphi$, $a_y = \sin\varphi$):

$$ X\big|_{\text{eq}} : \varphi \mapsto -\varphi, \qquad
   Z\big|_{\text{eq}} : \varphi \mapsto \varphi + \pi $$

**On the equator NOT is a reflection and its conjugate is a rotation.** A circle reflection has
two fixed points; a $\pi$ rotation has none. $X$'s fixed-point set on the whole ball is the
$x$-axis, the pair $\ket{\pm} = (\ket0 \pm \ket1)/\sqrt2$; $Z$'s is the $z$-axis, the poles.

## 1.2 What that says logically

The prior AI turn read $X\ket{+} = \ket{+}$ as "a statement logically equivalent to its own
negation" and $X\ket-=-\ket-$ as "a logical contradiction or paradox state". The first half is
suggestive; the second is wrong, and the geometry says why. $\ket\pm$ are an **orthonormal
basis**: perfectly distinguishable, perfectly settled, at radius $r=1$, exactly as un-mixed as
$\ket0,\ket1$. They are "self-negating" only because we chose the $z$ question to call truth;
under the $x$ question they *are* the poles and $\ket0,\ket1$ are the self-negating pair. The
honest statement is a duality, not a paradox:

> A proposition invariant under NOT is not undecided. It is decided about a different question,
> and NOT is that question's "don't care".

Hadamard makes this literal: $HXH = Z$, $HZH = X$. So "truth" and "the conjugate quantity" are
related by a *gate*, not a semantic stipulation, and any logic read off this sphere must fix
which of the two it means before it can say anything.

## 1.3 Classical negation is one of a one-parameter family

For any $\varphi$, $N_\varphi = \cos\varphi\, X + \sin\varphi\, Y$ is Hermitian, unitary, squares
to $\mathbb 1$ and swaps the poles: a perfectly good NOT. It differs from $X$ only on the equator,
acting there as the reflection $\vartheta \mapsto 2\varphi - \vartheta$, and all members agree on
every truth measurement.

**This is the first place the equator earns a meaning by gate action rather than by fiat:** it is
exactly the parameter distinguishing members of the NOT family. It answers "*which* negation",
not "*how true*".

---

# 2. Phase gates: a parameter invisible to the truth question

## 2.1 The gates

$$ S = \begin{pmatrix}1 & 0 \\ 0 & i\end{pmatrix},\qquad
   T = \begin{pmatrix}1 & 0 \\ 0 & e^{i\pi/4}\end{pmatrix},\qquad
   R_z(\theta) = \begin{pmatrix}e^{-i\theta/2} & 0 \\ 0 & e^{i\theta/2}\end{pmatrix} $$

On the ball $R_z(\theta)$ rotates by $\theta$ about $\hat z$, leaving $a_z$ untouched everywhere.
Two facts follow, and they are the strongest argument here.

**(a) Phase gates change no truth probability, anywhere, ever.** All computational-basis
statistics are $p = (1+a_z)/2$, and $a_z$ is fixed.

**(b) Phase gates act transitively on the equator.** $S$ rotates it by $\pi/2$, $T$ by $\pi/4$,
$R_z(\theta)$ by $\theta$. Any equatorial state reaches any other by a gate the truth question
cannot detect.

Together: **the equatorial angle is a degree of freedom the truth question is blind to.** Not
merely unmeasured; there is no computational-basis measurement, on any number of copies, that
depends on it.

## 2.2 When it becomes visible

Only by interference against a state whose phase is already fixed. $H R_z(\theta) H$ carries
$\ket0$ to a state with $p = \cos^2(\theta/2)$, a genuine truth probability, but that needed a
*second* reference: the $H$ pinned phase zero. This is the ordinary superselection statement,
relative phase observable and global phase not. The reading it forces:

> $\varphi$ is not a property of one proposition. It is two-place, defined only against a chosen
> reference, and observable only when the two interfere.

## 2.3 Stress-testing the "relative commitment" reading

Candidate: *$\varphi$ encodes an entailment or context between two propositions rather than a
value belonging to one.* Four tests.

**1. Arity. PASS.** A truth value is one-place, $v(P)$; an entailment is two-place,
$P \vdash Q$. §2.2 says $\varphi$ is only ever defined against a reference. This is the same
arity move [`omniscience.md`](omniscience.md) makes about the knower, and it is the strongest
thing going for the reading.

**2. Composition. PASS.** Contexts compose by concatenation, phases by addition:
$R_z(\theta_1)R_z(\theta_2) = R_z(\theta_1{+}\theta_2)$. Abelian and free, a reasonable model of
accumulated commitment.

**3. Invisibility. PASS.** A context should not change the truth of what it contextualises, only
what that truth means. That is exactly fact (a).

**4. Ordering. FAIL.** An entailment relation is a preorder. If $\varphi$ encoded entailment
*strength*, comparability would have to be independent of where $\varphi = 0$ was put, since that
is gauge fixed by an arbitrary $H$. §5.2 shows no such order exists. The reading therefore
survives only in weak form: $\varphi$ names *which* context, never *how much*. A label on a
fibre, not a magnitude along it.

---

# 3. CNOT

## 3.1 The gate

In basis $\ket{00},\ket{01},\ket{10},\ket{11}$, first qubit controlling,

$$ \mathrm{CNOT} = \begin{pmatrix}
1&0&0&0\\ 0&1&0&0\\ 0&0&0&1\\ 0&0&1&0 \end{pmatrix}
\;=\; \ket0\!\bra0 \otimes \mathbb 1 \;+\; \ket1\!\bra1 \otimes X $$

Classically $(a,b) \mapsto (a, a \oplus b)$: an involution, hence a bijection, hence
information-preserving.

$$ \mathrm{CNOT} \circ \mathrm{CNOT} = \mathrm{id}, \qquad
   \mathrm{TOFFOLI} \circ \mathrm{TOFFOLI} = \mathrm{id} \veq{rev}\lean $$

## 3.2 The reduced state: radius traded for correlation

Take $\rho = \rho_c \otimes \rho_t$ with Bloch vectors $\vec a$ (control), $\vec b$ (target).
With $P_i = \ket i\!\bra i$ and $\mathrm{CNOT} = P_0 \otimes \mathbb 1 + P_1 \otimes X$,

$$ \mathrm{CNOT}\,(\rho_c \otimes \rho_t)\,\mathrm{CNOT}^\dagger
 = \sum_{i,j=0}^{1} P_i \rho_c P_j \;\otimes\; X^i \rho_t X^j $$

**Target.** Trace out the control. Since $\operatorname{Tr}(P_i \rho_c P_j) = \delta_{ij} p_i$
with $p_i = \bra i \rho_c \ket i$, only diagonal terms survive:

$$ \rho_t' = p_0\, \rho_t + p_1\, X \rho_t X, \qquad
   p_0 = \tfrac{1+a_z}{2},\quad p_1 = \tfrac{1-a_z}{2} $$

and since $X\sigma_x X = \sigma_x$ while $X\sigma_{y,z}X = -\sigma_{y,z}$, with
$p_0 - p_1 = a_z$,

$$ \vec b\,' \;=\; \big(\,b_x,\;\; a_z\, b_y,\;\; a_z\, b_z\,\big) $$

**Control.** Trace out the target instead. Diagonal terms give
$\operatorname{Tr}(X^i \rho_t X^i) = 1$; the $i=0,j=1$ term gives
$\operatorname{Tr}(\rho_t X) = b_x$, so the off-diagonal elements are multiplied by $b_x$ and the
populations are untouched:

$$ \vec a\,' \;=\; \big(\, b_x\, a_x,\;\; b_x\, a_y,\;\; a_z \,\big) $$

Both formulas were checked against a direct partial trace over 200 random mixed input pairs;
maximum componentwise error $1.7\times10^{-16}$. Read together, they are the whole of CNOT's
Bloch action in one sentence:

> CNOT multiplies the **control's equator** by the target's $x$-projection, and the **target's
> $y$ and $z$** by the control's $z$-projection. Each qubit keeps exactly the coordinate the
> *other* one's gate axis fixes.

**Contraction, with numbers.** Control $\ket+$ ($\vec a = (1,0,0)$), target $\ket0$
($\vec b = (0,0,1)$): $\vec a\,' = \vec b\,' = (0,0,0)$, both radii falling from 1 to 0, both
marginals maximally mixed while the pair is the *pure* Bell state $(\ket{00}+\ket{11})/\sqrt2$.
In the family $\vec a = (\sin\theta,0,\cos\theta)$, $\vec b = (0,0,1)$, the output pair has
concurrence $C = \sin\theta$:

| $\theta$ | $r'$ (target radius) | $C$ | $\sqrt{1-C^2}$ |
|---|---|---|---|
| $0.300$ | $0.955336$ | $0.295520$ | $0.955336$ |
| $0.700$ | $0.764842$ | $0.644218$ | $0.764842$ |
| $1.100$ | $0.453596$ | $0.891207$ | $0.453596$ |
| $\pi/2$ | $0.000000$ | $1.000000$ | $0.000000$ |

so $r' = \sqrt{1-C^2}$ exactly, which is the standard pure-state relation
$C = \sqrt{2(1-\operatorname{Tr}\rho_A^2)}$ rewritten in Bloch radius.

**This is the best physical answer this essay has to "what does the interior of the ball mean
logically".** On the sibling reading that $r$ measures how much is *settled*, a CNOT between two
propositions makes each one individually **less** settled while the pair becomes **maximally**
settled. Radius lost is correlation gained, at the rate above. A logic in which combining
information about parts can *decrease* what is known about each part is not classical, and not
fuzzy either, since fuzzy conjunction is componentwise.

**Where the contraction vanishes.** $\vec b\,'$ keeps radius 1 iff $|b_x| = 1$, that is iff the
target sits at $\ket\pm$: the poles of the *conjugate* basis, the equator's own pole pair. The
same condition keeps $|\vec a\,'| = |\vec a|$. So CNOT acts unitarily on each factor separately
precisely when the target is on the $x$-axis, and never entangles then; in every other case both
marginals shrink.

## 3.3 Phase kickback is the $b_x = -1$ case of the same formula

Put the target in $\ket-$, the $-1$ eigenvector of $X$:

$$ \mathrm{CNOT}\,\big[(\alpha\ket0 + \beta\ket1)\otimes\ket-\big]
 = \alpha\ket0\ket- + \beta\ket1 X\ket-
 = \big(\alpha\ket0 - \beta\ket1\big)\otimes\ket- $$

The target is unchanged and the control has been hit by $Z$. Substituting $b_x = -1$ into
$\vec a\,' = (b_x a_x, b_x a_y, a_z)$ gives $(-a_x,-a_y,a_z)$, which *is* $Z$. **Kickback is not
a separate phenomenon; it is the no-entanglement corner of the same back-action.**

Note what this does to §1.2. The $-1$ in $X\ket-=-\ket-$ was dismissed as a global phase. It is
global for an *isolated* qubit. Attach that qubit as a target and the "global" phase is promoted
to a relative phase *of the control*, with full physical consequence. **A phase is global or
relative depending on what else is in the world.** That is the sharpest thing the gates say about
the equator, and it disposes of the exported conversation's claim that $\ket\pm$ targets are
"logically independent" of the control: $\ket+$ is genuinely inert ($b_x = +1$, $\vec a\,' = \vec
a$) and $\ket-$ is maximally back-acting. Opposite extremes, not a class.

## 3.4 The implication reading costs more than it looks

CNOT is tempting to read as material implication: the target depends on the control, the control
is untouched, so control $=$ premise, target $=$ conclusion. Two objections; the second is
decisive.

**The dependence runs both ways** (§3.3). Any account of implication requiring the premise to be
unaffected is simply false here.

**The roles are a basis choice.** The identity

$$ (H \otimes H)\; \mathrm{CNOT}_{1 \to 2}\; (H \otimes H) \;=\; \mathrm{CNOT}_{2 \to 1} $$

is exact (verified as a matrix identity to machine precision). It holds because
$\mathrm{CNOT} = \tfrac12(\mathbb 1\otimes\mathbb 1 + Z\otimes \mathbb 1 + \mathbb 1 \otimes X -
Z \otimes X)$, and conjugating by $H\otimes H$ swaps $Z \leftrightarrow X$ on each factor,
mapping that expression to itself with the tensor factors exchanged. So a *local* change of basis
-- one gate per wire, no communication -- turns "1 implies 2" into "2 implies 1".

**The cost:** the control/target asymmetry is not intrinsic to the gate but to the basis in which
truth values are read off. A logic built on this must either fix the basis by external decree, in
which case the equator is that decree's gauge freedom (consistent with §2.3), or accept that
entailment direction is observer-relative.

## 3.5 CNOT cannot compute AND, and the reason is algebraic

CNOT computes exclusive-or, which is addition in $\mathrm{GF}(2)$. Composing CNOTs composes
$\mathrm{GF}(2)$-linear maps and NOT gates only add constants, so **every wire of a CNOT/NOT
circuit carries an affine function of the inputs**, however many wires and ancillas are given.
Conjunction is not affine:

$$ \nexists\, c,a,b \in \mathrm{GF}(2):\quad x \wedge y = c \oplus (a \wedge x) \oplus (b \wedge y)
   \ \ \text{for all } x,y \veq{gf2}\lean $$

The closure of affineness under composition is standard linear algebra, asserted here and not
formalised; only AND's non-affineness is discharged in Lean. The group-theoretic version is §4.3.

---

# 4. TOFFOLI, and the owner's own question

## 4.1 Why the third wire, counted

The owner asked directly (2025-08-09): *"Why is the third qubit needed for AND?"* The answer is
cardinality and nothing else. Unitary evolution is invertible, so a gate must be a bijection of
its state space. AND has fibres of sizes 3 and 1, and indeed no two-input one-output Boolean
function of any kind is injective:

$$ \forall f : \{0,1\}^2 \to \{0,1\},\quad f \text{ is not injective}
   \qquad\big(4 > 2\big) \veq{ancilla}\lean $$

That much the prior AI turn had. Here is the part it did not. **Widening the output to two bits
does not rescue it.** One might hope to reuse the second wire, emitting
$(\text{something}, a \wedge b)$ reversibly. Three of the four inputs have conjunction 0, so they
would have to land injectively in the two-element set $\{(x,0)\}$:

$$ \nexists\, g:\{0,1\}^2 \to \{0,1\}^2 \ \text{injective with}\ (g(a,b))_2 = a \wedge b
   \veq{minwires}\lean $$

and the same for the first coordinate (`no_ancilla_free_and_fst`). Since neither output wire of a
two-wire reversible gate can carry AND, **three wires is a genuine minimum, not a convenience.**
Toffoli attains it:

$$ \mathrm{TOFFOLI}(a,b,c) = (a,\,b,\,c \oplus (a\wedge b)), \qquad
   \mathrm{TOFFOLI}(a,b,0)_3 = a \wedge b \veq{toff}\lean $$

## 4.2 And why the third wire, thermodynamically

The counting argument says *that* a bit must be kept; Landauer says what discarding it costs.
Erasing one bit against a bath at $T$ dissipates at least $k_B T \ln 2$ (Landauer 1961; measured
by Berut et al., *Nature* **483** (2012) 187), and reversible computation (Bennett 1973) evades
the bound by never erasing, exactly what Toffoli's untouched controls do: the answer is *added*
to a wire rather than *replacing* the inputs. At $T = 293\ \mathrm{K}$ the floor is
$2.80 \times 10^{-21}\ \mathrm{J}$ per bit, some four orders of magnitude below current CMOS
switching energy: real, but not the binding constraint.

The two arguments are **not** the same. The counting one is a theorem about finite sets, true in
a classical reversible computer with no thermodynamics at all; Landauer supplies the *price* of
the irreversible alternative. Lean formalises only the first.

## 4.3 Reconciling with the owner's own reversibility census

In the 2025-09-09 export the owner worked this territory independently and got most of the way
there. His census of two-input Boolean functions is **correct as stated**: 16 functions, of which
2 are constant and 4 depend on one input, leaving 10 "real" 2-bit functions, 5 up to output
inversion. Verified by enumeration. He then asked, verbatim: *"But only $(2^2)! = 12$ of them are
actually invertible -- I wonder if all of them can be expressed via the TOFFOLI gate?"*

**Where I agree.** The framing is right: the reversible two-bit gates are the permutations of the
4-element input *space*, so the count is a factorial of $2^n$, not a power.

**One located arithmetic slip.** $(2^2)! = 4! = \mathbf{24}$, not 12. Twelve is exactly half, and
half is what he was quotienting by elsewhere in the same message ("*half of which are inverted to
the other 5*"), so it reads as a carried-over halving rather than a misunderstanding. Surfaced,
not corrected (finding 4).

**Where I go further.** Exhaustive enumeration of the group generated by the two CNOTs and the
two NOTs:

| wires $n$ | $\langle$CNOT, NOT$\rangle$ | $+$ TOFFOLI | all bijections $(2^n)!$ |
|---|---|---|---|
| 2 | **24** | 24 | **24** |
| 3 | **1344** | **40320** | **40320** |

At two bits CNOT and NOT already generate *every* one of the 24 reversible gates:
$\mathrm{AGL}(2,\mathrm{GF}(2)) \cong S_4$, order $4 \cdot 6 = 24$. So his question's answer is
**yes, and Toffoli is not even needed** -- at two bits every reversible gate is affine:

$$ g \in \mathrm{Sym}(\{0,1\}^2) \;\Longrightarrow\; \text{each output bit of } g
   \text{ is affine in } (x,y) \veq{agl2}\lean $$

At three bits the affine group has order $2^3 \cdot 7 \cdot 6 \cdot 4 = 1344$ against
$8! = 40320$: affineness now captures $3.3\%$ of the reversible gates, and adding Toffoli closes
the gap exactly. **Toffoli is precisely the escape from affineness, and two bits is too small for
the question to have teeth.** That is the sharpened version of his hunch, and the same fact as
§3.5 seen through the group rather than through one function.

## 4.4 Conjunction as a phase

The seed's request, applied to Toffoli. Put the target in $\ket-$ and the kickback mechanism runs
one level up:

$$ \mathrm{TOFFOLI}\,\big[\ket a \ket b \ket-\big] = (-1)^{a\wedge b}\,\ket a\ket b\ket-,
   \qquad (\mathbb 1 \otimes \mathbb 1 \otimes H)\,\mathrm{TOFFOLI}\,
   (\mathbb 1 \otimes \mathbb 1 \otimes H) = \mathrm{CCZ} $$

both verified exactly (eigenvalue $-1$ for $(a,b)=(1,1)$ and $+1$ otherwise;
$\mathrm{CCZ} = \mathrm{diag}(1,1,1,1,1,1,1,-1)$). So **AND is not computed as a value at all; it
is imposed as a phase condition on the pair of premises**, and the output wire is never written
to. Three properties follow, none of them properties of a lattice meet.

1. **Invisible until interference.** By §2.1(a) a phase changes no truth probability: CCZ leaves
   every computational-basis statistic of all three wires unchanged. The conjunction has been
   computed and nothing about "how true" anything is has moved. Detectable only by recombining
   branches, which is how every phase oracle works: mark by phase, then interfere.
2. **No premise/conclusion structure at all.** CCZ is invariant under permuting all three wires,
   whereas Toffoli distinguishes the target. This is stronger than §3.4's "the direction is a
   basis choice": in the $\ket-$ basis the direction has evaporated.
3. **$\mathbb{Z}_2$-valued, not $[0,1]$-valued.** The phase written is $\pm1$, an element of the
   *finite* subgroup $\{0,\pi\}$ of $U(1)$.

Point 3 cuts against my own §5.2 obstruction rather than for it, and is where I would look next
if the owner wants the phase-as-logic reading rescued: not the whole circle, but the $\pm$
subgroup the real gates generate.

## 4.5 The reach of the analogy, honestly

Toffoli is universal for *classical reversible* computation (Toffoli 1980; Fredkin and Toffoli
1982) but **not** for quantum computation: its matrix is real, in fact integer, and no circuit of
Toffolis and NOTs leaves the real subspace. Toffoli plus Hadamard **is** universal (Shi 2002;
short proof in Aharonov 2003).

This bounds what the whole programme can mean. The classical reversible gates -- exactly the ones
this section's counting arguments concern -- act only on the *poles*, permuting basis states.
Everything genuinely equatorial in §1 to §3 came from $H$, $S$ and $T$, the *non*-classical
generators. So the seed has a built-in division: **Toffoli answers the ancilla question and says
nothing about the equator; Hadamard creates the equator and answers nothing about ancillas.**
They meet only at §4.4, and that meeting is a change of basis, not a new gate.

---

# 5. Ternary logic, honestly

## 5.1 What the classical three-valued logics actually are

| logic | third value reads as | structure |
|---|---|---|
| Kleene (strong $K_3$) | undefined / not yet computed | chain $F < U < T$, connectives $\min$/$\max$ |
| Lukasiewicz $L_3$ | possible | same chain, different implication |
| Priest $LP$ | both true and false | same elements, $U$ *designated* |
| Belnap $B_4$ | none / both / true / false | bilattice: two orders at once |

Every one is an **order**. The connectives are its meet and join; the third value is a point in a
finite chain or lattice. That is what makes them logics rather than decorations.

## 5.2 The obstruction: a circle carries no invariant order

The equator is not a point and not a chain. It is a circle on which the phase gates act
transitively (§2.1b). Ask for a truth-ordering of equatorial states independent of where phase
zero was arbitrarily put -- and it *is* arbitrary, fixed by a choice of $H$ -- and you are asking
for a linear order on the rotation group invariant under translation. There is none:

$$ \begin{aligned}
&\text{If } (G,+,\le) \text{ is linearly ordered abelian with }
   a \le b \Rightarrow a + c \le b + c \ \ \forall c, \\
&\text{then } g \ne 0 \text{ with } n\cdot g = 0 \text{ for some } n > 0 \text{ is impossible.}
\end{aligned} \veq{circle-order}\lean $$

Proof: translation invariance upgrades to strict by cancellation, so $0 < g$ forces $0 < ng$ for
all $n \ge 1$, contradicting $ng = 0$; the case $g < 0$ goes through $-g$. Feed it the circle
group and $g =$ rotation by $2\pi/n$. Every root of unity is a nonzero element of finite order,
so **$U(1)$ admits no rotation-covariant linear order at all**, and any proposed order already
fails on the $n$-th roots of unity. The step from the Lean lemma to $U(1)$ uses only the standard
fact that $U(1)$ has torsion, asserted here and not formalised.

**Therefore the equatorial angle is not a third truth value and cannot be made into one without
breaking the phase symmetry by hand.** Any "more true than" on equatorial states smuggles in a
preferred phase origin, and a preferred phase origin is a preferred conjugate basis, which by
§1.2 is a *second question*, not a third value.

Note what is *not* claimed. The ball does carry good ordered structure: $p = (1+a_z)/2 \in [0,1]$
is a Lukasiewicz-style fuzzy truth value, totally ordered, with NOT acting as the standard
involutive negation $p \mapsto 1-p$. The obstruction is specific to the *circle* direction:

$$ \text{Bloch ball} \;\cong\; \underbrace{p \in [0,1]}_{\text{fuzzy truth value}} \;\times\;
   \underbrace{r}_{\text{how settled}} \;\times\;
   \underbrace{\varphi \in U(1)}_{\text{no order; a context label}} $$

with the caveat that the product is not global (the fibre degenerates at the poles), which is
exactly the statement that a *settled* proposition has no context left to carry.

## 5.3 Where contextuality does and does not bite

The natural next move is to call the equator a **modality** and reach for Kochen-Specker. That
reach is legitimate but must be made in the right dimension, and getting this wrong is the most
common overclaim in the area.

**Kochen-Specker (1967):** in dimension $d \ge 3$ there is no assignment of values $\{0,1\}$ to
all projectors giving exactly one $1$ per orthogonal resolution of the identity, i.e. no
non-contextual hidden-variable assignment. Gleason's theorem, on which the original proof leans,
likewise requires $d \ge 3$.

**For $d = 2$ the theorem is false and a model exists.** Bell (1966), and Kochen and Specker
themselves, gave an explicit non-contextual hidden-variable model for a single qubit: the hidden
state is a point on the sphere and each projective measurement reads off a hemisphere. **So no
property of a single qubit's equator can be argued from contextuality**, and everything in §1 to
§2 is contextuality-free.

**It becomes available exactly at CNOT.** Two qubits give $d = 4$, where the Peres-Mermin magic
square is a state-independent contextuality proof built from two-qubit Pauli products. If the
modality reading is to be underwritten by contextuality, its smallest honest witness is a
*two*-proposition system, the regime of §3. That agrees with §2.3 test 1: both say the equator's
meaning is two-place.

## 5.4 What the equator is *not* a good model of

The exported conversation suggested "unprovable statements might live on the equator". They
should not. An equatorial state is **pure**: radius 1, maximal information, perfectly
distinguishable from its antipode. Independence of a sentence from a theory (CH in ZFC) is not
maximal information about that sentence; it is a fact about the *theory's* inability to fix it,
modelled here by the **centre** ($r=0$, zero information) or a mixture, never a pure equatorial
state. §3.2 makes it concrete: a qubit *acquires* "I hold no information about your truth" by
being entangled and having its radius contracted, and CNOT is the operation that does it.

The 2025-09-21 export's computability framing cuts the same way: undecidability is a property of
a decision procedure over a language, three-place at minimum (theory, sentence, procedure), and
squeezing it into a one-place state label is the arity error
[`omniscience.md`](omniscience.md) diagnoses in the omniscience TODO;
[`logic-qutrit-su3.md`](logic-qutrit-su3.md) takes that on properly.

---

# 6. Disagreements and limits

## 6.1 Four places this essay contradicts the prior AI turns in the exports

1. **"$X\ket- = -\ket-$, unchanged up to global phase"** (2025-08-16). True in isolation,
   misleading in context: §3.3 shows that sign *is* the phase kickback the moment the qubit is a
   CNOT target. The same answer then discusses CNOT without connecting the two.
2. **"If target is $\ket+$: unchanged regardless of control ... logically independent
   statements"** (2025-08-16). $\ket+$ and $\ket-$ behave *oppositely*: $b_x=+1$ gives
   $\vec a\,'=\vec a$ (nothing happens), $b_x=-1$ gives a $Z$ on the control (maximal
   back-action). Lumping them as "real phases, logically autonomous" is the error.
3. **"Unprovable statements might live on the equator"** (2025-08-16). §5.4: the equator is
   maximal information; the centre is none.
4. **"$(2^2)! = 12$"** (owner's own, 2025-09-09). $4! = 24$. §4.3.

Items 1 to 3 are prior AI output and carry no authority. **Item 4 is the owner's own text and is
surfaced, not corrected**, per the working contract.

## 6.2 What the gates did not tell us

- **Which pole is which.** Nothing here distinguishes $\ket0$ from $\ket1$; every gate is
  equivariant under relabelling. That is entirely
  [`logic-bloch-poles.md`](logic-bloch-poles.md)'s question.
- **Why $U(1)$.** The circle is forced by $d=2$ and complex amplitudes; why the amplitudes are
  complex is the qutrit essay's territory.
- **Whether any of this is a logic.** A logic needs a consequence relation with closure
  properties. This essay produced a fuzzy value, a settledness radius, a context circle and a
  $\mathbb{Z}_2$ phase, and checked not one structural rule (cut, weakening, contraction).
  Quantum logic in the Birkhoff-von Neumann sense drops distributivity; whether the reading here
  reproduces that or something else is untested.

---

# 7. Map of the Lean file

[`docs/dreamed/lean/LogicGates.lean`](lean/LogicGates.lean), zero `sorry`, checked with
`lake env lean` from `verify/` under the memory-capped wrapper, exit code 0.

| Theorem | Statement | Used at |
|---|---|---|
| `cnot_involutive`, `toffoli_involutive`, `cnot_bijective`, `toffoli_bijective` | both gates are self-inverse, hence bijections | §3.1 |
| `toffoli_computes_and`, `toffoli_preserves_inputs` | $\mathrm{TOFFOLI}(a,b,0)_3 = a\wedge b$; controls survive | §4.1, §4.2 |
| `no_injective_two_to_one`, `and_not_injective` | no $f:\{0,1\}^2\to\{0,1\}$ is injective | §4.1 |
| `no_ancilla_free_and`, `no_ancilla_free_and_fst` | no reversible 2-wire gate emits AND on either wire | §4.1 |
| `Affine2`, `xor_affine`, `fst_affine`, `not_affine`, `affine2_xor` | the $\mathrm{GF}(2)$-affine class and its positives | §3.5 |
| `and_not_affine` | AND is not affine | §3.5 |
| `bijective_two_bit_affine` | every 2-bit bijection is affine: $\mathrm{AGL}(2,2)\cong S_4$ | §4.3 |
| `lt_add_of_invariant`, `pos_nsmul_succ` | invariance upgrades to strict, and iterates | §5.2 |
| `no_torsion_of_invariant`, `no_invariant_order_of_torsion` | an invariant linear order forbids torsion | §5.2 |

**Not** in Lean and carrying no badge: the density-matrix computations of §3.2, the kickback
identity of §3.3, the Hadamard-conjugation identities of §3.4 and §4.4, and §4.3's group-order
table. Those were checked numerically under the capped wrapper (matrix identities to machine
precision; group orders by exhaustive closure), and numerics is a counter-indicator, never an
assurance tier (`CONVENTIONS.md` §2).

---

# Surfaced for the owner

Each item is a located claim plus the ruling it needs. **None has been written into `TODO.md`,
`ROADMAP.md`, `REVIEW_ME.md` or any sidecar.** A delegated agent's verdict is a recommendation,
never a settled decision.

1. **The central negative finding: the equatorial angle is not a truth value.** §5.2,
   discharged as `no_torsion_of_invariant`. *Ruling:* accept, and Bloch Truth Mapping's "third
   value" ambition moves off the equator entirely (onto the radius per §3.2, or the
   $\mathbb{Z}_2$ phase subgroup per §4.4.3); reject, and the project must nominate a privileged
   phase origin and say on what grounds. First ruling, because the rest reads differently after
   it.

2. **The equator as a two-place modality rather than a one-place value.** §2.2, §2.3, §5.3.
   Passes three of four tests, fails ordering, and is underwritten by contextuality only from two
   qubits up. *Ruling:* is "which context" (a fibre label) enough for what the owner wants, or
   was a magnitude required?

3. **The single sharpest gate fact, offered for promotion of the idea only.** §3.3: a phase is
   global or relative depending on what else is in the world, and kickback is the
   no-entanglement corner of $\vec a\,' = (b_x a_x, b_x a_y, a_z)$. *Ruling:* the owner may want
   this in `physics/toesnail.md`'s eventual measurement or subsystems section. The AI does not
   move it.

4. **One located arithmetic slip in his own text.** "Invertible Functions Bit Mapping Problem",
   2025-09-09: *"only $(2^2)!=12$ of them are actually invertible"*; $4! = 24$, and 12 is that
   halved, consistent with the up-to-inversion halving in the same paragraph. Surfaced, not
   corrected. *Ruling:* whether the downstream reasoning in that conversation used 12 or 24,
   which I have not traced.

5. **His Toffoli question, answered, the answer being more interesting than yes.** §4.3: at two
   bits CNOT and NOT already generate all 24 reversible gates so Toffoli is unnecessary and the
   question has no teeth; at three bits affine gives 1344 of 40320 and Toffoli closes the gap
   exactly. *Ruling:* whether this belongs in the essays wing as its own piece, being a
   self-contained checkable result that his own question generated.

6. **The reach limit of the whole gate programme.** §4.5: classical reversible gates act only on
   the poles; everything equatorial came from $H$, $S$, $T$. *Ruling:* accept as a scoping
   constraint, which would make the ancilla thread and the equator thread two projects rather
   than one.

7. **Contextuality is unavailable in dimension 2.** §5.3: Kochen-Specker and Gleason both need
   $d \ge 3$, and one qubit has an explicit non-contextual hidden-variable model (Bell 1966).
   *Ruling:* none needed, this is settled literature. Listed because it forecloses an argument
   the exported conversations were drifting toward, and the owner should know the door is shut
   before walking at it.

8. **Untested: whether any of this satisfies a consequence relation.** §6.2, no structural rule
   checked. *Ruling:* whether to spend a session on the Birkhoff-von Neumann comparison, the
   natural next dreamed essay, which would settle whether "logic" is the right word for any of
   the above.

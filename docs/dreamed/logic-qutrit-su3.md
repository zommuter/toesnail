---
title: The logical qutrit, SU(3), and the Bloch body that is not a ball
permalink: /dreamed/logic-qutrit-su3
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This file *proposes*; the owner disposes. Nothing here is toesnail theory, and nothing may be
> promoted into `physics/` or `essays/` without the owner authoring the move himself. The two
> `\veq` badges below claim something about [`lean/LogicQutrit.lean`](lean/LogicQutrit.lean)
> **only**, and are deliberately not wired into `physics/*.toml` or `tests/test_verify.sh`.

# Seed and provenance

The owner has a standing backburner project he named himself: **"Bloch Truth"**, later
**"Bloch Truth Mapping"**. Origin turn, verbatim,
`~/knowledge/sessions/claude-ai/2025-08-05_breaking_project_paralysis_cbae6cd6.md:1334`
(2025-08-08 07:22 UTC):

> "the Bloch Truth (might need a better name) might be useful for the AI logic core in the second
> (ZFC?) layer where incompleteness applies (core layer should only be complete, e.g. ZF without
> C), and the Lissajous (again better name needed) for Proxypolation"

The idea was worked out in a chat of 2025-08-16, *Falsifiability and Logical Boundaries*: put
"proven true" and "proven false" at the poles of a Bloch sphere and ask what the rest of the ball
means logically. This essay answers its **last movement**, where the owner pushes from qubit to
qutrit. His turns there, verbatim, are the brief:

> "What about encoding true/false in the phase of provable as unprovable's antipode? And for the
> three state qutrit what would be the Bloch sphere generalization?"
>
> "Why would the qutrit require SU(3) or 8D? The superposition of three states used three complex
> amplitudes, i.e. six real parameters, the absolute sum of which must be normalized to one, so
> even a native approach would only require a 5D representation on 5-sphere (is it called
> 6-sphere?). And by dropping the irrelevant global phase, shouldn't 4D be enough even?"
>
> "So if we use SU(3) for the qutrit mixture Bloch-like space, then we can also use analogies to
> quantum chromodynamics, right? Help me with that please"
>
> "Great, so how do QCD things like confinement, quarks and gluons relate to the logical qutrit
> in detail? Has this been researched publicly?"
>
> "So does the qubit also correspond to SU(2)? Are the three base vectors of QCD up, down,
> strange or the colors? What about the other quarks (charm, top, bottom) and antiquarks or
> anticolors?"

A **companion thread of the same day**, *Mathematical Group Theory Overview*, is where he did the
group theory itself. It matters because it already contains the right answers to two of the
questions above, which the falsifiability thread then got wrong anyway (§4.3, §5). Assistant turns
in both are prior AI output with no authority; auditing them is part of the job here.

Siblings, not repeated: the poles and Kleene / Priest / Belnap are
[`logic-bloch-poles.md`](logic-bloch-poles.md); the CNOT / TOFFOLI equator reading is
[`logic-bloch-gates.md`](logic-bloch-gates.md); "the world formula is impossible" is
[`weltformel-impossibility.md`](weltformel-impossibility.md). Gödel versus Lawvere on $\ket{42}$ is
[`omniscience.md`](omniscience.md), and §6.3 is consistent with it on purpose.

# 0. The headline, stated and not teased

**The owner's arithmetic was right and the AI's correction was wrong in the other direction.**
Pure qutrit states really are a 4-real-parameter family, exactly as he counted. But 8 was never an
error: it is the dimension of the *mixed*-state Bloch body, a different object. Both numbers are
correct, of different things, and the confusion in that exchange is that neither party kept them
apart.

**The structural fact that follows is the real content: the qutrit's Bloch body is not a ball.**
For a qubit every direction of every legal length is a legal state, so a qubit-logic has a
continuum of sharp truth values with no constraints at all. For a qutrit, positivity imposes a
second condition ($\det\rho \ge 0$) with no qubit analogue, and the legal states become a
**proper** subset of the ball. Read as logic: **there are combinations of the three pairwise
leanings that no three-valued state can hold.** In the plane carrying the classical reading it is
one sharp inequality,

$$ |n_3| + p_{\text{undec}} \;\le\; 1 $$

truth-polarisation plus undecidability weight cannot exceed one. That is a theorem about
three-valued quantum logic, not a modelling choice, and one explicit violating state is
machine-checked in [`lean/LogicQutrit.lean`](lean/LogicQutrit.lean).

Everything else is smaller. The phase proposal (§3) survives only weakened. The QCD analogy
(§4, §5) contains exactly one sharp import, and it is not confinement.

# 1. The dimension count, settled

## 1.1 Pure states

| step | constraint | real parameters left | object |
|---|---|---|---|
| raw amplitudes $(\alpha,\beta,\gamma)$ | none | $2 \times 3 = 6$ | $\mathbb{C}^3 \cong \mathbb{R}^6$ |
| normalisation | $\lvert\alpha\rvert^2+\lvert\beta\rvert^2+\lvert\gamma\rvert^2 = 1$ | $6-1 = 5$ | $S^5 \subset \mathbb{R}^6$ |
| drop global phase | $\ket{\psi} \sim e^{i\theta}\ket{\psi}$ | $5-1 = \mathbf{4}$ | $\mathbb{CP}^2 = S^5/U(1)$ |

**The owner is right, twice.** Five parameters after normalisation, four after the phase. And his
parenthetical worry about the name is answered: it is $S^5$, the **5-sphere**, not the 6-sphere.
$S^n$ is named for its own dimension, not the dimension of the space it sits in, so a
5-dimensional sphere lives in $\mathbb{R}^6$. The same table for a qubit gives $4 \to 3 \to 2$,
i.e. $S^3 \to \mathbb{CP}^1 = S^2$, the Bloch sphere, via the Hopf fibration $S^1 \to S^3 \to S^2$.

**Where the prior AI turn went wrong.** It conceded the point and then mis-named the answer: "4
real parameters -> 4-dimensional space [...] which we could visualize as: **4D hypersphere (3-sphere
S³)** [...] **Hopf fibration**: S³ as circles fibered over S²". Three errors in four lines.
(i) $S^3$ is **3**-dimensional, contradicting the count just done correctly. (ii) $S^5/U(1)$ is
$\mathbb{CP}^2$, which is **not a sphere**: $H^2(\mathbb{CP}^2;\mathbb{Z}) = \mathbb{Z}$, so it is
not even homotopy-equivalent to one. (iii) $S^1 \to S^3 \to S^2$ is the **qubit's** fibration; the
qutrit's is $S^1 \to S^5 \to \mathbb{CP}^2$.

**And the concession was too large.** The same turn wrote "Why I confused this with 8D: I
mistakenly thought about the full density matrix representation [...] But for pure states only,
you're absolutely correct." Calling the 8 a mistake is the error. The owner asked for a
*Bloch-sphere* generalisation, and the Bloch sphere is about mixed states. The 8 is the answer to
the question he actually asked.

## 1.2 Mixed states, and the one number that matters

A density matrix on $\mathbb{C}^3$ is $3\times 3$ Hermitian: $3 + 2\cdot 3 = 9$ real parameters,
minus trace one, giving **8**. Those are the Gell-Mann coefficients, in Kimura's normalisation

$$ \rho = \tfrac{1}{3}\hat{I} + \tfrac{1}{2}\, n_a \hat\lambda_a, \qquad a = 1,\dots,8 $$

with $\operatorname{Tr}\hat\lambda_a\hat\lambda_b = 2\delta_{ab}$, so $n_a =
\operatorname{Tr}(\rho\,\hat\lambda_a) = \langle\lambda_a\rangle$ is directly measurable.

| | qubit ($N=2$) | qutrit ($N=3$) |
|---|---|---|
| pure states | $\mathbb{CP}^1 = S^2$, real dim **2** | $\mathbb{CP}^2$, real dim **4** |
| Bloch body | ball in $\mathbb{R}^3$, dim **3** | convex body in $\mathbb{R}^8$, dim **8** |
| body's boundary | $S^2$, dim 2 | dim **7** |
| pure states = boundary? | **yes** | **no**: 4 inside 7 |

$\dim \mathbb{CP}^{N-1} = 2N-2$ and $\dim \partial(\text{body}) = N^2-2$ agree only at $N=2$.
**The qubit is the unique case in which the pure states fill the boundary of the state space.**
Everything strange about the qutrit follows from $4 < 7$. Concretely, every pure qutrit state does
lie on the outsphere $\lvert n\rvert = 2/\sqrt{3}$, but occupies a measure-zero slice of it. So
the prior turn's "pure states live on the surface of a sphere in 8D real space" is half true in
the worst way: the rest of that sphere is not "mixed states in the interior", it is **not states
at all**.

# 2. The Bloch body is not a ball, and that is a claim about logic

## 2.1 Where the extra condition comes from

Write the characteristic polynomial of $\rho$ as $\sum_j (-1)^j a_j x^{N-j}$. All roots are real
($\rho$ Hermitian), so by Descartes' rule of signs all eigenvalues are non-negative **iff** all
$a_j \ge 0$ (Kimura's Lemma 1, Theorem 1). Newton's identities give (his Eqs. 27):

$$ a_1 = 1, \qquad 2!\,a_2 = 1 - \operatorname{Tr}\rho^2, \qquad 3!\,a_3 = 1 - 3\operatorname{Tr}\rho^2 + 2\operatorname{Tr}\rho^3 $$

- $a_1 \ge 0$ is trivial. $a_2 \ge 0$ is $\operatorname{Tr}\rho^2 \le 1$, the **ball condition**;
  in Bloch coordinates $2!\,a_2 = \frac{N-1}{N} - \frac12\lvert n\rvert^2$, i.e.
  $\lvert n\rvert \le \sqrt{2(N-1)/N} = 2/\sqrt3$ for $N=3$.
- **For $N = 2$ the list stops there.** A $2\times 2$ characteristic polynomial has no $a_3$. That
  is the one-line reason the qubit Bloch body is a ball, and it is a fact about *the degree of a
  polynomial*, not about quantum mechanics.
- For $N \ge 3$ there is an $a_3 \ge 0$, and $a_3 = \det\rho$.

With $d_{abc} = \frac14 \operatorname{Tr}(\{\hat\lambda_a,\hat\lambda_b\}\hat\lambda_c)$ (Kimura
writes $g_{ijk}$), the third condition for $N=3$ is

$$ 3!\,a_3 \;=\; \tfrac{2}{9} - \tfrac{1}{2}\lvert n\rvert^2 + \tfrac{1}{2}\, d_{abc}\,n_a n_b n_c \;\ge\; 0 \quad\Longleftrightarrow\quad \det\rho = \frac{1}{27} - \frac{\lvert n\rvert^2}{12} + \frac{d_{abc}\,n_a n_b n_c}{12} \;\ge\; 0 $$

The cubic term is the symmetric "star product" $n \star n \cdot n$ of the qudit literature. **It is
odd in $n$**, and that single fact is the source of everything asymmetric below: it distinguishes
$n$ from $-n$.

*Verification note.* The text extracted from Kimura's PDF renders the invariant form as
"$36 - 9\lvert\lambda\rvert^2 + 9g\lambda\lambda\lambda \ge 0$", whose constant cannot be right: a
pure state ($\lvert n\rvert^2 = 4/3$, $d(n,n,n) = 8/9$) must give exactly zero, and does so for
$4$, not $36$. His fully expanded Eq. (31) likewise loses a $\lambda_8$ factor in extraction. So
the formulas above were **re-derived** from $\det = \frac16[(\operatorname{Tr}M)^3 - 3
\operatorname{Tr}M\operatorname{Tr}M^2 + 2\operatorname{Tr}M^3]$ and checked numerically against
explicitly built Gell-Mann matrices, not copied. The recomputed $d_{abc}$ ($d_{118} = 1/\sqrt3$,
$d_{888} = -1/\sqrt3$, $d_{448} = -1/(2\sqrt3)$, $d_{146} = 1/2$) agree with his Eq. (10).

## 2.2 The worked counterexample

Take $n = -\tfrac{3}{4}\,(0,0,1,0,0,0,0,\tfrac{1}{\sqrt3})$, i.e. $n_3 = -3/4$,
$n_8 = -\sqrt3/4$, all others zero.

- **Length** $\lvert n\rvert = \sqrt3/2 \approx 0.866$ against the maximum $2/\sqrt3 \approx 1.155$,
  so 75 % of the pure-state radius. **The ball test passes, with room to spare.**
- **Determinant** $\det\rho = -49/864 \approx -0.057 < 0$. **Positivity fails.**
- **The matrix** is $\rho = \operatorname{diag}(-1/6,\; 7/12,\; 7/12)$: the "probability" of the
  outcome *proven true* is $-1/6$.

$$ \exists\, H = H^\dagger,\ \operatorname{Tr}H = 0,\ \operatorname{Tr}H^2 \le \tfrac23 \ \text{ with } \ \tfrac13 I + H \not\ge 0 \veq{qutrit-ball}\lean $$

That is `qutrit_body_not_a_ball`, discharged over $\mathbb{Q}$ with the explicit eigenvector
$e_0 = (1,0,0)$, so no eigenvalue algorithm and no irrational number is involved.

**What logical combination does it describe?** Under $\ket{0} = $ proven true, $\ket{1} = $ proven
false, $\ket{2} = $ undecidable, the two Cartan coordinates are

$$ n_3 = p_{\text{true}} - p_{\text{false}}, \qquad n_8 = \frac{p_{\text{true}} + p_{\text{false}} - 2 p_{\text{undec}}}{\sqrt3} $$

so $n_3$ is the **truth polarisation** and $n_8$ the **undecidability weight**. The rejected vector
says: *this statement leans towards proven-false by 3/4 of the maximum polarisation, and carries
7/12 of its weight on undecidable.*

Both halves are separately attainable: a state with $n_3 = -3/4$ exists (take
$n_8 \in [\sqrt3/12, \sqrt3/3]$), and so does one with $p_{\text{undec}} = 7/12$. **No state has
both.** In this plane positivity is just $p \ge 0$ componentwise, so
$\lvert n_3\rvert = \lvert p_{\text{true}} - p_{\text{false}}\rvert \le p_{\text{true}} +
p_{\text{false}} = 1 - p_{\text{undec}}$:

$$ \lvert n_3 \rvert + p_{\text{undec}} \;\le\; 1 $$

and the offending vector scores $3/4 + 7/12 = 4/3$. In words: **the more sharply a statement is
polarised between proven-true and proven-false, the less undecidability it can carry, and the
trade-off is exactly linear and saturated at 1.** Not a soft tension, not an uncertainty relation:
a hard kinematic bound with no qubit analogue, because the corresponding qubit section is the full
diameter $[-1,1]$ and nothing is excluded.

Geometrically the $(n_3, n_8)$ section is a **triangle** (Kimura's "Type I" section, Eq. 32) whose
vertices are the three pure classical verdicts: the probability simplex. The ball condition draws
its **circumcircle**, radius $2/\sqrt3$. The crescents between triangle and circle are the whole
discovery: every point there is a logical value a naive Bloch generalisation admits and positivity
forbids. The **incircle** has radius $1/\sqrt3$, so the largest ball of guaranteed-legal Bloch
vectors is exactly **half** the outsphere. (That agrees independently with the Gurvits-Barnum
Hilbert-Schmidt radius $1/\sqrt{d(d-1)} = 1/\sqrt6$ around the maximally mixed state, which
converts to $\lvert n\rvert = 1/\sqrt3$.) In general the ratio is $1/(N-1)$: the Bloch body gets
*relatively* thinner as the logic gets more truth values.

## 2.3 The antipode, the sharpest single instance

Take the pure state "proven true", $n_{\text{pure}} = (0,0,1,0,0,0,0,1/\sqrt3)$,
$\lvert n\rvert = 2/\sqrt3$, $\det\rho = 0$. Now **reverse it**.

$$ \operatorname{Tr}\big((-H_p)^2\big) = \operatorname{Tr}\big(H_p^2\big) \quad\text{and yet}\quad \det\!\big(\tfrac13 I - H_p\big) = -\tfrac{4}{27} < 0 \veq{antipode}\lean $$

The antipode has *identical* length, so no norm test can distinguish it, and it is
$\operatorname{diag}(-1/3, 2/3, 2/3)$: not a state. That is `antipode_not_a_state`.

For a qubit, $n \mapsto -n$ maps the ball onto itself and **is** logical negation: it swaps the
poles and is realised by a unitary. For a qutrit it leaves the state space. **"Flip every leaning"
is not an operation on three-valued logical values**, and the odd $d_{abc}$ term is why. §4.4 shows
this is the state-space shadow of $\bar{\mathbf{3}} \not\cong \mathbf{3}$.

# 3. True/false in the phase of provable

The proposal: poles are $\ket{\text{unprovable}}$ and $\ket{\text{provable}}$, truth rides in the
phase of the provable component.

**The version in the prior AI turn does not survive.** It wrote "$\ket{\tilde 1} =
e^{i\pi}\ket{\text{provable}} = -\ket{\text{provable}} = \ket{\text{provable\_false}}$ [...] North
pole: Provably true; South pole: Unprovable; Antipodal to south: Provably false". Two located
errors: (i) $-\ket{1}$ and $\ket{1}$ are **the same physical state**, since that is the global
phase §1.1 just quotiented away, so provably-false would be indistinguishable from provably-true;
(ii) "antipodal to south" is the north pole, already assigned to provably-true. The picture is not
merely non-unique, it is inconsistent as written.

**What survives, weakened.** A *relative* phase is real and observable. With

$$ \ket{\psi} = \cos\tfrac{\theta}{2}\,\ket{\text{unprov}} + e^{i\varphi}\sin\tfrac{\theta}{2}\,\ket{\text{prov}} $$

$\varphi$ is a genuine coordinate for $\theta \notin \{0,\pi\}$, and $\varphi \in \{0,\pi\}$ is
distinguishable by an $X$-basis measurement. So the embedding works, with three consequences:

1. **Wildly non-unique.** Any antipodal pair $\{\varphi_0, \varphi_0+\pi\}$ does the job, so there
   is no canonical choice and hence **no canonical negation**. Same defect §4.4 finds in SU(3),
   reached far more cheaply.
2. **Meaningless without a reference.** A single isolated qubit has no observable phase; you need
   a fixed basis or a second system. Logically: *truth is defined only relative to a chosen
   interpretation.* I think this is the proposal's genuinely attractive feature rather than a bug,
   and it connects directly to §6.2's model-relativity.
3. **It fails exactly where it is needed most.** At $\theta = 0$, the pole $\ket{\text{prov}}$, the
   relative phase is undefined: nothing is left to be relative to. A statement that is *certainly
   provable* has **no truth value** in this encoding, which is the opposite of the intent.

**Recommendation (the owner rules).** Reject the $\ket{\text{false}} = -\ket{\text{provable}}$ form
outright. Keep the relative-phase form only as a *coordinate on the interior*, never as the carrier
of a settled verdict. And note the punchline: defect (3) is repaired by giving truth its own
dimension, so the phase proposal taken seriously **argues for the qutrit**. His two questions in
that one turn are not alternatives; the first motivates the second.

# 4. The QCD analogy: what is true, what is prior art, what is mood

## 4.1 Has this been researched publicly?

Searches, not an exhaustive literature review, and I say so.

**Exists.** Three-valued logic and QM as philosophy (Reichenbach 1944; Bigaj, *J. Phil. Logic* 30,
2001) -- about interpreting QM, not qutrit geometry. *Quantum logic* in the Birkhoff-von Neumann
sense (the lattice of projections) is not a many-valued logic at all and is routinely conflated
with one. Ternary quantum circuits and qutrit computing: large and active. Recent work claims an
error-correctable implication algebra embedding three-valued Łukasiewicz logic in a stabiliser
code, which I saw only via a secondary report, so treat as a lead. MV-algebras (Chang) are where a
genuine **continuum** of truth values already lives, and it is the interval $[0,1]$, not a ball.

**Not found.** Any published work mapping QCD's SU(3) -- colour, confinement, gluons -- onto a
logical system; nor any reading the qutrit positivity constraint of §2 as a constraint on
many-valued logic. So the prior AI's "genuinely novel research direction" lands roughly right but
with the wrong emphasis. **The mathematics is not novel at all**: Kimura 2003 and Bertlmann-Krammer
2008 are standard twenty-year-old qudit geometry. Only the *interpretation* is unclaimed, and
"unexploited application of settled mathematics" is the honest description, a far weaker claim.

## 4.2 Does the qubit correspond to SU(2)? Yes, with a refinement

The pure-state space is $\mathbb{CP}^1 = SU(2)/U(1) \cong S^2$: the Bloch sphere is a
**homogeneous space** of SU(2), not SU(2) itself (which is $S^3$). The Pauli matrices generate, and
the *adjoint* action on the Bloch vector is rotation, $SO(3) = SU(2)/\mathbb{Z}_2$. Likewise
$\mathbb{CP}^2 = SU(3)/U(2)$, with the adjoint action on the 8-vector by
$SU(3)/\mathbb{Z}_3 \subset SO(8)$. Note the containment: $\dim SU(3) = 8$ while $\dim SO(8) = 28$,
so **the adjoint action covers only a small part of the rotations that would move the ball
freely.** That is a second, independent way to see §2: there is not enough symmetry to carry an
arbitrary direction to any other, so there is no reason for the body to be round, and it is not.

## 4.3 Colour or flavour? Colour, and the owner already knew

|  | $SU(3)_C$ | $SU(3)_{\text{flavour}}$ |
|---|---|---|
| the **3** is | red, green, blue | $u$, $d$, $s$ |
| status | **exact gauge symmetry** | **approximate, badly broken global** |
| adjoint **8** | the eight gluons, real particles | the Eightfold Way octet |
| $c$, $t$, $b$? | carry colour like every quark | **excluded**, mass splitting far too large |

Charm, top and bottom are not "the other basis vectors": they are *flavours*, each coming in all
three colours, and they sit outside flavour SU(3) because $m_c \approx 1.3$, $m_b \approx 4.2$,
$m_t \approx 173$ GeV against $m_{u,d,s} \lesssim 0.1$ GeV.

**Audit finding.** The owner's companion group-theory thread of the *same day* got this exactly
right, including "There are actually three different SU(3) symmetries in particle physics". The
falsifiability thread nonetheless opened its QCD section with "**Up quark (u)** ↔
$\ket{\text{provably\_true}}$, **Down quark (d)** ↔ $\ket{\text{provably\_false}}$, **Strange quark
(s)** ↔ $\ket{\text{unprovable}}$", and corrected to colour only after he pushed back. **He caught
it himself, from his own prior reading.** Two AI threads on one day disagreeing on the same point
is the practical argument for writing it down once.

Which should a logical qutrit use? **Colour**, and for a better reason than "colour is the exact
one": the three logical values are meant to be interchangeable placeholders whose labels carry no
intrinsic content, which is what colour is and flavour is not. But note the twist. Flavour SU(3)
has a preferred direction (the mass hierarchy, i.e. the $\lambda_8$ / hypercharge axis), and a
three-valued *logic* has one too, since "undecidable" is not on a par with "true" and "false". So
if one insists on the analogy, **broken flavour SU(3) is arguably the closer fit than exact colour
SU(3)**, inverting the usual advice. Offered as an observation, not a recommendation; it is exactly
the kind of thing that reads well and predicts nothing.

## 4.4 Antiquarks and anticolours: the one sharp import

The fact the falsifiability thread never reached, though the group-theory thread stated its general
form ("For SU(2): **2** and **2̄** are equivalent. This is special to SU(2)! For SU(n≥3),
**n** ≠ **n̄**"):

For SU(2) the antisymmetric invariant $\epsilon_{ab}$ intertwines $\mathbf{2}$ and
$\bar{\mathbf{2}}$ ($\sigma_2 U^* \sigma_2^{-1} = U$), so the fundamental is **pseudo-real**. For
SU(3) there is no such intertwiner: $\mathbf{3}$ and $\bar{\mathbf{3}}$ are genuinely inequivalent,
distinguished by the cubic Casimir (equivalently by $d_{abc}$ changing sign). Hence
$\mathbf{3}\otimes\mathbf{3} = \mathbf{6} \oplus \bar{\mathbf{3}}$ while
$\mathbf{3}\otimes\bar{\mathbf{3}} = \mathbf{8} \oplus \mathbf{1}$, which is why mesons need an
antiquark and baryons need three quarks.

**The logical claim, this essay's second-best content.** For a qubit, "swap the two truth values"
is an inner symmetry of the state space: $n \mapsto -n$, unitary, ball to ball, and it is *the*
negation. For a qutrit the corresponding move leaves the representation you started in. Hence:

> **A three-valued logic built on SU(3) has no basis-independent notion of "the negation".**

**Does it hold up? Partly, and the qualification matters.**

1. **The Bloch-reversal form holds and is proved.** $n \mapsto -n$ genuinely does not preserve the
   qutrit state space (§2.3, machine-checked). Not an analogy, a theorem.
2. **But conjugation itself *does* preserve it.** $\rho \mapsto \rho^{*} = \rho^{T}$ is positive
   and trace-preserving. In Bloch coordinates it flips only the antisymmetric generators
   ($\lambda_2, \lambda_5, \lambda_7$), so it is a reflection, not $-1$. Conjugation-as-negation is
   not impossible; it is merely **not $-1$ and not completely positive** (the fact behind the
   Peres-Horodecki criterion).
3. **The real claim is uniqueness, not existence.** For a qubit "the negation" is pinned down. For
   a qutrit there are many candidate involutions -- the three basis transpositions, conjugation in
   any basis, the order-3 cyclic permutations -- and **nothing in the geometry selects one.**
   Exactly the defect §3 found in the phase encoding, from the opposite direction.

The honest form, and the one I recommend for ratification: **there is no distinguished negation on
a three-valued state space, and there is on a two-valued one.** The $\mathbf{3}$-versus-
$\bar{\mathbf{3}}$ story explains why. Overstating it as "negation is impossible" would be false.

# 5. Confinement: mood, and what to take instead

The tempting reading -- only colour-singlet combinations are physical, so only certain logical
combinations are assertible -- is a good sentence with nothing behind it.

**Confinement is a property of the Yang-Mills Hamiltonian, not of SU(3) representation theory.**
The group gives gauge invariance, gluons in the adjoint **8**, and self-interacting field
equations. It does *not* give a linear potential, a string tension, or a mass gap. Those come from
non-perturbative dynamics: the running coupling ($\beta(g) = -b_0 g^3 - \dots$, $b_0 > 0$, so
$\alpha_s \to \infty$ in the infrared), the area law for Wilson loops, and lattice QCD. Proving it
rigorously is an open Clay Millennium problem. The owner's own group-theory thread says this
correctly and at length ("Confinement is **not** a consequence of SU(3) representation theory. It's
a **dynamical** phenomenon"), so I am agreeing with him, not correcting him.

**A logic supplies none of the ingredients**: no Hamiltonian on statements, no energy, no length
scale, hence no running coupling. "Asymptotic logical freedom", "logical flux tubes" and "phase
transitions between logical vacua" are mood, each borrowing its only content from the word itself.

**What would have to be added?** Three things, none cheap: a **cost metric** on statements (proof
length is the plausible candidate); a **dynamics**, a distinguished one-parameter evolution (proof
search is not unitary, not reversible, not canonical); and a **scale** so that high and low energy
mean something (proof-theoretic ordinal strength or axiom-set size, neither of which runs). A
falsifiable version would then read: *the minimum proof length required to settle a statement in
isolation from its axiomatic context grows linearly in a suitable separation measure.* I do not
know whether that is true, false, or ill-formed, and neither does the analogy.

**There is a better analogue available, and it is §2.** The positivity constraint is real, purely
kinematic, needs no dynamics or coupling, says exactly what confinement was being borrowed to say
("not every combination is physical"), and is proved in one line and machine-checked. If the owner
wants forbidden logical combinations in the theory, take them from $\det\rho \ge 0$, not from
Yang-Mills. And if he still wants a QCD word for it, the right one is not confinement but
**superselection**: a kinematic constraint on which states exist. That import is honest and free.

# 6. Gödel, model-relativity, and the layered core

## 6.1 A correction to the origin quote, offered plainly

The seed proposes a layered core: "the second (ZFC?) layer where incompleteness applies (core layer
should only be complete, e.g. ZF without C)".

**Dropping choice buys no completeness.** Gödel's first incompleteness theorem applies to any
consistent, effectively axiomatised theory in which Robinson's $Q$ can be interpreted. ZF
interprets $Q$ just as ZFC does. The Stanford Encyclopedia entry makes the point explicitly for set
theories: the theorems hold for ZFC without infinity "and all its extensions, however strong (as
long as they are axiomatizable)". Worse for the example chosen: **the independence of AC from ZF is
itself an instance of ZF's incompleteness** (Gödel 1938 shows $\mathrm{ZF} \nvdash \neg\mathrm{AC}$
via $L$; Cohen 1963 shows $\mathrm{ZF} \nvdash \mathrm{AC}$ via forcing). "ZF without C" is a theory
whose most famous property is that it fails to decide the axiom that was removed from it.

This is one parenthetical in a fast idea-capture turn and he is the domain expert. I flag it
because a layered architecture built on it inherits the mistake at its foundation.

**The idea is salvageable, cheaply.** Complete decidable logics exist; they are exactly the ones
too weak to interpret arithmetic.

| candidate core | status | cost |
|---|---|---|
| propositional logic | complete, decidable | no quantifiers, no arithmetic |
| Presburger arithmetic ($+$, no $\times$) | complete, decidable | no multiplication |
| Tarski's real closed fields | complete, decidable | no integers definable |
| ZF, ZFC, PA | **incomplete** | -- |

So the layer split he wants is real. **It is just not ZF-versus-ZFC; it is
arithmetic-versus-no-arithmetic.** The boundary is the one Gödel's hypothesis draws, and it falls
far below set theory.

## 6.2 Third basis state, or ensemble over models?

**Independence is relative twice over**, to a theory and to a model. "AC is undecidable" is a
property of the pair (ZF, AC), not of AC. And a sentence undecidable in $T$ is still **true or
false in each model** of $T$: AC holds in $L$ and fails in Cohen's model. There is no third truth
value inside any model. So making "undecidable" a third *basis state* commits to a position: that
undecidability is an intrinsic status of a sentence, on a par with truth and falsity.

| | **(a) third pure basis state** | **(b) ensemble over models** |
|---|---|---|
| object | qutrit, $\ket{2} = \ket{\text{undecidable}}$ | qubit, mixed $\rho$, $r < 1$ |
| dimension, group | 8, SU(3) | 3, SU(2) |
| model-relativity right? | no: undecidable is a status | **yes**: $r$ = model agreement |
| open problem (Goldbach) | ad hoc superposition | small $r$, near the centre. natural |
| $\mathrm{Con}(PA)$, proven independent | pure $\ket{2}$, natural | $r \approx 0$: same as ignorance |
| inherits §2's constraint | **yes** | no: the ball is the whole story |

**(b) is the logically more defensible reading of "undecidable"**: it gets model-relativity right
and makes independence a *degree*. **(a) is the more defensible reading of "we have PROVED that $T$
does not decide $\varphi$"**: that is a positive metatheorem, knowledge and not ignorance, and (b)
cannot tell it apart from "no idea", since both land near $r = 0$.

**Recommendation, to accept, reject or amend.** Neither alone; use **both axes**:

- **Basis** = the three settled *metatheoretic verdicts*: $\ket{\text{provable}}$,
  $\ket{\text{refutable}}$, $\ket{\text{proven independent}}$. Given consistency these are mutually
  exclusive and jointly exhaustive of what a metatheory can establish, which is exactly the
  condition for an orthonormal basis to be the right structure.
- **Mixedness** $r$ = the *epistemic* state, how far from settled.

Then Goldbach today sits near the centre, a proof moves it to a vertex, and $\mathrm{Con}(PA)$ and
AC-in-ZF sit at the $\ket{\text{independent}}$ vertex, correctly distinguished from ignorance about
them. It is genuinely a **qutrit**, so §2 bites and $\lvert n_3\rvert + p_{\text{indep}} \le 1$
becomes substantive: *the more decisively a question is settled either way, the less
independence-weight it can carry.* Right as epistemology, and a theorem rather than a stipulation.

This is a real fork in the "Bloch Truth" architecture, it changes the group, and it is his to take.

## 6.3 Consistency with `omniscience.md`

That sibling argues **Gödel I does not apply** to $\ket{42}$ and that the real theorem is
Lawvere's. Nothing here disagrees. There the object is a **physical knower**, a subsystem of a
Hilbert space with no formal language, no effective axiomatisation and no arithmetic, so Gödel I's
hypotheses are absent and importing it is an error. Here the object **is a formal theory**, where
they hold by construction. Same repo, opposite verdicts, no contradiction: the difference is
entirely whether the thing discussed is a formal system. The one real error would be sliding
between them, and §6.2's ensemble reading is the natural bridge, because a *model* is what turns a
formal sentence back into something with a definite truth value.

# 7. Lean attestation

File [`docs/dreamed/lean/LogicQutrit.lean`](lean/LogicQutrit.lean), namespace
`Toesnail.LogicQutrit`. Command, from `verify/`:

```
../docs/dreamed/capped.sh -m 4G -c 100 -- lake env lean --threads=1 ../docs/dreamed/lean/LogicQutrit.lean
```

**Exit status 0, no output, no `sorry`, no warnings.** Everything is over $\mathbb{Q}$, so `det`
and `trace` are `norm_num` computations and no eigenvalue algorithm is involved.

| theorem | statement |
|---|---|
| `H_traceless`, `rho_eq`, `rho_trace` | the witness really is a Bloch decomposition of a unit-trace matrix |
| `H_hs_norm`, `H_inside_ball` | `Tr(H*H) = 3/8 < 2/3`: **the ball test passes** |
| `rho_det`, `rho_det_neg` | `det rho = -49/864 < 0`: **positivity fails** |
| `rho_eigen`, `rho_not_psd` | explicit negative eigenvector: `rho *ᵥ e0 = (-1/6) • e0` |
| **`qutrit_body_not_a_ball`** | **§2.2**: traceless `H`, `Tr H² ≤ 2/3`, `(1/3)I + H` not positive |
| `Hp_hs_norm`, `Hm_hs_norm`, `pure_det` | a pure Bloch vector and its antipode have identical length `2/3` |
| **`antipode_not_a_state`** | **§2.3**: same length, `det = -4/27 < 0` |

**What is NOT proved**, so the badges are not over-read: Kimura's theorem (that $a_i \ge 0$ for all
$i$ is necessary *and sufficient*); the closed form of $a_3$ in $d_{abc}$; §1's dimension counts
(arithmetic in prose only); anything about SU(3), colour, or $\bar{\mathbf{3}} \not\cong
\mathbf{3}$. One counterexample is all §2 claims and all that is discharged. The two `\veq` badges
are scoped to that file per `docs/dreamed/README.md` and are **not** sidecar attestations.

# Surfaced for the owner

Each item is a located claim plus the ruling it needs. **None has been written into `TODO.md`,
`ROADMAP.md` or `REVIEW_ME.md`, and none is a decision.**

1. **The dimension count: he was right, and so was the 8.** §1. Pure states are $\mathbb{CP}^2$,
   real dimension 4, exactly as he counted; the sphere is $S^5$, not $S^6$; the mixed-state body has
   dimension 8. The prior AI turn conceded the 8 as "a mistake" and then named the 4-dimensional
   answer "$S^3$" (3-dimensional, and not $\mathbb{CP}^2$), quoting the qubit's Hopf fibration as
   the qutrit's. **Ruling:** whether to record the corrected count durably, this being the second AI
   thread to get it wrong.

2. **HEADLINE. The qutrit Bloch body is not a ball, and the logical consequence is a hard linear
   trade-off.** §2. $\lvert n_3\rvert + p_{\text{undec}} \le 1$. Violating state
   $\operatorname{diag}(-1/6, 7/12, 7/12)$, Bloch length only 75 % of maximum, $\det = -49/864$;
   machine-checked. **Ruling:** is this the thesis the "Bloch Truth" essay has been missing (item 9)?

3. **The antipode of a pure logical value is not a logical value.** §2.3, `antipode_not_a_state`.
   **Ruling:** accept or reject the derived claim that a three-valued state space has **no
   distinguished negation** (§4.4), in the *qualified* form given there. The unqualified form
   ("negation is impossible") is false: transposition is a perfectly good involution, what fails is
   uniqueness.

4. **The phase encoding, as written in the prior turn, is incoherent.** §3.
   $\ket{\text{false}} = -\ket{\text{provable}}$ is a *global* phase, hence the same state; and
   "antipodal to south" is the north pole, already assigned. The relative-phase version works, is
   wildly non-unique, and **has no truth value at the provable pole**, precisely where one is
   wanted. **Recommendation:** reject the global-phase form, keep the relative-phase form as an
   interior coordinate only, and note it argues *for* the qutrit. **Ruling:** accept or reject.

5. **Colour, not flavour, and he caught it himself.** §4.3. Offered without recommendation: because
   a three-valued logic has a preferred $\lambda_8$ direction, **broken flavour SU(3) is arguably
   the closer analogy than exact colour SU(3)**, inverting the standard advice. **Ruling:** whether
   that inversion is interesting or merely cute.

6. **Confinement is mood; take superselection instead.** §5. Confinement is a property of the
   Yang-Mills Hamiltonian, not of SU(3) representation theory, and a logic supplies no Hamiltonian,
   scale or running coupling. §2's positivity constraint says the same thing kinematically and is
   proved. **Ruling:** drop the confinement / asymptotic-freedom / flux-tube language from the Bloch
   Truth material, or keep it explicitly labelled as metaphor.

7. **LOAD-BEARING CORRECTION to the origin quote.** §6.1.
   `~/knowledge/sessions/claude-ai/2025-08-05_breaking_project_paralysis_cbae6cd6.md:1334` says
   "core layer should only be complete, e.g. ZF without C". Dropping AC buys no completeness: ZF
   interprets Robinson arithmetic, so Gödel I applies identically, and AC's independence from ZF
   (Gödel 1938, Cohen 1963) is *itself* an instance of that incompleteness. The layered idea
   survives; the boundary is arithmetic-versus-no-arithmetic (Presburger, RCF, propositional logic
   are complete), not ZF-versus-ZFC. **Ruling:** amend the layered-core design before anything is
   built on it.

8. **The architectural fork, his to take: third basis state or ensemble over models?** §6.2. A third
   *pure* basis state makes undecidability an intrinsic status, adds a dimension, and buys SU(3)
   plus item 2's constraint. An ensemble gets model-relativity right, keeps it a qubit, and cannot
   distinguish "proven independent" from "no idea". **Recommendation:** both axes -- basis = the
   three settled metatheoretic verdicts (provable / refutable / proven-independent), mixedness = how
   far from settled. That keeps the qutrit, so item 2 bites. **Ruling:** this changes the group
   (SU(2) versus SU(3)) and is the design decision of the whole project.

9. **Candidate unblocker for `TODO.md:127` (`id:4bb2`).** That item records the "Bloch Truth" essay
   as BLOCKED because a 2026-07-17 meeting found no thesis statement in 412 session files. Items 2
   and 8 are offered as a candidate thesis: *"positivity, not choice of geometry, fixes the shape of
   a three-valued logical state space; the space of coherent logical attitudes is a probability
   simplex inscribed in the naive Bloch ball, and the polarisation/undecidability trade-off is a
   theorem."* **Ruling:** whether that is a thesis in the sense that meeting meant. **Nothing has
   been edited in `TODO.md`.**

10. **Prior-art honesty.** §4.1. No published work found mapping QCD's SU(3) onto a logical system,
    nor reading qutrit positivity as a many-valued-logic constraint. But the *mathematics* is
    entirely standard, so the right claim is "unexploited application of settled mathematics", not
    "novel research direction". The search was engine-mediated and not exhaustive. **Ruling:**
    whether a proper literature check is worth commissioning before any public write-up.

# Sources consulted

- G. Kimura, *The Bloch Vector for N-Level Systems*, arXiv:quant-ph/0301152 (Phys. Lett. A **314**,
  339-349, 2003). Read in full; §2 is his Theorem 1, Lemma 1 and Eqs. (17), (18), (27)-(32).
  Constants re-derived and numerically re-checked, see §2.1.
- R. A. Bertlmann and P. Krammer, *Bloch vectors for qudits*, J. Phys. A **41** (2008) 235303
  (arXiv:0806.1174). Consulted for generalised Gell-Mann basis conventions.
- L. Gurvits and H. Barnum, *Largest separable balls around the maximally mixed bipartite quantum
  state*, Phys. Rev. A **66**, 062311 (2002). Cross-check of the insphere radius only.
- P. Raatikainen, *Gödel's Incompleteness Theorems*, Stanford Encyclopedia of Philosophy, for
  §6.1's hypotheses and their applicability to set theories.
- T. Bigaj, *Three-valued logic, indeterminacy and quantum mechanics*, J. Phil. Logic **30** (2001).
  Located, not read in full.
- The owner's own chats: *Falsifiability and Logical Boundaries* (2025-08-16), *Mathematical Group
  Theory Overview* (2025-08-16), *Gödel's incompleteness theorem reimagined* (2025-10-09), and the
  "Bloch Truth" origin turn of 2025-08-08. Assistant turns there are prior AI output, audited
  above, not authority.

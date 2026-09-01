---
title: Photon localizability and the Gaussian ansatz
permalink: /dreamed/photon-localizability
---

**DREAMED, UNREVIEWED.** AI-generated exploration, not owner-authored, no authority.
See [`docs/dreamed/README.md`](README.md) for the status contract. Every "finding" below is a
recommendation awaiting the owner's ruling.

Seed: [`physics/photon.md`](../../physics/photon.md), which is 15 lines long and stops in the middle
of a derivative. Open question **Q12** in `TODO.md id:57e2`: *accept the Newton-Wigner
non-localizability caution flag on photon.md's Gaussian ansatz?* The flag was raised in
`docs/meeting-notes/2026-07-07-1257-corpus-dreaming-session.md` §1.7, phrased as a
`[finding - caution]`: the file "should meet the theorem *before* interpreting $\mu_\alpha(x)$ as
'the photon's position', or the rigor-debt will be structural rather than algebraic."

This essay does three things. It states what the theorem actually says, because most of what
circulates under "photons cannot be localized" is half true. It checks the owner's ansatz against
the wave equation with SymPy and Lean, which produces a finding that has nothing to do with
localizability. And it argues Q12 both ways and lands on a recommendation with its weakness named.

---

## 1. What is actually true about photon localizability

Four separate statements travel together under one slogan. They have different truth values.

**(1a) There is no Newton-Wigner position operator for the photon. TRUE, and this is the sharp
statement.** Newton and Wigner (*Rev. Mod. Phys.* **21**, 400, 1949) axiomatised "localized at a
point at time $t$" by five requirements including rotational completeness, and solved the resulting
problem. The construction succeeds for every massive irreducible representation, and for massless
ones **only up to helicity $|\lambda| \le 1/2$**. It fails at $|\lambda| \ge 1$, which is exactly
where the photon sits. Wightman (*Rev. Mod. Phys.* **34**, 845, 1962) recast this as a system of
imprimitivity with commuting coordinate operators and showed the photon case has no solution, with
transversality identified as the obstruction. The modern re-derivations agree on the boundary:
[Dobrski et al., arXiv:1806.09372](https://arxiv.org/abs/1806.09372) put it as "the Newton-Wigner
construction works only for helicity $|\lambda| \le 1/2$", and locate the failure in the fact that
helicity eigenstates form a complete rotational set only for $S \le 1/2$.

**(1b) There is no position operator with commuting components. CONTESTED, not settled folklore.**
Pryce's operator is Hermitian but has non-commuting components, with an anomalous commutator
proportional to $\lambda$. Hawton (*Phys. Rev. A* **59**, 954, 1999) constructed an operator that
differs from Pryce's by a Berry-connection term and does have commuting components; the price is
that it carries a gauge/frame choice and is not rotationally covariant in the naive sense. The
construction is still being argued about
([arXiv:2205.04791](https://arxiv.org/pdf/2205.04791) constructs it from axioms,
[arXiv:2203.14555](https://arxiv.org/abs/2203.14555) is a published objection). So the honest form of
(1b) is: **no operator satisfying all of Wightman's axioms simultaneously**, not "no operator".

**(1c) Any positive-energy state with compact support spreads instantly. TRUE and much more general
than relativity.** Hegerfeldt (*Phys. Rev. D* **10**, 3320, 1974) showed that a state initially
confined to a bounded region acquires nonzero detection probability arbitrarily far away at
arbitrarily small later times. Hegerfeldt and Ruijsenaars later showed relativity is not even
needed: positivity of the Hamiltonian plus translation invariance suffice. This applies to the
*electron* as much as to the photon. It is not a photon-specific fact and it does not single out
this file's ansatz.

**(1d) Nothing about a photon is localizable. FALSE, and this is where the folklore overreaches.**
The **energy density** is a perfectly good local quantity. Bialynicki-Birula's photon wave function,
the Riemann-Silberstein vector $\vec F = \vec E + i\vec B$, has $|\vec F|^2$ equal to the field
energy density rather than a probability density; a Schrödinger-form equation holds for it. And the
often-repeated claim that photon energy density can fall off no faster than a power law is wrong:
Bialynicki-Birula proved that **any falloff up to almost exponential is allowed** (*Phys. Rev. Lett.*
**80**, 5247, 1998, "Exponential localization of photons"; see the review
[at CERN indico](https://indico.cern.ch/event/423687/contributions/1040123/subcontributions/88199/attachments/896013/1262445/Bialynicki-BirulaI_2005_received02.09.pdf)
and [arXiv:1308.0479](https://arxiv.org/pdf/1308.0479)). Weak localizability via positive-operator-valued
measures survives Hegerfeldt too, per the standard summary of the theorem's caveats.

**The one-line version.** What fails is the *operator*: there is no $\hat{\vec x}$ for the photon
satisfying Wightman's axioms. What survives is *everything a classical field configuration ever
needed*: an energy density, a near-exponentially concentrated field profile, a POVM-based detection
model, and a laboratory click at a point.

---

## 2. The owner's ansatz, checked

His written object is

$$ A_\alpha(\underline x) = a_\alpha \exp\Bigg\{-\frac{(x^\nu-\mu_\alpha^\nu(\underline x))^2}{2\sigma_\alpha(\underline x)^2}\Bigg\} $$

with a per-index mean $\mu_\alpha^\nu$ and a per-index width $\sigma_\alpha$, both functions of
position, and the square in the exponent is a Minkowski square of a four-vector.

### 2.1 His derivative line is right

Writing $X^\nu = x^\nu - \mu_\alpha^\nu$, differentiating the exponent gives
$-X_\nu\,\partial^\beta X^\nu/\sigma_\alpha^2 + X^2\,\partial^\beta\sigma_\alpha/\sigma_\alpha^3$, and
$\partial^\beta X^\nu = \eta^{\beta\nu} - \partial^\beta\mu_\alpha^\nu$. Expanding his bracket over
$\sigma_\alpha^3$ reproduces exactly that. **The line he stopped on is correct.** The one snag is
notational: the bracket writes $\partial^\beta\mu_\alpha$ with the $\nu$ index suppressed while the
line above carries it as $\mu_\alpha^\nu$, so the contraction is only readable from context.

### 2.2 The wave operator does not annihilate it, and SymPy says by exactly how much

Take the simplest honest specialisation: constant centre at the origin, constant width, one
component, and the exponent $-(x^\nu x_\nu)/(2\sigma^2)$ written with the spatial part positive,
$x^\nu x_\nu \to x^2 - c^2t^2$. Then

$$ \square A \;=\; \frac{c^2t^2 - x^2 + 2\sigma^2}{\sigma^4}\,A \veq{owner-box}\lean $$

so $\square A = 0$ only on the hyperbola $c^2t^2 - x^2 + 2\sigma^2 = 0$, a measure-zero set. At the
origin $\square A = 2/\sigma^2$. In $3{+}1$ dimensions SymPy returns
$\square A/A = (c^2t^2 - r^2 + 4\sigma^2)/\sigma^4$. Flipping the sign convention in the exponent
flips the sign of the constant only ($-2\sigma^2$ and $-4\sigma^2$ respectively): the constant moves
with the convention and the dimension, the conclusion does not.

The static spatial Gaussian is no better: $\square\,e^{-r^2/2\sigma^2} = (3\sigma^2 - r^2)/\sigma^4$
times itself, zero only on the sphere $r = \sqrt3\,\sigma$.

The contrast that makes this a *finding* rather than a complaint: a Gaussian in the **travelling-wave
variable**, $e^{-(x-ct)^2/2\sigma^2}$, solves the wave equation exactly, because *every* twice
differentiable $g(x-ct)$ does. So the shape "Gaussian" is not the problem. The problem is a Gaussian
whose argument is $x$ or $x^\nu x_\nu$ rather than a null combination.

$$ \square\, g(x-ct) = 0 \quad\text{for any } g \veq{gauss-travel}\lean
\qquad\text{but}\qquad
\square\, e^{-x^2/2\sigma^2} = \frac{x^2-\sigma^2}{\sigma^4}\,e^{-x^2/2\sigma^2} \neq 0 \veq{gauss-static}\lean $$

Read charitably this is not fatal, because the owner wrote $\square A_\mu = J_\mu$ with a source. The
computation then *is* the answer: it tells him which $J_\mu$ his ansatz is the field of. That
current is not a free photon. Both halves are proved in Lean.

### 2.3 A per-index width is not a Lorentz covariant object

Suppose $\sigma_\alpha$ genuinely differs between components in some frame. Under a boost,
$A'_\alpha(x') = \Lambda_\alpha{}^\beta A_\beta(x)$, so each new component is a **linear combination
of Gaussians with different widths**. A sum of Gaussians of different width is not a Gaussian: SymPy
confirms that $\partial_x^2\log\!\big(e^{-x^2/2} + e^{-x^2/8}\big)$ takes the values
$-0.625, -0.572, -0.420, -0.051$ at $x = 0, 0.5, 1, 2$, and constancy of that quantity is exactly the
test for being Gaussian. So the ansatz's *form* is frame dependent unless $\sigma_\alpha$ and
$\mu_\alpha^\nu$ are $\alpha$-independent, in which case $A_\mu = a_\mu\,\Phi(x)$ for one scalar
$\Phi$ and the four-vector structure is carried entirely by the constant $a_\mu$.

That collapse is not a loss. With $A_\mu = a_\mu\Phi$, the Lorenz condition is
$a^\mu\partial_\mu\Phi = 0$, and for a plane wave $\Phi = \cos(k\cdot x)$ it becomes $k\cdot a = 0$,
transversality, proved in Lean.

$$ \partial^\alpha\big(a_\alpha\cos(k\cdot x)\big) = -(k\cdot a)\,\sin(k\cdot x)
   \;\Longrightarrow\; k\cdot a = 0 \veq{lorenz-transverse}\lean $$

Combined with $k^2 = 0$ the residual shift $a \to a + \lambda k$ preserves both conditions, giving
corpus row **P-E**'s count $4 - 1 - 1 = 2$ against Proca's $4 - 1 = 3$, the missing subtraction being
precisely that $k^2 = m^2 \neq 0$ kills the residual gauge freedom. That is the cleanest place in the
whole file to cash out row P-E, and it also touches row **P-D**: the photon's masslessness is the
statement $P^2 = 0$, and $P^2 = 0$ is what makes the residual shift legal.

---

## 3. Q12, argued both ways

**The case FOR accepting the flag.** A Gaussian centred at $\mu_\alpha^\nu$ with width
$\sigma_\alpha$ reads, to any physicist and to every one of D4's "everyone" audience, as *the photon
is here, plus or minus sigma*. The symbols are borrowed wholesale from the non-relativistic
single-particle wave packet. If the file later quantises this into a one-photon state, that reading
becomes false in a way that no amount of later algebra repairs, and the debt is structural: the
object would be doing work it cannot do. The flag costs one sentence and buys immunity.

**The case AGAINST.** $A_\mu$ is a **classical field**, not a one-particle wave function. Newton and
Wigner constrain a *position operator on a one-particle Hilbert space*. A classical solution of
$\square A = J$ may be as concentrated as you like, and Bialynicki-Birula's result (1d) says the
concentration can be near-exponential. Nothing in the owner's 15 lines quantises anything, or writes
a probability, or asks where the photon is. Flagging it is answering a question the file has not
asked, and doing so at the top of the file trains the reader to expect a prohibition where there is
none. On this reading the worry **dissolves**: the theorem and the ansatz do not touch.

**Which is right.** The AGAINST case is correct *about the mathematics as written*, and I think that
matters more than it looks: the flag as phrased in §1.7 says the program "will run into" the theorem,
and on the evidence here it will not, because a classical Lorenz-gauge field configuration never
meets a position operator. But the FOR case is correct about the *word in the file's title*. The file
is called `photon.md` and its first line says "single Photon solution". That phrase, not the
mathematics, is what invites the misreading. The trigger for the caution is the noun, not the
Gaussian.

**Recommendation, the owner's to ratify or reject.** Take the middle option: **not a caution
section, and not silence, but one epistemic-status aside at the ansatz**, using the D3 ratified
tags-to-mechanism carrier. Something of the shape

> `[aside: prereq]` $A_\mu$ here is a classical field configuration, not a one-photon wave function.
> The two are often conflated; the Newton-Wigner theorem forbids a photon *position operator*
> (helicity $\ge 1$), and says nothing about how concentrated a classical $A_\mu$ may be.

That is one sentence, it is true, it pre-empts the misreading, and it does not import a prohibition
the file is not subject to. **Its weakness:** it defers rather than settles. The moment the file
moves from $A_\mu$ to $|1_{\vec k\lambda}\rangle$, the theorem becomes live and this aside is no
longer sufficient. If the owner's intent is to reach a genuinely quantum single-photon state, the
FOR case wins and the flag should be accepted in full. **That intent is the thing I cannot read off
the file, and it is the actual content of Q12.**

---

## 4. Three honest continuations, as options and not a plan

**(a) The paraxial / Gaussian-beam route.** Write $A = u(x,z)\,e^{ikz}$ and drop $\partial_z^2 u$
against $2ik\,\partial_z u$. The Gaussian beam then solves the paraxial equation *exactly*: SymPy
returns residual $0$ for $u = q^{-1/2}\exp\{ikx^2/2q\}$ with $q = z - iz_R$, $z_R = kw_0^2/2$. The
expansion parameter is $1/(kz_R) = 2/(k^2w_0^2)$, and the dropped term at the waist is
$\tfrac32/(k^2w_0^2)$ relative, i.e. $\tfrac34$ of one unit of the small parameter. Mathematics
demanded: complex beam parameter, Rayleigh range, and honesty that this is an *approximate* solution
of $\square A = 0$, tagged accordingly. Cheapest route, weakest claim.

**(b) The genuine wave packet.** Superpose plane waves with a Gaussian spectral weight. Then the
solution is exact, the transversality condition $k\cdot a(k) = 0$ is imposed mode by mode, and the
spreading is computable in closed form. Mathematics demanded: one Fourier integral,
$\int e^{-ak^2 + iyk}\,dk = \sqrt{\pi/a}\;e^{-y^2/4a}$, which Mathlib already has and which is proved
in the Lean file. Propagation turns $a$ into $a + it$ and the modulus width grows; that growth *is*
the honest content of Hegerfeldt, arrived at constructively instead of by citation. This is the route
I would recommend if the owner wants the file to reach a defensible endpoint.

$$ \int_{\mathbb R} e^{-ak^2 + iyk}\,dk = \sqrt{\tfrac{\pi}{a}}\;e^{-y^2/4a},\qquad \operatorname{Re}a>0 \veq{packet-fourier}\lean $$

**(c) The Riemann-Silberstein route.** Take $\vec F = \vec E + i\vec B$. The two curl equations
collapse into one first-order equation $\partial_t \vec F = -ic\,\nabla\times\vec F$, and
$\vec F\cdot\vec F = (E^2 - B^2) + 2i\,\vec E\cdot\vec B$ delivers both Lorentz invariants in one
line. This is the most natural object called a "photon wave function", it is gauge invariant, and it
makes (1d) visible: $|\vec F|^2$ is the energy density. Both algebraic halves are in Lean.

$$ \partial_t(\vec E + i\vec B) = -ic\,\nabla\times(\vec E + i\vec B),\qquad
   \vec F\cdot\vec F = (E^2-B^2) + 2i\,\vec E\cdot\vec B \veq{riemann-silberstein}\lean $$

**Is the $i$ in $\vec E + i\vec B$ the same $i$ as the WiRoHSH holomorphic split?** No, and saying so
plainly is worth more than the analogy. In WiRoHSH the complexification is a *Wick rotation of a
coordinate*, $z \to iz$, which makes a propagation direction null and is why an arbitrary
$a_\phi(x_\phi + iz)$ is harmonic. In Riemann-Silberstein the complexification is of the *field
values*, pairing two real three-vectors on the same real spacetime; no coordinate is rotated. The
shared feature is real and shallow: both use $i$ to encode a **duality rotation** in a
two-dimensional real space ($E,B$ there, two transverse directions here), and in both cases the
payoff is that a second-order real system becomes a first-order complex one. Calling that a
coincidence of $i$ undersells it; calling it the same construction oversells it. It is the same
*trick*, applied to different objects.

---

## 5. Follow-up leads

1. **Does the owner intend to quantise?** Decidable by his answer alone, and it decides Q12
   completely: quantise, and the FOR case wins; stay classical, and the aside suffices.
2. **Which $J_\mu$ is the Gaussian ansatz the field of?** Decidable by finishing the SymPy
   computation of §2.2 with the general $\mu_\alpha^\nu(x)$ and $\sigma_\alpha(x)$ restored, then
   asking whether that current is conserved, $\partial^\mu J_\mu = 0$. If it is not, the ansatz is
   inconsistent with the Lorenz gauge it was written in, which would be a much harder finding than
   anything about localizability.
3. **Is the per-index width intended?** Decidable by reading his intent for the subscript on
   $\sigma_\alpha$. If it is an index, §2.3 applies and the form is frame dependent; if it is a
   label meaning "the width of the $\alpha$ component's amplitude $a_\alpha$", there is no problem
   and only the notation needs a word.
4. **Does row P-E deserve to be cashed out here rather than at step 7?** Decidable by whether the
   file gets a plane-wave section at all: the $4-1-1=2$ count needs exactly the transversality
   already proved, so it costs three lines here and would be free.
5. **Is the Riemann-Silberstein route a spine item or a topic file?** Decidable against the roadmap's
   step ordering: it needs no quantisation and no Fock space, so it can precede step 6, which would
   make it unusually cheap for the payoff.

---

## Surfaced for the owner

Findings about `physics/photon.md`, located and not fixed, per the working contract.

- **F1.** The Gaussian ansatz does not solve $\square A = 0$. With constant centre and width,
  $\square A = A\,(c^2t^2 - x^2 + 2\sigma^2)/\sigma^4$ in $1{+}1$ and
  $A\,(c^2t^2 - r^2 + 4\sigma^2)/\sigma^4$ in $3{+}1$; it vanishes only on a hypersurface. Since the
  file writes $\square A_\mu = J_\mu$ this is arguably the intended answer rather than an error, but
  it is not stated in the file and the reader will assume a free-field solution.
- **F2.** A per-index width $\sigma_\alpha$ makes the ansatz's *form* frame dependent: a boost mixes
  components and a sum of unequal-width Gaussians is not a Gaussian (checked numerically). Covariance
  requires $\sigma_\alpha$ and $\mu_\alpha^\nu$ to be $\alpha$-independent, which collapses the
  ansatz to $A_\mu = a_\mu\Phi(x)$.
- **F3.** The $\partial^\beta A_\alpha$ line the file stops on is **correct**. Only the notation
  snags: $\partial^\beta\mu_\alpha$ inside the bracket suppresses the $\nu$ index that the line above
  carries.
- **F4, Q12 recommendation.** The Newton-Wigner flag as phrased in the 2026-07-07 note is aimed at a
  target the current file does not present: $A_\mu$ is a classical field, and the theorem constrains
  a one-particle position operator. Recommend a one-sentence `[aside: prereq]` at the ansatz rather
  than a caution section, **conditional on the file staying classical**. Owner's call.
- **F5.** Corpus row P-E ($-\tfrac14 F^2 \Rightarrow$ massless; Proca counting) can be discharged in
  this file for three lines once transversality is written, and it connects to row P-D because
  $P^2 = 0$ is exactly what licenses the residual gauge shift.

**None of this was written into `TODO.md`, `ROADMAP.md`, or `REVIEW_ME.md`.** Routing a dreamed
finding into a ledger is an owner decision.

---

## Lean attestation

All six `\lean`-badged claims above are proved in
[`docs/dreamed/lean/Photon.lean`](lean/Photon.lean), namespace `Photon`. Fifteen theorems, no `sorry`.

| handle | theorem(s) | content |
|---|---|---|
| `gauss-travel` | `gaussian_travelling_solves` | $f = e^{-(x-ct)^2/2\sigma^2}$ satisfies $f_{xx} - c^{-2}f_{tt} = 0$; both second slice derivatives delivered from `G_xx`, not assumed |
| `gauss-static` | `gaussian_static_box`, `gaussian_static_ne_zero` | the static Gaussian gives $G(x)(x^2-\sigma^2)/\sigma^4$, nonzero off $x = \pm\sigma$ |
| `owner-box` | `owner_ansatz_box`, `owner_ansatz_origin`, `owner_ansatz_ne_zero`, `owner_factorises` | the owner's Minkowski-square Gaussian in $1{+}1$: $\square A = A(c^2t^2 - x^2 + 2\sigma^2)/\sigma^4$, equal to $2/\sigma^2$ at the origin |
| `lorenz-transverse` | `lorenz_planewave`, `lorenz_forces_transversality`, `cos_slice` | all four slice derivatives of $a_\alpha\cos(k\cdot x)$, the Lorenz combination $=-(k\cdot a)\sin(k\cdot x)$, and $k\cdot a = 0$ where $\sin \neq 0$ |
| (bonus) | `residual_gauge_preserves`, `photon_dof`, `proca_dof` | $a \to a + \lambda k$ preserves $k\cdot a = 0$ given $k^2 = 0$; the $4-1-1=2$ versus $4-1=3$ arithmetic with constraint counts as named hypotheses |
| `riemann-silberstein` | `rs_first_order`, `rs_invariants` | the two curls collapse into $F_t = -ic\,\mathrm{curl}\,F$; $F\cdot F = (E^2-B^2) + 2i\,E\cdot B$ |
| `packet-fourier` | `gaussian_packet` | $\int e^{-ak^2+iyk}dk = (\pi/a)^{1/2}e^{-y^2/4a}$ for $\operatorname{Re}a > 0$, instantiated from Mathlib's `integral_cexp_quadratic` |

Checked with:

```
cd /home/tobias/src/toesnail/verify
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/Photon.lean
```

Exit status **0**, no output, zero `sorry`. Mathlib rev as vendored in `verify/`,
toolchain `leanprover/lean4:v4.30.0-rc2`.

**Weakened, stated plainly.** The Lean file formalises the owner's ansatz only in $1{+}1$ dimensions
with a **constant** centre and a **constant** width, one component. His $\mu_\alpha^\nu(x)$ and
$\sigma_\alpha(x)$ are position dependent and index dependent; those are handled by SymPy in §2.2 and
§2.3, not by Lean. The Riemann-Silberstein theorems take the curl components as *given real numbers*
and prove only the algebra, not that `curl` is the derivative operator. `photon_dof` / `proca_dof`
are arithmetic bookkeeping with the constraint counts as hypotheses; they do not derive the counts.

---

## Computation block

```computation
# section 2.2, the owner's ansatz in 1+1 and 3+1 (Minkowski square in the exponent)
box_1p1 = (c**2*t**2 - x**2 + 2*sigma**2)/sigma**4
box_3p1 = (c**2*t**2 - x**2 - y**2 - z**2 + 4*sigma**2)/sigma**4

# section 2.2, the contrast: travelling-wave Gaussian versus static Gaussian
box_travel = 0
box_static = (x**2 - sigma**2)/sigma**4

# section 4a, the 1D Gaussian beam solves the paraxial equation exactly
q = z - I*k*w0**2/2
u = q**Rational(-1,2) * exp(I*k*x**2/(2*q))
paraxial_residual = diff(u,x,2) + 2*I*k*diff(u,z)

# section 4b, the wave-packet Fourier identity
packet = Integral(exp(-a*kk**2 + I*y*kk), (kk, -oo, oo))
```

Every expression above was produced by an actual SymPy run, not transcribed from memory.
`box_travel = 0` and `paraxial_residual = 0` were returned by `simplify`, not assumed.

---

## Sources

- [Localizability, gauge symmetry and Newton-Wigner operator for massless particles (arXiv:1806.09372)](https://arxiv.org/abs/1806.09372)
- [The geometrical interpretation of the photon position operator (arXiv:2104.04351)](https://arxiv.org/pdf/2104.04351)
- [Construction of a photon position operator with commuting components from natural axioms (arXiv:2205.04791)](https://arxiv.org/pdf/2205.04791)
- [A Comment on the "Photon position operator with commuting components" by Margaret Hawton (arXiv:2203.14555)](https://arxiv.org/abs/2203.14555)
- [Hegerfeldt's theorem (Wikipedia)](https://en.wikipedia.org/wiki/Hegerfeldt%27s_theorem)
- [Localization in Quantum Field Theory (arXiv:2312.15348)](https://arxiv.org/pdf/2312.15348)
- [Bialynicki-Birula, The Riemann-Silberstein vector as a photon wave function](https://indico.cern.ch/event/423687/contributions/1040123/subcontributions/88199/attachments/896013/1262445/Bialynicki-BirulaI_2005_received02.09.pdf)
- [Localization of relativistic particles and uncertainty relations (arXiv:1308.0479)](https://arxiv.org/pdf/1308.0479)

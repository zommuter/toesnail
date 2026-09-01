---
title: WiRoHSH and refraction
permalink: /dreamed/wirohsh-refraction
---

# WiRoHSH meets a refractive index: what survives, what does not, and why Fresnel is a reflection principle

> **DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](./). AI-written, 2026-09-01, round 2, from
> an owner-picked seed: the bare `### Refraction` heading that ends `physics/wirohsh.md` with nothing
> under it, plus his physics.SE [q/787284](https://physics.stackexchange.com/q/787284) ("What are the
> Fresnel formulas for acoustics?", `docs/se-corpus.md` row **P-K**, feeding `physics/acoustics.md`).
> It **proposes**; the owner disposes. Round 1 is [`wirohsh-splats.md`](wirohsh-splats.md); this file
> does not repeat it.

## 0. Headline

**The seed's centrepiece claim is half true, and the false half is the interesting one.** With
$c=c(x)$ the Wick rotation gives $\partial_x^2 f + n(x)^2\partial_\tau^2 f = 0$, which is **not** the
Laplace-Beltrami equation of the optical metric and not the flat Laplace equation. Its *principal
part* is conformally flat (as every 2D symbol is), so the null structure of
[round 1](wirohsh-splats.md), the eikonal, Fermat and Snell survive **any** profile untouched. The
*full operator* differs from Laplace-Beltrami by a first-order **drift** $n'\partial_\xi$, which no
conformal change of coordinates removes. The amplitude gauge $w=\sqrt n\,f$ trades it for a
**potential**

$$ \partial_\xi^2 w + \partial_\tau^2 w = V(\xi)\,w, \qquad V = \frac{(\sqrt n)_{\xi\xi}}{\sqrt n},
   \qquad \xi = \int^x n\,dx' \veq{gauge-potential}\lean $$

so the holomorphic/Laurent basis is exact **iff $V\equiv 0$, iff $\sqrt n$ is linear in the optical
path**, i.e. iff $n$ is constant or $n(x)=A/(x-x_0)^2$. That one-parameter family, plus constants, is
the entire class on which "WiRoHSH survives refraction" is literally true. Everything else keeps only
the rays.

For a **sharp** interface $V$ vanishes on each side, which is exactly why Fresnel is a **Schwarz
reflection principle** and why $r=\pm1$ (odd and even reflection) are its two limits. The
"two sides Wick-rotate by different amounts" worry is a **gauge artifact**, removable, and I show
which gauge is the good one.

---

## 1. What the Wick rotation actually does to $c(x)$

Take the owner's 1+1 wave equation with a position-dependent speed, constant density,

$$ \partial_x^2 f(x,t) - \frac{1}{c(x)^2}\partial_t^2 f(x,t) = 0, \qquad n(x):=\frac{c_0}{c(x)} $$

with $c_0$ a *fixed reference speed* chosen once for the whole problem. The owner's `(Wick)` line
$c_0 t = i\tau$ gives $\partial_t^2 = -c_0^2\partial_\tau^2$, hence

$$ \partial_x^2 f + n(x)^2\,\partial_\tau^2 f = 0. \veq{wick-variable}\lean $$

This is the honest starting point and it is already a departure from the draft: the index does **not**
disappear into the rotation. Two readings of the result, both worth having.

**(a) Divergence form.** Because $n$ depends on $x$ only, the equation is exactly
$\nabla\!\cdot\!(A\nabla f)=0$ with $A=\operatorname{diag}(1,n(x)^2)$: divergence-form elliptic, but
with an **anisotropic** coefficient matrix, not the scalar $\sigma$ of the textbook transmission
problem. It becomes scalar-$\sigma$ only in the acoustic generalisation of §3.3, where the density
supplies the missing scalar.

**(b) Optical metric.** The Wick-rotated optical metric is $d\sigma^2 = n(x)^2dx^2 + d\tau^2$ (the
conformal factor sits on the *spatial* part; that is what makes its null curves travel at $c_0/n$).
The metric read off the principal symbol of our operator is $g = dx^2 + n^{-2}d\tau^2 = n^{-2}d\sigma^2$,
**conformal to the optical metric**, so reading (b) is geometrically right about the conformal class.
It is wrong about the operator. In 2D, $\Delta_g = n^2(\partial_\xi^2+\partial_\tau^2)$ with
$\xi=\int n\,dx$, whereas

$$ \partial_x^2 + n^2\partial_\tau^2 \;=\; \Delta_g \;+\; \frac{n'}{n}\,\partial_x. \veq{symbol-metric}\sympy $$

The Wick-rotated wave operator is **not** a Laplace-Beltrami operator. It is one plus a drift.

---

## 2. The centrepiece claim, checked

The claim to test: *in 1+1, WiRoHSH survives any refractive-index profile, because every 2D metric
is conformally flat and a 2D conformal map is exactly a holomorphic map, which is the structure the
Laurent basis is built on.*

**Where it holds.** The conformal-flatness step is correct and the isothermal coordinate is
explicit and physical:

$$ \xi(x) = \int^x n(x')\,dx' \quad\text{(optical path length)},\qquad
   d\sigma^2 = d\xi^2 + d\tau^2. $$

Consequently the **characteristic variety is index-independent**: the eikonal $f\sim e^{kS}$ obeys
$(\partial_\xi S)^2+(\partial_\tau S)^2=0$, i.e. $\partial_\xi S = \pm i\,\partial_\tau S$ for every
$n$. Round 1's null direction is *exactly* preserved by refraction, which is a real and pretty
statement: **refraction cannot touch the null structure in 1+1, it can only reparametrise it by the
optical path.**

**Where it breaks.** Conformal flatness is a statement about the *principal symbol*. Substituting
$\xi=\int n\,dx$ into $\eqref{wick-variable}$ (SymPy, exact) gives

$$ n^2\Big[\,\partial_\xi^2 f + \partial_\tau^2 f + \frac{n_\xi}{n}\,\partial_\xi f\,\Big] = 0 $$

and the first-order term does not go away: a conformal (holomorphic) change of coordinates conjugates
second-order terms into second-order terms and cannot cancel a drift. So $f$ is **not** harmonic and
has **no Laurent expansion**, for any non-constant $n$.

**What repairs it, at a price.** The gauge $w=\sqrt n\,f$ removes the drift and leaves a potential:

$$ \partial_\xi^2 w+\partial_\tau^2 w = V w,\qquad
   V=\frac{(\sqrt n)_{\xi\xi}}{\sqrt n} = \frac{\big(\partial_\xi^2\sqrt n\big)}{\sqrt n}
   \veq{gauge-potential-2}\lean $$

(SymPy residual $0$ for a free $n$). This is the 2D Euclidean cousin of the Langer/WKB substitution.
So the corrected statement is:

> **What survives 1D refraction is the conformal class, hence the eikonal, hence rays, Fermat and
> Snell. What does not survive is harmonicity, hence the holomorphic Laurent basis. The obstruction
> is one scalar, $V=(\sqrt n)_{\xi\xi}/\sqrt n$.**

**The exact-survival class.** $V\equiv0$ iff $\sqrt n$ is an affine function of $\xi$. Integrating
$d\xi = n\,dx$ with $\sqrt n = \alpha+\beta\xi$ gives, for $\beta\neq0$,

$$ n(x) = \frac{A}{(x-x_0)^2},\qquad \xi = -\frac{A}{x-x_0},\qquad \sqrt n = \frac{|\xi|}{\sqrt A}
   \veq{flat-class}\sympy $$

and $\beta=0$ gives $n$ constant. Verified: for $n=A/(x-x_0)^2$ and $W=\operatorname{Re}(\xi+i\tau)^k$,
$k=1,\dots,4$, the function $f=W/\sqrt n$ satisfies $\eqref{wick-variable}$ with residual exactly $0$
on $x>x_0$; for the counter-profile $n=e^{x}$ the residual is $\tfrac14(e^{2x}-\tau^2)e^{-x/2}\neq0$.

That the surviving profile is $(x-x_0)^{-2}$ is not an accident worth hiding: it is the conformal
factor of an inversion, the one non-trivial conformal map of the line into itself. **The class on
which the discrete basis survives refraction is precisely the class generated by a Mobius change of
the optical coordinate.**

**And even there, the caveat the seed asked for.** The *equation* transforms correctly, but the
coordinate is $\xi=\int n\,dx$, so the Laurent index $m$ labels modes of the **optical-path**
annulus, not the physical one. Two media with the same $m$ carry different physical mode shapes: the
basis survives, the *labelling* is $n$-dependent, and any scheme comparing $m$ across media is
comparing different objects.

---

## 3. The sharp interface: Fresnel as the Schwarz reflection principle

### 3.1 The set-up in the flat chart

Two half-spaces, $n=n_1$ for $x<0$ and $n=n_2$ for $x>0$. On each side $n$ is constant, so $V=0$ and
each side is **exactly** flat: $\xi = n_1x$ on the left, $\xi=n_2x$ on the right, both harmonic in
$(\xi,\tau)$. The physics is entirely in the two interface conditions, which in the $\xi$ chart read
(using $\partial_x = n\,\partial_\xi$)

$$ [\,f\,]=0,\qquad n_1\,\partial_\xi f\big|_{0^-} = n_2\,\partial_\xi f\big|_{0^+}. $$

That is the classical two-phase transmission problem: harmonic on each side, continuous across the
line, conormal derivative jumping by the ratio of the weights. Harmonic continuation across a line
under exactly such conditions is the **Schwarz reflection principle**, in its two-phase form.

### 3.2 The coefficients are the continuation coefficients

Let $I(\xi,\tau)$ be any harmonic function (the incident field, continued). Set

$$ f(\xi,\tau) = \begin{cases} I(\xi,\tau) + r\,I(-\xi,\tau), & \xi<0\\[2pt] t\,I(\xi,\tau), & \xi>0\end{cases}
   \qquad r=\frac{n_1-n_2}{n_1+n_2},\quad t=\frac{2n_1}{n_1+n_2}. \veq{schwarz-two-phase}\lean $$

$I(-\xi,\tau)$ is harmonic because reflection is an isometry, so both branches are harmonic; the
matching conditions are $1+r=t$ and $n_1(1-r)=n_2t$, which is exactly what defines $r,t$. Verified in
SymPy for $I=e^{\xi}\cos\tau$, $I=\operatorname{Re}(\xi+i\tau)^3$ and $I=\log|\xi+i\tau|$: both
Laplacians $0$, both jumps $0$.

Energy:

$$ r^2 + \frac{n_2}{n_1}\,t^2 = \frac{(n_1-n_2)^2+4n_1n_2}{(n_1+n_2)^2} = 1. \veq{fresnel-energy}\lean $$

**The two classical Schwarz reflections are the two limits.** $n_2\to\infty$ gives $r=-1$, the *odd*
(Dirichlet) reflection; $n_2\to0$ gives $r=+1$, the *even* (Neumann) reflection. Fresnel interpolates
between them, with $r$ the interpolation parameter. That, I think, is the sentence the empty
`### Refraction` section wants.

### 3.3 How far the reading extends

**Oblique incidence.** Add a tangential coordinate $y$ (2+1 dimensions, Wick-rotating to 3D). The
interface is still $\xi=0$ and $\eqref{schwarz-two-phase}$ still reflects in $\xi$ alone, but $r,t$
now depend on the tangential wavenumber, i.e. on the angle: $I\mapsto r\,I(-\xi,\cdot)$ becomes a
**Fourier multiplier in the tangential variables**, not a pointwise reflection. The reading survives
obliquity as an *operator* statement and stops being an elementary one. Beyond the critical angle the
symbol goes complex (the evanescent branch); `critical_angle_iff` gives the existence condition.

**Acoustics: it is the impedance, not the index (this answers the framing of q/787284).** With both
density and speed varying, the pressure equation is
$\nabla\!\cdot\!\big(\rho^{-1}\nabla p\big) - (\rho c^2)^{-1}\partial_t^2 p = 0$, which Wick-rotates to

$$ \partial_x\!\Big(\frac1\rho\partial_x p\Big) + \frac{n^2}{\rho}\,\partial_\tau^2 p = 0, $$

so the scalar weight is $\sigma=1/\rho$ and the matching conditions are $[p]=0$,
$[\rho^{-1}\partial_x p]=0$. Redoing §3.2 with that weight gives

$$ r = \frac{n_1/\rho_1-n_2/\rho_2}{n_1/\rho_1+n_2/\rho_2} = \frac{Z_2-Z_1}{Z_2+Z_1},
   \qquad Z_j=\rho_jc_j \veq{acoustic-impedance}\sympy $$

(SymPy: difference exactly $0$). **The Wick-rotated transmission problem produces the impedance
automatically**, because the weight it carries is $1/\rho$ and not $1$. The optical case is the
special case $\rho_1=\rho_2$, where $Z$ and $n$ happen to give the same ratio. That is precisely the
gap the SE question points at, and it is a one-line answer in this picture.

---

## 4. The two-sided Wick rotation: a gauge artifact, not an obstruction

**Confidence: high on the mathematics below (each step is checkable), medium on the verdict**, since
"gauge vs obstruction" is a judgement about which structure one insists on preserving. I state the
reasoning so the owner can overrule it.

The worry: $c\,t=i\tau$ names a speed, and with $c_1\neq c_2$ there is no single rotation that
flattens both half-spaces. Two gauges:

**Gauge B (the bad one), per-side rotation $\tau_j=-ic_jt$.** Each side is flat in its own
$(x,\tau_j)$, but the *same physical time* maps to two different Euclidean times, so gluing along
$x=0$ requires $\tau_2=(c_2/c_1)\tau_1$: the seam's induced metrics, $d\tau_1^2$ and
$(c_2/c_1)^2d\tau_1^2$, **disagree**, so there is no Riemannian gluing at all. It is neither a
conical defect (a 2D curvature singularity concentrates at a *point*, not a line) nor a branch cut.
It is an inconsistent chart, with mismatch factor $c_2/c_1=n_1/n_2$.

**Gauge A (the good one), one rotation, per-side spatial rescale.** Rotate the *one* variable that is
shared, $t$, with the *one* reference speed $c_0$, and let the index live on the spatial side:
$\tau=-ic_0t$ globally, $\xi=n_jx$ per side. Now $\tau$ is common, both sides are flat half-planes,
the seam carries the same induced metric $d\tau^2$ from both sides, and the glued Euclidean space is
**flat $\mathbb R^2$ with no defect whatsoever**. The map $x\mapsto\xi$ is continuous with a kink
(slope $n_1$ then $n_2$), and a kink is exactly what a holomorphic map cannot have.

**So the mismatch is removable from the geometry, and reappears where it belongs.** Its invariant
content is the ratio $n_1/n_2$, which is neither the metric nor the topology but the **conormal jump**
$[\,n\partial_\xi f\,]$, and that jump *is* the Fresnel coefficient of §3.2. The obstruction is not to
Wick-rotating; it is to finding a single global holomorphic coordinate, and its measure is $r$.

I would put it this way in the draft: *there is no such thing as rotating the two sides differently.
There is one rotation, of one time, by one reference speed, and refraction is what happens to the
spatial chart.* Round 1 already needs a reference $c$ to define the null direction; this fixes which
one.

**The one place I would not bet.** A *kinked* or *curved* interface. Two straight interfaces meeting
at an angle $\theta$ give a wedge of opening $\theta$ stretched by $n_1$ against a wedge of opening
$2\pi-\theta$ stretched by $n_2$, and those two stretched angles need not sum to $2\pi$. That would
be a genuine **conical defect** at the corner, with deficit set by $n_1,n_2,\theta$. I have not
computed it and I flag it as **speculation**; it is lead 3 in §6.

---

## 5. The continuous case: graded index

With $V\neq0$ the discrete basis is gone, but the *rays* are exactly the null geodesics of the
optical metric, i.e. of $d\sigma^2=n^2dx^2+dy^2$, and those are exactly solvable in the two standard
profiles.

### 5.1 Linear gradient (the mirage)

$n^2=n_0^2(1+x/L)$, ray invariant $n\sin\theta=\beta$, so $dx/dy=\sqrt{n^2-\beta^2}/\beta$ integrates
exactly to the parabolic mirage ray

$$ x(y) = \frac{\sqrt{n_0^2-\beta^2}}{\beta}\,y + \frac{n_0^2}{4L\beta^2}\,y^2. $$

Nothing subtle, but it is the cheapest worked example the `### Refraction` section could carry.

### 5.2 The exactly solvable guide, $n(x)=n_0\operatorname{sech}(x/a)$

Integrating the same ray ODE (SymPy residual $0$):

$$ \sinh\!\Big(\frac{x}{a}\Big) = \frac{\sqrt{n_0^2-\beta^2}}{\beta}\,\sin\!\Big(\frac{y}{a}\Big)
   \veq{sech-ray}\sympy $$

Every ray, whatever its launch angle $\beta$, has the same $y$-period $2\pi a$. Perfect
self-focusing, which is why this profile is the textbook graded-index waveguide.

**The potential, in closed form.** The optical path is $\xi = 2an_0\arctan\tanh(x/2a)$, i.e.
$n = n_0\cos\theta$ with $\theta=\xi/(an_0)\in(-\tfrac\pi2,\tfrac\pi2)$, and

$$ V(x) = -\frac{1}{(n_0a)^2}\Big[\frac12 + \frac14\sinh^2\!\Big(\frac{x}{a}\Big)\Big]
   = -\frac{1}{(n_0a)^2}\Big[\frac12+\frac14\tan^2\theta\Big]. \veq{sech-potential}\sympy $$

$V<0$ everywhere, and $V\to-\infty$ at the edges $\theta\to\pm\pi/2$: the guide is, in the Euclidean
picture, a **potential well with infinitely steep walls at finite optical distance**. That is the
geometric reason the modes are discrete.

**What the discrete basis looks like here.** Separating $f=e^{k\tau}X(x)$ turns
$\eqref{wick-variable}$ into $X''+k^2(n^2-\beta^2)X=0$, i.e. the Poschl-Teller problem with
$\operatorname{sech}^2$ well. Its bound states are finite in number,
$N=\lceil s\rceil$ with $s(s+1)=k^2n_0^2a^2$, plus a continuum of radiation modes. Concretely, at
$k n_0 a=\sqrt2$ the fundamental mode is exactly $X=\operatorname{sech}(x/a)$ with $\beta=1/(ka)$
(SymPy residual $0$; for general $n_0$ the residual is $(a^2k^2n_0^2-2)/(a^2\cosh^3)$, so the value
$\sqrt2$ is forced).

**This is the honest form of the owner's ambition.** A graded-index guide gives him a discrete
index for a physical reason (trapping) rather than a rotational one, and the price is explicit: the
discrete set is **finite** and **incomplete**, with the radiation continuum exactly the part it
cannot represent. Same trade round 1 found in the annulus (its §2(c)), now with a mechanism attached.

---

## 6. Surfaced for the owner

Findings located, never fixed. Every resolution is his.

1. **The `### Refraction` section is the owner's to author.** Everything in §1 to §5 is offered as
   raw material for it, not as a draft of it. Nothing here belongs in `physics/wirohsh.md` unless he
   writes it there himself.
2. **`physics/wirohsh.md` currently has no reference speed.** The `(Wick)` line writes $c\,t=i\tau$
   with *the* wave speed. §4 argues the refraction section will need to distinguish a fixed reference
   $c_0$ from a medium speed $c(x)$, and that the choice is not free once two media are present. This
   affects a line he has already written.
3. **The four notation snags from round 1 are still open** (`physics/wirohsh.md` L58, L88, L97, L154);
   see [round 1 §1.6](wirohsh-splats.md). Not re-litigated here.
4. **`physics/acoustics.md` derives $\vec n\cdot(\rho\vec u)$ continuous** and the potential-continuity
   argument, but does not yet reach an amplitude formula. §3.3 connects that file to
   `docs/se-corpus.md` row **P-K** (q/787284) in one step, if he wants the connection.
5. The `\veq` badges here attest **the dreamed Lean file and the SymPy runs recorded above only**.
   They are deliberately not wired into `physics/*.toml` or `tests/test_verify.sh`, per
   [`docs/dreamed/README.md`](./).

## 7. Follow-up leads

1. **Is the $(x-x_0)^{-2}$ family the whole story in 2+1?** Decidable by redoing $\eqref{flat-class}$
   with $n=n(x,y)$: the drift is then a vector field and its removability is a curl condition, not an
   ODE. If the answer is "only $n$ harmonic-ish", the exact-survival class collapses to nothing in
   higher dimensions and the seed's $d\geq4$ Weyl-tensor caveat is not even the binding one.
2. **Does the corrected claim change round 1's NO-GO on `id:ff32`?** Decidable by asking whether any
   splat-like primitive has $V=0$; a Gaussian does not, so the answer is almost certainly no, but it
   is worth one line in the record rather than an assumption. *(Owner-only: the `id:ff32` disposition.)*
3. **The kinked-interface conical defect (§4).** Decidable by computing the total angle at the corner
   in the glued flat chart: two wedges $\theta$ and $2\pi-\theta$, anisotropically stretched by
   $n_1,n_2$. Either the angles sum to $2\pi$ (gauge, as for the straight interface) or they do not
   (a genuine defect, with a computable deficit). One page of trigonometry decides it. **Currently
   flagged speculation.**
4. **Fresnel at oblique incidence as an operator reflection.** Decidable by writing the tangential
   Fourier multiplier explicitly and checking it reproduces the standard acoustic Fresnel coefficients
   at all angles, which is literally what q/787284 asks for. This is the lead with a ready-made
   external consumer. *(Owner-only if it lands in `physics/acoustics.md`.)*
5. **Does $V$ have an independent physical name?** $V=(\sqrt n)_{\xi\xi}/\sqrt n$ is the Langer
   potential of WKB and, in the transmission-line literature, the local reflectivity of a graded
   taper. Decidable by checking whether $\int|V|^{1/2}d\xi$ reproduces the known adiabatic
   (reflectionless-taper) criterion; if it does, $V$ is *the* refraction observable in this picture
   and deserves a name in the draft.

---

## Lean attestation

Proved in [`docs/dreamed/lean/WirohshRefraction.lean`](lean/WirohshRefraction.lean), namespace
`WirohshRefraction`:

| handle | theorem | content |
|---|---|---|
| `wick-variable` | `wick_variable_speed` | $f_{xx}-c^{-2}f_{tt} = f_{xx}+n^2f_{\tau\tau}$ under $c=c_0/n$ and $f_{tt}=-c_0^2f_{\tau\tau}$ |
| `gauge-potential` | `gauge_second_deriv`, `drift_to_potential` | $(sf)'' = s(f''+(2s'/s)f') + (s''/s)(sf)$, second derivative delivered from `HasDerivAt` witnesses |
| `fresnel-energy` | `fresnel_energy` | $r^2+(n_2/n_1)t^2=1$ with $n_1,n_2>0$ in named hypotheses |
| `schwarz-two-phase` | `fresnel_matching` | both interface conditions hold for arbitrary incident boundary data $(I_0,I_1)$ |
| `snell-fermat` | `leg_hasDerivAt`, `leg'_hasDerivAt`, `fermat_hasDerivAt`, `snell_iff_stationary` | $T'(x)=n_1\sin\theta_1-n_2\sin\theta_2$, and $T'=0 \iff n_1\sin\theta_1=n_2\sin\theta_2$ |
| `fermat-convex` | `leg_second`, `fermat_deriv2_pos` | $T''=n_1a^2(a^2+x^2)^{-3/2}+n_2b^2(b^2+(d-x)^2)^{-3/2}>0$, so the Snell point is the unique minimum |
| `tir` | `critical_angle_iff` | $\exists\,\theta_c\in[0,\pi/2]$ with $n_1\sin\theta_c=n_2$ $\iff$ $n_2\le n_1$ |

Checked with:

```
cd /home/tobias/src/toesnail/verify
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/WirohshRefraction.lean
```

**Exit status 0**, zero `sorry`, one `unusedVariables` warning.

**What had to be weakened, stated plainly.**

- `wick_variable_speed` assumes the Wick substitution in the algebraic form
  $f_{tt}=-c_0^2f_{\tau\tau}$. That analytic continuation in $t$ *delivers* that relation is the
  owner's `(Wick)` line and is not proved. `hc0 : c0 <> 0` is stated because a zero reference speed
  makes $n$ meaningless, but `field_simp` does not consume it; hence the single warning. I kept the
  hypothesis rather than a technically-stronger theorem with a meaningless parameter.
- The centrepiece $\eqref{gauge-potential}$ is Lean-attested only in its **algebraic half**. The
  change of variables $\xi=\int n\,dx$, which is what *produces* the drift, is SymPy-verified (§2)
  and not formalised: it needs a chain rule through an implicitly defined coordinate map, which is
  more machinery than the claim is worth. `gauge_second_deriv` is genuine calculus;
  `drift_to_potential` is the identity that makes the trade visible.
- `fermat_deriv2_pos` delivers "the second derivative exists and is strictly positive everywhere",
  not `StrictConvexOn`. Mathlib's bridge from the latter to the former routes through `deriv`, which
  is junk-on-failure; the `HasDerivAt` witness is the faithful statement. Uniqueness of the minimum
  therefore follows *mathematically* from the theorem but is not itself a Lean theorem here.
- `fresnel_matching` proves the two matching **equations**. That the reflected branch
  $I(-\xi,\tau)$ is harmonic (true, and the reason the ansatz is admissible) and that the
  transmission problem has a unique solution are both out of scope; the SymPy runs of §3.2 cover
  harmonicity on three examples.
- `\sympy` badges are finite-sample checks on the families named inline, not general proofs.

## `.mw` sketch

```computation
n_of_x = n0 / cosh(x/a)
```

```computation
xi = Integral(n_of_x, x)
```

```computation
wick_operator = Derivative(f(x,tau), x, 2) + n_of_x**2 * Derivative(f(x,tau), tau, 2)
```

```computation
potential = diff(sqrt(n_of_x), xi, 2) / sqrt(n_of_x)
```

```computation
fresnel_energy = ((n1-n2)/(n1+n2))**2 + (n2/n1) * (2*n1/(n1+n2))**2
```

The DAG edge that matters: `potential` depends on `xi`, which depends on `n_of_x`. Any edit to the
profile (a sign, an exponent, `sech` to `sech**2`) must mark `xi`, `potential`, `wick_operator` and
every closed form in §5 stale. That is the `stale_after_edit` property the HARD-tier commit hook
already exercises on the Resogram mirror, and refraction is the better stress test: the dependency
chain is three deep rather than one.

## Sources consulted

- Owner's own: `physics/wirohsh.md`, `physics/acoustics.md`, `docs/se-corpus.md` row P-K,
  [physics.SE q/787284](https://physics.stackexchange.com/q/787284) (fetched via the SE API).
- [Round 1, `wirohsh-splats.md`](wirohsh-splats.md) for the null direction and the Whittaker/Bateman
  attribution.
- Standard references for the classical content invoked (not re-derived here): isothermal
  coordinates and 2D conformal flatness; the Poschl-Teller $\operatorname{sech}^2$ spectrum; the
  Langer/WKB amplitude substitution; the two-phase Schwarz reflection principle for divergence-form
  elliptic equations; acoustic impedance matching.

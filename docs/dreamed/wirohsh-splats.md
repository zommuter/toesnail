---
title: WiRoHSH, finished 3D reduction, and a ruling on id:ff32
permalink: /dreamed/wirohsh-splats
---

# WiRoHSH: finishing the 3D reduction, and a NO-GO recommendation on splats

> **DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](./). AI-written, 2026-09-01, from an
> owner-picked seed: the owner's unfinished `physics/wirohsh.md` (which dies mid-sentence at
> `f(x,y,z) = \int_0^{2\pi}d\phi\ (\ )`) plus `ROADMAP.md id:ff32` (INBOUND `routed:b0c5` from
> `loderite`). It **proposes**; the owner disposes. Every verdict below is a **recommendation for
> ratification**, never a decision, and nothing may be promoted into `physics/` without the owner
> authoring the move.

## 0. Headline

The 3D reduction closes, and it closes for a reason the draft does not yet name: after the Wick
rotation the propagation direction becomes the **null** vector $\vec n_\phi=(\cos\phi,\sin\phi,i)$
with $\vec n_\phi\cdot\vec n_\phi=0$, so *any* twice-differentiable $a_\phi$ gives a harmonic
$a_\phi(x_\phi+iz)$ with no further constraint. The completed formula is Whittaker's 1903
representation of harmonic functions, i.e. classical; the owner's *framing* (Wick rotation as a
device to trade continuous $\omega$ for discrete $m$) is his, and I could not find it stated that
way in the classical sources. His second family $b_\phi(x_\phi+iz)\,x_{\bar\phi}$ is harmonic but
**redundant**: it integrates by parts in $\phi$ back into the first family, because
$x_{\bar\phi}=-\partial_\phi x_\phi$. On `id:ff32` I recommend **NO-GO as framed**, with one
narrow salvage (§4).

---

## 1. Finishing the 3D reduction

### 1.1 Setup, verbatim from the draft

With $\vec x=(x,y)$, $\vec e_\phi=(\cos\phi,\sin\phi)$, $\vec e_{\bar\phi}=(\sin\phi,-\cos\phi)$,

$$ x_\phi := x\cos\phi+y\sin\phi,\qquad x_{\bar\phi} := x\sin\phi-y\cos\phi. $$

The draft's transverse-Laplacian algebra is correct:

$$ \Delta - (\vec e_\phi\cdot\vec\nabla)^2 = (\partial_x\sin\phi-\partial_y\cos\phi)^2 = \partial_{\bar\phi}^2 \veq{transverse-symbol}\lean $$

so the transverse (here one-dimensional) Laplace equation $\partial_{\bar\phi}^2 f_\phi=0$ forces
$f_\phi$ to be **linear in $x_{\bar\phi}$ and arbitrary in $x_\phi$**, which is exactly the draft's
$f_\phi(\vec x)=a_\phi(x_\phi)+b_\phi(x_\phi)x_{\bar\phi}$.

### 1.2 The missing line

Substituting $\vec x\mapsto\vec x+iz\vec e_\phi$ (which sends $x_\phi\mapsto x_\phi+iz$ and leaves
$x_{\bar\phi}$ alone, as the draft already notes) fills the empty parentheses:

$$ f(x,y,z) = \int_0^{2\pi}\!\!d\phi\;\Big[\,a_\phi\big(x_\phi+iz\big) \;+\; b_\phi\big(x_\phi+iz\big)\,x_{\bar\phi}\Big] \veq{whittaker-3d}\sympy $$

with $a_\phi,b_\phi:\mathbb C\to\mathbb C$ twice differentiable in their (single, complex) argument
and measurably dependent on $\phi$. **No further constraint is needed.**

### 1.3 Why: the null direction

Write $u:=x_\phi+iz=x\cos\phi+y\sin\phi+iz$. Then

$$ \vec\nabla u = (\cos\phi,\ \sin\phi,\ i),\qquad \vec\nabla u\cdot\vec\nabla u = \cos^2\phi+\sin^2\phi+i^2 = 0,\qquad \Delta u = 0. \veq{null-direction}\lean $$

The chain rule gives $\Delta\,a(u) = a''(u)\,(\vec\nabla u\cdot\vec\nabla u) + a'(u)\,\Delta u = 0$.
The Wick rotation has turned the *unit* direction $\vec e_\phi$ into a **null** direction of the
Euclidean metric, which is why the transverse condition evaporates in this coordinate. For the
second family, with $v:=x_{\bar\phi}$,

$$ \Delta\big(b(u)v\big) = v\,\Delta b(u) + 2\,b'(u)\,\big(\vec\nabla u\cdot\vec\nabla v\big) + b(u)\,\Delta v = 0, $$

since $\vec\nabla u\cdot\vec\nabla v=\cos\phi\sin\phi-\sin\phi\cos\phi+i\cdot 0=0$ and $\Delta v=0$.

SymPy confirms both for $a\in\{u^n\}_{n=0}^{5},e^u,\sin u,\log u$ and
$b\in\{u^n\}_{n=0}^{4},e^u$: every Laplacian is identically $0$.

### 1.4 The $b$-family is redundant (this is the interesting part)

$x_{\bar\phi}=-\partial_\phi x_\phi$, hence $v=-\partial_\phi u$ at fixed $(x,y,z)$ (SymPy: the
difference is exactly $0$). Let $B(w,\phi)$ be an antiderivative of $b$ in its first slot,
$\partial_1 B=b$. Then

$$ \partial_\phi\big[B(u,\phi)\big] = b(u,\phi)\,\partial_\phi u + (\partial_2 B)(u,\phi) = -\,b(u,\phi)\,v + (\partial_2 B)(u,\phi), $$

and integrating over the full period kills the total derivative:

$$ \int_0^{2\pi}\!\!d\phi\; b_\phi(u)\,x_{\bar\phi} \;=\; \int_0^{2\pi}\!\!d\phi\;(\partial_2 B)(u,\phi) \veq{b-collapse}\sympy $$

which is an $a$-family integrand. Checked symbolically on $b(w,\phi)=w^2e^{i\phi}$ and
$b(w,\phi)=e^{w}\cos 2\phi$: both sides agree exactly. So $\eqref{whittaker-3d}$ collapses to

$$ f(x,y,z) = \int_0^{2\pi}\!\!d\phi\;\; g\big(x\cos\phi+y\sin\phi+iz,\ \phi\big). $$

That is **Whittaker's formula**, verbatim (see §3).

### 1.5 It really does generate the solid harmonics

Taking $g(w,\phi)=e^{-im\phi}w^n$ and integrating (SymPy, exact):

| $n$ | $m$ | $\int_0^{2\pi}e^{-im\phi}u^n\,d\phi$ | $\Delta$ |
|---|---|---|---|
| 1 | 0 | $2\pi i z$ | 0 |
| 2 | 0 | $\pi (x^2+y^2-2z^2)$ | 0 |
| 2 | 1 | $2\pi z(ix+y)$ | 0 |
| 2 | 2 | $\tfrac{\pi}{2}(x-iy)^2$ | 0 |
| 3 | 0 | $i\pi z(3x^2+3y^2-2z^2)$ | 0 |
| 3 | 3 | $\tfrac{\pi}{4}(x-iy)^3$ | 0 |

These are the regular solid harmonics $R_n^m$ up to normalisation, and the selection rule
$|m|\le n$ falls out for free: $\int e^{-im\phi}u^n d\phi=0$ whenever $|m|>n$ (checked for
$(n,m)\in\{(1,2),(2,3),(0,1)\}$). **So the discrete $m\in\mathbb Z$ of the 1D story survives as
the $\phi$-Fourier index of the direction integral, and the radial index $n$ is the power of the
null coordinate.** The draft's ambition ("a discrete base set") is delivered, in 3D, by
$(n,m)$.

### 1.6 Four notation snags surfaced, not fixed

Located and reported per the working contract; the owner decides every resolution.

- L97: `\underbrace{\vec e^2}_{=1]}` has a stray `]`. L58: `-\frac1\Phi\partial_\varphi\Phi=m^2`
  should presumably be $\partial_\varphi^2$. L88: $d^3e$ for a measure on the unit 2-sphere, where
  the general formula says $d^{d-1}e$.
- L154: `$\Delta_\phi = \Delta - \partial_\phi^2$` collides with the angular derivative, and §1.4
  shows that collision is load-bearing (the angular $\partial_\phi$ is what collapses the
  $b$-family). Suggest $\partial_{x_\phi}$ or $(\vec e_\phi\cdot\vec\nabla)$ for the directional
  one.

---

## 2. The owner's question: what is lost against the continuous Fourier basis?

The draft asks "what happens to non-holomorphic parts in this approach?". Three separate answers,
because three separate things are going on.

**(a) In the rotated picture, nothing is lost to smoothness.** Harmonic functions are automatically
real-analytic, so there *are* no non-smooth solutions of $\Delta f=0$ to lose. Holomorphy is not an
extra assumption there; it is a theorem.

**(b) The loss happens at the un-rotation, and it is real.** The d'Alembert form itself is
unconditional:

$$ f(x,t)=f^+(x-ct)+f^-(x+ct) \;\Longrightarrow\; \partial_x^2 f-\tfrac1{c^2}\partial_t^2 f=0 \veq{dalembert}\lean $$

and it admits any locally
integrable profile, including $f^+(s)=\theta(s)$ (a shock) or a $C^\infty$-but-not-analytic bump.
Neither is the restriction of a holomorphic function to the real line. What *is* true is the
hyperfunction statement: such a profile is a **two-sided boundary value**
$f(s)=F(s+i0)-F(s-i0)$ of a function holomorphic off the real axis (for $\theta$, take
$F=\tfrac{1}{2\pi i}\log$). So the discrete construction recovers the non-holomorphic solutions
only if you allow the limit from *both* half-planes and take the jump. A single Laurent series
does not. This is the honest cost, and it is the same cost the Penrose transform pays by moving
from functions to Čech cocycles on a cover (§3).

**(c) The Laurent series is domain-bound, and that is the sharpest loss.**
$f^+(z)=\sum_m f^+_m z^m$ converges on an annulus $r_1<|z|<r_2$. The real line $z=x-ct$ passes
through both $0$ and $\infty$, and **no annulus contains it**. So the 1D discrete representation is
global only in the degenerate cases where the negative-$m$ half vanishes (a disc) or the
positive-$m$ half vanishes (an exterior). Fourier has no such restriction: $e^{i\omega x}$ is
defined on all of $\mathbb R$. Trading $\omega\in\mathbb R$ for $m\in\mathbb Z$ trades *global
validity* for *domain-local geometric convergence*.

**(d) What $m\in\mathbb Z$ actually buys** is exactly what solid harmonics buy in the fast multipole
method: on a ball or shell the error decays **geometrically** in $(r/R)^n$, so truncation at degree
$N$ costs $(N+1)^2$ coefficients and no quadrature rule, whereas a continuous-$\omega$
representation needs a quadrature whose node count is set by bandwidth rather than geometry. For
compact scatterers, near-field evaluation, and repeated re-evaluation of the same field, the
discrete index simply wins. That is the real payoff of the Wick-rotation programme and it is worth
stating in the draft.

---

## 3. What is classical here, and what is the owner's

I searched; here is the honest allocation.

**Classical, and old.**

- **Whittaker (1903)**, *On the partial differential equations of mathematical physics*, Math. Ann.
  57: every harmonic function of three variables (analytic near a point) equals
  $\int_0^{2\pi} g(x\cos u+y\sin u+iz,\,u)\,du$. That is $\eqref{whittaker-3d}$ after the §1.4
  collapse, character for character. The owner has re-derived a 123-year-old theorem, correctly, by
  his own route.
- **Bateman (1904)**, Proc. LMS: the contour-integral generalisation (4D Laplace / 3D wave), now the
  "Bateman transform", asserted by Bateman to be the general solution.
- **Penrose transform / twistor theory**: the modern completion, in which the "arbitrary function of
  one variable" is properly a Čech cohomology class on a cover of the twistor line. That is exactly
  the machinery repairing the annulus problem of §2(c); the reach of the representation is the
  "harmonic hull". Eastwood's *Bateman's formula* states it cleanly.
- That harmonic functions superpose **null plane waves** is the standard reading of Bateman's
  formula, not new.

**Plausibly the owner's own, and worth keeping.**

- **The motivation.** Every classical source starts from Laplace. None that I found frames the
  construction as *a device for the wave equation*, namely: Wick-rotate in order to replace the
  continuous $\omega$ of the `(Fourier)` step in `physics/wirohsh.md` by the discrete $m$ of a
  shell periodicity condition,
  then rotate back. "WiRoHSH" as a *computational* programme for wave problems is his framing.
- **The dimensional ladder** stated as a ladder: $d$-dim Laplace is superposed from $(d-2)$-dim
  Laplace solutions, via $d$-dim wave. Classically this is a corollary nobody bothers to name; as
  a recursion it is a genuinely nice packaging and it is the thing a `.mw` document could actually
  mechanise.
- **The $b_\phi x_{\bar\phi}$ second family** is his addition. §1.4 shows it is redundant, but the
  redundancy is instructive rather than a mistake: it is the same one-form-freedom the twistor
  picture calls a coboundary.

**Recommendation for the draft:** cite Whittaker and Bateman explicitly, keep the derivation
(re-deriving it from the Wick rotation is the pedagogical point of the whole document), and drop
or footnote the $b$ family. Do not present $\eqref{whittaker-3d}$ as new.

---

## 4. Ruling recommendation on `ROADMAP.md id:ff32` (T-matrix $\leftrightarrow$ splats $\leftrightarrow$ WiRoHSH)

**Recommendation: NO-GO as framed.** Owner ratification required; this is a recommendation, not a
decision.

The question asks whether a precomputed per-geometry response basis (T-matrix analogy) can
represent Gaussian splats compactly via WiRoHSH. Three objects, and the analogy breaks at each
join.

**Break 1: a T-matrix is two-sided, a splat's SH is one-sided.** Waterman's $T$ maps *incident* VSH
coefficients to *scattered* ones, $p=T a$, at one frequency, one rigid geometry, outside the
circumscribing sphere. A 3D Gaussian splat carries position, anisotropic covariance, opacity, and
low-degree SH coefficients encoding **outgoing radiance as a function of view direction**. There is
no incident field. A one-sided object is a *vector*, not an operator, so the "precomputed
per-geometry response basis" already exists in 3DGS and is literally the per-splat SH vector. A
T-matrix adds nothing unless the goal is **relighting**, and if it is, the correct classical anchor
is **precomputed radiance transfer** (Sloan et al. 2002), not the T-matrix; the dual-SH and
relightable-3DGS literature is already there.

**Break 2: there is no wave equation in the splat pipeline, so WiRoHSH's payoff does not exist.**
WiRoHSH earns its keep by replacing a continuous $\omega$ in a Helmholtz problem. Rasterising
splats is geometric-optics alpha compositing along a ray. There is no $\omega$, no phase, no
Helmholtz operator. The disease WiRoHSH cures is not present.

**Break 3: the domain restriction of §2(c) is exactly wrong for a splat cloud.** A harmonic
expansion about a centre converges on a ball or shell. A 3DGS scene is $10^6$ disjoint
compactly-supported anisotropic bumps with hard opacity cutoffs and mutual **occlusion**
discontinuities, evaluated *inside* the cloud, not in the far field. Occlusion edges are precisely
the non-holomorphic content §2(b) reaches only through a two-sided jump. Multipole-style expansions
win when sources cluster and the field is sampled far away, which is the opposite regime.

**Break 4: direction of compression.** 3DGS is already sparse *spatially*, which is why it is
compact; rewriting a spatially sparse representation in a globally dense harmonic basis makes it
larger. If the target is compactness, the live directions are SH-degree pruning and anchor/codebook
methods, both of which shrink the existing SH and neither of which needs a new basis.

**The one salvage worth keeping open.** If `loderite` ever needs genuine **wave** behaviour from a
splat-like primitive (diffraction, coherent scattering, acoustics, an ultrasound or RF forward
model), a per-primitive T-matrix in a Wick-rotated harmonic basis becomes a coherent question,
because a real Helmholtz problem with a real continuous-$\omega$ nuisance is finally present. One
specific reason to look: a Gaussian is exactly the profile for which
$\int_0^{2\pi}d\phi\,\exp[-(x_\phi+iz)^2/2\sigma^2]$ is a candidate for closed form, which would
give an analytic per-splat far field. One SymPy run decides it.

**Suggested disposition:** split `id:ff32` into (i) *closed, NO-GO, with this note as the record*
for the rendering/compactness reading, and (ii) a new, much narrower item for the wave-forward-model
reading, gated on `loderite` actually needing one. As always, the owner rules.

---

## 5. Follow-up leads

1. **Is the $b$-collapse a 3D accident?** It rests on $\vec e_{\bar\phi}=-\partial_\phi\vec e_\phi$,
   which needs a *one*-parameter direction sphere. Decidable by redoing §1.4 in 4D, where $S^2$ has
   two transverse directions and the total-derivative argument cannot cover both.
2. **Invert the representation.** Write the explicit map from solid-harmonic coefficients
   $f_{nm}$ to the $\phi$-Fourier coefficients of $g$. Decidable by checking it against the §1.5
   SymPy table up to $n=6$; if it inverts, the "discrete basis" claim is constructive, not just
   existential.
3. **Rotate back and demand reality.** Evaluate $u^n$ at $z=-ict$ and ask which combinations of
   $(n,m)$ give a real $f(x,y,t)$. Decidable by a conjugation-symmetry condition on $g$, analogous
   to $\tilde T(-\omega)=\overline{\tilde T(\omega)}$ for Fourier; either such a condition exists or
   the discrete basis is not usable for real waves.
4. **Test the hyperfunction claim concretely.** Take the d'Alembert shock $\theta(x-ct)$ and check
   whether the two-sided boundary-value construction of §2(b) reproduces it, and confirm that no
   Laurent annulus contains its profile. Decidable by explicit computation with
   $F=\tfrac{1}{2\pi i}\log$.
5. **The splat salvage.** Compute $\int_0^{2\pi}d\phi\,\exp[-(x_\phi+iz)^2/2\sigma^2]$. Decidable in
   one SymPy run: closed form (probably a Bessel-type function of $x^2+y^2-z^2$) keeps lead (ii) of
   §4 alive; no closed form kills it.

---

## Lean attestation

The three `\lean`-badged claims above, plus one bonus, are proved in
[`docs/dreamed/lean/Wirohsh.lean`](lean/Wirohsh.lean), namespace `Wirohsh`:

| handle | theorem | content |
|---|---|---|
| `transverse-symbol` | `wirohsh_transverse_symbol` | both `=` steps of the owner's $\Delta_\phi$ block, at the level of second-order symbols $(\xi,\eta)$ |
| `null-direction` | `wirohsh_null_direction`, `wirohsh_transverse_orthogonal` | $\cos^2\phi+\sin^2\phi+i^2=0$ and $\vec n_\phi\cdot\vec e_{\bar\phi}=0$ in $\mathbb C^3$ |
| (bonus) | `wirohsh_kernel_harmonic` | $\Delta\,u^{n+2}=0$ for $u=x\cos\phi+y\sin\phi+iz$, by twice differentiating each coordinate slice with `HasDerivAt` witnesses |
| `dalembert` | `dalembert_wave` | $f=g(x-ct)+h(x+ct)$ satisfies $f_{xx}-c^{-2}f_{tt}=0$, second derivatives delivered not assumed |

Checked with:

```
cd /home/tobias/src/toesnail/verify
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/Wirohsh.lean
```

**Exit status 0**, zero `sorry`, two `unusedVariables` warnings (see below).

**What had to be weakened, stated plainly.**

- `wirohsh_transverse_symbol` is a **symbol-level** identity in $(\xi,\eta)$, not an identity of
  differential operators. That symbol calculus faithfully models composition of
  constant-coefficient operators is standard and is *not* proved.
- `wirohsh_kernel_harmonic` proves harmonicity of the **kernel** $u^{n+2}$, not of the
  $\phi$-integral $\eqref{whittaker-3d}$. Differentiating under the integral sign is not done, and
  the general-$a_\phi$ statement (which needs a genuine multivariable chain rule for
  $\mathbb R^3\to\mathbb C$) is not done either. The Laplacian is assembled from the three second
  slice derivatives, legitimate here only because each slice is a polynomial.
- `dalembert_wave` states the first-derivative hypotheses `hg`/`hh` for faithfulness (they are what
  make the theorem a statement about $g(x-ct)+h(x+ct)$ rather than about arbitrary functions), but
  the proof consumes only the second-derivative witnesses `hg2`/`hh2`. Hence the two warnings. I
  kept them rather than produce a technically-stronger theorem that no longer says what the draft
  says.
- The `\sympy` badges on `whittaker-3d` and `b-collapse` are **finite-sample** SymPy checks (the
  families listed in §1.3 and the two examples in §1.4), not general proofs. Per
  `docs/dreamed/README.md` these badges attest the dreamed Lean file and the runs recorded here
  only; they are deliberately not wired into `physics/*.toml` or `tests/test_verify.sh`.

## `.mw` sketch

What a future `.mw` document would carry, so the essay is `.mw`-linkable:

```computation
u = x*cos(phi) + y*sin(phi) + I*z
```

```computation
null_condition = diff(u,x)**2 + diff(u,y)**2 + diff(u,z)**2
```

```computation
harmonic_kernel = diff(u**n, x, 2) + diff(u**n, y, 2) + diff(u**n, z, 2)
```

```computation
solid_harmonic = Integral(exp(-I*m*phi) * u**n, (phi, 0, 2*pi))
```

```computation
b_collapse = Integral(b(u,phi) * (x*sin(phi) - y*cos(phi)), (phi, 0, 2*pi)) - Integral(Derivative(B(u,phi), phi, evaluate=False), (phi, 0, 2*pi))
```

The DAG edge that matters: `harmonic_kernel` and `solid_harmonic` both depend on `u`, so any edit
to the definition of `u` (for instance a sign change in the Wick rotation, `+I*z` to `-I*z`) must
mark both stale. That is precisely the `stale_after_edit` property the HARD-tier commit hook
already exercises on the Resogram mirror.

## Sources consulted

- [Bateman transform (Wikipedia)](https://en.wikipedia.org/wiki/Bateman_transform)
- [Eastwood, *Bateman's formula*](https://maths-people.anu.edu.au/~eastwood/bateman.pdf)
- [Whittaker's Work on the Integral Representation of Harmonic Functions, Proc. Edinburgh Math. Soc.](https://www.cambridge.org/core/journals/proceedings-of-the-edinburgh-mathematical-society/article/whittakers-work-on-the-integral-representation-of-harmonic-functions/95CD6D8ADB9F83B54D1FCF3763AE4A61)
- [Twistor theory and the harmonic hull (arXiv:1012.2620)](https://arxiv.org/pdf/1012.2620)
- [Penrose transform (Encyclopedia of Mathematics)](https://encyclopediaofmath.org/wiki/Penrose_transform)
- [Gaussian splatting (Wikipedia)](https://en.wikipedia.org/wiki/Gaussian_splatting)
- [StructGS: Adaptive Spherical Harmonics for 3DGS (arXiv:2503.06462)](https://arxiv.org/abs/2503.06462)
- [Dual Spherical Harmonics for 3D Gaussian Splatting (ACM CVMP 2025)](https://dl.acm.org/doi/10.1145/3756863.3769709)

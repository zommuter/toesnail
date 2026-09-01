---
title: What WiRoHSH can and cannot approximate
permalink: /dreamed/wirohsh-approximation
---

# What WiRoHSH can and cannot approximate

> **DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](./). AI-written, 2026-09-01, round 2 of the
> owner-picked dreaming session. Seed, verbatim: *"Thoughts on what WiRoHSH can approximate vs what
> not (like Laurent series vs Fourier transform etc)"*, plus `docs/se-corpus.md` row **M-6**
> (the Laurent-continuation cluster, framed by the owner as *"Fourier : transform :: Laurent : ?"*
> and *"analytic ⟺ one-sided FT"*, flagged interesting 2026-07-08). It **proposes**; the owner
> disposes. Nothing here may be promoted into `physics/` without the owner authoring the move.

## 0. Headline

Three results, all checked rather than asserted.

1. **The missing cell in the owner's analogy is the two-sided Laplace transform, spelled in
   multiplicative coordinates as the Mellin transform.** Not the z-transform: the z-transform *is* a
   Laurent series, so it sits in the cell the analogy already occupies.
2. **The basis cannot localize.** A nonzero real-analytic function has no compact support
   (identity theorem, proved in Lean below). This is a stronger and more structural obstruction than
   the four reasons round 1 gave for its `id:ff32` NO-GO, because a splat is *defined* by compact
   local support. Recommendation for the owner, not a decision.
3. **The measured rates confirm the geometric-vs-algebraic story but not the naive version of it.**
   For $1/(1+x^2)$ the Chebyshev/Laurent ratio comes out $\rho = 2.414214$ against the exact
   $1+\sqrt2 = 2.4142136$ (seven digits), while Fourier on the *same* analytic function manages only
   $n^{-1}$. The discriminant is not "analytic data" but "basis matched to the geometry of the data":
   on an analytic *and* periodic function Fourier wins by an equally wide margin.

[Round 1 §2](wirohsh-splats.md) established the qualitative version of the loss: the d'Alembert form
admits any locally integrable profile, the Laurent detour admits only holomorphic ones, and the
Laurent series is domain-bound to an annulus. This essay makes each of those a theorem with a
constant attached, and corrects one of them (§3.3).

---

## 1. The completed analogy (`se-corpus` row M-6)

The owner's proportion is **Fourier series : Fourier transform :: Laurent series : ?**

### 1.1 The answer

The operation that turns a Fourier *series* into a Fourier *transform* is: unwrap the compact domain
into a non-compact one, and the dual index goes from discrete to continuous. Apply the same operation
to a Laurent series. The exponential map $z = e^w$ carries the annulus onto a strip,

$$ \exp:\ \{\,\ln r_1 < \operatorname{Re} w < \ln r_2\,\} \longrightarrow \{\,r_1<|z|<r_2\,\}, \qquad (2\pi i\text{-periodically}). \veq{annulus-strip}\numeric $$

In the $w$ coordinate a Laurent series $\sum_n a_n z^n$ is literally a **Fourier series in
$\operatorname{Im} w$** with $\operatorname{Re} w$-dependent coefficients $a_n e^{n\operatorname{Re}w}$.
Discreteness of $n$ is nothing but the $2\pi$-periodicity of $\operatorname{Im} w$. Drop that
periodicity, and the index becomes continuous: that object is the **two-sided (bilateral) Laplace
transform** on the strip,

$$ f(w) = \frac{1}{2\pi i}\int_{c-i\infty}^{c+i\infty} F(s)\,e^{ws}\,ds, \qquad a<c<b. $$

Written back in the multiplicative variable $x = e^{-w}$ this is the **Mellin transform**,
$F(s)=\int_0^\infty f(x)x^{s-1}dx$, with $z^n \to x^{-s}$ exactly as the seed guessed. Laplace and
Mellin here are one transform in two coordinates, not two answers.

### 1.2 The table, with each cell's status

| function lives on | expansion | index | region of convergence | status |
|---|---|---|---|---|
| circle $\mathbb T$ | Fourier series | $n\in\mathbb Z$, discrete | the circle | given |
| line $\mathbb R$ | Fourier transform | $\omega\in\mathbb R$, continuous | the line (or a strip, if complexified) | given |
| annulus $r_1<\|z\|<r_2$ | **Laurent series** | $n\in\mathbb Z$, discrete | the annulus | given |
| strip $a<\operatorname{Re}s<b$ | **two-sided Laplace** | $s\in c+i\mathbb R$, continuous | the strip | **exact** |
| ray $\mathbb R_+$ | **Mellin** | $s\in c+i\mathbb R$, continuous | fundamental strip | **exact, same object** |
| sequence on $\mathbb Z$ | $z$-transform | $n\in\mathbb Z$, discrete | an annulus | **occupies the Laurent cell** |
| sequence on $\mathbb Z$ | DTFT | $\theta\in\mathbb T$ | the unit circle | Fourier-series cell |

Two cells need defending.

**The $z$-transform is not the answer.** $X(z)=\sum_n x[n]z^{-n}$ is a Laurent series of the
sequence, with a genuine annulus of convergence. It is the *same* cell, restated for sequences, and
the classical DSP square confirms the assignment: DTFT : $z$-transform :: Fourier transform :
Laplace transform. Reading that square along the other diagonal gives Laurent $\to$ Laplace, which
is §1.1.

**Where the analogy is loose, precisely.** A Fourier series index $n$ and a Fourier transform index
$\omega$ parameterize the *same* direction (translation), one compactified and one not. Laurent's
$n$ and Mellin's $s$ do **not**: on $\mathbb C^\ast \cong \mathbb T \times \mathbb R_+$, Laurent's
$n$ is dual to the *angular* (compact) factor while Mellin's $s$ is dual to the *radial* (non-compact)
one. The analogy is exact only after the $\exp$ transport of §1.1 puts both on the same additive
line. **Confidence: high** on Laplace/Mellin being the right and unique cell; **medium** on which
spelling deserves to be called canonical. I would write it as *Laplace on the strip*, and note Mellin
as the same thing in the coordinate the owner is already using.

### 1.3 "Analytic ⟺ one-sided FT" is the same fact a third time

Row M-6's second phrase is the degenerate case of the table, and it unifies three notations:

- **Laurent:** the principal part vanishes ($r_1=0$) $\iff$ $f$ is holomorphic on the whole disc.
- **Laplace:** the strip is a half-plane $\operatorname{Re}s>a$ $\iff$ the signal is one-sided
  (causal, supported on $t\ge0$).
- **Paley-Wiener:** $\hat f$ is supported in $[0,\infty)$ $\iff$ $f$ extends holomorphically and
  boundedly to the upper half-plane ($f \in H^2$).

**One-sidedness of the index set, one-sidedness of the support, and half-plane holomorphy are the
same condition transported by $\exp$ and by Fourier duality.** Row M-6's third phrase, "analytic
continuation ring by ring", is then just: a function that is real-analytic but not entire needs
*several* annuli, one per ring between consecutive singularity radii. §3.3 shows that this is exactly
what the owner's 1D basis costs.

---

## 2. What the basis can represent, as a theorem

**Theorem (Laurent).** $f$ holomorphic on the open annulus $A(r_1,r_2)=\{r_1<|z|<r_2\}$,
$0\le r_1<r_2\le\infty$, has a unique locally uniformly convergent expansion
$f(z)=\sum_{n\in\mathbb Z}a_nz^n$, $a_n=\frac{1}{2\pi i}\oint f(z)z^{-n-1}dz$; conversely such a
series converges on an annulus and nowhere larger, with
$1/r_2=\limsup_n|a_n|^{1/n}$ and $r_1=\limsup_n|a_{-n}|^{1/n}$. So the honest statement of the
owner's reach is: **analytic data on an open annulus, with a forbidden core and a finite outer
radius, both set by the nearest singularities.**

### 2.1 The exact map to spacetime

`physics/wirohsh.md` sets $z=x+iy$ with $y$ the imaginary time, then Wick-rotates back with
$z = x-ct$ and $\bar z = x+ct$. Real spacetime therefore sits on the **real axis of the $z$-plane**,
and the accessible part of it is $A(r_1,r_2)\cap\mathbb R = (-r_2,-r_1)\cup(r_1,r_2)$. In
characteristic coordinates $\xi=x-ct$, $\eta=x+ct$ the full two-wave solution
$f = f^+(\xi)+f^-(\eta)$ is valid exactly on

$$ \mathcal R = \{(x,t):\ r_1^+ < |x-ct| < r_2^+ \ \ \text{and}\ \ r_1^- < |x+ct| < r_2^-\}, $$

which is four open parallelograms in the $(x,t)$ plane, each a rectangle in $(\xi,\eta)$ rotated onto
the light cone. Reading it physically:

- $r_1^+>0$ excludes a strip of half-width $r_1^+$ **around the characteristic $x=ct$ itself**, i.e.
  around the wavefront, which is exactly where the interesting physics of a pulse lives.
- $r_2^+<\infty$ excludes everything far from that characteristic.
- $r_1=0$ (no principal part) gives a band $|x-ct|<r_2$ containing the characteristic. This is the
  physically sane case and it is precisely the one-sided/causal case of §1.3.
- $r_2=\infty$ with $r_1>0$ keeps only the far field.

---

## 3. What it fundamentally cannot do

### 3.1 The locality obstruction

**Theorem.** A real-analytic $f:\mathbb R\to\mathbb R$ with compact support is identically zero.

$$ f\ \text{real-analytic on }\mathbb R \ \ \wedge\ \ \operatorname{supp}f\ \text{compact} \quad\Longrightarrow\quad f\equiv 0 \veq{no-compact-support}\lean $$

Proof (formalised below): compact support puts $\operatorname{supp}f$ inside some
$\overline{B}(0,R)$, so $f$ vanishes on the open ray $(R,\infty)$; the identity principle on the
preconnected set $\mathbb R$ then forces $f\equiv0$.

Consequently **no finite combination and no convergent Laurent expansion represents a bump that is
exactly zero outside an interval.** Every basis element, and every limit of them in the topology the
expansion converges in, is felt everywhere at once. The consequences are all corollaries of that one
sentence:

- **No space-frequency localization.** A wavelet basis exists because compactly supported (or rapidly
  decaying) smooth atoms exist. Here they provably do not, so there is no WiRoHSH wavelet, ever.
- **No adaptivity.** Refinement in a global basis means "add more global modes". A local feature costs
  the same everywhere; error cannot be spent where it is needed.
- **Pollution.** A single discontinuity anywhere destroys the rate everywhere. §5's square-wave row
  shows this quantitatively: the $L^2$ error falls off as $n^{-1/2}$ on the whole interval, not just
  near the jump.
- **Gibbs at every jump**, in *both* bases, measured at 8.94% in §5.

### 3.2 What this implies for `id:ff32`

Round 1 recommended NO-GO on `id:ff32` (T-matrix $\leftrightarrow$ splats $\leftrightarrow$ WiRoHSH)
on four grounds: one-sidedness, no wave equation in the pipeline, wrong domain regime, and wrong
direction of compression. §3.1 supplies a fifth that is independent of all four and does not depend
on any reading of the splat pipeline: **a Gaussian splat is by construction a local bump, and the
basis provably contains none.** The Gaussian is not compactly supported, so the theorem does not kill
it outright, but the practical splat *is* clipped at a few $\sigma$ and the clipped object is exactly
the forbidden class. This is a **recommendation for the owner**, offered as reinforcement of the
round-1 recommendation, not as a decision; `id:ff32` remains open until he rules.

### 3.3 A correction to round 1 §2(c)

Round 1 wrote: *"The real line $z=x-ct$ passes through both $0$ and $\infty$, and no annulus contains
it."* That is too strong. The degenerate annulus $A(0,\infty)=\mathbb C$ contains $\mathbb R$, and its
Laurent series is an ordinary Taylor series of an **entire** function. $f^+(s)=\sin s$ or $e^{-s^2}$
is globally represented by one series on all of $\mathbb R$; there is no domain obstruction at all.

The correct statement is sharper and more useful: **the domain restriction and the analyticity
restriction are the same restriction wearing two hats.** Shrinking the annulus is exactly the price of
a singularity. $f^+(s)=1/(1+s^2)$ is real-analytic on all of $\mathbb R$ yet needs **two** Laurent
series, $\sum(-1)^ks^{2k}$ on $|s|<1$ and $\sum(-1)^ks^{-2k-2}$ on $|s|>1$, because a pole at $s=\pm i$
sits at distance 1 from the origin. That is row M-6's "analytic continuation ring by ring", showing up
as a concrete cost in the owner's own construction.

---

## 4. The rates, measured

All numbers below are computed, not quoted. Setup: max-norm and $L^2$ truncation error on $[-1,1]$,
$N$ = degree kept. The analytic-basis column is a **Chebyshev** expansion, which is the owner's
Laurent basis in disguise: under the Joukowski map $x=\tfrac12(z+z^{-1})$, Chebyshev coefficients on
$[-1,1]$ *are* Laurent coefficients on the annulus, and the Bernstein ellipse parameter $\rho$ is the
annulus radius. The Fourier column is the series of the 2-periodic extension.

### 4.1 Max-norm error vs $N$

| function | basis | $N{=}4$ | 8 | 16 | 32 | 64 | 128 | 256 | fitted |
|---|---|---|---|---|---|---|---|---|---|
| $1/(1+x^2)$, analytic, **not** periodic | Cheb | 8.6e-3 | 2.5e-4 | 2.2e-7 | 1.7e-13 | 3e-16 | 3e-16 | 3e-16 | geometric, $\rho=2.414214$ |
| | Fourier | 2.2e-2 | 1.2e-2 | 6.1e-3 | 3.1e-3 | 1.6e-3 | 7.9e-4 | 4.0e-4 | **algebraic $n^{-1.00}$** |
| $e^{\cos\pi x}$, analytic **and** periodic | Cheb | 2.9e-1 | 3.2e-2 | 1.7e-4 | 8.2e-10 | 9e-16 | | | geometric |
| | Fourier | 5.9e-4 | 1.2e-8 | 1.8e-15 | | | | | geometric, much faster |
| $C^\infty$ bump, compact support | Cheb | 1.2e-1 | 4.0e-2 | 1.7e-2 | 4.7e-3 | 6.2e-4 | 4.5e-5 | 1.1e-6 | $\exp(-0.78\sqrt N)$ |
| | Fourier | 2.9e-2 | 1.0e-2 | 1.6e-3 | 2.1e-4 | 9.8e-6 | 1.3e-7 | 3.1e-10 | $\exp(-1.29\sqrt N)$ |
| $\operatorname{sign}(x)$ | Cheb | 1.00 | 1.00 | 1.00 | 1.00 | 0.99 | 0.99 | 0.98 | **no convergence** |
| | Fourier | 1.00 | 1.00 | 1.00 | 1.00 | 1.01 | 1.02 | 1.03 | **no convergence** |

In $L^2$ the two rough rows do converge, both at $n^{-0.51}$ and $n^{-0.52}$ respectively: identical
rates, so the roughness penalty is a property of *global smooth bases*, not of Fourier in particular.

### 4.2 Coefficient decay, checked against theory

$$ |a_n| \le \frac{M}{r^n} \ \ (\text{Cauchy}) \quad\Longrightarrow\quad \sum_{k\ge n}|a_k| \le \frac{M\,q^{\,n}}{1-q},\ \ q=1/\rho<1 \veq{geometric-tail}\lean $$

Measured Chebyshev ratios for $1/(1+x^2)$: $\rho_{\text{est}} = 2.414214$ at $n=10$, $20$ and $30$,
against the exact Bernstein value $1+\sqrt2 = 2.4142136$; the $n=40$ estimate drifts to $2.4277$
because $|a_{40}|\approx10^{-18}$ is roundoff. The Cauchy bound itself was spot-checked directly on
$1/(1+z^2)$ at $r\in\{0.5,0.9,0.99\}$: it holds, and tightens toward equality as $r\to1^-$, the
distance to the pole.

The same function's **Fourier** coefficients: $|c_8|=7.9\cdot10^{-4}$, $|c_{16}|=2.0\cdot10^{-4}$,
$|c_{32}|=4.9\cdot10^{-5}$. Exactly a factor 4 per doubling, i.e. $n^{-2}$.

$$ \forall k,\ \ n^k q^{\,n} \to 0 \quad (0\le q<1) \veq{geometric-beats-algebraic}\lean $$

### 4.3 The expected rate that did not show up, and why it matters

**Fourier on an analytic function decayed only algebraically.** $1/(1+x^2)$ is analytic everywhere on
$[-1,1]$, yet its Fourier series converges at $n^{-1}$ in max norm. The reason is that its 2-periodic
extension has a kink at $x=\pm1$: Fourier does not see the function, it sees the *periodic* function.
Symmetrically, on $e^{\cos\pi x}$ Fourier reaches machine precision at $N=16$ where Chebyshev needs
$N\approx 40$.

So the fair statement of the trade-off is **not** "analytic basis beats Fourier on analytic data". It
is: *each basis is geometric exactly when the data is analytic on the basis's own domain, including
its identifications.* WiRoHSH's Laurent basis is right when the analyticity domain is an annulus
around the characteristic; Fourier is right when it is a periodic strip. Round 1 §2(d) claimed the
discrete index "simply wins" for compact scatterers; §4.1 row 2 shows the claim needs the qualifier
"and the data is not naturally periodic", which for a Matsubara/thermal problem it very much is.

### 4.4 Gibbs, measured

Classical Wilbraham-Gibbs overshoot: $\frac1\pi\int_0^\pi\frac{\sin t}{t}dt-\frac12 = 0.0894898$,
i.e. **8.9490%** of the jump. Measured on $\operatorname{sign}(x)$:

| $N$ | Fourier overshoot | Chebyshev overshoot |
|---|---|---|
| 16 | 9.0172% | 9.0112% |
| 64 | 8.9556% | 8.9501% |
| 256 | 8.9442% | 8.9472% |

$$ \lim_{N\to\infty}\ \frac{\max_x S_N - 1}{2} = \frac{1}{\pi}\operatorname{Si}(\pi)-\frac12 = 0.0894898 \veq{gibbs}\numeric $$

Both bases land on the same constant, to three digits. **Gibbs is not a Fourier artifact; it is what
any global smooth basis does at a jump**, and the owner's basis inherits it in full.

---

## 5. Verdict

WiRoHSH is a spectral method, and it has a spectral method's economics exactly: exponential accuracy
on analytic data, catastrophic behaviour on rough data, and no locality ever. Concretely, it is the
right tool when the field is analytic on an annulus around the propagation characteristic, when the
same field is evaluated many times so that the up-front coefficient solve amortises, and when the
singularity structure is itself the answer, because a Laurent principal part *is* a resonance pole:
exterior scattering and far-field radiation patterns, free-space propagation of a smooth pulse
through a smooth medium, resonance and pole-hunting, and thermal/Matsubara problems where the
imaginary-time circle supplies the periodicity for free (see
[`wick-entropy.md`](wick-entropy.md)). It is disqualified from anything with a front or an edge:
shock formation and nonlinear steepening, contact discontinuities, sharp material interfaces,
compactly supported initial data (the one class it *provably* cannot represent, §3.1), any adaptive
or multiresolution scheme, and any problem where a local error must be kept local. The decisive test
before committing to it on a given problem is not "is the data smooth" but "is the data analytic on
an annulus that contains the region I care about, and does that annulus exclude the wavefront?" If
the answer to the last clause is yes, §2.1 says the method is blind precisely where the physics is.

---

## Surfaced for the owner

Located, not fixed. The owner decides every resolution.

1. **`physics/wirohsh.md`, the paragraph after the d'Alembert result**, says: *"the detour to the
   discrete Laurent series did impose the condition of being holomorphic to the two waves. In smooth
   regions those are perfectly sufficient."* **Smooth is not sufficient; analytic is required**, and
   the gap is not empty. The $C^\infty$ compactly supported bump of §4.1 is smooth everywhere and is
   represented by no Laurent series at all (§3.1). Suggested wording: *"in regions where the data is
   analytic"*.
2. **Round 1 §2(c) overstates the domain loss.** See §3.3: an entire $f^+$ is globally valid on
   $\mathbb R$; the real cost is ring-by-ring continuation for anything with a finite singularity
   radius.
3. **Round 1 §2(d) needs a qualifier.** §4.3: the discrete index wins on non-periodic analytic data
   and loses to Fourier on periodic analytic data, by a comparable margin.
4. **A fifth, independent reason for the `id:ff32` NO-GO** (§3.2), which the owner may want on the
   record whichever way he rules.

## Follow-up leads

1. **Which physically interesting $f^\pm$ are entire?** That class has no domain restriction at all.
   Decidable by classifying the standard 1D pulse shapes (Gaussian, sech, Ricker): the Gaussian is
   entire, so WiRoHSH covers it globally; sech is only meromorphic.
2. **Domain-decomposed WiRoHSH**, i.e. row M-6's "ring by ring" as an algorithm. Decidable by a
   two-ring test on $1/(1+x^2)$: does a patched expansion recover the geometric rate on all of
   $\mathbb R$, and at what overlap cost?
3. **Is the Mellin cell computationally useful or only structurally correct?** Decidable by writing
   the Mellin-Barnes form of the same 1D wave solution and counting quadrature nodes against Laurent
   terms at fixed accuracy; if it needs a quadrature it reintroduces the continuous-index nuisance
   WiRoHSH exists to remove.
4. **Gegenbauer post-processing on the §4.4 Gibbs data.** Decidable by running it on the measured
   $\operatorname{sign}(x)$ Chebyshev coefficients and checking whether the error away from $x=0$
   drops below the $n^{-1/2}$ floor.
5. **Hyperfunctions are the principled escape from §3.1**, a two-sided boundary value carrying
   exactly the non-analytic content one Laurent series cannot. Not developed here: a sibling agent is
   writing `wirohsh-discontinuities.md`, which is where this lead belongs.

---

## Lean attestation

The three `\lean`-badged claims are proved in
[`docs/dreamed/lean/WirohshApprox.lean`](lean/WirohshApprox.lean), namespace `WirohshApprox`:

| handle | theorem | content |
|---|---|---|
| `no-compact-support` | `analytic_hasCompactSupport_eq_zero` | a real-analytic `f : ℝ → ℝ` with compact support is `0` |
| `no-compact-support` | `entire_eq_zero_of_vanishes_on_open` | an entire `f : ℂ → ℂ` vanishing on a nonempty open set is `0` |
| `geometric-tail` | `geometric_tail`, `truncation_error_le` | `∑' k, M q^(n+k) = M q^n/(1-q)`, and the tail bound it gives under the Cauchy hypothesis `|a m| ≤ M q^m` |
| `geometric-beats-algebraic` | `geometric_beats_algebraic` | `n^k q^n → 0` for every `k`, every `0 ≤ q < 1` |

Checked with:

```
cd /home/tobias/src/toesnail/verify
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/WirohshApprox.lean
```

**Exit status 0**, zero `sorry`, zero warnings.

**What had to be weakened, stated plainly.**

- The **Cauchy estimate itself is a hypothesis, not a theorem.** `truncation_error_le` takes
  `ha : ∀ m, |a m| ≤ Mconst * q ^ m` as given; deriving it from Cauchy's integral formula was not
  attempted, and §4.2 checks the bound numerically instead.
- `analytic_hasCompactSupport_eq_zero` is the **one-variable real** case; the several-variable
  version, which the 3D WiRoHSH of round 1 would need, is not proved.
  `entire_eq_zero_of_vanishes_on_open` is stated on `univ`, not on an annulus.
- **Nothing about §1's Mellin/Laplace correspondence is formalised.** It is a dictionary of
  definitions plus classical theorems, cited not proved; the only machine check there is the
  numerical Mellin inversion of $\Gamma$ under `annulus-strip`, which reproduced $e^{-1.3}$ to 25
  digits.
- The `\numeric` badges are **measurements** at the stated sample points, not general statements. Per
  `docs/dreamed/README.md` all badges here attest this dreamed Lean file and these runs only; they are
  deliberately not wired into `physics/*.toml` or `tests/test_verify.sh`.

## `.mw` sketch

```computation
rho = 1 + sqrt(2)
```

```computation
q = 1/rho
```

```computation
geometric_tail = Sum(Mconst * q**(n+k), (k, 0, oo))
```

```computation
gibbs_constant = Integral(sin(t)/t, (t, 0, pi))/pi - Rational(1,2)
```

The DAG edge that matters: `geometric_tail` depends on `rho` through `q`, so an edit to the
singularity location (a pole moved, a different test function) must mark the whole rate table stale.
That is the same `stale_after_edit` property the HARD-tier commit hook exercises on the Resogram
mirror.

## Sources consulted

- Laurent, annulus, two-sided Cauchy-Hadamard: Ahlfors, *Complex Analysis*, ch. 5.
- Mellin transform, fundamental strip, Mellin as Fourier on $\mathbb R_+$: Flajolet, Gourdon, Dumas,
  *Mellin transforms and asymptotics* (1995).
- Paley-Wiener and $H^2$ of a half-plane: Rudin, *Real and Complex Analysis*, ch. 19.
- Chebyshev-as-Laurent under Joukowski, Bernstein ellipse, geometric convergence: Trefethen,
  *Approximation Theory and Approximation Practice*, ch. 8. Root-exponential rates and Gibbs:
  Boyd, *Chebyshev and Fourier Spectral Methods*, ch. 2.
- Gegenbauer reconstruction: Gottlieb and Shu, SIAM Review 39 (1997).
- Identity theorem as formalised: Mathlib `Analysis/Analytic/{Uniqueness,IsolatedZeros}.lean`.

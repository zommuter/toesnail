---
title: WiRoHSH and discontinuous initial data
permalink: /dreamed/wirohsh-discontinuities
---

# WiRoHSH: what happens to the non-holomorphic parts

> **DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](./). AI-written, 2026-09-01, round 2 of an
> owner-directed dreaming session. Seed, owner-picked: *"1+1 -> 2D: discontinuous initial conditions,
> and continuous ones too"*, aimed at the owner's own question at `physics/wirohsh.md:82`. It
> **proposes**; the owner disposes. Nothing here may be promoted into `physics/` without the owner
> authoring the move. Round 1 is [`wirohsh-splats.md`](wirohsh-splats.md) and is not repeated.

## 0. Headline

**Nothing is lost, and the owner's instinct is right, but his stated dividing line is wrong.** The
non-holomorphic data survives as a *boundary value*: drop the requirement that the two Laurent
series share a common annulus straddling the shell, keep only that each half converges up to it, and
the pair `(f⁺, f⁻)` becomes precisely a **Sato hyperfunction**, which is an arbitrary distribution
(and more). The discrete index `m` is not lost either: regularity is read off the *growth rate* of
`f_m^±`, from exponentially decaying (real-analytic) through polynomially bounded (distribution) to
infra-exponential (hyperfunction). What is lost is only convergence *as a function on a
neighbourhood*, which round 1 already identified as the annulus problem.

The wrong dividing line: `physics/wirohsh.md:82` says *"In smooth regions those are perfectly
sufficient"*. **Smoothness is not the criterion; real-analyticity is.** A $C^\infty$ bump with
compact support is infinitely smooth and is *not* the restriction of any holomorphic function
anywhere on the boundary of its support. It sits on the same side of the line as a shock, not on
the same side as $1/(1+x^2)$. Located finding in §7; it is the single thing in this essay I would
most want ratified or rejected.

---

## 1. Where round 1 left it

[Round 1](wirohsh-splats.md) §2 answered the question three ways: (a) harmonic functions are
automatically real-analytic, so the *rotated* picture has no non-smooth solutions to lose; (b) the
loss happens at the un-rotation, and the repair is a two-sided boundary value; (c) no annulus
contains the real line, so the representation is domain-bound. This essay does (b) and (c)
properly. (a) is left standing and is used below as the thing that *forces* the boundary-value move.

---

## 2. The owner's pair versus Sato's pair, stated exactly

A hyperfunction on $\mathbb R$ is, by definition, a class $[F]$ with $F$ holomorphic on
$U\setminus\mathbb R$ for some open $U\supset\mathbb R$, read as
$f(x)=F(x+i0)-F(x-i0)$, modulo functions holomorphic on all of $U$.

The owner has $f(x,y)=f^+(z)+f^-(\bar z)$, $z=x+iy$, with $f^+$ holomorphic in $z$ and $f^-$
holomorphic in its own argument. **Restrict to $y>0$.** Then $z$ ranges over $U^+ := U\cap\{y>0\}$
and $\bar z$ ranges over the mirror $U^-=\overline{U^+}\subset\{y<0\}$. Define one function on
$U\setminus\mathbb R$:

$$ F(w) := \begin{cases} f^+(w), & w\in U^+\\ -\,f^-(w), & w\in U^-\end{cases} $$

$F$ is holomorphic on $U\setminus\mathbb R$, and

$$ F(x+i0)-F(x-i0) \;=\; f^+(x+i0)+f^-(x-i0) \;=\; \lim_{y\to 0^+} f(x,y). $$

So the owner's Euclidean field, read as a boundary value from above, **is** the Sato hyperfunction
with defining function $F$. That is the correspondence, and it is tight. Three things could look
like a mismatch; two are cosmetic and one is real.

- *Cosmetic 1, sign.* Sato takes a difference, the owner a sum. Absorbed by the minus on the lower
  branch above.
- *Cosmetic 2, "same plane" versus "two planes".* The owner's $f^+$ and $f^-$ are evaluated at
  conjugate points of one plane; Sato's two pieces live on disjoint domains and are approached from
  opposite sides of one real line. These agree because for $y>0$ the map $z\mapsto\bar z$ is a
  bijection $U^+\to U^-$, and both limits land on the same $x$ as $y\to0^+$.
- **Real, and it is the answer to the question.** As the owner *derives* it, $f^\pm$ are Laurent
  series converging on a common annulus $r_1<|z|<r_2$ with $r_1<1<r_2$, which **straddles** the unit
  circle. A function holomorphic on such an annulus extends holomorphically *across* the shell, so
  $F$ extends across, so the hyperfunction class is **zero**. A straddling annulus is exactly what
  kills all non-analytic content. The general hyperfunction is recovered by weakening one
  hypothesis and only one: require each half to converge only *up to* the shell,
  $\sum_{m\ge0}f_m^+z^m$ on $|z|<1$ and $\sum_{m<0}f_m^-\bar z^{\,m}$ on $|\bar z|>1$, with no
  common annulus. That is a genuine change of hypothesis, and it costs nothing else: the index set
  is still $m\in\mathbb Z$.

One more difference, which I flag rather than assert as a finding. On the Euclidean side, demanding
$f$ real forces $f_m^-=\overline{f_m^+}$, so a real harmonic function is *one* holomorphic function.
After the un-rotation $z=x-ct$, $\bar z=x+ct$ are two independent **real** null coordinates, and
$f^+$, $f^-$ are two independent real profiles with no relation. The real-parameter count matches
(two reals per $m\in\mathbb Z$ either way), but the constraint *pattern* is different: a reality
condition linking the two families becomes two separate reality conditions, one per family.

---

## 3. The delta, concretely

### 3.1 Sokhotski-Plemelj at finite regulator

Before any limit, for real $x$ and $\varepsilon\neq0$:

$$ \frac{1}{x-i\varepsilon}-\frac{1}{x+i\varepsilon} \;=\; \frac{2i\varepsilon}{x^2+\varepsilon^2} \veq{sp-finite}\lean $$

so the standard combination is manifestly the Poisson kernel:

$$ -\frac{1}{2\pi i}\left[\frac{1}{x+i\varepsilon}-\frac{1}{x-i\varepsilon}\right] \;=\; \frac1\pi\,\frac{\varepsilon}{x^2+\varepsilon^2} \;=:\; P_\varepsilon(x) \veq{delta-boundary}\lean $$

$P_\varepsilon\ge0$ and $\int_{\mathbb R}P_\varepsilon\,dx=1$ for every $\varepsilon>0$:

$$ \int_{-\infty}^{\infty}\frac1\pi\,\frac{\varepsilon}{x^2+\varepsilon^2}\,dx = 1 \veq{poisson-mass}\lean $$

so the family is a probability density for every $\varepsilon$ and the $\varepsilon\to0^+$ limit
cannot be anything but $\delta$. Numerically, against $g(u)=\cos 3u\,e^{-u^2/4}$ with $g(0)=1$:
$\varepsilon=10^{-1}\to0.74267$, $10^{-2}\to0.97047$, $10^{-3}\to0.99700$, $10^{-4}\to0.99970$,
the error going as $O(\varepsilon)$ as it must for a Lorentzian tail. The defining function is
$F(w)=-1/(2\pi i w)$, holomorphic on $\mathbb C\setminus\{0\}$: **the delta is the boundary value of
a single Laurent monomial**, the $m=-1$ term of the owner's own series.

### 3.2 The Heaviside step is the boundary value of a logarithm

Take $F(w)=-\dfrac{1}{2\pi i}\log(-w)$, principal branch, holomorphic on $\mathbb C\setminus[0,\infty)$.
Then

$$ F(x+i0)-F(x-i0) = -\frac{1}{2\pi i}\Big[\big(\log|x|-i\pi\big)-\big(\log|x|+i\pi\big)\Big] = 1 \quad (x>0), $$

and $0$ for $x<0$, because for $x<0$ both arguments approach the positive real axis where $\log$ is
continuous. Numerically at $\varepsilon=10^{-9}$: $x=-2\to0.000000$, $x=-0.3\to0.000000$,
$x=0.4\to1.000000$, $x=3\to1.000000$, imaginary parts below $10^{-20}$. So
$\theta(x)=F(x+i0)-F(x-i0)$, and $F'(w)=-\frac{1}{2\pi i}\frac1w$ is exactly the delta's defining
function of §3.1. The derivative relation $\theta'=\delta$ holds **at the level of defining
functions**, before any distributional pairing. That is the structural payoff of the hyperfunction
picture and it is worth putting in the draft.

### 3.3 The Poisson kernel *is* the Abel-summed Laurent series

On the shell, where the owner's $m$ comes from, this closes the loop. With $w=e^{i\varphi}$ and
$0\le r<1$,

$$ \sum_{m\ge0}r^m w^m \;+\; \sum_{m\ge1}r^m w^{-m} \;=\; \frac{1}{1-rw}+\frac{rw^{-1}}{1-rw^{-1}} \;=\; \frac{1-r^2}{1-2r\cos\varphi+r^2} \veq{abel-poisson}\lean $$

which is the Poisson kernel on the disc, with $\frac{1}{2\pi}\int_{-\pi}^{\pi}$ of it equal to $1$
(SymPy, exact, at $r=\tfrac12$), and $\to2\pi\delta(\varphi)$ as $r\to1^-$. Checked numerically
against the two geometric sums at $r=0.6$, $\varphi\in\{0.3,1.1,2.7\}$: residual $<3\cdot10^{-16}$.

Read the left-hand side: it is **the owner's own $f^+(z)+f^-(\bar z)$**, with
$f_m^+=f_m^-=1$ for all $m$ and $|z|=r<1$, $|\bar z|=r<1$. The periodic delta is the Laurent series
all of whose coefficients are $1$. It has no annulus of convergence containing the shell, so it is
not a function on the shell. It is the $r\to1^-$ boundary value, and the boundary value exists.

---

## 4. The Riemann problem in his notation

Given $f(x,0)=\varphi(x)$ and $\partial_t f(x,0)=\psi(x)$, put $\Psi'=\psi$. From
$f=f^+(x-ct)+f^-(x+ct)$,

$$ f^+(x)+f^-(x)=\varphi(x), \qquad c\big[(f^-)'-(f^+)'\big](x)=\psi(x), $$

so $f^--f^+=\Psi/c+K$ for one constant $K$, giving

$$ f^\pm(s) \;=\; \tfrac12\varphi(s) \mp \tfrac{1}{2c}\Psi(s) \mp \tfrac{K}{2} \veq{riemann-split}\lean $$

and, summing, d'Alembert's formula
$f(x,t)=\tfrac12[\varphi(x-ct)+\varphi(x+ct)]+\tfrac{1}{2c}\int_{x-ct}^{x+ct}\psi$. Verified in
SymPy: $f(x,0)-\varphi(x)=0$, $\partial_tf(x,0)=\psi(x)$, and
$\partial_x^2f-c^{-2}\partial_t^2f=0$ identically, with $K$ symbolic throughout.

**The constant is the only genuine non-uniqueness.** If two splits give the same field,
$g_1(x-ct)+h_1(x+ct)=g_2(x-ct)+h_2(x+ct)$ for all $(x,t)$, then $g_1-g_2$ is constant:

$$ g_1(s)-g_2(s)=g_1(0)-g_2(0)\quad\text{for all }s \veq{split-unique}\lean $$

The proof is one line and it is the whole geometric content: for $c\neq0$ the map
$(x,t)\mapsto(x-ct,\,x+ct)$ is onto $\mathbb R^2$, so the two light-cone coordinates are
**independent**, and $g(\xi)+h(\eta)=0$ for all $(\xi,\eta)$ forces both constant. It is also
exactly the hyperfunction "modulo holomorphic on $U$" ambiguity of §2, cut down to what survives on
the real slice.

**What discontinuous data does to each piece.**

| data | $f^+$ and $f^-$ | what propagates |
|---|---|---|
| $\varphi$ has a jump $[\varphi]$ at $x_0$, $\psi=0$ | each gets a jump $\tfrac12[\varphi]$ at $x_0$ | two half-jumps, one each way, amplitude conserved |
| $\psi$ has a jump, $\varphi$ smooth | $\Psi$ is $C^0$ with a corner, so $f^\pm$ are $C^0$, not $C^1$ | two propagating **kinks**, opposite in sign |
| $\psi=\delta_{x_0}$ | $\Psi=\theta$, so $f^\pm$ jump by $\mp\tfrac{1}{2c}$ | a plateau of height $1/c$ opening between the characteristics |

**Where the smooth and non-smooth cases genuinely differ.** For $\varphi\in C^2$, $\psi\in C^1$ the
d'Alembert formula is a classical solution and every derivative in the equation exists pointwise.
For jump data none of the second derivatives exist at the jump, and the equation holds only in the
weak sense, $\int\!\!\int f\,(\partial_x^2-c^{-2}\partial_t^2)\chi = 0$ for test $\chi$. That is a
real difference, but it is *not* the difference the Laurent construction cares about. §7 is.

---

## 5. The square pulse: a jump travels undistorted

Take $\varphi=\mathbf 1_{[-a,a]}$, $\psi=0$. Along the right-going characteristic $X=x+ct$,

$$ \tfrac12\varphi(X-ct)+\tfrac12\varphi(X+ct) \;=\; \tfrac12\varphi(x)+\tfrac12\varphi(x+2ct) \veq{pulse-undistorted}\lean $$

for **every** $t$, with no hypothesis on $\varphi$ at all: not continuity, not measurability. The
right-moving half is rigid. Once $ct>2a$ the two half-pulses are disjoint and each has height
exactly $\tfrac12$; the jump amplitude $1$ has become two jumps of $\tfrac12$ and neither has been
smoothed by a single $\varepsilon$. Contrast the heat equation, whose solution is real-analytic for
every $t>0$: it destroys the jump immediately. **Hyperbolic propagation preserves exactly the
structure that the Laurent picture has to work to represent.**

Its Laurent coefficients, on the shell of half-width $\alpha$ (SymPy, exact):

$$ c_m=\frac{\sin(m\alpha)}{\pi m}\ (m\neq0),\qquad c_0=\frac{\alpha}{\pi}. $$

These decay like $1/m$ and no faster, so $\limsup|c_m|^{1/m}=1$: measured at $\alpha=\tfrac12$,
$|c_m|^{1/m}=0.7054$ at $m=10$, $0.9316$ at $m=100$, $0.9912$ at $m=10^3$, $0.99896$ at $m=10^4$.
The inner series converges exactly on $|z|<1$, the outer exactly on $|\bar z|>1$, **and there is no
common annulus.** The square pulse lives precisely at the boundary the owner's derivation assumed
away.

---

## 6. The convergence geometry, drawn

On the physical slice $z=x-ct$ is *real*, so an annulus $r_1<|z|<r_2$ is the condition
$r_1<|x-ct|<r_2$: a pair of bands in the $(x,t)$ plane, parallel to the right-going characteristics,
symmetric about $x=ct$.

```
    t ^     z=-r2    z=-r1        z=0       z=+r1    z=+r2
      |       \        \           \          \        \
      |        \  ok    \  EXCLUDED \   ok     \        \
      |  out    \ (band) \  (hole)   \ (band)   \  out   \
   ---+----------\--------\-----------\----------\--------\---> x
      |    \      \        \           \          \        \
      |     \      \        \           \          \        \
              |z|>r2        the characteristic x = ct        |z|>r2
```

The hole $|z|<r_1$ is a **band around the characteristic through the origin**, not a point, and the
outer cutoff is another pair of bands. $f^-$ contributes the mirror-image picture tilted the other
way, so the region where both series converge is the intersection: a parallelogram, or rather a
periodic lattice of them, bounded by four characteristics.

**A jump sitting on a characteristic is exactly what the expansion cannot reach**, because the jump
of $f^+$ sits at a fixed value of $z$ and the annulus is an annulus in $z$. This is geometric, not
analytic: it does not go away by taking more terms. Re-centring the Laurent expansion at $z_0$ moves
the hole, so *any single jump can be placed inside the hole* and then the series converges on a
genuine annulus around it. What cannot be done is to have the jump on the shell itself, and that is
§2's straddling-annulus obstruction seen in the $(x,t)$ plane. Several jumps at different $z$
require several charts, which is the Čech-cover repair round 1 §3 pointed at.

---

## 7. Surfaced for the owner

Located, evidenced, not edited. The owner decides every resolution.

### 7.1 `physics/wirohsh.md:82`, "In smooth regions those are perfectly sufficient"

**This is false as stated, and the correct statement is sharper and more interesting.** The
criterion for "is the restriction of a holomorphic function" is **real-analyticity**, not
smoothness, and the two differ on the most physically ordinary object there is.

Counterexample: $\rho(x)=e^{-1/(1-x^2)}$ for $|x|<1$, zero otherwise. It is $C^\infty$ on all of
$\mathbb R$. It is not real-analytic at $x=\pm1$, and it cannot be: a nonzero function holomorphic
on a connected open set containing an interval on which it vanishes is identically zero (identity
theorem), so **no** nonzero holomorphic function has compact support. A compactly supported bump is
therefore on the *same* side of the dividing line as a shock. Meanwhile $1/(1+x^2)$ is on the
*other* side despite also being merely smooth: it extends holomorphically to the strip
$|\mathrm{Im}\,z|<1$ (poles at $\pm i$).

$$ \text{smooth} \;\not\Rightarrow\; \text{boundary value of a locally holomorphic function} \veq{smooth-not-analytic}\sorry $$

(Badge `\sorry`: classical, certain, but *not* machine-checked in this repo. It is a good `\lean`
candidate; Mathlib has the identity theorem.)

The regularity is read off the coefficient growth, and this is the version I would put in the draft,
because it keeps the discrete index the whole way down:

| initial data on the shell | $|f_m|$ behaviour | Laurent domain |
|---|---|---|
| real-analytic | $\lesssim\rho^{|m|}$, some $\rho<1$ | genuine annulus $\rho<|z|<1/\rho$ |
| $C^\infty$ | faster than any polynomial, slower than any exponential | radius exactly $1$, **no annulus** |
| distribution | polynomially bounded | radius exactly $1$ |
| hyperfunction | infra-exponential, $|f_m|\le C_\epsilon e^{\epsilon|m|}$ | radius exactly $1$ |
| nothing | genuinely exponential growth | no boundary value |

Measured $|c_m|^{1/m}$, three profiles on the shell:

| profile | $m=10$ | $m=20$ | $m=40$ | $m=80$ | $m=160$ |
|---|---|---|---|---|---|
| Poisson kernel $P_{r=1/2}$ (real-analytic) | 0.5000 | 0.5000 | 0.5000 | 0.5000 | 0.5000 (exact) |
| $C^\infty$ bump | 0.5454 | 0.6274 | 0.7635 | 0.8444 | 0.8827 |
| square pulse (distribution) | 0.7048 | 0.7922 | 0.8852 | 0.9266 | 0.9617 |

The criterion being measured, and the one I would state in the draft:

$$ \limsup_{|m|\to\infty}\big|f_m\big|^{1/|m|}=1 \iff \text{the profile is nowhere the restriction of a locally holomorphic function} \veq{coeff-ladder}\numeric $$

The Poisson row is exactly $r^{|m|}=2^{-|m|}$ by construction; the
quadrature reproduces $0.5$ to the precision floor and then loses it at $m=160$ where
$|c_m|\sim10^{-49}$, so that entry is quoted from the closed form, not the quadrature. The bump and
pulse rows both climb toward $1$, confirming radius of convergence exactly $1$ in both cases: the
bump is on the *non*-analytic side, exactly as the identity theorem says. The bump climbs more
slowly, which is the $C^\infty$-versus-distribution distinction showing up as a *rate*, not as a
yes/no. For the standard bump the fitted decay is close to $e^{-c\sqrt m}$: $-\log|c_m|/\sqrt m$
stays in $1.3$ to $2.1$ over $m\in[5,320]$ while $-\log|c_m|/m$ falls monotonically
$2.06\to0.073$, i.e. sub-exponential.

*A sibling agent in this same session is writing the approximation-theory essay and will also touch
compact support. The systematic treatment is theirs; this is only the initial-data angle.*

### 7.2 A suggested one-sentence replacement, for the owner to accept, edit, or reject

Not an edit. A candidate, offered for his judgement:

**The line is analytic versus not, and a smooth bump is on the shock's side; non-analytic data
returns as a boundary value, at the price of a common annulus.**

> While this solution is valid for any function, even discontinuous ones, the detour through the
> discrete Laurent series imposed holomorphy on the two waves. The dividing line is not smooth
> versus discontinuous but **analytic versus non-analytic**: a $C^\infty$ bump of compact support is
> already outside. Non-analytic data is recovered by reading $f^\pm$ as a *boundary value* rather
> than a convergent sum, at the price of giving up a common annulus; the discrete index survives,
> and the regularity is encoded in the growth of $f_m^\pm$.

### 7.3 Two smaller notation points

- `physics/wirohsh.md:78` sets $z=x-ct$ and $\bar z=x+ct$, but §1 defined $z=x+iy$ with $y=\tau$ the
  Wick-rotated time. Following `(Wick)` at l.38, $ct=i\tau$ gives $z=x+iy=x-i^2 ct=x+ct$, i.e. the
  opposite labelling. Nothing downstream depends on it (the two are symmetric), but the sign should
  be fixed once and stated, because §2 above shows the labelling decides which half-plane carries
  which mover.
- The notation $f^\pm$ is used both for the mover and for the coefficient family $f_m^\pm$ at l.70,
  where $\pm$ means the *radial* solution $r^{\pm m}$. At l.74 the same $\pm$ silently becomes the
  $z$ versus $\bar z$ split. They coincide only after the reordering noted at l.70; worth a
  half-sentence.

---

## 8. Follow-up leads

1. **Make the coefficient ladder a theorem, not a table.** Prove that $\limsup|f_m|^{1/|m|}=1$ for
   every compactly supported $C^\infty$ profile. Decidable: it follows from the identity theorem
   plus Cauchy-Hadamard, and Mathlib has both, so this is a `\lean` item, not a research question.
2. **Does the discrete index survive the un-rotation for genuinely distributional data?** The shell
   picture (§3.3) keeps $m\in\mathbb Z$; the line picture (§6) loses it to a continuum. Decidable by
   asking whether a compactly supported initial pulse on $\mathbb R$ has a *periodised* representation
   whose truncation error is controlled by the same $(N+1)$ geometric bound round 1 §2(d) quotes.
3. **The reality-condition asymmetry of §2.** Euclidean reality couples $f^+$ to $f^-$; Lorentzian
   reality is two separate conditions. Decidable by writing the map between the two coefficient
   sets explicitly and checking that the involution $m\mapsto-m$ composed with conjugation goes to
   the exchange of the two movers.
4. **The multi-jump case needs a cover.** Two jumps at different $z$ cannot both sit in one hole.
   Decidable by constructing the two-chart Čech cocycle for $\varphi=\mathbf 1_{[-a,a]}$ explicitly
   and checking that its class is nonzero, which would make round 1's twistor remark concrete rather
   than an analogy.
5. **Which $\varepsilon$ is physical?** The Poisson regulator $P_\varepsilon$ is a genuine
   one-parameter family of *exact* wave solutions with analytic data, converging to the shock.
   Decidable whether $\varepsilon$ can be given a physical meaning (a dispersion length, a
   detector resolution) by checking whether the WiRoHSH coefficient truncation at degree $N$ is
   equivalent to a particular $\varepsilon(N)$; if $\varepsilon\sim1/N$ the two regularisations are
   the same object and the draft gains a physical interpretation of truncation.

---

## Lean attestation

The `\lean`-badged claims are proved in
[`docs/dreamed/lean/WirohshDiscont.lean`](lean/WirohshDiscont.lean), namespace `WirohshDiscont`.
Round 1's `dalembert_wave` (that $g(x-ct)+h(x+ct)$ *solves* the wave equation) is **not** reproved
and nothing is imported from `Wirohsh.lean`; this file is the initial-data half.

| handle | theorem(s) | content |
|---|---|---|
| `sp-finite` | `sokhotski_plemelj_finite` | $1/(x-i\varepsilon)-1/(x+i\varepsilon)=2i\varepsilon/(x^2+\varepsilon^2)$ in $\mathbb C$, with `add_I_mul_ne_zero`, `sub_I_mul_ne_zero` |
| `delta-boundary` | `poisson_from_boundary_jump` | the $-1/(2\pi i)$ combination equals the real Poisson kernel |
| `poisson-mass` | `poisson_nonneg`, `poisson_integral_one` | $P_\varepsilon\ge0$ and $\int_{\mathbb R}P_\varepsilon=1$, via `integral_univ_inv_one_add_sq` and `Measure.integral_comp_div` |
| `abel-poisson` | `poisson_partial_fraction`, `poisson_denominator` | the two closed geometric sums combine to $(1-r^2)/(1-2r\cos\varphi+r^2)$, using $w+w^{-1}=2\cos\varphi$ |
| `riemann-split` | `dalembert_initial_position`, `dalembert_time_deriv`, `dalembert_initial_velocity` | the forced split reproduces $\varphi$ and $\psi$, derivatives as `HasDerivAt` witnesses |
| `split-unique` | `split_ambiguity_is_constant`, `split_unique_up_to_constant` | the split is unique up to one additive constant |
| `pulse-undistorted` | `right_mover_undistorted`, `square_pulse_separates` | the right-mover is rigid for arbitrary $\varphi$; a square pulse separates into two half-height pulses |

Checked with:

```
cd /home/tobias/src/toesnail/verify
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/WirohshDiscont.lean
```

**Exit status 0**, zero `sorry`, zero warnings.

**What was weakened, stated plainly.**

- **No limits are taken in Lean.** `sp-finite`, `delta-boundary` and `abel-poisson` are the
  *finite-$\varepsilon$* and *finite-$r$* algebra. That $P_\varepsilon\to\delta$ and that the Abel
  sum converges to the periodic delta are **not** proved; `poisson-mass` is the closest the file
  gets, and it is only the normalisation that makes the limit forced.
- **`abel-poisson` does not prove the geometric series sums.** `poisson_partial_fraction` proves the
  numerator identity and `poisson_denominator` the denominator identity, both division-free. That
  $\sum_m r^mw^m=1/(1-rw)$ for $|r|<1$ is standard (`tsum_geometric_of_norm_lt_one`) and is asserted,
  not proved here.
- **`pulse-undistorted` says nothing about weak solutions.** That the discontinuous $f$ solves the
  wave equation *distributionally* is not formalised. `right_mover_undistorted` proves the rigidity
  of the profile, which is the sharp statement, but it is a statement about the *formula*, not about
  the *equation*.
- **`smooth-not-analytic` (§7.1) carries `\sorry`.** The identity theorem argument is classical and
  certain; it is simply not machine-checked here. Lead 1 above is the escalation path.
- The `\numeric` badge on `coeff-ladder` is a **finite sample** (three profiles, five values of $m$),
  and one cell of it is quoted from the closed form rather than the quadrature, as noted there.
- Per `docs/dreamed/README.md`, every badge in this file attests the dreamed Lean file and the runs
  recorded here only. None is wired into `physics/*.toml` or `tests/test_verify.sh`.

## `.mw` sketch

```computation
poisson = 1/pi * epsilon/(x**2 + epsilon**2)
```

```computation
sokhotski = 1/(x - I*epsilon) - 1/(x + I*epsilon) - 2*I*epsilon/(x**2 + epsilon**2)
```

```computation
poisson_mass = Integral(poisson, (x, -oo, oo))
```

```computation
abel_sum = 1/(1 - r*exp(I*varphi)) + (r*exp(-I*varphi))/(1 - r*exp(-I*varphi))
```

```computation
fplus = phi(s)/2 - Psi(s)/(2*c) - K/2
```

```computation
fminus = phi(s)/2 + Psi(s)/(2*c) + K/2
```

```computation
dalembert = fplus.subs(s, x - c*t) + fminus.subs(s, x + c*t)
```

```computation
wave_residual = diff(dalembert, x, 2) - diff(dalembert, t, 2)/c**2
```

The DAG edges that matter: `poisson` feeds both `sokhotski` and `poisson_mass`, so changing the
regulator convention (say $\varepsilon\to\varepsilon/2$, or the sign of the $i\varepsilon$
prescription) must mark both stale. And `dalembert` depends on **both** `fplus` and `fminus`, so the
split constant `K` is a single node whose edit invalidates the whole initial-data chain: exactly the
non-uniqueness of §4, made mechanical. That is the `stale_after_edit` property the HARD-tier commit
hook already exercises on the Resogram mirror.

## Sources consulted

- [Hyperfunction (Wikipedia)](https://en.wikipedia.org/wiki/Hyperfunction)
- [Sokhotski-Plemelj theorem (Wikipedia)](https://en.wikipedia.org/wiki/Sokhotski%E2%80%93Plemelj_theorem)
- [Poisson kernel (Wikipedia)](https://en.wikipedia.org/wiki/Poisson_kernel)
- [Analytic function: real-analytic and compact support (Wikipedia)](https://en.wikipedia.org/wiki/Analytic_function)
- [Riemann problem (Wikipedia)](https://en.wikipedia.org/wiki/Riemann_problem)
- Round 1 of this session: [`wirohsh-splats.md`](wirohsh-splats.md)

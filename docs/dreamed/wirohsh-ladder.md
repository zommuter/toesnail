---
title: The WiRoHSH ladder, its two floors, and whether that is Huygens
permalink: /dreamed/wirohsh-ladder
---

# The `d -> d-2` ladder: where it bottoms out, and whether its parity is Huygens' principle

> **DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](./). AI-written, 2026-09-01, from an
> owner-picked seed: the sentence in `physics/wirohsh.md:110`, *"the Laplace equation can be solved
> as the superposition of solutions two dimensions lower!"*. It **proposes**; the owner disposes.
> Nothing here is a decision, and nothing may be promoted into `physics/` without the owner
> authoring the move.
>
> *Process note:* this essay was written **after** its Lean half. The agent that produced
> `lean/WirohshLadder.lean` was interrupted before writing any prose, so the formal file came first
> and this text was written to match it. Where its doc-comments overclaim relative to what its
> theorems say, §6 says so.

Round 1 is [`wirohsh-splats.md`](wirohsh-splats.md) and is not repeated. Siblings leaned on rather
than duplicated: [`wirohsh-approximation.md`](wirohsh-approximation.md) (what the basis can and
cannot represent), [`wirohsh-discontinuities.md`](wirohsh-discontinuities.md) (hyperfunctions,
boundary values), [`wirohsh-refraction.md`](wirohsh-refraction.md).

---

## 0. Headline

Three verdicts, each argued below and none of them decided.

1. **The ladder's parity is not Huygens' principle.** They share one `mod 2` and nothing else. The
   separator is `d = 1`: the ladder calls `d = 1` its *best* floor (transverse Laplacian
   zero-dimensional, profile completely arbitrary), while Huygens **fails** at `d = 1`, because
   d'Alembert's initial-velocity term integrates over the whole interval and leaves a tail. Huygens
   is sharp for odd `d >= 3` only. Every "odd `d` is the good case" reading true for the ladder is
   false for Huygens at exactly one dimension, and it is the dimension the ladder is proudest of.
2. **The owner's `d -> d-2` is not the classical radial ladder**, though that ladder is real and I
   verified it: `(1/r) d_r` intertwines the radial wave operator in `d` dimensions with the one in
   `d+2`, symbolically, for general `d`. The classical ladder is a local differential operator going
   **up**, closed on radial solutions, adding no parameters. The owner's is a nonlocal integral
   transform going **down**, defined on all solutions, adding `d-2` continuous direction parameters
   plus one function's worth of gauge. Same parity, opposite arrow, opposite type. The Gegenbauer
   relation the Lean file proves sits on the classical side, not the owner's.
3. **Descending two dimensions buys nothing computationally, on a degrees-of-freedom count.** The
   transform's data is a function of `d` real variables where the target needs `d-1`, so each rung is
   overdetermined by exactly one variable's worth: round 1's redundant `b_phi` family, seen from the
   counting side. Worse for the programme's own aim, the `phi`-integral reintroduces a **continuous**
   parameter, which is the disease (`physics/wirohsh.md:30`, "a continuous variable has to be
   considered") the Wick rotation was invented to cure. What pays is not the descent but the Fourier
   relabelling of the direction circle from round 1 §1.5. Two separate steps, currently sold as one.

---

## 1. Where the ladder bottoms out

The step is fixed by the owner's own derivation: a `d`-dimensional wave solution is superposed over
directions `e` from profiles obeying the `(d-1)`-dimensional **Laplace** equation transverse to `e`
(`physics/wirohsh.md:104`), and Wick-rotating that Laplace equation back turns it into the
`(d-2)`-dimensional wave equation. A step-2 recursion on the positive integers has exactly two orbits.

$$ \mathrm{bottom}(d) = \begin{cases} 1 & d \text{ odd} \\ 2 & d \text{ even}\end{cases}, \qquad \mathrm{bottom}(d+2) = \mathrm{bottom}(d), \qquad d = 2k + \mathrm{bottom}(d) \veq{ladder-parity}\lean $$

The two floors are **qualitatively different conditions**, and the draft already computes both
without naming them as a pair.

- **Odd `d`, floor `d = 1`.** The transverse Laplacian is zero-dimensional. There is no equation.
  The profile is *arbitrary*, which is `physics/wirohsh.md:133` verbatim: "any `f_e` is acceptable".
- **Even `d`, floor `d = 2`.** The transverse Laplacian is one-dimensional, `d_{\bar\phi}^2 f = 0`,
  so the profile is *linear* in the transverse coordinate. That is
  `f_\phi = a_\phi(x_\phi) + b_\phi(x_\phi) x_{\bar\phi}` at `physics/wirohsh.md:161`, and its second
  term is exactly the family [round 1](wirohsh-splats.md) showed is redundant under the `phi`
  integral.

So the even floor carries a genuine constraint and a genuine redundancy; the odd floor carries
neither. The ladder does not *fail* in either parity. It terminates, on different terms.

---

## 2. Is that parity Huygens' principle?

**Recommendation: no, and the confusion is worth heading off explicitly in the draft.**

Sharp Huygens says a signal from a point source arrives and is then *gone*: the fundamental solution
is supported on the light cone, not in it. For the flat wave equation this holds in odd spatial
dimensions `d >= 3` and fails in even ones, where the fundamental solution fills the solid cone and
leaves a decaying tail. Three arguments that the two parities are different facts agreeing on a
residue class.

**(a) They disagree at `d = 1`.** d'Alembert's formula is

$$ u(x,t) = \tfrac12\big[u_0(x-ct)+u_0(x+ct)\big] + \tfrac1{2c}\int_{x-ct}^{x+ct} v_0(s)\,ds $$

and the second term depends on the *whole* interval, not its endpoints: a point of initial velocity
is heard forever. So `d = 1` is odd and **not** Huygens, and the standard statement carries it as an
explicit exception. The ladder's odd floor is `d = 1` and it regards it as the ideal case. One parity
statement's best case is the other's counterexample; that alone forbids identifying them.

**(b) The parity-breaking operator is descent, and the ladder never applies it.** Hadamard's method
of descent steps `d -> d-1`: regard a `d`-dimensional solution constant in one coordinate as a
`(d-1)`-dimensional one. That is exactly how the 2D Poisson formula, tail and all, is produced from
3D Kirchhoff, and the tail is *manufactured by the descent*, by integrating the sphere average over
a coordinate. Descent changes the parity class and therefore changes the Huygens verdict; the owner's
ladder steps by two and is precisely the operator that **cannot**. Saying "both have a parity"
describes a `Z/2` that one operator preserves and another flips. The honest phrasing is that the
ladder and descent generate the same `Z/2` between them.

**(c) The parities have different stability.** The ladder's parity is arithmetic, `d mod 2` for an
integer `d`, immune to anything added to the operator. Huygens is a support property of a
distribution and is fragile: Klein-Gordon in `d = 3` has a tail, so a mass term destroys sharp
Huygens without moving `d` at all. A property that survives a mass term and one that does not are
not the same property.

What *is* true and worth the draft saying: both descend from the `d`-dependence of the radial wave
operator's first-order coefficient `(d-1)/r`, which is why a 2-shift is natural on both sides. A
shared cause, not a shared statement.

---

## 3. The `d = 3` rung, explicitly, and the two neighbours

### 3.1 `d = 3` is 1D in disguise

$$ u(r,t) = \frac{f(r-ct)}{r} \qquad\Longrightarrow\qquad u_{rr} + \frac{2}{r}u_r - \frac{1}{c^2}u_{tt} = 0 \quad (r \neq 0) \veq{radial-3d}\lean $$

SymPy returns the residual as **exactly `0`** for an unspecified twice-differentiable `f`. Lean proves
the same with `HasDerivAt` witnesses for every derivative and `r != 0`, `c != 0` named
(`radial3_dalembert`), and isolates why it works: `v = ru` obeys the 1D equation because in
`u_rr + (2/r)u_r` the `1/r^2` and `1/r^3` terms cancel identically (`radial3_reduction`). The profile
`f` is arbitrary: the `d = 1` floor of §1, reached in one step.

### 3.2 One rung up: `(1/r) d_r` generates `d = 5`

The classical ladder, verified symbolically and for **general symbolic `d`**, not just for the case
at hand:

$$ \Big(\tfrac1r\partial_r\Big)\Big[\partial_r^2 + \tfrac{d-1}{r}\partial_r\Big] = \Big[\partial_r^2 + \tfrac{d+1}{r}\partial_r\Big]\Big(\tfrac1r\partial_r\Big) \veq{radial-intertwiner}\sympy $$

SymPy simplifies the difference of the two sides applied to an arbitrary `g(r)` to `0`. Applying it,

$$ u_5 = \frac1r\partial_r\frac{f(r-ct)}{r} = \frac{r f'(r-ct) - f(r-ct)}{r^3} $$

has residual exactly `0` against `u_{rr} + (4/r)u_r - c^{-2}u_{tt}`, and one more application gives
`d = 7`, also exactly `0`. This is a real ladder, it is a differential operator, and it goes **up**.

### 3.3 `d = 2` admits no such profile at all

Ask whether *any* power `a` makes `u = f(r-ct)/r^a` solve the 2D radial wave equation. SymPy returns

$$ r^{a+2}\Big[u_{rr} + \tfrac1r u_r - \tfrac1{c^2}u_{tt}\Big] = a^2 f(r-ct) + (1-2a)\,r\,f'(r-ct) \veq{no-2d-profile}\sympy $$

For this to vanish for arbitrary `f`, both coefficients must vanish: `a^2 = 0` forces `a = 0` and
`1 - 2a = 0` forces `a = 1/2`. No `a` does both, so **no algebraic prefactor turns 2D radial
propagation into a travelling profile**. The genuine 2D solution needs the Poisson kernel

$$ u(\vec x,t) \sim \frac{1}{2\pi c}\int_{|\vec y - \vec x| < ct} \frac{v_0(\vec y)}{\sqrt{c^2t^2 - |\vec y - \vec x|^2}}\,d^2y $$

integrated over the whole past **disc**, not its boundary circle. That integral is the tail, and
`no-2d-profile` is its algebraic fingerprint at the level of a single formula.

---

## 4. The counting side

### 4.1 The dimensions themselves

Degree-`n` hyperspherical harmonics in `D` ambient dimensions have

$$ N(D,n) = \binom{n+D-1}{D-1} - \binom{n+D-3}{D-1} \veq{harm-dim}\lean $$

Verified three independent ways, agreeing in every cell: the difference formula, the Lean file's
subtraction-free Pascal form `C(n+k,k) + C(n+k-1,k)` with `k = D-2`, and a **direct** count (general
homogeneous degree-`n` polynomial in `D` variables, impose `Delta P = 0`, take the nullity).

| `D` | `n=0` | `n=1` | `n=2` | `n=3` | `n=4` |
|---|---|---|---|---|---|
| 2 | 1 | 2 | 2 | 2 | 2 |
| 3 | 1 | 3 | 5 | 7 | 9 |
| 4 | 1 | 4 | 9 | 16 | 25 |
| 5 | 1 | 5 | 14 | 30 | 55 |
| 6 | 1 | 6 | 20 | 50 | 105 |

Row `D = 3` is the familiar `2n+1`; row `D = 2` is `1, 2, 2, 2, ...` (the pair `e^{\pm in\varphi}`),
which is the owner's `m in Z` from `physics/wirohsh.md:62`; row `D = 4` is `(n+1)^2`.

One caveat the difference formula hides and the Lean file is right about: at `D = 2, n = 0` the
difference form gives `2` under any convention reading `binom(-1,1)` as the polynomial `-1`, where the
answer is `1`. Lean avoids this by *defining* `Nharm` in Pascal form and proving the difference form
only from `n = 2` upward (`Nharm_diff`). A genuine edge case, not pedantry: if the owner writes the
difference formula down, the convention `binom(m,k) = 0` for `m < k` has to travel with it.

### 4.2 What one rung does to the count

$$ \sum_{m=0}^{n} N(D-1, m) \;=\; N(D,n) \veq{ladder-count}\lean $$

Confirmed for `D = 3..7`, `n = 0..6`, and proved in Lean by induction with Pascal's rule twice
(`Nharm_branching`). This is the classical branching rule, and it is the exact bookkeeping of the
owner's direction integral: the direction sphere is `S^{D-2}`, its degree-`m` harmonics number
`N(D-1,m)`, round 1 §1.5 showed the transform annihilates every `m > n`, and the survivors `m = 0..n`
sum to precisely the ambient `N(D,n)`. Nothing lost, nothing double-counted.

**Note which dimension that is a statement about.** `ladder-count` steps `D-1 -> D`, one dimension,
not two. The transform is one-dimension-down in its *direction-sphere bookkeeping* and
two-dimensions-down in the *PDE its profiles satisfy*. Both hold at once; they are different counts,
and the draft's exclamation mark is attached to the second. At fixed `n = 3` the two-step drop is
steep: `N(8,3) = 112`, `N(6,3) = 50`, `N(4,3) = 16`, `N(2,3) = 2`. That would be the case *for* the
ladder if the descent were free. §5 argues it is not.

### 4.3 Gegenbauer: the ladder in one differentiation

With `lambda = (D-2)/2`, the shift `D -> D+2` is exactly `lambda -> lambda + 1`, and

$$ \frac{d}{dx}\,C_n^{(\lambda)}(x) \;=\; 2\lambda\, C_{n-1}^{(\lambda+1)}(x) \veq{gegenbauer-ladder}\lean $$

SymPy confirms this identically in `x` and `lambda` for `n = 1..8`. The Lean file writes out
`C_0..C_3` explicitly (this Mathlib vendoring has no Gegenbauer, Legendre or Jacobi family, only
Chebyshev) and proves the relation as `HasDerivAt` statements for `n = 1,2,3`. I checked the four
hand-written polynomials against SymPy's `gegenbauer`: all four agree exactly, including the
awkward `C_3` with its thirds.

**This is the cleanest algebraic dimension ladder in the file, and it goes the wrong way for the
owner.** One differentiation raises `D` by two and lowers the degree by one: the same *type* as
`(1/r) d_r` in §3.2, local, differential, upward, parameter-free. The owner's transform is nonlocal,
integral, downward, parameter-adding. So `gegenbauer-ladder` is the formal shadow of the classical
ladder, not of the owner's. Worth keeping regardless: it is what the owner's construction has to be
*adjoint to* if the two are ever related, and pinning that adjoint down is lead 2.

---

## 5. Does descending two dimensions buy anything?

**Recommendation: no, not as a descent. Count the data.**

At rung `d` the transform's input is a direction `e` over `S^{d-2}`, so `d-2` continuous parameters,
and for each `e` a profile which, after `x -> x + i z e`, is an arbitrary function of **one complex
variable** (round 1 §1.3: the Wick rotation makes the direction isotropic, so the transverse condition
evaporates in that coordinate). Total input: a function of `(d-2) + 2 = d` real variables. The
target, a harmonic function on a ball in `R^d`, is fixed by its boundary values on `S^{d-1}`, a
function of `d-1` real variables.

**Every rung is overdetermined by exactly one variable's worth**, in every dimension. That excess is
not new here; it is round 1 §1.4 counted rather than computed. There the surplus was the
`b_\phi x_{\bar\phi}` family collapsing under integration by parts in `phi`; here it is one function
of `d-1` variables of gauge freedom, the same object. The twistor literature calls it a coboundary
and quotients by it with Cech cohomology, machinery that exists because the naive count does not
close. Three consequences, as costs.

- **The rung reintroduces a continuum.** The premise of `physics/wirohsh.md` is that continuous
  `omega` is unwelcome and discrete `m` is better. Every rung hands back `d-2` continuous direction
  parameters, and re-discretising them needs a quadrature on `S^{d-2}` whose node count is what
  §4.1's table counts. Not a saving: the original problem in angular clothing.
- **The real saving belongs to a different step.** Round 1 §1.5 gets a genuinely discrete `(n,m)`
  labelling by Fourier-expanding the *direction circle*, not by descending. Descent and
  discretisation are separable and only the second pays. Recommend the draft split them.
- **The locality obstruction bites here too.** [`wirohsh-approximation.md`](wirohsh-approximation.md)
  argues the basis cannot represent spatially local structure cheaply. A rung makes that worse: a
  compactly supported feature at rung `d` becomes a globally supported integrand over the whole
  direction sphere at rung `d-2`. An already non-local representation does not get more local by
  being integrated against a sphere.

**Where a rung might still pay, narrowly.** If the target has a symmetry collapsing the direction
integral to a point or a finite set, the descent is free and the count falls as §4.2 shows. The clean
example is the radial case, where the direction integral is trivial and the classical `(1/r) d_r`
ladder does the whole job with no parameters. So the honest summary: the ladder is a **structural**
result about the solution space, worth stating for what it explains, and it is *not* an algorithm.
The negative is not hostile to the draft. It separates the claim that is true and pretty from the
one that would have to be true for `id:ff32`-style applications, which
[round 1](wirohsh-splats.md) already recommended NO-GO on for independent reasons.

---

## 6. Surfaced for the owner

Located and evidenced; every resolution is the owner's. Nothing here was edited and nothing was
filed into `TODO.md`, `ROADMAP.md` or `REVIEW_ME.md`.

**In `physics/wirohsh.md`.**

- **`:110`, the seed sentence.** "The Laplace equation can be solved as the superposition of
  solutions two dimensions lower" is correct as written, but the exclamation invites the reader to
  hear a *recursion with a payoff*. §5 counts the payoff as negative and §1 shows the recursion has
  two floors on different terms. The draft already derives both floors (`:133` odd, `:161` even) and
  never remarks that they are the two ends of one ladder. Suggest naming the terminus at `:110`.
- **No Huygens remark exists yet, and a reader will supply one.** The `mod 2` is conspicuous and the
  natural guess is wrong (§2). One sentence naming `d = 1` as the separator would forestall it.
- Round 1's four notation snags (`:97`, `:58`, `:88`, `:154`) are unchanged and not restated here.

**In `docs/dreamed/lean/WirohshLadder.lean`.** Both are doc-comment overclaims; every theorem
statement is correct and every proof compiles.

- `Nharm_branching`'s doc-comment calls it "the exact bookkeeping of the `D -> D-2` step". The
  theorem is a `D-1 -> D` statement (§4.2). It *is* the right bookkeeping for the direction-sphere
  data, so the claim is defensible, but the dimension shift named in the comment is not the one in
  the theorem.
- The `gegenbauer_deriv_*` section header calls `lambda -> lambda+1` "one rung of the ladder". It is
  one rung of the **classical upward** ladder (§4.3), a different operator from the owner's downward
  transform. Suggest qualifying the comment, or better, keeping it and recording the adjointness
  question as an open problem (lead 2).

I found no theorem in the file whose statement I could not verify independently.

---

## 7. Follow-up leads

1. **Does the even floor's redundancy have an odd-floor analogue?** At `d = 2` the profile is linear
   in the transverse coordinate and the linear term collapses; at `d = 1` there is no constraint at
   all. Decidable by computing the `d = 1` floor's gauge freedom explicitly: if §5's "overdetermined
   by one variable" holds there too, the collapse is universal and round 1 §1.4 is a corollary rather
   than a 3D accident.
2. **Is the owner's transform the adjoint of `(1/r) d_r`?** §3.2 and §4.3 give two upward
   differential ladders, the owner gives one downward integral one. Decidable by pairing them in
   `L^2` on a ball and checking `<T f, g> = <f, (1/r d_r)^* g>` up to boundary terms. If it closes,
   verdict 2 softens from "different" to "adjoint"; if not, the distinction is permanent.
3. **Does the ladder survive a mass term?** §2(c) uses Klein-Gordon to separate the parities. The
   null-direction argument needs `grad u . grad u = 0`; for `(Delta - m^2)` the analogue needs
   `k.k = m^2`, a different quadric. Decidable by redoing round 1 §1.3 with `exp(k.x)` on that
   quadric and asking whether the direction manifold stays compact, since a non-compact one kills the
   discrete-index payoff outright.
4. **Where does the `1/sqrt(c^2t^2 - r^2)` kernel come from in the ladder's language?** The even
   floor should produce it, since `no-2d-profile` says nothing algebraic can. Decidable by running
   the owner's `d = 2` construction to a closed form and comparing with the Poisson formula term by
   term; agreement would make the even floor explanatory rather than merely terminal.
5. **Is `ladder-count` tight for a truncated transform?** §4.2 is exact for complete expansions.
   Decidable by truncating the direction-sphere expansion at degree `M < n` and measuring the error
   against [`wirohsh-approximation.md`](wirohsh-approximation.md) §4's rates; if the rung's
   truncation error exceeds the ambient one, §5's negative hardens.

---

## Lean attestation

Every `\lean` badge above refers to
[`docs/dreamed/lean/WirohshLadder.lean`](lean/WirohshLadder.lean), namespace `WirohshLadder`. The
file was written by the predecessor agent; this essay was written to it, not the reverse.

| handle | definitions and theorems | content |
|---|---|---|
| `ladder-parity` | `bottom`, `bottom_odd`, `bottom_even`, `bottom_add_two`, `terminus`, `bottom_eq_one_or_two` | `bottom d = 1` for odd `d`, `2` for even; a rung does not change it; every `d >= 1` is `2k + bottom d`; there are exactly two floors |
| `harm-dim` | `Nharm`, `Nharm_zero`, `Nharm_succ`, `Nharm_three`, `Nharm_two`, `Nharm_diff` | the Pascal-form definition, `Nharm 1 n = 2n+1` (`D=3`), `Nharm 0 (n+1) = 2` (`D=2`), and the owner-style binomial difference restated additively |
| `ladder-count` | `Nharm_branching` | `sum_{m<=n} N(D-1,m) = N(D,n)`, by induction with Pascal's rule |
| `radial-3d` | `radial3_reduction`, `radial3_dalembert` | `v = ru` reduces the 3D radial operator to the 1D one; `u = f(r-ct)/r` solves the 3D radial wave equation, all derivatives delivered as `HasDerivAt` witnesses |
| `gegenbauer-ladder` | `geg0`, `geg1`, `geg2`, `geg3`, `gegenbauer_deriv_one`, `gegenbauer_deriv_two`, `gegenbauer_deriv_three` | `d/dx C_n^{(l)} = 2l C_{n-1}^{(l+1)}` for `n = 1,2,3`, as `HasDerivAt` statements |

Checked with:

```
cd /home/tobias/src/toesnail/verify
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/WirohshLadder.lean
```

**Exit status 0**, silent, zero `sorry`, zero warnings. Re-run independently for this essay; the file
was not modified.

**Out of scope, restated from the file's own doc-comments.**

- `radial3_dalembert` proves sufficiency only. The converse (every radial solution has the form
  `f(r-ct)/r`) is not formalised.
- The `(1/r) d_r` step from `d = 3` to `d = 5` and the general-`d` intertwiner
  `\eqref{radial-intertwiner}` are **SymPy only**. Nothing in Lean touches them, nor `no-2d-profile`.
- `gegenbauer_deriv_*` covers `n = 1, 2, 3` with hand-written polynomials. The general-`n` relation
  is not formalised: this Mathlib vendoring (`v4.30.0-rc2`) has no Gegenbauer, Legendre or Jacobi
  family, only `Mathlib.RingTheory.Polynomial.Chebyshev`.
- `Nharm` is *defined* as a binomial expression. That it **is** the harmonic dimension is not proved
  in Lean; it is classical and is verified numerically here (§4.1, direct nullity count).
- `ladder-parity` is trivial arithmetic, stated rather than assumed because it is the essay's spine.
- Per [`docs/dreamed/README.md`](./), these badges attest the dreamed Lean file and the SymPy runs
  recorded here only. They are not wired into `physics/*.toml` or `tests/test_verify.sh`.

## `.mw` sketch

What a future `.mw` document would carry, so the essay is `.mw`-linkable:

```computation
u3 = f(r - c*t) / r
```

```computation
resid3 = diff(u3, r, 2) + 2/r*diff(u3, r) - diff(u3, t, 2)/c**2
```

```computation
u5 = diff(u3, r) / r
```

```computation
resid5 = diff(u5, r, 2) + 4/r*diff(u5, r) - diff(u5, t, 2)/c**2
```

```computation
Nharm = binomial(n + D - 1, D - 1) - binomial(n + D - 3, D - 1)
```

```computation
branching = Sum(Nharm.subs(D, D-1).subs(n, m), (m, 0, n)) - Nharm
```

```computation
geg_ladder = diff(gegenbauer(n, lam, x), x) - 2*lam*gegenbauer(n-1, lam+1, x)
```

The DAG edges that matter: `resid3`, `u5` and `resid5` all depend on `u3`, so a sign change in the
Wick rotation or in the profile argument (`r - c*t` to `r + c*t`) marks the whole radial chain stale;
and `branching` depends on `Nharm`, so an edit to the binomial convention at `n < 2` (§4.1) marks it
stale too. The second edge is the one a human misses, because the two expressions sit in different
sections.

## Sources consulted

- [Hadamard's method of descent (Wikipedia)](https://en.wikipedia.org/wiki/Hadamard%27s_method_of_descent)
- [Huygens principle (Encyclopedia of Mathematics)](https://encyclopediaofmath.org/wiki/Huygens_principle)
- [Wave Equation in Higher Dimensions (Stanford Math 220A handout)](https://web.stanford.edu/class/math220a/handouts/waveequation3.pdf)
- [Origin of the tail in Green's functions in odd dimensional space-times (arXiv:1309.2996)](https://arxiv.org/pdf/1309.2996)
- [A geometric perspective on the method of descent (arXiv:1703.06458)](https://arxiv.org/pdf/1703.06458)
- [Solutions of the spherically symmetric wave equation in p+q dimensions (arXiv:hep-th/9402065)](https://arxiv.org/pdf/hep-th/9402065)

The Gegenbauer derivative relation `\eqref{gegenbauer-ladder}` is classical (Erdelyi, and DLMF
§18.9) but I did not find it stated with the dimension-shift reading in a source I could quote, so
it is asserted here on the SymPy check for `n = 1..8` and the Lean proof for `n = 1,2,3`, not on a
citation.

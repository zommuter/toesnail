---
title: "Dreamed: the Lambert-W branch, and the N between Bose and Fermi"
permalink: /dreamed/lambertw-statistics
---

# Dreamed: the Lambert-W branch, and the `N` between Bose and Fermi

> **STATUS: DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](./). Written by an AI agent on
> 2026-09-01 from an owner-picked seed. Nothing here is theory or a correction, and nothing moves
> into `physics/` without the owner authoring the move. Every claim about the owner's math sits in
> [Surfaced for the owner](#5-surfaced-for-the-owner), located and evidenced, never resolved.

**Seed:** `physics/entropy.md`, handles `meanE` (l.22), `be` (l.27), `fd` (l.35), `lambertw`
(l.59). **Context:** ROADMAP `id:5d31`, `id:37cc`, `id:3d2a` and
`docs/meeting-notes/2026-06-21-2129-lean-formalization-strategy.md` (D1 split the `lambertw`
marker: algebra is SymPy-provable, the W-branch/domain caveat is queued as Lean debt). This essay
attempts that caveat.

## 0. The one-line answer

The caveat is real and it bites in the bosonic case: on the whole physical domain that inversion
needs the **`W_{-1}` branch**, and reading `W` as the principal branch `W_0` makes l.59 return
`βE₁ = 0` identically. The fermionic case has the opposite problem: a real solution **always**
exists (the bound `-βE·e^{βE} ≥ -1/e` is exactly saturated by the physical range, at
`βE = W₀(1/e)`), but **both** branches give physically admissible roots, so that inversion is
two-valued and `W` alone does not name which one.

## 1. Sign audit of the chain (l.53 to l.59)

The `∓` bookkeeping in the source is internally consistent. Reading the upper sign throughout:

- upper sign `-` : denominator `e^x - 1`, i.e. **Bose-Einstein**, `X := x + y`, argument `-y·e^{-y}`;
- lower sign `+` : denominator `e^x + 1`, i.e. **Fermi-Dirac**, `X := x - y`, argument `-y·e^{+y}`.

With `x := βE₁`, `y := βE` the shift `x → x ∓ y` of l.55 produces, algebraically,

$$ \text{BE:}\quad -y\,e^{-y} = -X\,e^{-X},\ X = x+y \qquad\text{and}\qquad \text{FD:}\quad -y\,e^{+y} = -X\,e^{-X},\ X = x-y. $$

Both verified in SymPy by substituting the defining relation (BE simplifies to symbolic `0`;
FD to `0.e-166` at `x = 0.7` and `x = 3`, 30 digits). No sign error is present in the source and
the chain is sound as algebra. The open question is entirely the last arrow, `⇒ x = -W(-y e^{∓y})`.

## 2. Where that arrow needs a licence

`W(v)·e^{W(v)} = v`, so `x = -W(...)` asserts that `-X` is *the* pre-image of `F(u) := u·e^u`.
`F` is not injective: `F'(u) = (1+u)e^u`, so `F` strictly increases on `[-1,∞)` (that is `W₀`),
strictly decreases on `(-∞,-1]` (`W_{-1}`), and the two meet at the global minimum `F(-1) = -1/e`.
The inversion needs two stated answers: does a real pre-image exist (`v ≥ -1/e`?), and which of the
two is meant. Both are proved in Lean below, with no Lambert W in the proof.

$$ \operatorname{StrictMonoOn}\ (u \mapsto u e^u)\ [-1,\infty), \qquad \operatorname{StrictAntiOn}\ (u\mapsto u e^u)\ (-\infty,-1], \qquad u e^u \ge -e^{-1} \veq{lwbranch}\lean $$

## 3. The bosonic verdict: `W_{-1}`, and `W_0` degenerates to zero

`y = x/(e^x - 1)` maps `x ∈ (0,∞)` strictly monotonically onto `y ∈ (0,1)`: SymPy gives the limits
`1` (`x → 0⁺`) and `0` (`x → ∞`), derivative negative throughout (`-0.417`, `-0.339`, `-0.0274` at
`x = 0.5, 1, 5`). So `y < 1` always, i.e. `-y > -1` sits on the `W₀` side of the branch point.

But `-y` is itself a solution of `F(-y) = F(-X)`, trivially via `X = y`, which is `x = 0`. Since
`-y ∈ [-1,∞)` and `F` is injective there, `-y` is the **only** principal-branch root, so the
wanted root lies on the other branch: `X = x + y > 1`. The numbers (mpmath, 25 dps):

| `x = βE₁` | `y = βE` | `X = x+y` | `-W₀(-y e^{-y})` | `-W_{-1}(-y e^{-y})` | `βE₁` via `W₀` | `βE₁` via `W_{-1}` |
|---|---|---|---|---|---|---|
| 0.10 | 0.950833 | 1.050833 | 0.950833 | 1.050833 | `1.8e-25` | 0.100000 |
| 1.00 | 0.581977 | 1.581977 | 0.581977 | 1.581977 | `1.3e-26` | 1.000000 |
| 5.00 | 0.033918 | 5.033918 | 0.033918 | 5.033918 | `0.0` | 5.000000 |

The `W₀` column reproduces `-W₀ = y` to machine precision, so `βE₁ = -W₀(...) - βE = 0`
identically; the `W_{-1}` column recovers the input exactly. Not a numerical accident: it is the
trivial root, and it is what an unqualified `W` returns (the default branch in SymPy, mpmath,
SciPy, Mathematica and Maple is the principal one). Uniqueness on the correct branch holds, since
`F` is injective on `(-∞,-1]`. The bosonic inversion is **well posed with the qualifier and
degenerate without it**.

## 4. The fermionic verdict: always exists, tight, and two-valued

`y = x/(e^x + 1)` is **not** monotone on `x > 0`. It rises from `0`, peaks, and falls back to `0`.
The stationary condition `e^x(1-x) + 1 = 0` gives `e^x = 1/(x-1)`, whence

$$ y_{\max} = \frac{x^\ast(x^\ast-1)}{x^\ast} = x^\ast - 1, \qquad x^\ast = 1 + W_0(1/e). $$

So the maximum of `βE` is **exactly** `W₀(1/e)`. Numerically, `x* = 1.27846454276107379510935873902`
and `y_max = 0.2784645427610737951093587`, against `W₀(1/e) = 0.278464542761073795109358739023`:
agreement to `3.9e-26` at 25 dps, and `x* - 1 = y_max` symbolically.

The FD chain gives `-y·e^{y} = F(-X) ≥ -1/e`, so a real `W` value exists iff `y ≤ W₀(1/e)`: the
same number. Numerically `min(-y e^y)` over the physical range is `-0.36787944117144233 = -1/e` to
full double precision. **The physical domain of `βE` and the domain of the real Lambert W coincide
exactly, boundary attained**, so for a two-level system the inversion is always solvable. The cost
is uniqueness: for every `βE < W₀(1/e)` there are two roots, one per branch, both physical.

| `βE` | root via `W₀` | root via `W_{-1}` | `⟨k⟩` low root | `⟨k⟩` high root |
|---|---|---|---|---|
| 0.2 | `βE₁ = 0.5448804402` | `βE₁ = 2.3961385061` | 0.36705300 | 0.08346763 |

Both confirmed independently by bisection on `x/(e^x+1) - 0.2` in the two intervals separated by
`x*`. At `βE = y_max` they coalesce (`X = 1` exactly, the branch point); above it there is no
solution at all, which is the correct physics: at inverse temperature `β` a two-level system
simply cannot hold `βE > 0.2785`.

## 5. Surfaced for the owner

Located, evidenced, **not resolved**. Two items, both about `physics/entropy.md` l.59
(handle `lambertw`, badge `\leanc`).

**(a) The bosonic branch is `W_{-1}`, not `W_0`.** As written, `βE₁ = -W(-βE·e^{-βE}) - βE` with
`W` the principal branch evaluates to `0` for every physical `βE`, because `-βE` is itself the
principal pre-image (§3). The formula becomes true on the whole physical domain `βE ∈ (0,1)` with
the single qualifier `W = W_{-1}`. Possible wording, entirely the owner's call: a branch subscript
on the bosonic sign, plus a sentence naming `βE < 1` as the physical range. Evidence:
`-W₀(-y e^{-y}) - y = 1.8e-25` at `βE₁ = 0.1`.

**(b) The fermionic case has two solutions and `W` does not select between them.** For every
`βE ∈ (0, W₀(1/e))` both branches give a positive `βE₁` satisfying the source equation (§4).
Physically: a measured `E` does not determine `E₁` for a two-level system, since a small gap held
hot and a large gap held cold share an energy. The threshold `βE ≤ W₀(1/e) ≈ 0.2784645` is not a
defensive caveat, it is exactly the range of the map. What is missing is a selection rule.

Neither item is applied to the source. Both are the owner's decision, and (b) carries a physical
reading he may want to phrase himself.

## 6. The `N` in between: this is Gentile, and it is not anyons

`meanE` (l.22) holds for every `N`, BE at `N → ∞` and FD at `N = 2`. SymPy confirms the owner's
closed form against the direct sum `Σ k z^k / Σ z^k` for `N = 2,3,4,5` (difference simplifies to
exactly `0` each time), giving

$$ \langle k\rangle_{N=3} = \frac{z(2z+1)}{z^2+z+1}, \qquad \langle k\rangle_{N=4} = \frac{z(3z^2+2z+1)}{(z+1)(z^2+1)}, \qquad z = e^{-\beta E_1}. $$

So there is a one-parameter family in the owner's own algebra. **What it is:** an *occupancy
cutoff*, at most `N-1` quanta per level. That is precisely **Gentile statistics** (G. Gentile jr.,
1940), intermediate statistics with maximum occupation `n` per state: `n = 1` fermions, `n → ∞`
bosons. The owner's `N-1` is Gentile's `n`. **What it is not**, because the analogy is tempting:

- **Not a consistent quantum statistics** field-theoretically. Greenberg's review is blunt: "as
  formulated by Gentile, intermediate statistics is not a proper quantum statistics, because the
  condition of having at most `n` particles in a quantum state is not invariant under change of
  basis". The consistent generalisation is Green's **parastatistics** (para-Bose / para-Fermi,
  basis-invariant, a genuine local QFT).
- **Not anyons.** Anyons generalise *braid* statistics in 2D (the wavefunction picks up `e^{iθ}`
  under exchange); Gentile generalises *occupancy*. Different axis. Maps between the two have to
  be constructed ([2003.06235](https://arxiv.org/abs/2003.06235)), which is evidence they are
  distinct objects, not that they coincide.
- **Known trap in the limit:** Gentile does not reduce to Bose-Einstein as `n → N_particles` when
  the fugacity `z > 1`; the ground-state contribution must be kept
  ([Dai and Xie 2004](https://arxiv.org/abs/cond-mat/0310066)). The owner's `N → ∞` at fixed `β`,
  `E₁` is a single-level limit and does not touch this; a condensation discussion would.

Speculative, flagged: the family is a legitimate pedagogical object ("BE and FD are the two ends of
one geometric sum") that toesnail derives for free. It is not new physics.

## 7. Does the inversion close in special functions for general `N`?

No, and the reason is structural. Writing the inversion as an exponential-polynomial equation:

$$ N=2:\ y(e^x+1) = x, \qquad N\to\infty:\ y(e^x-1) = x, \qquad N=3:\ y\,(e^{2x}+e^x+1) = x\,(e^x+2). $$

For `N = 2` and `N → ∞` there is a **single** exponential monomial `e^x` with constant
coefficients and the equation is affine in `x` times `e^x`: exactly the normal form `(ax+b)e^{cx}
= d` that Lambert W inverts, which is why the owner's shift `x → x ∓ y` works. For `N = 3` there
are two independent monomials `e^{2x}` and `e^x`, one carrying an `x`-dependent coefficient. No
shift makes that a single `u e^u`.

Evidence, not proof: SymPy's `solve` on the `N = 3` equation raises `NotImplementedError: multiple
generators [x, exp(x)]`. **A genuine non-existence result needs a Liouvillian / differential-Galois
argument over the exponential field, which I did not do.** So: `N = 2` and `N = ∞` are the only
members whose inversion is *known* to close in Lambert W, the obstruction for `N ≥ 3` being the
second exponential monomial.

Numerically the general-`N` inversion inherits the fermionic pathology, not the bosonic one:
`y(x) = x·⟨k⟩(x,N)` vanishes at both ends for every **finite** `N`, so it has a maximum and is
two-valued.

| `N` | `x` at max | `max βE` |
|---|---|---|
| 2 | 1.278465 | 0.2784645428 |
| 3 | 1.000765 | 0.4247897654 |
| 5 | 0.717695 | 0.5817057419 |
| 8 | 0.517770 | 0.6964810581 |
| 64 | 0.103365 | 0.9403336629 |
| 1024 | 0.009570 | 0.9946790201 |
| `∞` | (none) | 1 (supremum, not attained) |

For `N = 3`, `βE = 0.3` the two roots are `βE₁ = 0.4080084959` and `1.9888609105` (bisection,
both reproduce `βE = 0.300000000000`). Unique invertibility in the bosonic case is therefore the
**singular limit**, not the generic behaviour: at `N = ∞` the maximum runs off to `x → 0⁺` and the
upper branch escapes to infinity, leaving a monotone map onto `(0,1)`. Speculation, flagged:
`max βE → 1` from below, so the ambiguity is pushed to `x → 0` rather than vanishing abruptly.

## 8. Physical reading (a suggestion)

Inverting `E → E₁` is thermometry run backwards: given a measured mean energy and a known
temperature, read off the level spacing. That is the useful direction whenever occupancy is what
you can see and the spectrum is what you want, as in the neighbouring `physics/lasercool.md`
(fluorescence gives populations, the transition spacing is unknown) and in the owner's physics.SE
question 669175 on entropy accounting in lasing. Both findings bite there: a bosonic mode inverts
uniquely but only via `W_{-1}`, and for a two-level system one energy measurement is provably
insufficient, so such thermometry needs a second observable to break the branch tie.

## 9. Lean attestation

**File** `docs/dreamed/lean/Statistics.lean`. **Command**
`cd verify && nice -n19 lake env lean --threads=2 ../docs/dreamed/lean/Statistics.lean`.
**Exit status `0`, `sorry` count `0`.** Mathlib is the rev pinned in `verify/lake-manifest.json`,
which has **no Lambert W** (the sole `lambert` hit under `Mathlib/` is
`NumberTheory/TsumDivisorsAntidiagonal.lean`, Lambert series), hence the file proves the
*precondition*, not the W identity.

| Theorem | Statement |
|---|---|
| `be_closed_form` | `e^{-x}/(1-e^{-x}) = 1/(e^x-1)` for `x > 0` (handle `be`, algebraic half) |
| `fd_closed_form` | `e^{-x}/(1+e^{-x}) = 1/(e^x+1)` (handle `fd`, algebraic half) |
| `partition_N_two` | `(1-z²)/(1-z) = 1+z` for `z ≠ 1` (the `N=2` collapse, l.34) |
| `strictMonoOn_F` | `StrictMonoOn (u ↦ u e^u) [-1,∞)` -- the `W₀` branch |
| `strictAntiOn_F` | `StrictAntiOn (u ↦ u e^u) (-∞,-1]` -- the `W_{-1}` branch |
| `neg_exp_neg_one_le_F` | `u e^u ≥ -1/e` for all real `u` -- the real-W existence bound |
| `be_chain` | `F(-y) = F(-(x+y))` from `y(e^x-1) = x` (owner l.55 to l.57, bosonic) |
| `fd_chain` | `F(y) = -F(-(x-y))` from `y(e^x+1) = x` (fermionic; note the sign flip) |
| `be_y_lt_one` | `y < 1` for `x > 0` (bosonic range) |
| `be_shift_gt_one` | `x + y > 1`, i.e. the bosonic root is on `W_{-1}` |
| `be_principal_root_is_trivial` | the only root in `[-1,∞)` is `-y`, giving `βE₁ = 0` |
| `be_second_branch_unique` | the root in `(-∞,-1]` is unique |
| `fd_arg_ge_neg_inv_e` | `-y e^{y} ≥ -1/e`, the fermionic existence condition |

**Weakened / not attempted, stated plainly.** No theorem names `W` (Mathlib has none, and
defining it is `id:37cc` scope). Fermionic non-uniqueness (§4) is numerical only; formalising it
needs intermediate-value plus a certified numeric bound. `y_max = W₀(1/e)` is SymPy and mpmath
only, since it mentions `W`. `neg_exp_neg_one_le_F` proves only `≥`, not the equality case at
`u = -1`. The entropy maximisation (l.8 to l.12) and the general-`N` `meanE` (l.22) are untouched.

## 10. What a `.mw` document would carry

Sketch in the style of `verify/mirror/resogram_esol.mw`, not a working mirror:

```computation
kmean = Sum(k*Z1**k, (k, 0, N-1)) / Sum(Z1**k, (k, 0, N-1))
be    = limit(kmean.subs(Z1, exp(-x)), N, oo)                              # 1/(exp(x) - 1)
fd    = kmean.subs(N, 2).subs(Z1, exp(-x))                                 # 1/(exp(x) + 1)
```

```computation
chain_be = simplify(-y*exp(-y) + (x+y)*exp(-(x+y))).subs(y, x/(exp(x)-1))  # 0
fd_ymax  = maximum(x/(exp(x)+1), x, Interval.open(0, oo))                  # LambertW(1/E)
```

What the `.mw` DAG would buy: `chain_be` and `fd_ymax` both depend on `be`/`fd`, so editing either
closed form should mark the branch analysis stale. Known blind spot (`id:ad8c`): the DAG keys edges
on regex symbol references and cannot see whether a transcription is faithful.

## 11. Follow-up leads

1. **Ratify or reject finding (a)** (bosonic branch `W_{-1}`). Decidable by the owner reading §3's
   table; the numeric evidence is complete and reproducible in three lines of mpmath.
2. **Decide whether finding (b) is prose or a marker.** Decidable once the owner says whether l.42
   onwards intends `E → E₁` as a definition or as an invertible measurement map.
3. **Close `id:5d31` with the branch-free half.** The l.53 to l.57 instrument is writable today
   (§1: the chain simplifies to `0` for both signs). Decidable when the split `\veq` markers land.
4. **Prove `y_max = W₀(1/e)` W-free in Lean** as `∀ x > 0, x/(e^x+1) ≤ c` with `c·e^c = 1/e`.
   Decidable by attempting it: the only hard step is existence of `c`, from `intermediate_value_Icc`.
5. **Settle the general-`N` non-closure.** Decidable by a differential-Galois / Ritt argument over
   the field generated by `x, e^x`; until then §7 must say "no known closed form".

---

*Sources for §6:* [cond-mat/0310066](https://arxiv.org/abs/cond-mat/0310066) (Dai and Xie),
[hep-ph/9306225](https://arxiv.org/pdf/hep-ph/9306225) (Greenberg),
[2003.06235](https://arxiv.org/pdf/2003.06235), [0903.4773](https://arxiv.org/pdf/0903.4773).

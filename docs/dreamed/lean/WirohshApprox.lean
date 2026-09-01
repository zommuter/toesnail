/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`.

  Lean attestation for `docs/dreamed/wirohsh-approximation.md` (round 2 of the
  2026-09-01 dreaming session), seeded from the owner's `physics/wirohsh.md`
  ("WiRoHSH -- Wick-rotated hyper-spherical harmonics") and from `docs/se-corpus.md`
  row M-6 ("Fourier : transform :: Laurent : ?").

  The essay is an approximation-theory audit of the owner's Laurent basis. Its two
  load-bearing mathematical claims are formalised here, plus the quantitative claim
  that its measured tables illustrate.

  1. `analytic_hasCompactSupport_eq_zero`  (handle `no-compact-support`)
     THE LOCALITY OBSTRUCTION. A real-analytic `f : R -> R` with compact support is
     identically zero. This is the essay's §4: the owner's basis cannot localise, so
     no convergent Laurent/analytic expansion represents a bump that is exactly zero
     outside an interval. Proved from Mathlib's identity principle
     (`AnalyticOnNhd.eqOn_zero_of_preconnected_of_eventuallyEq_zero`) applied at a
     point beyond the bounded support.
     OUT OF SCOPE: the several-variable version, and the quantitative statement (how
     fast a C-infinity bump's coefficients CAN decay -- measured, not proved, in §5).

  2. `entire_eq_zero_of_vanishes_on_open`  (handle `no-compact-support`, complex form)
     The corollary the essay actually cites for the WiRoHSH setting: an entire
     `f : C -> C` vanishing on a nonempty open set is `0`. Same identity principle.

  3. `truncation_error_le`  (handle `geometric-tail`)
     THE RATE THE ESSAY MEASURES. If the coefficients obey a Cauchy-type estimate
     `|a m| <= M * q ^ m` (NAMED hypothesis `ha`; `q < 1` is `hq1`, `0 <= q` is
     `hq0`), then the tail from index `n` is bounded by `M * q ^ n / (1 - q)`, i.e.
     the truncation error decays GEOMETRICALLY. `geometric_tail` is the exact
     summation lemma it rests on.
     OUT OF SCOPE: deriving `|a m| <= M / r ^ m` from Cauchy's integral formula. The
     Cauchy estimate enters as a hypothesis, not as a theorem; the essay says so.

  4. `geometric_beats_algebraic`  (handle `geometric-beats-algebraic`)
     `n ^ k * q ^ n -> 0` for every fixed `k` and every `0 <= q < 1`: geometric decay
     beats every algebraic rate. This is the essay's §5 table stated as a theorem
     rather than as a fit.

  Identifier mapping to the essay's notation:
      `a n`   <-> the Laurent/Chebyshev coefficient `a_n`
      `q`     <-> `1 / rho`, `rho` the annulus/Bernstein ratio (so `q < 1` IS
                  "the point sits strictly inside the annulus")
      `Mconst`<-> the sup bound `M` on the circle `|z| = r` in `|a_n| <= M / r^n`
      `k`     <-> the smoothness exponent in the Fourier `n^(-k)` rate
  `Mconst` is spelled out because `M` collides with Mathlib's module variables.

  NOT CLAIMED anywhere in this file: anything about the Mellin / two-sided Laplace
  correspondence of the essay's §2 (that is a dictionary of definitions, not a
  theorem), and anything about Gibbs (a numerical measurement, badged `\numeric`).
-/
import Mathlib.Analysis.Analytic.Uniqueness
import Mathlib.Analysis.Analytic.IsolatedZeros
import Mathlib.Analysis.SpecificLimits.Normed
import Mathlib.Topology.Algebra.Support
import Mathlib.Analysis.Complex.Basic

open Filter Topology Set

namespace WirohshApprox

/-! ## 1. The locality obstruction: analytic + compact support => zero -/

/-- **A nonzero real-analytic function on `R` cannot have compact support.**

    This is the essay's deepest limitation on the WiRoHSH basis, and it is an
    identity-theorem statement, not an estimate: compact support forces the function
    to vanish on a whole open ray, and an analytic function vanishing on an open set
    of a preconnected domain vanishes everywhere.

    Hypotheses are named: `hf` is analyticity on all of `R`, `hsupp` is compact
    support. Neither can be dropped (`exp` is analytic without compact support; a
    `C^infinity` bump has compact support without analyticity). -/
theorem analytic_hasCompactSupport_eq_zero {f : ℝ → ℝ}
    (hf : AnalyticOnNhd ℝ f Set.univ) (hsupp : HasCompactSupport f) :
    f = 0 := by
  -- compact support is bounded support: some closed ball contains it
  obtain ⟨R, hR⟩ := hsupp.isBounded.subset_closedBall (0 : ℝ)
  -- hence `f` vanishes on the whole open ray `(R, infinity)`
  have hzero : ∀ x : ℝ, R < x → f x = 0 := by
    intro x hx
    refine image_eq_zero_of_notMem_tsupport ?_
    intro hmem
    have hb := hR hmem
    rw [Metric.mem_closedBall, Real.dist_eq, sub_zero] at hb
    exact absurd ((le_abs_self x).trans hb) (not_le.mpr hx)
  -- so `f` agrees with `0` on a neighbourhood of the point `R + 1`
  have hev : f =ᶠ[𝓝 (R + 1)] 0 := by
    filter_upwards [Ioi_mem_nhds (show R < R + 1 by linarith)] with x hx
    exact hzero x hx
  -- the identity principle on the preconnected set `univ` finishes it
  funext x
  exact hf.eqOn_zero_of_preconnected_of_eventuallyEq_zero isPreconnected_univ
    (Set.mem_univ _) hev (Set.mem_univ x)

/-- **An entire function vanishing on a nonempty open set is zero.**

    The complex form of the same obstruction, and the one the WiRoHSH setting uses
    directly: the owner's `f^+(z)` is holomorphic on its annulus, so it cannot be
    switched off on any open piece of that annulus without being switched off on all
    of it.  Stated on `univ` (entire) because the essay's §4 only needs that case;
    the annulus version is `AnalyticOnNhd.eqOn_zero_of_preconnected_of_eventuallyEq_zero`
    applied to the (preconnected) annulus and is not restated here. -/
theorem entire_eq_zero_of_vanishes_on_open {f : ℂ → ℂ}
    (hf : AnalyticOnNhd ℂ f Set.univ) {V : Set ℂ} (hV : IsOpen V)
    {z₀ : ℂ} (hz₀ : z₀ ∈ V) (hfV : Set.EqOn f 0 V) :
    f = 0 := by
  have hev : f =ᶠ[𝓝 z₀] 0 := by
    filter_upwards [hV.mem_nhds hz₀] with z hz
    exact hfV hz
  funext z
  exact hf.eqOn_zero_of_preconnected_of_eventuallyEq_zero isPreconnected_univ
    (Set.mem_univ _) hev (Set.mem_univ z)

/-! ## 2. The rate: a geometric coefficient bound gives a geometric tail -/

/-- Exact summation of the geometric tail from index `n`:
    `sum_{k >= 0} Mconst * q^(n+k) = Mconst * q^n / (1 - q)`.
    `hq0 : 0 <= q` and `hq1 : q < 1` are the convergence conditions, named. -/
theorem geometric_tail (Mconst q : ℝ) (hq0 : 0 ≤ q) (hq1 : q < 1) (n : ℕ) :
    ∑' k : ℕ, Mconst * q ^ (n + k) = Mconst * q ^ n / (1 - q) := by
  have hcongr : ∀ k : ℕ, Mconst * q ^ (n + k) = (Mconst * q ^ n) * q ^ k := by
    intro k; rw [pow_add]; ring
  rw [tsum_congr hcongr, tsum_mul_left, tsum_geometric_of_lt_one hq0 hq1]
  field_simp

/-- **Truncation error of an expansion with geometrically decaying coefficients.**

    `ha` is the Cauchy-estimate hypothesis in the form the essay uses it,
    `|a m| <= Mconst * q ^ m` with `q = 1 / rho`; the conclusion is that discarding
    every term of index `>= n` costs at most `Mconst * q ^ n / (1 - q)`.

    This is exactly what the essay's §5 table measures for the Chebyshev/Laurent
    expansion of `1/(1+x^2)`, where `rho = 1 + sqrt 2` and the measured ratio agrees
    to seven digits. The Cauchy estimate itself is a HYPOTHESIS here, not a theorem;
    see the file header. -/
theorem truncation_error_le {Mconst q : ℝ} (hq0 : 0 ≤ q) (hq1 : q < 1)
    {a : ℕ → ℝ} (ha : ∀ m : ℕ, |a m| ≤ Mconst * q ^ m) (n : ℕ) :
    ∑' k : ℕ, |a (n + k)| ≤ Mconst * q ^ n / (1 - q) := by
  have hsum2 : Summable (fun k : ℕ => Mconst * q ^ (n + k)) := by
    have := (summable_geometric_of_lt_one hq0 hq1).mul_left (Mconst * q ^ n)
    refine this.congr ?_
    intro k; rw [pow_add]; ring
  have hsum1 : Summable (fun k : ℕ => |a (n + k)|) :=
    hsum2.of_nonneg_of_le (fun k => abs_nonneg _) (fun k => ha (n + k))
  calc ∑' k : ℕ, |a (n + k)|
      ≤ ∑' k : ℕ, Mconst * q ^ (n + k) :=
        hsum1.tsum_le_tsum (fun k => ha (n + k)) hsum2
    _ = Mconst * q ^ n / (1 - q) := geometric_tail Mconst q hq0 hq1 n

/-! ## 3. Geometric beats algebraic, for every algebraic rate -/

/-- **Geometric decay beats every algebraic decay.**  For `0 <= q < 1` and any fixed
    `k`, `n ^ k * q ^ n -> 0`; equivalently `q ^ n = o(n ^ (-k))`.

    In the essay's terms: an analytic-data expansion truncated at `n` terms
    (error `~ rho^(-n)`, `q = 1/rho`) eventually beats a Fourier expansion of merely
    `C^k` data (error `~ n^(-k)`), for every `k`, no matter how large. That "for
    every `k`" is what makes the win qualitative rather than a constant factor. -/
theorem geometric_beats_algebraic {q : ℝ} (hq0 : 0 ≤ q) (hq1 : q < 1) (k : ℕ) :
    Tendsto (fun n : ℕ => (n : ℝ) ^ k * q ^ n) atTop (𝓝 0) :=
  tendsto_pow_const_mul_const_pow_of_abs_lt_one k (by rwa [abs_of_nonneg hq0])

end WirohshApprox

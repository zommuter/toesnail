/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. This file is NOT part of the
  `verify` lake target and is not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean tier for three owner-stated claims in `physics/entropy.md`, plus the one
  bridging identity the dreamed essay `docs/dreamed/wick-entropy.md` leans on.

  Source claims (`physics/entropy.md`), verbatim in the owner's notation:

      Z_B = sum_{k=0}^{N-1} Z_1^k = (1 - Z_1^N)/(1 - Z_1)
      <k> = E/E_1 = -N Z_1^N / (Z_B (1 - Z_1)) + 1/(Z_1^{-1} - 1)      (handle `meanE`)
      N -> infinity:  <k> -> Z_1/(1 - Z_1)     = 1/(e^{beta E_1} - 1)  (handle `be`)
      N = 2        :  <k>  = Z_1/(1 + Z_1)     = 1/(e^{beta E_1} + 1)  (handle `fd`)

  Identifier mapping (the doc's symbols are not Lean identifiers, so):
      `z`  <-> Z_1 = exp(-beta E_1)   (the one-quantum Boltzmann factor)
      `x`  <-> beta E_1               (the dimensionless level spacing)
      `N`  <-> N                      (number of retained occupation levels)
  Side conditions are NAMED hypotheses (`hz1 : z <> 1`, `hx : 0 < x`, ...) rather than
  hidden inside the statements.

  EXPLICITLY OUT OF SCOPE:
  - The Lagrange-multiplier derivation of p_k = Z_k/Z_B (the maximum-entropy variational
    step in `physics/entropy.md` line 1). Only its algebraic consequences are proven.
  - The N -> infinity limit as a LIMIT. `be_closed_form` proves the closed form of the
    limit VALUE that the doc names; it does not prove convergence of `meanE` to it.
  - Any physics: nothing here asserts that N = 2 IS Fermi-Dirac, only that the doc's
    algebra for N = 2 is what the doc says it is.
  - The essay's central claim (Matsubara <-> Laurent, N = 2 <-> antiperiodic boundary
    conditions) is NOT formalized. Only the two-term-sum algebra it rests on is.
-/
import Mathlib.Algebra.Field.GeomSum
import Mathlib.Analysis.SpecialFunctions.Exp

namespace WickEntropy

open Finset

/-- The owner's partition function `Z_B` (`physics/entropy.md`), stated faithfully as the
    truncated geometric sum rather than reproved: Mathlib's `geom_sum_eq` supplies it.
    `hz1` is the named side condition the doc leaves implicit. -/
theorem Z_B_closed_form (z : ℝ) (hz1 : z ≠ 1) (N : ℕ) :
    ∑ k ∈ range N, z ^ k = (1 - z ^ N) / (1 - z) := by
  have h : z - 1 ≠ 0 := sub_ne_zero.mpr hz1
  have h' : 1 - z ≠ 0 := sub_ne_zero.mpr (Ne.symm hz1)
  rw [geom_sum_eq hz1]
  field_simp
  ring

/-- `N = 2` truncation: the two-term partition function. This is the algebraic core of the
    essay's `N = 2` <-> antiperiodic correspondence -- the truncated geometric series
    collapses to the same `1 + z` that Grassmann (antiperiodic) integration produces. -/
theorem Z_B_two (z : ℝ) (hz1 : z ≠ 1) : (1 - z ^ 2) / (1 - z) = 1 + z := by
  have h' : 1 - z ≠ 0 := sub_ne_zero.mpr (Ne.symm hz1)
  field_simp
  ring

/-- The doc's general mean-occupation formula (handle `meanE`) evaluated at `N = 2` gives
    the doc's `fd` left-hand side `z/(1+z)`. Named side conditions: `z` is a Boltzmann
    factor so `0 < z`, and `z ≠ 1` is the doc's implicit `E_1 ≠ 0`. Positivity of `z`
    is what makes `1 + z ≠ 0`. -/
theorem meanE_two (z : ℝ) (hz : 0 < z) (hz1 : z ≠ 1) :
    -2 * z ^ 2 / (((1 - z ^ 2) / (1 - z)) * (1 - z)) + 1 / (z⁻¹ - 1) = z / (1 + z) := by
  have h' : 1 - z ≠ 0 := sub_ne_zero.mpr (Ne.symm hz1)
  have hz0 : z ≠ 0 := ne_of_gt hz
  have hp : (1 : ℝ) + z ≠ 0 := by positivity
  have hinv : z⁻¹ - 1 ≠ 0 := by
    intro h
    apply hz1
    field_simp at h
    linarith
  rw [Z_B_two z hz1]
  field_simp
  ring

/-- Fermi-Dirac closed form (handle `fd`): with `z = exp (-x)`, `z/(1+z) = 1/(exp x + 1)`.
    No side condition is needed: `exp` is everywhere positive. -/
theorem fd_closed_form (x : ℝ) :
    Real.exp (-x) / (1 + Real.exp (-x)) = 1 / (Real.exp x + 1) := by
  have hx : Real.exp x ≠ 0 := ne_of_gt (Real.exp_pos x)
  have hp : Real.exp x + 1 ≠ 0 := by positivity
  rw [Real.exp_neg]
  field_simp

/-- Bose-Einstein closed form (handle `be`): with `z = exp (-x)`, `z/(1-z) = 1/(exp x - 1)`.
    Here the side condition is real and named: `hx : 0 < x` is what makes `z < 1`, i.e.
    what keeps the geometric series summable and the denominators nonzero. -/
theorem be_closed_form (x : ℝ) (hx : 0 < x) :
    Real.exp (-x) / (1 - Real.exp (-x)) = 1 / (Real.exp x - 1) := by
  have hlt : Real.exp (-x) < 1 := by
    rw [show (1 : ℝ) = Real.exp 0 from Real.exp_zero.symm]
    exact Real.exp_lt_exp.mpr (by linarith)
  have h1 : 1 - Real.exp (-x) ≠ 0 := sub_ne_zero.mpr (ne_of_lt hlt).symm
  have hgt : 1 < Real.exp x := by
    rw [show (1 : ℝ) = Real.exp 0 from Real.exp_zero.symm]
    exact Real.exp_lt_exp.mpr hx
  have h2 : Real.exp x - 1 ≠ 0 := sub_ne_zero.mpr (ne_of_gt hgt)
  have hx0 : Real.exp x ≠ 0 := ne_of_gt (Real.exp_pos x)
  rw [Real.exp_neg] at h1 ⊢
  field_simp

end WickEntropy

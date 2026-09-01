/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`.

  Lean attestation for `docs/dreamed/generators-and-bch.md`, seeded from the owner's
  own math.SE material, `docs/se-corpus.md` rows M-1 and M-2 (both promoted
  2026-07-08, Q13):

    M-1  q/116633 + his own a/116639   f(x+a) = e^{a d/dx} f(x); the dilation
                                       generator alpha^{x d/dx}
         q/186201                      curl written as a skew 3x3 matrix; its
                                       eigenvectors
    M-2  q/2043 + his own a/2047       d/dx exp(A(x)) for non-commuting A, with an
                                       explicit Pauli-matrix counterexample
         q/57832                       BCH, ln(AB)

  Nothing here is theory. The essay proposes; the owner disposes.

  Derivative-name convention (owner's, `CLAUDE.md` memory `lean-derivative-naming`):
  a derivative is `f_x`, the subscript naming the differentiation variable. The only
  derivatives here are `Polynomial.derivative` iterates, which carry their own name.

  WHAT IS PROVED
  --------------
  so(3) and the hat map (essay section 3):
    `hat_antisymm`      the hat map lands in the antisymmetric matrices
    `hat_mulVec`        `hat w *ᵥ v = w × v`, the defining property
    `hat_bracket`       `[hat a, hat b] = hat (a × b)`; so(3) IS the cross product
    `hat_cube`          `(hat w)^3 = -|w|^2 • hat w`, the Rodrigues engine
    `hat_cube_unit`     the unit-vector corollary `W^3 = -W`

  The non-commuting exponential trap and BCH (essay sections 4 and 5), on the
  smallest algebra where the series terminates, the 3x3 Heisenberg nilpotents:
    `exp_of_sq_zero`    `A*A = 0` implies `exp A = 1 + A`
    `exp_of_cube_zero`  `A^3 = 0` implies `exp A = 1 + A + A^2/2`
    `heis_bracket_ne_zero`      `[A,B] != 0`, so the pair is genuinely non-commuting
    `heis_exp_mul_ne_exp_add`   `exp A * exp B != exp (A + B)`, the counterexample
                                the M-2 corpus row asks for, with the two sides
                                differing by exactly `[A,B]/2`
    `heis_bch2`         `exp A * exp B = exp (A + B + [A,B]/2)` EXACTLY, because
                        `[A,[A,B]] = [B,[A,B]] = 0` (also proved). This is BCH
                        truncating, not approximating.

  The translation generator (essay section 1), in the case where convergence is not
  a hypothesis at all:
    `taylor_polynomial` for a polynomial `p` and any `N` past its degree,
                        `sum_{k<=N} (a^k/k!) (d/dx)^k p |_x = p (x+a)`.
                        This is `e^{a d/dx} p = p(x+a)` with a finite sum.

  WHAT IS NOT PROVED HERE, AND WHY
  --------------------------------
  * The dilation generator `alpha^{x d/dx}` (essay section 2) is checked in SymPy,
    not here. `x d/dx` is not a bounded operator and its exponential needs a
    functional calculus this file does not build.
  * Rodrigues in the form `exp(theta W) = 1 + sin(theta) W + (1-cos(theta)) W^2` is
    checked in SymPy. What is proved here is `hat_cube_unit`, the algebraic engine
    that forces it: `W^3 = -W` closes the exponential series onto span{1, W, W^2}
    with the sine and cosine series as the coefficients. Stated plainly so nobody
    reads this file as attesting Rodrigues itself.
  * The owner's own a/2047 counterexample uses `X(0) = sigma_3`, `X'(0) = sigma_1`,
    whose exponentials are `cosh`/`sinh` combinations rather than polynomials. It is
    checked in SymPy with exact numbers. The Lean file substitutes the nilpotent
    Heisenberg pair, where every exponential is a polynomial and nothing is left to
    a series argument. Same phenomenon, different witness; the essay says so.
-/
import Mathlib.Analysis.Normed.Algebra.MatrixExponential
import Mathlib.LinearAlgebra.CrossProduct
import Mathlib.Algebra.Polynomial.Taylor

open scoped Matrix
open NormedSpace

/-! ## 1. so(3): the hat map, the cross product, and the Rodrigues engine -/

abbrev M3 := Matrix (Fin 3) (Fin 3) ℝ

/-- The hat map `w ↦ W` sending a vector to the matrix that acts as `w × ·`. -/
noncomputable def hatM (w : Fin 3 → ℝ) : M3 :=
  !![0, -w 2, w 1; w 2, 0, -w 0; -w 1, w 0, 0]

/-- `hat w` is antisymmetric, i.e. it lies in `so(3)`. -/
theorem hat_antisymm (w : Fin 3 → ℝ) : (hatM w)ᵀ = -hatM w := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [hatM, Matrix.transpose]

/-- The defining property: `hat w` acts on vectors as the cross product by `w`. -/
theorem hat_mulVec (w v : Fin 3 → ℝ) : (hatM w) *ᵥ v = crossProduct w v := by
  ext i
  fin_cases i <;>
    simp [hatM, Matrix.mulVec, crossProduct, Matrix.vecHead, Matrix.vecTail] <;> ring

/-- The `so(3)` bracket IS the cross product: `[hat a, hat b] = hat (a × b)`.
    This is the statement that the hat map is a Lie algebra isomorphism
    `(ℝ³, ×) ≅ so(3)`. -/
theorem hat_bracket (a b : Fin 3 → ℝ) :
    hatM a * hatM b - hatM b * hatM a = hatM (crossProduct a b) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [hatM, crossProduct, Matrix.vecHead, Matrix.vecTail] <;> ring

/-- The engine behind Rodrigues: `W^3 = -|w|^2 W`. Every power of `W` therefore lies
    in `span {W, W^2}`, which is why `exp(θW)` closes in three terms. -/
theorem hat_cube (w : Fin 3 → ℝ) :
    hatM w ^ 3 = (-(w 0 ^ 2 + w 1 ^ 2 + w 2 ^ 2)) • hatM w := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [hatM, pow_succ, Matrix.mul_apply, Fin.sum_univ_three] <;> ring

/-- Unit-vector corollary: `W^3 = -W`, so `W` behaves like `i` on its two-dimensional
    rotation plane. The sine and cosine of Rodrigues come from exactly this. -/
theorem hat_cube_unit (w : Fin 3 → ℝ) (hw : w 0 ^ 2 + w 1 ^ 2 + w 2 ^ 2 = 1) :
    hatM w ^ 3 = -hatM w := by
  rw [hat_cube, hw]
  simp

/-! ## 2. Exponentials that terminate: nilpotent matrices -/

/-- `A * A = 0` forces the exponential series to stop after two terms. -/
theorem exp_of_sq_zero {A : M3} (h : A * A = 0) : exp A = 1 + A := by
  simp only [NormedSpace.exp_eq_tsum (𝕂 := ℝ)]
  rw [tsum_eq_sum (s := {0, 1})]
  · simp
  · intro b hb
    have hb2 : 2 ≤ b := by simp at hb; omega
    have hz : A ^ b = 0 := by
      obtain ⟨k, rfl⟩ := Nat.exists_eq_add_of_le hb2
      rw [pow_add, sq, h, zero_mul]
    simp [hz]

/-- `A^3 = 0` forces the exponential series to stop after three terms. -/
theorem exp_of_cube_zero {A : M3} (h : A ^ 3 = 0) :
    exp A = 1 + A + (2 : ℝ)⁻¹ • A ^ 2 := by
  simp only [NormedSpace.exp_eq_tsum (𝕂 := ℝ)]
  rw [tsum_eq_sum (s := {0, 1, 2})]
  · simp [Finset.sum_insert, add_assoc]
  · intro b hb
    have hb3 : 3 ≤ b := by simp at hb; omega
    have hz : A ^ b = 0 := by
      obtain ⟨k, rfl⟩ := Nat.exists_eq_add_of_le hb3
      rw [pow_add, h, zero_mul]
    simp [hz]

/-! ## 3. The counterexample: `exp A * exp B ≠ exp (A + B)`

The witness is the 3x3 Heisenberg pair, the smallest non-commuting pair whose
exponentials are polynomials. Everything below is decided by `norm_num` on entries;
no convergence argument is used anywhere. -/

/-- `A = E₁₂`. -/
def heisA : M3 := !![0, 1, 0; 0, 0, 0; 0, 0, 0]

/-- `B = E₂₃`. -/
def heisB : M3 := !![0, 0, 0; 0, 0, 1; 0, 0, 0]

/-- `[A, B] = E₁₃ ≠ 0`: the pair really is non-commuting. -/
theorem heis_bracket_ne_zero : heisA * heisB - heisB * heisA ≠ 0 := by
  intro h
  have := congrFun (congrFun h 0) 2
  simp [heisA, heisB] at this

/-- The commutator is central in the subalgebra generated by `A` and `B`:
    `[A,[A,B]] = 0`. Half of the Hall condition under which BCH truncates. -/
theorem heis_ad_A : heisA * (heisA * heisB - heisB * heisA)
    - (heisA * heisB - heisB * heisA) * heisA = 0 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [heisA, heisB]

/-- `[B,[A,B]] = 0`. The other half of the Hall condition. -/
theorem heis_ad_B : heisB * (heisA * heisB - heisB * heisA)
    - (heisA * heisB - heisB * heisA) * heisB = 0 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [heisA, heisB]

theorem heisA_sq : heisA * heisA = 0 := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [heisA, Matrix.mul_apply, Fin.sum_univ_three]

theorem heisB_sq : heisB * heisB = 0 := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [heisB, Matrix.mul_apply, Fin.sum_univ_three]

theorem heis_sum_cube : (heisA + heisB) ^ 3 = 0 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [heisA, heisB, pow_succ, Matrix.mul_apply, Fin.sum_univ_three]

/-- **The trap, as an explicit refutation.** `exp A * exp B ≠ exp (A + B)` for a
    concrete non-commuting pair. The two sides differ by exactly `[A,B]/2`, visible
    in the `(0,2)` entry: `1` on the left, `1/2` on the right. -/
theorem heis_exp_mul_ne_exp_add : exp heisA * exp heisB ≠ exp (heisA + heisB) := by
  rw [exp_of_sq_zero heisA_sq, exp_of_sq_zero heisB_sq, exp_of_cube_zero heis_sum_cube]
  intro h
  have := congrFun (congrFun h 0) 2
  simp [heisA, heisB, Matrix.mul_apply, Fin.sum_univ_three, pow_succ,
    Matrix.one_apply] at this

/-- **BCH truncating, not approximating.** Because `[A,[A,B]] = [B,[A,B]] = 0`
    (`heis_ad_A`, `heis_ad_B`), the Baker-Campbell-Hausdorff series stops after the
    quadratic term and the resulting identity is exact. -/
theorem heis_bch2 : exp heisA * exp heisB
    = exp (heisA + heisB + (2 : ℝ)⁻¹ • (heisA * heisB - heisB * heisA)) := by
  have hcube : (heisA + heisB + (2 : ℝ)⁻¹ • (heisA * heisB - heisB * heisA)) ^ 3 = 0 := by
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [heisA, heisB, pow_succ, Matrix.mul_apply, Fin.sum_univ_three]
  rw [exp_of_sq_zero heisA_sq, exp_of_sq_zero heisB_sq, exp_of_cube_zero hcube]
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [heisA, heisB, pow_succ, Matrix.mul_apply, Fin.sum_univ_three] <;> norm_num

/-! ## 4. The translation generator, with no convergence hypothesis

`e^{a d/dx} f = f(x+a)` is exact and finite on polynomials. This is the honest
version of the M-1 identity: for a polynomial there is no remainder, no radius, and
no distinction between analytic and smooth. -/

open Polynomial in
/-- `∑_{k ≤ N} (aᵏ/k!) (d/dx)ᵏ p |ₓ = p(x+a)` for any `N` at least the degree of `p`.
    The sum is finite, so this is `e^{a d/dx} p = p(x+a)` as a theorem rather than as
    a formal series. -/
theorem taylor_polynomial (p : ℝ[X]) (x a : ℝ) (N : ℕ) (hN : p.natDegree ≤ N) :
    ∑ k ∈ Finset.range (N + 1),
      (a ^ k / (Nat.factorial k)) * ((derivative^[k] p).eval x) = p.eval (x + a) := by
  have hdeg : (taylor x p).natDegree < N + 1 := by
    rw [natDegree_taylor]
    omega
  have key : ∀ k : ℕ,
      (a ^ k / (Nat.factorial k)) * ((derivative^[k] p).eval x)
        = (taylor x p).coeff k * a ^ k := by
    intro k
    have hfac : ((Nat.factorial k : ℝ)) ≠ 0 := by
      exact_mod_cast Nat.factorial_ne_zero k
    have hd : (derivative^[k] p).eval x
        = (Nat.factorial k : ℝ) * (hasseDeriv k p).eval x := by
      rw [← Polynomial.factorial_smul_hasseDeriv (R := ℝ) (k := k)]
      simp [nsmul_eq_mul]
    rw [hd, taylor_coeff]
    field_simp
  calc ∑ k ∈ Finset.range (N + 1),
        (a ^ k / (Nat.factorial k)) * ((derivative^[k] p).eval x)
      = ∑ k ∈ Finset.range (N + 1), (taylor x p).coeff k * a ^ k := by
        exact Finset.sum_congr rfl fun k _ => key k
    _ = (taylor x p).eval a := (eval_eq_sum_range' hdeg a).symm
    _ = p.eval (x + a) := by rw [taylor_eval, add_comm]

/-! ## 5. Axiom audit

Every result above is checked against `sorryAx`. Expected output for each line is the
usual `propext, Classical.choice, Quot.sound` and nothing else. -/

#print axioms hat_antisymm
#print axioms hat_mulVec
#print axioms hat_bracket
#print axioms hat_cube
#print axioms hat_cube_unit
#print axioms exp_of_sq_zero
#print axioms exp_of_cube_zero
#print axioms heis_bracket_ne_zero
#print axioms heis_ad_A
#print axioms heis_ad_B
#print axioms heis_exp_mul_ne_exp_add
#print axioms heis_bch2
#print axioms taylor_polynomial

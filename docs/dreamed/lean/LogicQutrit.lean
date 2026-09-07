/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/logic-qutrit-su3.md`
  ("the logical qutrit, SU(3), and what the Bloch sphere does NOT generalise to").

  ------------------------------------------------------------------------------
  WHAT THIS FILE DISCHARGES, IN THE ESSAY'S LANGUAGE

  The essay reads a three-valued logic on a qutrit: the three basis states are

      |0>  =  proven TRUE          |1>  =  proven FALSE          |2>  =  UNDECIDABLE

  and a "logical value" is a density matrix on that 3-dimensional space, written in
  Bloch form as

      rho  =  (1/3) I  +  H          with  H  Hermitian and traceless.

  H is the essay's Bloch vector: it is exactly the list of the eight independent
  "leanings" of the statement (the expectation values of the Gell-Mann observables),
  and H = 0 is the maximally mixed state "no information whatsoever".

  For a QUBIT the analogous H is unconstrained up to its length: EVERY direction is a
  legal logical value, which is why the qubit's Bloch body is a ball. The essay's
  central claim is that this FAILS for the qutrit:

      the length test  Tr(H^2) <= 2/3  (equivalently Tr rho^2 <= 1, the ball
      condition, equivalently Kimura's a_2 >= 0) is NECESSARY BUT NOT SUFFICIENT.

  Below, `H` is an explicit traceless Hermitian matrix strictly INSIDE the ball whose
  `rho` has a NEGATIVE eigenvalue, exhibited by an explicit eigenvector. So there is a
  direction in "logical value space", of legal length, that no state occupies. That is
  the whole content of `qutrit_body_not_a_ball` and it is the essay's headline.

  A second witness, `antipode`, sharpens it: take the pure state "proven TRUE" and
  REVERSE its Bloch vector. The reversed vector has exactly the same length -- it is
  the antipode, which for a qubit is the legal pure state "proven FALSE" -- and for the
  qutrit it is not a state at all. Negation, read as Bloch-vector reversal, does not
  act on the three-valued state space.

  Reading the Lean symbols back:

    `H`         the Bloch vector of a candidate logical value, as a traceless
                Hermitian matrix. Here diag(-1/2, 1/4, 1/4): "leaning AWAY from
                proven-true, equally towards proven-false and undecidable".
    `rho`       (1/3) I + H, the candidate logical value itself.
    `trace (H * H)`
                the squared Bloch length in the Hilbert-Schmidt normalisation in
                which a PURE state sits at exactly 2/3. `3/8 < 2/3`, so this
                candidate passes the ball test with room to spare (its length is
                3/4 of the maximum).
    `det rho < 0`
                positivity FAILS. Kimura's third coefficient a_3 = det rho is the
                extra condition that has no qubit analogue.
    `e0 = ![1,0,0]`
                the eigenvector, i.e. the basis state "proven TRUE": the candidate
                assigns it probability -1/6.

  Everything is over the RATIONALS. The witnesses were chosen so that no irrational
  number and no eigenvalue algorithm is needed: `det` and `trace` of a 3x3 rational
  matrix are `norm_num` computations. Working over the reals or complexes would change
  nothing (a rational matrix is a real matrix is a Hermitian complex matrix) and would
  cost a diagonalisation argument, so it is deliberately not done.

  ------------------------------------------------------------------------------
  EXPLICITLY OUT OF SCOPE (do not read this file as more than it is):

    - This is NOT a formalisation of the qutrit Bloch body. Kimura's theorem (that
      `a_i >= 0` for all i is NECESSARY AND SUFFICIENT) is not proved here, and neither
      is the closed form of `a_3` in terms of the symmetric structure constants
      `d_abc`. Only ONE explicit counterexample is discharged. A counterexample is all
      the essay's "not a ball" claim needs, and it is all that is claimed.
    - This is NOT a theorem about SU(3), QCD, colour, confinement, or the
      inequivalence of the 3 and the 3-bar. Those are the essay's prose and are
      argued there, unformalised.
    - This is NOT a theorem about logic. The identification of the three basis states
      with "proven true / proven false / undecidable" is the OWNER's proposed reading,
      the essay's subject, and is nowhere used below. Nothing here decides whether
      that reading is a good one.
    - The dimension counts (pure qutrit states form a 4-real-dimensional CP^2 inside
      an 8-real-dimensional Bloch body) are arithmetic in the essay and are NOT
      formalised here; `Module.finrank` statements about CP^2 would be a different and
      much larger project.
-/
import Mathlib.Data.Matrix.Basic
import Mathlib.Data.Matrix.Mul
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.FinCases

namespace Toesnail.LogicQutrit

open Matrix

/-! ## 1. The counterexample: inside the ball, still not a state -/

/-- The candidate Bloch vector, as a traceless Hermitian (here: real diagonal) matrix.
    In the essay's reading: "strongly NOT proven-true, mildly proven-false, mildly
    undecidable". -/
def H : Matrix (Fin 3) (Fin 3) ℚ := !![-1/2, 0, 0; 0, 1/4, 0; 0, 0, 1/4]

/-- The candidate logical value `rho = (1/3) I + H`. -/
def rho : Matrix (Fin 3) (Fin 3) ℚ := !![-1/6, 0, 0; 0, 7/12, 0; 0, 0, 7/12]

/-- `H` is traceless, as a Bloch vector must be. -/
theorem H_traceless : H.trace = 0 := by
  simp [H, Matrix.trace_fin_three]
  norm_num

/-- `rho` really is `(1/3) I + H`. -/
theorem rho_eq : rho = (3⁻¹ : ℚ) • (1 : Matrix (Fin 3) (Fin 3) ℚ) + H := by
  rw [Matrix.one_fin_three]
  ext i j
  fin_cases i <;> fin_cases j <;> simp [rho, H] <;> norm_num

/-- `rho` has unit trace, as a density matrix must. -/
theorem rho_trace : rho.trace = 1 := by
  simp [rho, Matrix.trace_fin_three]
  norm_num

/-- The squared Bloch length of `H`, in the normalisation where a PURE qutrit state
    sits at exactly `2/3`. -/
theorem H_hs_norm : (H * H).trace = 3 / 8 := by
  simp [H, Matrix.trace_fin_three]
  norm_num

/-- **The ball test passes.** `3/8 < 2/3`, so `H` is strictly inside the ball
    `Tr(H^2) <= 2/3`, i.e. `Tr(rho^2) <= 1`. This is Kimura's `a_2 >= 0`, and for a
    QUBIT it would be the whole of positivity. -/
theorem H_inside_ball : (H * H).trace < 2 / 3 := by
  rw [H_hs_norm]; norm_num

/-- And yet the determinant is negative: Kimura's `a_3 = det rho >= 0` FAILS. -/
theorem rho_det : rho.det = -49 / 864 := by
  simp [rho, Matrix.det_fin_three]
  norm_num

theorem rho_det_neg : rho.det < 0 := by
  rw [rho_det]; norm_num

/-- The explicit witness: the basis state "proven TRUE". -/
def e0 : Fin 3 → ℚ := ![1, 0, 0]

/-- `e0` is an eigenvector of `rho` with eigenvalue `-1/6`. A "probability" of `-1/6`
    for the outcome "proven true" is what disqualifies `rho` as a logical value. -/
theorem rho_eigen : rho *ᵥ e0 = (-1/6 : ℚ) • e0 := by
  ext i
  fin_cases i <;>
    simp [rho, e0, Matrix.mulVec, dotProduct, Fin.sum_univ_three]

/-- The quadratic form is negative at `e0`, so `rho` is not positive semidefinite. -/
theorem rho_not_psd : e0 ⬝ᵥ (rho *ᵥ e0) < 0 := by
  rw [rho_eigen]
  simp [e0, dotProduct, Fin.sum_univ_three]
  norm_num

/-- **THE ESSAY'S HEADLINE, discharged.**

    There is a traceless Hermitian `H` that passes the qutrit ball test
    (`Tr(H^2) <= 2/3`, equivalently `Tr(rho^2) <= 1`) and whose `rho = (1/3) I + H`
    is nevertheless NOT a state: the quadratic form is negative on an explicit vector.

    For a qubit no such `H` exists: there, purity `<= 1` is equivalent to positivity,
    so the Bloch body is exactly a ball and every direction of every legal length is a
    legal state. For a qutrit the Bloch body is a PROPER subset of the ball. Read
    logically: there are combinations of the pairwise leanings between "proven true",
    "proven false" and "undecidable" that no three-valued state can hold, and the
    obstruction is kinematic -- no dynamics, no coupling, no confinement mechanism. -/
theorem qutrit_body_not_a_ball :
    ∃ K : Matrix (Fin 3) (Fin 3) ℚ, ∃ v : Fin 3 → ℚ,
      K.trace = 0 ∧ (K * K).trace ≤ 2 / 3 ∧
      v ⬝ᵥ (((3⁻¹ : ℚ) • (1 : Matrix (Fin 3) (Fin 3) ℚ) + K) *ᵥ v) < 0 := by
  refine ⟨H, e0, H_traceless, le_of_lt H_inside_ball, ?_⟩
  rw [← rho_eq]
  exact rho_not_psd

/-! ## 2. The antipode: negation is not an operation on qutrit logical values -/

/-- The Bloch vector of the PURE state "proven TRUE", i.e. `|0><0| - (1/3) I`. -/
def Hp : Matrix (Fin 3) (Fin 3) ℚ := !![2/3, 0, 0; 0, -1/3, 0; 0, 0, -1/3]

/-- Its antipode: same length, opposite direction. For a qubit this is the pure state
    "proven FALSE". -/
def Hm : Matrix (Fin 3) (Fin 3) ℚ := !![-2/3, 0, 0; 0, 1/3, 0; 0, 0, 1/3]

theorem Hp_traceless : Hp.trace = 0 := by
  simp [Hp, Matrix.trace_fin_three]; norm_num

theorem Hm_eq_neg : Hm = -Hp := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [Hp, Hm] <;> norm_num

/-- Both sit at the pure-state radius `2/3`: reversal preserves the Bloch length
    exactly, so no length test can tell them apart. -/
theorem Hp_hs_norm : (Hp * Hp).trace = 2 / 3 := by
  simp [Hp, Matrix.trace_fin_three]; norm_num

theorem Hm_hs_norm : (Hm * Hm).trace = 2 / 3 := by
  simp [Hm, Matrix.trace_fin_three]; norm_num

/-- `(1/3) I + Hp` is the pure state `|0><0|`: determinant zero, on the boundary. -/
theorem pure_det : ((3⁻¹ : ℚ) • (1 : Matrix (Fin 3) (Fin 3) ℚ) + Hp).det = 0 := by
  rw [Matrix.one_fin_three]
  simp [Hp, Matrix.det_fin_three]
  norm_num

/-- **The antipode of a pure logical value is not a logical value.** Reversing the
    Bloch vector of "proven TRUE" gives a matrix of the same, legal, Bloch length whose
    determinant is `-4/27 < 0`.

    On a qubit, `H |-> -H` maps the Bloch ball onto itself and IS the logical negation
    that swaps the two truth values. On a qutrit it leaves the state space entirely, so
    "flip every leaning" is not a truth-functional operation on three-valued states.
    The essay argues that this is the state-space shadow of `3-bar` not being
    equivalent to `3` for SU(3), while `2-bar` IS equivalent to `2` for SU(2). That
    representation-theoretic claim is NOT proved here; only this instance is. -/
theorem antipode_not_a_state :
    (Hm * Hm).trace = (Hp * Hp).trace ∧
    ((3⁻¹ : ℚ) • (1 : Matrix (Fin 3) (Fin 3) ℚ) + Hm).det < 0 := by
  constructor
  · rw [Hm_hs_norm, Hp_hs_norm]
  · rw [Matrix.one_fin_three]
    have : ((3⁻¹ : ℚ) • !![(1:ℚ), 0, 0; 0, 1, 0; 0, 0, 1] + Hm).det = -4/27 := by
      simp [Hm, Matrix.det_fin_three]
      norm_num
    rw [this]; norm_num

end Toesnail.LogicQutrit

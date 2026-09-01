/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/discrete-noether.md`.

  Seed (owner-authored): physics.SE q/8518, "Is there something similar to Noether's
  theorem for discrete symmetries?" (Tobias Kienzler, physics.SE uid 97, score 115;
  corpus row P-A, promoted 2026-07-08 for the spine's step 4 as a
  "What Noether doesn't give you" aside).

  What this file proves, in the essay's order:

  1. `eigenvalue_pow_eq_one` -- a symmetry of FINITE ORDER (`S ^ n = 1`) has only n-th
     roots of unity as eigenvalues: the discrete charge is a Z_n label, MULTIPLICATIVE
     by construction.
  2. `parity_eigenvalue` -- the n = 2 headline: parity charge is +1 or -1, nothing else.
  3. `eigenvector_stays` -- CONSERVATION: if the evolution U commutes with S, an
     S-eigenvector evolves inside its own S-eigenspace with the SAME eigenvalue. This
     is the discrete symmetry's entire conservation content, and it holds for ANY U
     commuting with S; the sibling `TimeEvolution.lean` (essay `time-and-operators.md`)
     supplies `U_commute : Commute A H -> Commute A (U H t)`, so `[S,H] = 0` feeds this
     hypothesis. Not reproved here.
  4. `charges_multiply` -- composing two symmetries MULTIPLIES their charges, while
     `phase_additive` shows the continuous one-parameter phases ADD. That contrast
     (multiplicative Z_n charge vs additive Noether charge) is the aside's punchline,
     here as two theorems side by side.
  5. `P3_*` -- parity made concrete: the reflection matrix on a 3-site chain squares to
     one, commutes with the hopping Hamiltonian H3, and has the explicit even/odd
     eigenvectors; `P3_eigenvalue_pm_one` instantiates theorem 2.
  6. `blochWave_translate`, `quasimomentum_umklapp`, `translation_eigenvalue_eq_iff` --
     BLOCH: on the lattice ZZ the wave exp(iqx) is a translation eigenvector with
     eigenvalue exp(iq), that eigenvalue is INVARIANT under q -> q + 2*pi (adding a
     reciprocal lattice vector, lattice constant 1), and two quasi-momenta give the same
     eigenvalue IFF they differ by an integer multiple of 2*pi. "Conserved modulo a
     reciprocal lattice vector" is exactly this iff.
  7. `translate_pow_n`, `ring_quasimomentum` -- on a ring of n sites the translation
     operator satisfies T ^ n = 1, so by theorem 1 its charge is a Z_n label: the
     finite-lattice quasi-momentum is conserved modulo n, no analysis needed.

  EXPLICITLY OUT OF SCOPE: no Lagrangians, no action functionals, no Noether currents
  (classical Noether is not formalized here, only the quantum [S,H] = 0 side); no
  antiunitary operators (time reversal is discussed in the essay, not proved -- Wigner's
  theorem and antilinearity are beyond this file); infinite-dimensional self-adjointness
  (everything here is bare linear algebra over CC plus scalar exp identities).
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.Module.LinearMap.End
import Mathlib.Analysis.SpecialFunctions.Complex.Log
import Mathlib.Data.ZMod.Basic
import Mathlib.LinearAlgebra.Matrix.Notation

namespace Toesnail.DiscreteNoether

open Complex

/-! ### 1. Finite-order symmetries: the multiplicative conserved quantum number -/

section Abstract

variable {V : Type*} [AddCommGroup V] [Module ℂ V]

/-- Iterating a symmetry on an eigenvector iterates the eigenvalue. -/
theorem pow_apply_eigenvector (S : Module.End ℂ V) {μ : ℂ} {ψ : V}
    (hev : S ψ = μ • ψ) : ∀ m : ℕ, (S ^ m) ψ = μ ^ m • ψ := by
  intro m
  induction m with
  | zero => simp
  | succ m ih =>
      rw [pow_succ, Module.End.mul_apply, hev, map_smul, ih, smul_smul, ← pow_succ']

/-- **A discrete symmetry's charge is a root of unity.** If `S` has finite order
    (`S ^ n = 1`, named hypothesis `horder`) then every eigenvalue of `S` satisfies
    `μ ^ n = 1`. The charge lives in Z_n, multiplicatively. -/
theorem eigenvalue_pow_eq_one [NoZeroSMulDivisors ℂ V]
    (S : Module.End ℂ V) {n : ℕ} (horder : S ^ n = 1)
    {μ : ℂ} {ψ : V} (hψ : ψ ≠ 0) (hev : S ψ = μ • ψ) : μ ^ n = 1 := by
  have hfix : ψ = μ ^ n • ψ := by
    have h := pow_apply_eigenvector S hev n
    rw [horder, Module.End.one_apply] at h
    exact h
  have hzero : (μ ^ n - 1) • ψ = 0 := by
    rw [sub_smul, one_smul, ← hfix, sub_self]
  rcases smul_eq_zero.mp hzero with h | h
  · exact sub_eq_zero.mp h
  · exact absurd h hψ

/-- **Parity: the charge is a sign.** `P ^ 2 = 1` forces every eigenvalue to be
    `1` or `-1`. The aside's headline case. -/
theorem parity_eigenvalue [NoZeroSMulDivisors ℂ V]
    (P : Module.End ℂ V) (horder : P ^ 2 = 1)
    {μ : ℂ} {ψ : V} (hψ : ψ ≠ 0) (hev : P ψ = μ • ψ) : μ = 1 ∨ μ = -1 := by
  have h := eigenvalue_pow_eq_one P horder hψ hev
  rw [pow_two] at h
  exact mul_self_eq_one_iff.mp h

/-- **Conservation.** If the evolution `U` commutes with the symmetry `S` (named
    hypothesis `hcomm`), an `S`-eigenvector stays an `S`-eigenvector with the SAME
    eigenvalue under evolution. Feed `hcomm` from `[S,H] = 0` via the sibling
    `TimeEvolution.lean`'s `U_commute`. This is what a discrete symmetry conserves:
    a label, not a current. -/
theorem eigenvector_stays (S U : Module.End ℂ V) (hcomm : Commute S U)
    {μ : ℂ} {ψ : V} (hev : S ψ = μ • ψ) : S (U ψ) = μ • (U ψ) := by
  rw [← Module.End.mul_apply, hcomm.eq, Module.End.mul_apply, hev, map_smul]

/-- **Charges compose multiplicatively.** A state carrying charge `μ` under `S` and
    `ν` under `T` carries charge `μ * ν` under the composite. Contrast with
    `phase_additive` below. -/
theorem charges_multiply (S T : Module.End ℂ V) {μ ν : ℂ} {ψ : V}
    (hS : S ψ = μ • ψ) (hT : T ψ = ν • ψ) : (S * T) ψ = (μ * ν) • ψ := by
  rw [Module.End.mul_apply, hT, map_smul, hS, smul_smul, mul_comm]

end Abstract

/-- **The continuous contrast: phases ADD.** For a one-parameter family
    `t ↦ exp(i t E)` the group law composes by ADDING the parameter, so the conserved
    label `E` of a continuous symmetry is additive where the discrete `Z_n` charge is
    multiplicative. The operator (matrix) version `U(t) * U(s) = U(t+s)` is
    `TimeEvolution.lean`'s `U_group`; this scalar identity is the eigenvalue shadow. -/
theorem phase_additive (E t s : ℝ) :
    Complex.exp (Complex.I * t * E) * Complex.exp (Complex.I * s * E)
      = Complex.exp (Complex.I * (t + s) * E) := by
  rw [← Complex.exp_add]
  congr 1
  ring

/-! ### 2. Parity on an explicit 3-site chain -/

section Chain

open Matrix

/-- Reflection (parity) on a 3-site chain: site 0 <-> site 2, site 1 fixed. -/
def P3 : Matrix (Fin 3) (Fin 3) ℂ := !![0,0,1; 0,1,0; 1,0,0]

/-- Nearest-neighbour hopping Hamiltonian on the 3-site chain. -/
def H3 : Matrix (Fin 3) (Fin 3) ℂ := !![0,1,0; 1,0,1; 0,1,0]

theorem P3_sq : P3 * P3 = 1 := by
  rw [P3, mul_fin_three, Matrix.one_fin_three]
  norm_num

theorem P3_comm_H3 : Commute P3 H3 := by
  show P3 * H3 = H3 * P3
  rw [P3, H3, mul_fin_three, mul_fin_three]
  norm_num

/-- The even eigenvector `(1,0,1)` of parity. -/
theorem P3_even : P3.mulVec ![1, 0, 1] = ![1, 0, 1] := by
  funext i
  fin_cases i <;> simp [P3, Matrix.mulVec, dotProduct, Fin.sum_univ_three]

/-- The odd eigenvector `(1,0,-1)` of parity. -/
theorem P3_odd : P3.mulVec ![1, 0, -1] = (-1 : ℂ) • ![1, 0, -1] := by
  funext i
  fin_cases i <;> simp [P3, Matrix.mulVec, dotProduct, Fin.sum_univ_three]

/-- Selection-rule engine, concretely: `H3` maps each parity sector to itself,
    because `[P3, H3] = 0`. Stated for an arbitrary parity eigenvector. -/
theorem H3_preserves_parity {μ : ℂ} {v : Fin 3 → ℂ} (hv : P3.mulVec v = μ • v) :
    P3.mulVec (H3.mulVec v) = μ • H3.mulVec v := by
  rw [Matrix.mulVec_mulVec, P3_comm_H3.eq, ← Matrix.mulVec_mulVec, hv,
    Matrix.mulVec_smul]

/-- Theorem `parity_eigenvalue` instantiated on the chain: any eigenvalue of `P3`
    is `1` or `-1`. -/
theorem P3_eigenvalue_pm_one {μ : ℂ} {v : Fin 3 → ℂ} (hv : v ≠ 0)
    (hev : P3.mulVec v = μ • v) : μ = 1 ∨ μ = -1 := by
  refine parity_eigenvalue P3.mulVecLin ?_ hv ?_
  · show P3.mulVecLin * P3.mulVecLin = 1
    rw [Module.End.mul_eq_comp, ← Matrix.mulVecLin_mul, P3_sq, Matrix.mulVecLin_one]
    rfl
  · simpa [Matrix.mulVecLin_apply] using hev

end Chain

/-! ### 3. Bloch: quasi-momentum conserved modulo a reciprocal lattice vector -/

section Bloch

/-- Bloch wave on the 1D lattice ZZ (lattice constant 1): `x ↦ exp(i q x)`. -/
noncomputable def blochWave (q : ℝ) : ℤ → ℂ := fun x => Complex.exp (Complex.I * q * x)

/-- The Bloch wave is a translation eigenvector: shifting one site multiplies it by
    the fixed phase `exp(i q)`. -/
theorem blochWave_translate (q : ℝ) (x : ℤ) :
    blochWave q (x + 1) = Complex.exp (Complex.I * q) * blochWave q x := by
  unfold blochWave
  rw [← Complex.exp_add]
  congr 1
  push_cast
  ring

/-- **Umklapp.** Adding the reciprocal lattice vector `2 * pi` (lattice constant 1)
    to the quasi-momentum does not change the Bloch wave at all: `q` is a label
    defined only modulo `2 * pi`. -/
theorem quasimomentum_umklapp (q : ℝ) (x : ℤ) :
    blochWave (q + 2 * Real.pi) x = blochWave q x := by
  unfold blochWave
  have h : Complex.I * ↑(q + 2 * Real.pi) * (x : ℂ)
      = Complex.I * q * x + (x : ℂ) * (2 * (Real.pi : ℂ) * Complex.I) := by
    push_cast
    ring
  rw [h, Complex.exp_add, Complex.exp_int_mul_two_pi_mul_I, mul_one]

/-- **Exactly modulo.** Two quasi-momenta give the same translation eigenvalue IFF
    they differ by an integer multiple of `2 * pi`. This is the sharp form of
    "momentum is conserved modulo a reciprocal lattice vector": the conserved label
    is a point of the circle RR/(2 pi ZZ), not a real number. -/
theorem translation_eigenvalue_eq_iff (q q' : ℝ) :
    Complex.exp (Complex.I * q) = Complex.exp (Complex.I * q') ↔
      ∃ m : ℤ, q = q' + m * (2 * Real.pi) := by
  rw [Complex.exp_eq_exp_iff_exists_int]
  constructor
  · rintro ⟨m, hm⟩
    refine ⟨m, ?_⟩
    have h2 : Complex.I * q = Complex.I * (↑q' + (m : ℂ) * (2 * (Real.pi : ℂ))) := by
      rw [hm]; ring
    have h3 := mul_left_cancel₀ Complex.I_ne_zero h2
    exact_mod_cast h3
  · rintro ⟨m, hm⟩
    exact ⟨m, by rw [hm]; push_cast; ring⟩

/-- Translation by one site on a ring of `n` sites, as a linear operator on wave
    functions `ZMod n → ℂ`. -/
def translate (n : ℕ) : Module.End ℂ (ZMod n → ℂ) where
  toFun ψ := fun x => ψ (x + 1)
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

theorem translate_pow_apply (n : ℕ) (m : ℕ) :
    ∀ (ψ : ZMod n → ℂ) (x : ZMod n), ((translate n) ^ m) ψ x = ψ (x + m) := by
  induction m with
  | zero => intro ψ x; simp
  | succ m ih =>
      intro ψ x
      rw [pow_succ, Module.End.mul_apply, ih]
      show ψ (x + m + 1) = ψ (x + ↑(m + 1))
      congr 1
      push_cast
      ring

/-- On the ring, translation has FINITE ORDER: going all the way around is the
    identity. This is what replaces "the symmetry group is a Lie group" for a
    lattice, and it is why the conserved label degrades from a real momentum to a
    `Z_n` charge. -/
theorem translate_pow_n (n : ℕ) : (translate n) ^ n = 1 := by
  apply LinearMap.ext
  intro ψ
  funext x
  rw [translate_pow_apply]
  simp

/-- **Discrete Noether on the ring, assembled.** The quasi-momentum label of a
    translation eigenstate on an `n`-site ring is an `n`-th root of unity, i.e. a
    `Z_n` charge: conserved (by `eigenvector_stays`, given `[T,H] = 0`) and defined
    only modulo `n`. Direct corollary of `eigenvalue_pow_eq_one` + `translate_pow_n`. -/
theorem ring_quasimomentum (n : ℕ) {μ : ℂ} {ψ : ZMod n → ℂ} (hψ : ψ ≠ 0)
    (hev : translate n ψ = μ • ψ) : μ ^ n = 1 :=
  eigenvalue_pow_eq_one (translate n) (translate_pow_n n) hψ hev

end Bloch

end Toesnail.DiscreteNoether

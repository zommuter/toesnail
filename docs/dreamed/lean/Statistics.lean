/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`.

  Lean tier for the `lambertw` branch/domain caveat of `physics/entropy.md`.

  Source handles (owner-authored, `physics/entropy.md`):

    `be`       (l.27)  ⟨k⟩ = Z₁/(1−Z₁) = 1/(e^{βE₁} − 1)          N → ∞, Bose-Einstein
    `fd`       (l.35)  ⟨k⟩ = Z₁/(1+Z₁) = 1/(e^{βE₁} + 1)          N = 2,  Fermi-Dirac
    `lambertw` (l.59)  βE₁ = −W(−βE·e^{∓βE}) ∓ βE                 (badge `\leanc`, open debt)

  Mathlib (rev pinned in `verify/lake-manifest.json`) has NO Lambert W: the only
  `lambert` hit under `Mathlib/` is `NumberTheory/TsumDivisorsAntidiagonal.lean`
  (Lambert *series*, unrelated). So this file deliberately proves the `lambertw`
  step's PRECONDITION rather than the step itself: the branch/injectivity fact that
  licenses "…hence x = −W(…)", stated W-free. That is exactly the half the
  2026-06-21 meeting (id:3d2a, D1) isolated as the unverified caveat, and it needs no
  Lambert W to state or to prove.

  Identifier mapping (`physics/entropy.md` l.53 sets `βE₁ =: x`, `βE =: y`):
    `x`  ↔ βE₁  (dimensionless level spacing), `y` ↔ βE (dimensionless energy),
    `X`  ↔ the shifted variable the owner introduces at l.55-56 by `x → x ∓ y`;
           bosonic `X = x + y`, fermionic `X = x − y`.
    `F u = u * exp u` is the function Lambert W inverts (`W(F u) = u` on a branch).
    `z`  ↔ Z₁ = e^{−βE₁}.

  EXPLICITLY OUT OF SCOPE (not proven here, do not read this file as covering it):
   * any statement naming W itself, any branch of it, or its existence;
   * the entropy maximisation (l.8-12) producing p_k = Z_k/Z_B;
   * the ⟨k⟩ closed form for general N (handle `meanE`, l.22) and the N → ∞ limit;
   * the fermionic NON-uniqueness (two pre-images for every physical βE): established
     numerically only in the essay, not formalised here;
   * the physical identification of x, y with any measured quantity.
-/
import Mathlib.Analysis.Calculus.Deriv.MeanValue
import Mathlib.Analysis.SpecialFunctions.ExpDeriv

namespace ToesnailDreamed.Statistics

open Real Set

/-! ### 1. The closed forms (handles `be`, `fd`) -/

/-- Handle `be` (`physics/entropy.md` l.27), algebraic half: with `z = e^{−x}` and
    `x > 0`, the geometric-series value `z/(1−z)` equals `1/(e^x − 1)`. -/
theorem be_closed_form {x : ℝ} (hx : 0 < x) :
    Real.exp (-x) / (1 - Real.exp (-x)) = 1 / (Real.exp x - 1) := by
  have h1 : Real.exp x ≠ 0 := (Real.exp_pos x).ne'
  have hlt : (1 : ℝ) < Real.exp x := by
    have := Real.add_one_lt_exp hx.ne'; linarith
  have h2 : Real.exp x - 1 ≠ 0 := by linarith
  have h3 : 1 - Real.exp (-x) ≠ 0 := by
    have h4 : Real.exp (-x) < 1 := by
      rw [Real.exp_neg, inv_lt_one_iff₀]; right; exact hlt
    linarith
  rw [Real.exp_neg]
  field_simp

/-- Handle `fd` (`physics/entropy.md` l.35), algebraic half: with `z = e^{−x}`,
    `z/(1+z) = 1/(e^x + 1)`. No positivity of `x` needed. -/
theorem fd_closed_form (x : ℝ) :
    Real.exp (-x) / (1 + Real.exp (-x)) = 1 / (Real.exp x + 1) := by
  have h1 : Real.exp x ≠ 0 := (Real.exp_pos x).ne'
  have h2 : (0:ℝ) < Real.exp x + 1 := by have := Real.exp_pos x; linarith
  have h3 : (0:ℝ) < 1 + Real.exp (-x) := by have := Real.exp_pos (-x); linarith
  rw [Real.exp_neg]
  field_simp

/-- Handle `fd`, the `N = 2` collapse of `Z_B = (1 − z^N)/(1 − z)`
    (`physics/entropy.md` l.34): `(1 − z²)/(1 − z) = 1 + z` for `z ≠ 1`. -/
theorem partition_N_two {z : ℝ} (hz : z ≠ 1) : (1 - z ^ 2) / (1 - z) = 1 + z := by
  have h : 1 - z ≠ 0 := sub_ne_zero.mpr (Ne.symm hz)
  field_simp
  ring

/-! ### 2. `F u = u · e^u`, the function Lambert W inverts -/

/-- `F u = u * exp u`. `W` is by definition a partial inverse of `F`; every branch
    question about `W` is a question about which piece of `F` is being inverted. -/
noncomputable def F (u : ℝ) : ℝ := u * Real.exp u

theorem hasDerivAt_F (u : ℝ) : HasDerivAt F ((1 + u) * Real.exp u) u := by
  have h : HasDerivAt (fun t : ℝ => t * Real.exp t)
      (1 * Real.exp u + u * Real.exp u) u :=
    (hasDerivAt_id u).mul (Real.hasDerivAt_exp u)
  exact h.congr_deriv (by ring)

theorem deriv_F (u : ℝ) : deriv F u = (1 + u) * Real.exp u := (hasDerivAt_F u).deriv

theorem continuous_F : Continuous F :=
  continuous_id.mul Real.continuous_exp

/-- **The branch condition, upper piece.** `F` is strictly increasing on `[−1, ∞)`.
    This is the `W₀` branch: `W₀ = F⁻¹` there. -/
theorem strictMonoOn_F : StrictMonoOn F (Ici (-1 : ℝ)) := by
  apply strictMonoOn_of_deriv_pos (convex_Ici _) continuous_F.continuousOn
  intro u hu
  rw [interior_Ici] at hu
  rw [deriv_F]
  have h1 : (0:ℝ) < 1 + u := by simp only [mem_Ioi] at hu; linarith
  exact mul_pos h1 (Real.exp_pos u)

/-- **The branch condition, lower piece.** `F` is strictly decreasing on `(−∞, −1]`.
    This is the `W₋₁` branch. Together with `strictMonoOn_F` these are the only two
    pieces on which `F` is injective, and they meet at `u = −1`, `F(−1) = −1/e`. -/
theorem strictAntiOn_F : StrictAntiOn F (Iic (-1 : ℝ)) := by
  apply strictAntiOn_of_deriv_neg (convex_Iic _) continuous_F.continuousOn
  intro u hu
  rw [interior_Iic] at hu
  rw [deriv_F]
  have h1 : 1 + u < 0 := by simp only [mem_Iio] at hu; linarith
  exact mul_neg_of_neg_of_pos h1 (Real.exp_pos u)

/-- **The range bound.** `F u ≥ −1/e` for every real `u`. (Equality holds exactly at
    `u = −1`; only the `≥` half is proved here.) Equivalently `t·e^{−t} ≤ e^{−1}`.
    This is why a real `W(v)` exists exactly for `v ≥ −1/e`, and it is the fermionic
    existence condition below. -/
theorem neg_exp_neg_one_le_F (u : ℝ) : -Real.exp (-1) ≤ F u := by
  rcases le_or_gt 0 u with h | h
  · have : 0 ≤ u * Real.exp u := mul_nonneg h (Real.exp_pos u).le
    have hpos : (0:ℝ) < Real.exp (-1) := Real.exp_pos _
    simp only [F]; linarith
  · -- for u < 0 write t = -u > 0 and use  t ≤ exp (t - 1)
    have key : -u ≤ Real.exp (-u - 1) := by
      have := Real.add_one_le_exp (-u - 1)
      linarith
    have hpos : (0:ℝ) < Real.exp u := Real.exp_pos u
    have h2 : -u * Real.exp u ≤ Real.exp (-u - 1) * Real.exp u :=
      mul_le_mul_of_nonneg_right key hpos.le
    have h3 : Real.exp (-u - 1) * Real.exp u = Real.exp (-1) := by
      rw [← Real.exp_add]; ring_nf
    simp only [F]
    rw [h3] at h2
    linarith

/-! ### 3. The owner's inversion chain (`physics/entropy.md` l.53-57) -/

/-- Bosonic chain, upper sign. From `y = x/(e^x − 1)` (handle `be` read as
    `βE = βE₁·⟨k⟩`) the owner's l.55-57 substitution `X = x + y` gives
    `−y·e^{−y} = −X·e^{−X}`, i.e. `F(−y) = F(−X)`. Pure algebra, no `W`. -/
theorem be_chain {x y : ℝ} (hy : y * (Real.exp x - 1) = x) :
    F (-y) = F (-(x + y)) := by
  have hxe : Real.exp (x + y) = Real.exp x * Real.exp y := Real.exp_add x y
  simp only [F, Real.exp_neg, hxe]
  have h1 : (0:ℝ) < Real.exp x := Real.exp_pos x
  have h2 : (0:ℝ) < Real.exp y := Real.exp_pos y
  field_simp
  nlinarith [hy, h1, h2]

/-- Fermionic chain, lower sign. From `y = x/(e^x + 1)` and `X = x − y`,
    `−y·e^{y} = −X·e^{−X}`, i.e. `F y = −F(−X)`: the fermionic chain flips the
    sign relative to the bosonic one because the shift is `x − y`, not `x + y`.
    Pure algebra, no `W`. -/
theorem fd_chain {x y : ℝ} (hy : y * (Real.exp x + 1) = x) :
    F y = -F (-(x - y)) := by
  have hxe : Real.exp (x - y) = Real.exp x / Real.exp y := by
    rw [Real.exp_sub]
  have h1 : (0:ℝ) < Real.exp x := Real.exp_pos x
  have h2 : (0:ℝ) < Real.exp y := Real.exp_pos y
  simp only [F, Real.exp_neg, hxe]
  field_simp
  nlinarith [hy, h1, h2]

/-! ### 4. What the branches actually say about the owner's `lambertw` line -/

/-- **Bosonic range.** `y = x/(e^x − 1) < 1` for every `x > 0`, so `−y > −1`:
    the bosonic argument of `W` always sits on the `W₀` side of the branch point. -/
theorem be_y_lt_one {x y : ℝ} (hx : 0 < x) (hy : y * (Real.exp x - 1) = x) : y < 1 := by
  have h1 : x + 1 < Real.exp x := Real.add_one_lt_exp hx.ne'
  have h2 : (0:ℝ) < Real.exp x - 1 := by linarith
  have : y = x / (Real.exp x - 1) := by field_simp at hy ⊢; linarith
  rw [this, div_lt_one h2]; linarith

/-- **The bosonic branch verdict (the point of this file).** For `x > 0` the shifted
    variable `X = x + y` satisfies `X > 1`, i.e. `−X < −1`: the root the owner needs
    lies on the `W₋₁` branch, NOT the principal one. Proved from injectivity of `F`
    on `[−1, ∞)` alone: if `−X` were `≥ −1` it would have to equal `−y`, forcing
    `x = 0`. -/
theorem be_shift_gt_one {x y : ℝ} (hx : 0 < x) (hy : y * (Real.exp x - 1) = x) :
    1 < x + y := by
  by_contra hcon
  simp only [not_lt] at hcon
  have hy1 : y < 1 := be_y_lt_one hx hy
  have hmem1 : (-(x + y)) ∈ Ici (-1 : ℝ) := by simp only [mem_Ici]; linarith
  have hmem2 : (-y) ∈ Ici (-1 : ℝ) := by simp only [mem_Ici]; linarith
  have := strictMonoOn_F.injOn hmem2 hmem1 (be_chain hy)
  linarith

/-- **The principal branch returns the trivial root.** `−y` is a solution of
    `F u = F(−y)` lying in `[−1, ∞)`, and it is the ONLY one there. Read through
    `βE₁ = −W(−βE·e^{−βE}) − βE`, taking `W = W₀` yields `βE₁ = y − y = 0`
    identically. This is a statement about the formula, not about the physics. -/
theorem be_principal_root_is_trivial {x y u : ℝ} (hx : 0 < x)
    (hy : y * (Real.exp x - 1) = x) (hu : u ∈ Ici (-1 : ℝ)) (heq : F u = F (-y)) :
    u = -y := by
  have hy1 : y < 1 := be_y_lt_one hx hy
  have hmem : (-y) ∈ Ici (-1 : ℝ) := by simp only [mem_Ici]; linarith
  exact strictMonoOn_F.injOn hu hmem heq

/-- **Bosonic uniqueness on the correct branch.** On `(−∞, −1]` the shifted root is
    unique, so `βE₁ = −W₋₁(−βE·e^{−βE}) − βE` is single-valued. -/
theorem be_second_branch_unique {x y v : ℝ} (hx : 0 < x)
    (hy : y * (Real.exp x - 1) = x) (hv : v ∈ Iic (-1 : ℝ)) (heq : F v = F (-y)) :
    v = -(x + y) := by
  have hX : 1 < x + y := be_shift_gt_one hx hy
  have hmem : (-(x + y)) ∈ Iic (-1 : ℝ) := by simp only [mem_Iic]; linarith
  exact strictAntiOn_F.injOn hv hmem (heq.trans (be_chain hy))

/-- **The fermionic existence condition, tight.** For `y = x/(e^x + 1)` the argument
    of `W` never leaves the real domain: `−y·e^{y} ≥ −1/e`. Hence a real `W` value
    always exists for the fermionic branch of `physics/entropy.md` l.59. The essay
    shows numerically that this bound is SATURATED at `y = W₀(1/e) ≈ 0.2784645`,
    where the two branches meet, and that BOTH branches are attained for smaller `y`
    (so the fermionic inversion is two-valued). That non-uniqueness is not formalised
    here. -/
theorem fd_arg_ge_neg_inv_e {x y : ℝ} (hy : y * (Real.exp x + 1) = x) :
    -Real.exp (-1) ≤ -F y := by
  rw [fd_chain hy, neg_neg]
  exact neg_exp_neg_one_le_F _

end ToesnailDreamed.Statistics

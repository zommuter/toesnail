/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`.

  Lean attestation for `docs/dreamed/wirohsh-discontinuities.md` (round 2), seeded from
  the owner's own question in `physics/wirohsh.md:82`:

      "While this solution is actually valid for any function, even discontinuous ones
       for example, the detour to the discrete Laurent series did impose the condition
       of being holomorphic to the two waves. In smooth regions those are perfectly
       sufficient, however the question is what happens to non-holomorphic parts in
       this approach."

  ROUND 1 (`docs/dreamed/lean/Wirohsh.lean`) proved `dalembert_wave`: that
  `g(x - c t) + h(x + c t)` SOLVES the 1D wave equation. That theorem is NOT reproved
  here and nothing is imported from that file. This file is the INITIAL-DATA half: which
  `(g, h)` a given `(phi, psi)` forces, how unique that choice is, and the algebra of the
  boundary-value (Sokhotski-Plemelj / Poisson) representation of the non-holomorphic data.

  Contents, each faithful to a display equation in the essay.

  1. `sokhotski_plemelj_finite` (handle `sp-finite`)
     `1/(x - I e) - 1/(x + I e) = 2 I e / (x^2 + e^2)` in ℂ for real `x, e`, `e <> 0`.
     This is the whole delta-as-a-boundary-value statement with the limit removed: the
     jump of `1/z` across the real axis at finite `e` is exactly `2 I e/(x^2+e^2)`.

  2. `poisson_from_boundary_jump` (handle `delta-boundary`)
     `-(1/(2 pi I)) * (1/(x + I e) - 1/(x - I e)) = (1/pi) * (e/(x^2+e^2))`, i.e. the
     owner's two conjugate half-plane pieces reassemble into the (real, positive) Poisson
     kernel. Rewriting of 1., but it is the form the essay actually displays.

  3. `poisson_nonneg`, `poisson_integral_one` (handle `poisson-mass`)
     The Poisson kernel is a probability density on ℝ: nonnegative, total mass 1.
     Mass via Mathlib's `integral_univ_inv_one_add_sq` plus the scaling
     `Measure.integral_comp_div`.

  4. `poisson_partial_fraction`, `poisson_denominator` (handle `abel-poisson`)
     The Abel-summed Laurent series of the periodic delta, at the level of the two closed
     geometric sums:
        1/(1 - r w) + (r/w)/(1 - r/w) = (1 - r^2)/((1 - r w)(1 - r/w))
        (1 - r w)(1 - r/w) = 1 - 2 r cos(phi) + r^2       for w = exp(i phi)
     OUT OF SCOPE: that the geometric series actually sums to `1/(1 - r w)` for `|r| < 1`
     (standard, `tsum_geometric_of_norm_lt_one`), and the `r -> 1` distributional limit.
     Only the algebra of the closed forms is proved.

  5. `dalembert_initial_position`, `dalembert_time_deriv`,
     `dalembert_initial_velocity` (handle `riemann-split`)
     The forced split. With `Psi' = psi`,
        f^+(s) = phi(s)/2 - Psi(s)/(2c) - K/2,   f^-(s) = phi(s)/2 + Psi(s)/(2c) + K/2,
     `f(x,t) = f^+(x - c t) + f^-(x + c t)` has `f(x,0) = phi(x)` (for ANY `phi`, `Psi`,
     `K`, `c`: no regularity, no `c <> 0`) and `d_t f(x,0) = psi(x)`.

  6. `split_ambiguity_is_constant`, `split_unique_up_to_constant` (handle `split-unique`)
     The ONLY non-uniqueness of the split is one additive constant, and it cancels.

  7. `right_mover_undistorted`, `square_pulse_separates` (handle `pulse-undistorted`)
     A jump travels at speed `c` without smoothing: the right-moving half of the solution,
     evaluated along the characteristic `X = x + c t`, is `phi(x)/2` for EVERY `t`, with no
     regularity hypothesis on `phi` whatsoever; and for a square pulse the two halves have
     separated once `c t > 2 a`, each of height exactly `1/2`.
     OUT OF SCOPE: that the discontinuous `f` solves the wave equation in the DISTRIBUTIONAL
     sense. That is the honest weakening -- see the essay's "Lean attestation" section.

  Identifier mapping (owner convention: a derivative is named `<f>_<var>`, the subscript
  naming the differentiation variable; NOT `xd`/`xdd`; Lean rejects the combining-dot forms):
      `phi_x`      <-> phi'          (initial-position profile derivative)
      `psi`, `Psi` <-> psi, its antiderivative (Psi' = psi)
      `f_t`        <-> d_t f
  `c` is the wave speed, `e` the regulator the essay writes as `epsilon`, `K` the split
  constant, `r` the Abel radius, `w = exp(i phi)` the point on the Wick-rotated shell.
-/
import Mathlib.Analysis.Complex.Trigonometric
import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.Calculus.Deriv.Comp

open Complex Real MeasureTheory

namespace WirohshDiscont

/-! ## 1. Sokhotski-Plemelj at finite regulator (handle `sp-finite`) -/

/-- For real `x` and real `e <> 0`, the point `x + I e` is off the real axis, hence
    nonzero. Needed as the denominator condition throughout §1-§2. -/
lemma add_I_mul_ne_zero (x e : ℝ) (he : e ≠ 0) : (x : ℂ) + Complex.I * (e : ℂ) ≠ 0 := by
  intro h
  have := congrArg Complex.im h
  simp at this
  exact he this

lemma sub_I_mul_ne_zero (x e : ℝ) (he : e ≠ 0) : (x : ℂ) - Complex.I * (e : ℂ) ≠ 0 := by
  intro h
  have := congrArg Complex.im h
  simp at this
  exact he this

/-- **Sokhotski-Plemelj, finite regulator, no limit.**  For real `x` and `e <> 0`,

      1/(x - I e) - 1/(x + I e) = 2 I e / (x^2 + e^2).

    The right-hand side is `2 I` times the Poisson kernel (up to the `1/pi`), so this
    single algebraic identity IS the statement that the delta is the JUMP of `1/z` across
    the real axis. No analysis is used; `e -> 0` is deliberately not taken. -/
theorem sokhotski_plemelj_finite (x e : ℝ) (he : e ≠ 0) :
    1 / ((x : ℂ) - Complex.I * (e : ℂ)) - 1 / ((x : ℂ) + Complex.I * (e : ℂ))
      = 2 * Complex.I * (e : ℂ) / ((x : ℂ) ^ 2 + (e : ℂ) ^ 2) := by
  have h1 := add_I_mul_ne_zero x e he
  have h2 := sub_I_mul_ne_zero x e he
  have hprod : ((x : ℂ) - Complex.I * (e : ℂ)) * ((x : ℂ) + Complex.I * (e : ℂ))
      = (x : ℂ) ^ 2 + (e : ℂ) ^ 2 := by
    have : Complex.I ^ 2 = -1 := Complex.I_sq
    linear_combination (-(e : ℂ) ^ 2) * this
  have h3 : ((x : ℂ) ^ 2 + (e : ℂ) ^ 2) ≠ 0 := by rw [← hprod]; exact mul_ne_zero h2 h1
  rw [div_sub_div _ _ h2 h1, hprod]
  congr 1
  ring

/-! ## 2. The Poisson kernel as the two-sided boundary value (handle `delta-boundary`) -/

/-- **The delta as a boundary value, at finite regulator.**  The owner's two conjugate
    pieces, `1/(x + I e)` from the upper half plane and `1/(x - I e)` from the lower,
    recombine into the REAL, POSITIVE Poisson kernel:

      -(1/(2 pi I)) * ( 1/(x + I e) - 1/(x - I e) ) = (1/pi) * ( e / (x^2 + e^2) ).

    Combined with `poisson_integral_one` below, this is `delta = -(1/2 pi I)[1/(x+i0) -
    1/(x-i0)]` with the limit stripped out. -/
theorem poisson_from_boundary_jump (x e : ℝ) (he : e ≠ 0) :
    -(1 / (2 * (Real.pi : ℂ) * Complex.I))
        * (1 / ((x : ℂ) + Complex.I * (e : ℂ)) - 1 / ((x : ℂ) - Complex.I * (e : ℂ)))
      = (1 / (Real.pi : ℂ)) * ((e : ℂ) / ((x : ℂ) ^ 2 + (e : ℂ) ^ 2)) := by
  have hsp := sokhotski_plemelj_finite x e he
  have hpi : (Real.pi : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr Real.pi_ne_zero
  have h1 := add_I_mul_ne_zero x e he
  have h2 := sub_I_mul_ne_zero x e he
  have hprod : ((x : ℂ) - Complex.I * (e : ℂ)) * ((x : ℂ) + Complex.I * (e : ℂ))
      = (x : ℂ) ^ 2 + (e : ℂ) ^ 2 := by
    linear_combination (-(e : ℂ) ^ 2) * Complex.I_sq
  have h3 : ((x : ℂ) ^ 2 + (e : ℂ) ^ 2) ≠ 0 := by rw [← hprod]; exact mul_ne_zero h2 h1
  have hswap : 1 / ((x : ℂ) + Complex.I * (e : ℂ)) - 1 / ((x : ℂ) - Complex.I * (e : ℂ))
      = -(2 * Complex.I * (e : ℂ) / ((x : ℂ) ^ 2 + (e : ℂ) ^ 2)) := by
    rw [← hsp]; ring
  rw [hswap]
  have hI : Complex.I ≠ 0 := Complex.I_ne_zero
  field_simp

/-! ## 3. The Poisson kernel is a probability density (handle `poisson-mass`) -/

/-- The Poisson kernel is nonnegative for `e > 0`. -/
theorem poisson_nonneg (e : ℝ) (he : 0 < e) (x : ℝ) :
    0 ≤ (1 / Real.pi) * (e / (x ^ 2 + e ^ 2)) := by
  have hd : 0 < x ^ 2 + e ^ 2 := by positivity
  have : 0 < Real.pi := Real.pi_pos
  positivity

/-- **The Poisson kernel has total mass 1.**  For every `e > 0`,

      ∫_ℝ (1/pi) * e/(x^2 + e^2) dx = 1.

    Proved by rescaling `x = e y` (Mathlib `Measure.integral_comp_div`) onto
    `∫_ℝ (1 + y^2)⁻¹ = pi` (`integral_univ_inv_one_add_sq`). Together with
    `poisson_from_boundary_jump` this pins the normalisation of the delta: the jump of
    `-(1/2 pi I) * 1/z` across ℝ is a unit mass for every `e`, so the `e -> 0` limit
    cannot be anything but `delta`. -/
theorem poisson_integral_one (e : ℝ) (he : 0 < e) :
    (∫ x : ℝ, (1 / Real.pi) * (e / (x ^ 2 + e ^ 2))) = 1 := by
  have hpi : (Real.pi : ℝ) ≠ 0 := Real.pi_ne_zero
  have he' : e ≠ 0 := ne_of_gt he
  have key : (∫ x : ℝ, (1 + (x / e) ^ 2)⁻¹) = |e| • ∫ y : ℝ, (1 + y ^ 2)⁻¹ :=
    Measure.integral_comp_div (fun y : ℝ => (1 + y ^ 2)⁻¹) e
  rw [integral_univ_inv_one_add_sq, abs_of_pos he, smul_eq_mul] at key
  have hpt : ∀ x : ℝ, (1 / Real.pi) * (e / (x ^ 2 + e ^ 2))
      = (1 / (Real.pi * e)) * (1 + (x / e) ^ 2)⁻¹ := by
    intro x
    have hd : x ^ 2 + e ^ 2 ≠ 0 := by positivity
    have hd2 : (1 : ℝ) + (x / e) ^ 2 ≠ 0 := by positivity
    field_simp
    ring
  calc (∫ x : ℝ, (1 / Real.pi) * (e / (x ^ 2 + e ^ 2)))
      = ∫ x : ℝ, (1 / (Real.pi * e)) * (1 + (x / e) ^ 2)⁻¹ := by
        simp only [hpt]
    _ = (1 / (Real.pi * e)) * ∫ x : ℝ, (1 + (x / e) ^ 2)⁻¹ := by
        rw [MeasureTheory.integral_const_mul]
    _ = (1 / (Real.pi * e)) * (e * Real.pi) := by rw [key]
    _ = 1 := by field_simp

/-! ## 4. The Abel-Poisson closed form on the shell (handle `abel-poisson`) -/

/-- The two closed geometric sums of the owner's Laurent split, `m >= 0` in `z` and
    `m < 0` in `zbar`, add to a single quotient with numerator `1 - r^2`.  Written
    division-free so that no branch or convergence question enters:

      1 * (1 - r/w) + (r/w) * (1 - r w)  =  (1 - r^2)      when `w * w⁻¹ = 1`.

    OUT OF SCOPE: that these closed forms are the sums of the respective geometric
    series (standard for `|r| < 1`) and the `r -> 1` limit. -/
theorem poisson_partial_fraction (r w : ℂ) (hw : w ≠ 0) :
    (1 - r * w⁻¹) + (r * w⁻¹) * (1 - r * w) = 1 - r ^ 2 := by
  field_simp
  ring

/-- The common denominator of the two geometric sums is exactly the owner's shell
    expression `1 - 2 r cos(phi) + r^2`, for `w = exp(i phi)` on the unit circle.  This is
    where `w + w⁻¹ = 2 cos(phi)` is consumed, i.e. where the SHELL (the periodicity
    condition that made `m` discrete in the first place) enters. -/
theorem poisson_denominator (r φ : ℝ) :
    (1 - (r : ℂ) * Complex.exp ((φ : ℂ) * Complex.I))
      * (1 - (r : ℂ) * (Complex.exp ((φ : ℂ) * Complex.I))⁻¹)
      = 1 - 2 * (r : ℂ) * (Real.cos φ : ℂ) + (r : ℂ) ^ 2 := by
  set w := Complex.exp ((φ : ℂ) * Complex.I) with hwdef
  have hw : w ≠ 0 := Complex.exp_ne_zero _
  have hinv : w⁻¹ = Complex.exp (-(φ : ℂ) * Complex.I) := by
    rw [hwdef, ← Complex.exp_neg]
    ring_nf
  have hsum : w + w⁻¹ = 2 * (Real.cos φ : ℂ) := by
    rw [hinv, Complex.ofReal_cos]
    exact (Complex.two_cos (φ : ℂ)).symm
  have hmul : w * w⁻¹ = 1 := mul_inv_cancel₀ hw
  linear_combination (-(r : ℂ)) * hsum + ((r : ℂ) ^ 2) * hmul

/-! ## 5. The forced split: d'Alembert from `(phi, psi)` (handle `riemann-split`) -/

/-- The right-moving profile forced by initial data `(phi, psi)`, `Psi` an antiderivative
    of `psi`, `K` the free split constant. -/
noncomputable def fplus (c K : ℝ) (φ Ψ : ℝ → ℝ) (s : ℝ) : ℝ :=
  φ s / 2 - Ψ s / (2 * c) - K / 2

/-- The left-moving profile. -/
noncomputable def fminus (c K : ℝ) (φ Ψ : ℝ → ℝ) (s : ℝ) : ℝ :=
  φ s / 2 + Ψ s / (2 * c) + K / 2

lemma fplus_eq (c K : ℝ) (φ Ψ : ℝ → ℝ) :
    fplus c K φ Ψ = fun s => φ s / 2 - Ψ s / (2 * c) - K / 2 := rfl

lemma fminus_eq (c K : ℝ) (φ Ψ : ℝ → ℝ) :
    fminus c K φ Ψ = fun s => φ s / 2 + Ψ s / (2 * c) + K / 2 := rfl

/-- **The split reproduces the initial position, unconditionally.**  For ANY `phi`, ANY
    `Psi`, ANY split constant `K`, ANY `c` (including `c = 0`, where Lean's `x/0 = 0` still
    makes the two `Psi` terms cancel), and with no regularity whatsoever:

      f^+(x) + f^-(x) = phi(x).

    The absence of hypotheses is the point: a discontinuous `phi` is admitted verbatim. -/
theorem dalembert_initial_position (c K : ℝ) (φ Ψ : ℝ → ℝ) (x : ℝ) :
    fplus c K φ Ψ (x - c * 0) + fminus c K φ Ψ (x + c * 0) = φ x := by
  simp only [fplus, fminus, mul_zero, sub_zero, add_zero]
  ring

/-- Time derivative of the d'Alembert form at arbitrary `t`, with `HasDerivAt` witnesses
    for `phi` and `Psi` (Mathlib `deriv` is junk-on-failure, so the derivative values live
    in named hypotheses and never as `deriv` applications). -/
theorem dalembert_time_deriv (c K : ℝ) (φ Ψ φ_x ψ : ℝ → ℝ)
    (hφ : ∀ s, HasDerivAt φ (φ_x s) s) (hΨ : ∀ s, HasDerivAt Ψ (ψ s) s) (x t : ℝ) :
    HasDerivAt (fun s : ℝ => fplus c K φ Ψ (x - c * s) + fminus c K φ Ψ (x + c * s))
      (-c * (φ_x (x - c * t) / 2 - ψ (x - c * t) / (2 * c))
        + c * (φ_x (x + c * t) / 2 + ψ (x + c * t) / (2 * c))) t := by
  have innerMinus : HasDerivAt (fun s : ℝ => x - c * s) (-c) t := by
    simpa using ((hasDerivAt_id t).const_mul c).const_sub x
  have innerPlus : HasDerivAt (fun s : ℝ => x + c * s) c t := by
    simpa using ((hasDerivAt_id t).const_mul c).const_add x
  have hp : HasDerivAt (fun s : ℝ => fplus c K φ Ψ (x - c * s))
      ((φ_x (x - c * t) / 2 - ψ (x - c * t) / (2 * c)) * (-c)) t := by
    have base : HasDerivAt (fplus c K φ Ψ)
        (φ_x (x - c * t) / 2 - ψ (x - c * t) / (2 * c)) (x - c * t) := by
      rw [fplus_eq]
      exact (((hφ (x - c * t)).div_const 2).sub
        ((hΨ (x - c * t)).div_const (2 * c))).sub_const (K / 2)
    exact base.comp t innerMinus
  have hm : HasDerivAt (fun s : ℝ => fminus c K φ Ψ (x + c * s))
      ((φ_x (x + c * t) / 2 + ψ (x + c * t) / (2 * c)) * c) t := by
    have base : HasDerivAt (fminus c K φ Ψ)
        (φ_x (x + c * t) / 2 + ψ (x + c * t) / (2 * c)) (x + c * t) := by
      rw [fminus_eq]
      exact (((hφ (x + c * t)).div_const 2).add
        ((hΨ (x + c * t)).div_const (2 * c))).add_const (K / 2)
    exact base.comp t innerPlus
  have := hp.add hm
  refine this.congr_deriv ?_
  ring

/-- **The split reproduces the initial velocity.**  With `Psi' = psi` and `c <> 0`,

      d_t [ f^+(x - c t) + f^-(x + c t) ] |_{t=0} = psi(x),

    the `phi'` contributions cancelling between the two movers and the `psi` contributions
    adding. The split `f^+ = phi/2 - Psi/(2c) - K/2` and `f^- = phi/2 + Psi/(2c) + K/2`
    is therefore forced, and `K` is
    the only remaining freedom (§6). -/
theorem dalembert_initial_velocity (c K : ℝ) (hc : c ≠ 0) (φ Ψ φ_x ψ : ℝ → ℝ)
    (hφ : ∀ s, HasDerivAt φ (φ_x s) s) (hΨ : ∀ s, HasDerivAt Ψ (ψ s) s) (x : ℝ) :
    HasDerivAt (fun s : ℝ => fplus c K φ Ψ (x - c * s) + fminus c K φ Ψ (x + c * s))
      (ψ x) 0 := by
  have h := dalembert_time_deriv c K φ Ψ φ_x ψ hφ hΨ x 0
  refine h.congr_deriv ?_
  simp only [mul_zero, sub_zero, add_zero]
  field_simp
  ring

/-! ## 6. The split is unique up to one additive constant (handle `split-unique`) -/

/-- If a d'Alembert pair sums to zero identically, both profiles are constant (and
    opposite). `c <> 0` is what makes `(x,t) |-> (x - c t, x + c t)` surjective onto ℝ²,
    which is the whole content: the two light-cone coordinates are INDEPENDENT. -/
theorem split_ambiguity_is_constant (c : ℝ) (hc : c ≠ 0) (g h : ℝ → ℝ)
    (H : ∀ x t : ℝ, g (x - c * t) + h (x + c * t) = 0) :
    (∀ s, g s = g 0) ∧ (∀ s, h s = h 0) ∧ g 0 + h 0 = 0 := by
  have key : ∀ ξ η : ℝ, g ξ + h η = 0 := by
    intro ξ η
    have h1 : (ξ + η) / 2 - c * ((η - ξ) / (2 * c)) = ξ := by field_simp; ring
    have h2 : (ξ + η) / 2 + c * ((η - ξ) / (2 * c)) = η := by field_simp; ring
    have := H ((ξ + η) / 2) ((η - ξ) / (2 * c))
    rwa [h1, h2] at this
  refine ⟨fun s => ?_, fun s => ?_, key 0 0⟩
  · have a := key s 0
    have b := key 0 0
    linarith
  · have a := key 0 s
    have b := key 0 0
    linarith

/-- **Uniqueness of the `±` split up to a constant.**  If two d'Alembert splits agree as
    functions on all of spacetime, the two right-movers differ by a constant (and hence so
    do the two left-movers, by the opposite constant). This is the single genuine
    non-uniqueness of the Riemann problem, and it cancels in `f` itself. -/
theorem split_unique_up_to_constant (c : ℝ) (hc : c ≠ 0) (g₁ h₁ g₂ h₂ : ℝ → ℝ)
    (H : ∀ x t : ℝ, g₁ (x - c * t) + h₁ (x + c * t) = g₂ (x - c * t) + h₂ (x + c * t)) :
    ∀ s, g₁ s - g₂ s = g₁ 0 - g₂ 0 := by
  have H0 : ∀ x t : ℝ, (fun s => g₁ s - g₂ s) (x - c * t)
      + (fun s => h₁ s - h₂ s) (x + c * t) = 0 := by
    intro x t
    have := H x t
    simp only
    linarith
  exact (split_ambiguity_is_constant c hc (fun s => g₁ s - g₂ s)
    (fun s => h₁ s - h₂ s) H0).1

/-! ## 7. A jump travels undistorted (handle `pulse-undistorted`) -/

/-- **The right-moving half is rigid.**  Along the characteristic `X = x + c t`, the
    right-moving half of the d'Alembert solution of the pure-position Riemann problem is
    `phi(x)/2` for EVERY `t`, and the whole solution there is
    `phi(x)/2 + phi(x + 2 c t)/2`.

    There is NO hypothesis on `phi`: not continuity, not measurability. That is exactly
    the sense in which the linear wave equation moves a jump at speed `c` without
    smoothing it, in contrast to the heat equation, whose solution is real-analytic for
    every `t > 0`. -/
theorem right_mover_undistorted (c : ℝ) (φ : ℝ → ℝ) (x t : ℝ) :
    φ ((x + c * t) - c * t) / 2 + φ ((x + c * t) + c * t) / 2
      = φ x / 2 + φ (x + 2 * c * t) / 2 := by
  have h1 : (x + c * t) - c * t = x := by ring
  have h2 : (x + c * t) + c * t = x + 2 * c * t := by ring
  rw [h1, h2]

/-- **A square pulse splits into two half-height pulses that separate.**  With
    `phi = 1 on [-a,a]`, once `2 a < c t` the two half-pulses no longer overlap, and at a
    point `x` inside the original support the solution has settled at exactly `1/2`:
    the right-moving copy is present, the left-moving copy has left. The jump amplitude is
    conserved (two jumps of `1/2` instead of one of `1`) and neither has been smoothed. -/
theorem square_pulse_separates (c a : ℝ) (ha : 0 < a) (t : ℝ) (ht : 2 * a < c * t)
    (x : ℝ) (hx : |x| ≤ a) :
    (if |x| ≤ a then (1 : ℝ) else 0) / 2 + (if |x + 2 * c * t| ≤ a then (1 : ℝ) else 0) / 2
      = 1 / 2 := by
  have hfar : ¬ (|x + 2 * c * t| ≤ a) := by
    have hxa : -a ≤ x := (abs_le.mp hx).1
    have hlow : a < x + 2 * (c * t) := by linarith
    intro hcon
    have := (abs_le.mp hcon).2
    have hrw : x + 2 * c * t = x + 2 * (c * t) := by ring
    rw [hrw] at this
    linarith
  rw [if_pos hx, if_neg hfar]
  ring

end WirohshDiscont

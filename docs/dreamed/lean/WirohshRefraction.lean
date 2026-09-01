/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`.

  Lean attestation for `docs/dreamed/wirohsh-refraction.md`, seeded from the bare
  `### Refraction` heading that ends the owner's `physics/wirohsh.md`, plus his
  physics.SE q/787284 ("What are the Fresnel formulas for acoustics?", corpus row P-K).

  Round 1 (`docs/dreamed/wirohsh-splats.md`, `lean/Wirohsh.lean`) proved the Wick-rotated
  propagation direction is NULL. This file is about what a variable wave speed does.

  Seven claims are formalised. Each is faithful to a line the dreamed essay actually
  states, and each is deliberately narrower than the PDE statement it supports.

  1. `wick_variable_speed` (handle `wick-variable`)
     The essay's opening algebraic step: with `c = c0 / n` and the Wick substitution
     `f_tt = -c0^2 f_tautau`, the variable-speed 1+1 wave operator
     `f_xx - (1/c^2) f_tt` becomes `f_xx + n^2 f_tautau`. NOT the flat 2D Laplacian.
     OUT OF SCOPE: that the substitution `f_tt = -c0^2 f_tautau` is what analytic
     continuation in `t` actually does. That is the owner's `(Wick)` line, assumed.

  2. `drift_to_potential` (handle `gauge-potential`) with `gauge_second_deriv`
     The essay's centrepiece step, in two halves. `gauge_second_deriv` is genuine
     calculus: the second derivative of the amplitude gauge `w = s * f` is
     `s_xx f + 2 s_x f_x + s f_xx`, delivered from `HasDerivAt` witnesses.
     `drift_to_potential` is the algebra that turns the DRIFT term `(2 s_x / s) f_x`
     into the POTENTIAL `(s_xx / s) w`.
     OUT OF SCOPE: the change of variables `xi = int n dx` itself (the chain rule that
     PRODUCES the drift), and the two-dimensional equation. Both are SymPy-checked in
     the essay, not proved here.

  3. `fresnel_energy` (handle `fresnel-energy`)
     `r^2 + (n2/n1) t^2 = 1` for the normal-incidence coefficients.

  4. `fresnel_matching` (handle `schwarz-two-phase`)
     The two-phase Schwarz reflection data: with `r`, `t` as above, the reflected
     ansatz matches BOTH interface conditions for arbitrary incident boundary data
     `(I0, I1)` = (value, normal derivative) at the interface.
     OUT OF SCOPE: that `I(-xi, tau)` is harmonic when `I` is (true, and the reason the
     ansatz is legitimate) and the uniqueness of the transmission problem.

  5. `fermat_hasDerivAt`, `snell_iff_stationary` (handle `snell-fermat`)
     Snell's law from Fermat's principle. `T(x) = n1 sqrt(a^2+x^2) + n2 sqrt(b^2+(d-x)^2)`
     has derivative `n1 x / sqrt(a^2+x^2) - n2 (d-x) / sqrt(b^2+(d-x)^2)`, and that
     derivative vanishes exactly when `n1 sin th1 = n2 sin th2`.

  6. `fermat_deriv2_pos` (handle `fermat-convex`)
     The second derivative of `T` is `n1 a^2 (a^2+x^2)^(-3/2) + n2 b^2 (b^2+(d-x)^2)^(-3/2)`
     and it is STRICTLY POSITIVE, so the Snell point is the unique minimum.
     WEAKENED: this is the positive-second-derivative statement, delivered as a
     `HasDerivAt` witness. `StrictConvexOn` itself is not derived from it (that route
     goes through Mathlib's `deriv`, which is junk-on-failure).

  7. `critical_angle_iff` (handle `tir`)
     `n1 sin th_c = n2` is solvable with `th_c` in `[0, pi/2]` iff `n2 <= n1`.

  Identifier mapping (owner convention: a derivative is named `<f>_<var>`, the subscript
  naming the differentiation variable; NOT `fd`/`fdd`):
      `f_x`, `f_xx`     <-> d_xi f, d_xi^2 f      (essay writes xi for optical path)
      `s_x`, `s_xx`     <-> d_xi sqrt(n), d_xi^2 sqrt(n)
      `f_tt`, `f_tautau` <-> d_t^2 f, d_tau^2 f
  `n`, `n1`, `n2` are refractive indices (positivity always in NAMED hypotheses),
  `c0` the reference speed, `th1`/`th2`/`thc` the angles the essay writes as theta.
-/
import Mathlib.Analysis.SpecialFunctions.Sqrt
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Inverse
import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.Calculus.Deriv.Inv
import Mathlib.Analysis.Calculus.Deriv.Comp

namespace WirohshRefraction

/-! ## 1. The Wick rotation of a variable wave speed (handle `wick-variable`) -/

/-- **A variable speed does not Wick-rotate to the flat Laplacian.**  With `c = c0/n`
    (so `n` is the refractive index relative to the reference speed `c0`) and the owner's
    `(Wick)` substitution in the form `f_tt = -c0^2 * f_tautau`, the 1+1 wave operator
    becomes `f_xx + n^2 f_tautau`. The index survives as an ANISOTROPIC weight on the
    rotated time direction; only for constant `n = 1` is this the 2D Laplacian. -/
theorem wick_variable_speed (c c0 n f_xx f_tt f_tautau : ℝ)
    (hc : c ≠ 0) (hc0 : c0 ≠ 0) (hn : n = c0 / c)
    (hwick : f_tt = -c0 ^ 2 * f_tautau) :
    f_xx - (1 / c ^ 2) * f_tt = f_xx + n ^ 2 * f_tautau := by
  subst hn; subst hwick
  field_simp
  ring

/-! ## 2. Drift traded for potential by the amplitude gauge (handle `gauge-potential`) -/

/-- Second derivative of the amplitude gauge `w = s * f`, delivered from `HasDerivAt`
    witnesses (no `deriv` junk values): `w_xx = s_xx f + 2 s_x f_x + s f_xx`. -/
theorem gauge_second_deriv (s f s_x f_x s_xx f_xx : ℝ → ℝ) (ξ : ℝ)
    (hs : ∀ z, HasDerivAt s (s_x z) z) (hs2 : ∀ z, HasDerivAt s_x (s_xx z) z)
    (hf : ∀ z, HasDerivAt f (f_x z) z) (hf2 : ∀ z, HasDerivAt f_x (f_xx z) z) :
    HasDerivAt (fun z => s_x z * f z + s z * f_x z)
      (s_xx ξ * f ξ + 2 * s_x ξ * f_x ξ + s ξ * f_xx ξ) ξ := by
  have h1 := (hs2 ξ).mul (hf ξ)
  have h2 := (hs ξ).mul (hf2 ξ)
  have := h1.add h2
  refine this.congr_deriv ?_
  ring

/-- **Drift becomes potential.**  The essay's centrepiece algebra: in the optical-path
    coordinate the Wick-rotated equation carries a FIRST-ORDER drift `(2 s_x/s) f_x`
    (with `s = sqrt n`), and the gauge `w = s f` converts it into a ZEROTH-order
    potential `(s_xx/s) w`. Concretely, the second derivative of `w` decomposes as

        w_xx = s * (f_xx + (2 s_x / s) * f_x) + (s_xx / s) * w.

    So `f_xx + (2 s_x/s) f_x + f_tautau = 0` is equivalent to
    `w_xx + w_tautau = (s_xx/s) w`: the flat Laplace equation ONLY when `s_xx = 0`. -/
theorem drift_to_potential (s s_x s_xx f f_x f_xx : ℝ) (hs : s ≠ 0) :
    s_xx * f + 2 * s_x * f_x + s * f_xx
      = s * (f_xx + (2 * s_x / s) * f_x) + (s_xx / s) * (s * f) := by
  field_simp
  ring

/-! ## 3. Fresnel at normal incidence (handles `fresnel-energy`, `schwarz-two-phase`) -/

/-- **Energy conservation for the normal-incidence Fresnel coefficients.**
    With `r = (n1-n2)/(n1+n2)` and `t = 2 n1/(n1+n2)`, `r^2 + (n2/n1) t^2 = 1`.
    Positivity is what makes `n1 + n2` and `n1` invertible; it lives in named
    hypotheses, never in a side condition discharged by `positivity` inside the proof. -/
theorem fresnel_energy (n1 n2 : ℝ) (h1 : 0 < n1) (h2 : 0 < n2) :
    ((n1 - n2) / (n1 + n2)) ^ 2 + (n2 / n1) * (2 * n1 / (n1 + n2)) ^ 2 = 1 := by
  have hsum : n1 + n2 ≠ 0 := by positivity
  have hn1 : n1 ≠ 0 := ne_of_gt h1
  field_simp
  ring

/-- **The two-phase Schwarz reflection data.**  Let `I` be the incident harmonic
    function, `I0` its value and `I1` its normal derivative at the interface.  The
    ansatz `u = I + r * I(-xi)` on the left and `u = t * I` on the right satisfies BOTH
    interface conditions, for arbitrary `(I0, I1)`:

      continuity of the field      `I0 + r * I0 = t * I0`
      continuity of the flux       `n1 * (I1 - r * I1) = n2 * (t * I1)`

    (the minus sign in the second is the chain rule for `xi -> -xi`). The Fresnel
    coefficients ARE the coefficients of the analytic continuation, which is the
    essay's §3 claim. -/
theorem fresnel_matching (n1 n2 I0 I1 : ℝ) (h1 : 0 < n1) (h2 : 0 < n2) :
    I0 + ((n1 - n2) / (n1 + n2)) * I0 = (2 * n1 / (n1 + n2)) * I0
    ∧ n1 * (I1 - ((n1 - n2) / (n1 + n2)) * I1)
        = n2 * ((2 * n1 / (n1 + n2)) * I1) := by
  have hsum : n1 + n2 ≠ 0 := by positivity
  constructor <;> · field_simp; ring

/-! ## 4. Snell's law from Fermat's principle (handle `snell-fermat`) -/

/-- Derivative of one Fermat leg: `d/dz sqrt(a^2 + z^2) = z / sqrt(a^2 + z^2)`.
    `a <> 0` is what keeps the radicand away from the non-differentiable point `0`. -/
theorem leg_hasDerivAt (a s : ℝ) (ha : a ≠ 0) :
    HasDerivAt (fun z : ℝ => Real.sqrt (a ^ 2 + z ^ 2))
      (s / Real.sqrt (a ^ 2 + s ^ 2)) s := by
  have hpos : (0 : ℝ) < a ^ 2 + s ^ 2 := by positivity
  have hne : a ^ 2 + s ^ 2 ≠ 0 := ne_of_gt hpos
  have hq : (0 : ℝ) < Real.sqrt (a ^ 2 + s ^ 2) := Real.sqrt_pos.mpr hpos
  have hinner : HasDerivAt (fun z : ℝ => a ^ 2 + z ^ 2) (2 * s) s := by
    simpa using ((hasDerivAt_pow 2 s).const_add (a ^ 2))
  have := hinner.sqrt (by simpa using hne)
  refine this.congr_deriv ?_
  field_simp

/-- Derivative of the second Fermat leg, whose argument runs backwards:
    `d/dz sqrt(b^2 + (d-z)^2) = -(d-s) / sqrt(b^2 + (d-s)^2)`. -/
theorem leg'_hasDerivAt (b d s : ℝ) (hb : b ≠ 0) :
    HasDerivAt (fun z : ℝ => Real.sqrt (b ^ 2 + (d - z) ^ 2))
      (-((d - s) / Real.sqrt (b ^ 2 + (d - s) ^ 2))) s := by
  have hpos : (0 : ℝ) < b ^ 2 + (d - s) ^ 2 := by positivity
  have hne : b ^ 2 + (d - s) ^ 2 ≠ 0 := ne_of_gt hpos
  have hq : (0 : ℝ) < Real.sqrt (b ^ 2 + (d - s) ^ 2) := Real.sqrt_pos.mpr hpos
  have hsub : HasDerivAt (fun z : ℝ => d - z) (-1) s := by
    simpa using (hasDerivAt_id s).const_sub d
  have hinner : HasDerivAt (fun z : ℝ => b ^ 2 + (d - z) ^ 2) (2 * (d - s) * (-1)) s := by
    simpa using ((hsub.pow 2).const_add (b ^ 2))
  have := hinner.sqrt (by simpa using hne)
  refine this.congr_deriv ?_
  field_simp

/-- **Fermat's optical path length is differentiable, with the Snell expression as its
    derivative.**  For `T(z) = n1 sqrt(a^2+z^2) + n2 sqrt(b^2+(d-z)^2)`,

        T'(x) = n1 * x / sqrt(a^2+x^2)  -  n2 * (d-x) / sqrt(b^2+(d-x)^2),

    i.e. `n1 sin th1 - n2 sin th2` with the sines read off the two right triangles. -/
theorem fermat_hasDerivAt (n1 n2 a b d x : ℝ) (ha : a ≠ 0) (hb : b ≠ 0) :
    HasDerivAt (fun z : ℝ => n1 * Real.sqrt (a ^ 2 + z ^ 2)
        + n2 * Real.sqrt (b ^ 2 + (d - z) ^ 2))
      (n1 * (x / Real.sqrt (a ^ 2 + x ^ 2))
        - n2 * ((d - x) / Real.sqrt (b ^ 2 + (d - x) ^ 2))) x := by
  have h1 := (leg_hasDerivAt a x ha).const_mul n1
  have h2 := (leg'_hasDerivAt b d x hb).const_mul n2
  have := h1.add h2
  refine this.congr_deriv ?_
  ring

/-- **Snell's law is exactly the stationarity condition.**  `T'(x) = 0` iff
    `n1 sin th1 = n2 sin th2`, with `sin th1 = x/sqrt(a^2+x^2)` and
    `sin th2 = (d-x)/sqrt(b^2+(d-x)^2)`. Pure rearrangement, stated separately from
    the calculus so that the physics content is visible on its own. -/
theorem snell_iff_stationary (n1 n2 a b d x : ℝ) :
    n1 * (x / Real.sqrt (a ^ 2 + x ^ 2))
        - n2 * ((d - x) / Real.sqrt (b ^ 2 + (d - x) ^ 2)) = 0
      ↔ n1 * (x / Real.sqrt (a ^ 2 + x ^ 2))
        = n2 * ((d - x) / Real.sqrt (b ^ 2 + (d - x) ^ 2)) :=
  sub_eq_zero

/-! ## 5. The Fermat functional is strictly convex (handle `fermat-convex`) -/

/-- Second derivative of one Fermat leg: `d/dz [ z / sqrt(a^2+z^2) ]
    = a^2 / ((a^2+z^2) * sqrt(a^2+z^2))`, manifestly positive for `a <> 0`. -/
theorem leg_second (a s : ℝ) (ha : a ≠ 0) :
    HasDerivAt (fun z : ℝ => z / Real.sqrt (a ^ 2 + z ^ 2))
      (a ^ 2 / ((a ^ 2 + s ^ 2) * Real.sqrt (a ^ 2 + s ^ 2))) s := by
  have hpos : (0 : ℝ) < a ^ 2 + s ^ 2 := by positivity
  have hq : (0 : ℝ) < Real.sqrt (a ^ 2 + s ^ 2) := Real.sqrt_pos.mpr hpos
  have hsq : Real.sqrt (a ^ 2 + s ^ 2) ^ 2 = a ^ 2 + s ^ 2 :=
    Real.sq_sqrt (le_of_lt hpos)
  have hden := leg_hasDerivAt a s ha
  have := (hasDerivAt_id s).div hden (ne_of_gt hq)
  refine this.congr_deriv ?_
  simp only [id_eq]
  field_simp
  rw [hsq]
  ring

/-- **The Fermat path length is strictly convex.**  `T''(x) = n1 a^2 (a^2+x^2)^(-3/2)
    + n2 b^2 (b^2+(d-x)^2)^(-3/2) > 0` for `n1, n2 > 0`, so the Snell point of
    `snell_iff_stationary` is the UNIQUE minimum, not merely a stationary point.

    WEAKENED, stated plainly: this is "the second derivative exists and is positive
    everywhere", delivered as a `HasDerivAt` witness of `T'`. Mathlib's
    `StrictConvexOn` bridge is not taken (it routes through `deriv`, which is
    junk-on-failure). -/
theorem fermat_deriv2_pos (n1 n2 a b d x : ℝ)
    (h1 : 0 < n1) (h2 : 0 < n2) (ha : a ≠ 0) (hb : b ≠ 0) :
    HasDerivAt (fun z : ℝ => n1 * (z / Real.sqrt (a ^ 2 + z ^ 2))
        - n2 * ((d - z) / Real.sqrt (b ^ 2 + (d - z) ^ 2)))
      (n1 * (a ^ 2 / ((a ^ 2 + x ^ 2) * Real.sqrt (a ^ 2 + x ^ 2)))
        + n2 * (b ^ 2 / ((b ^ 2 + (d - x) ^ 2) * Real.sqrt (b ^ 2 + (d - x) ^ 2)))) x
    ∧ 0 < n1 * (a ^ 2 / ((a ^ 2 + x ^ 2) * Real.sqrt (a ^ 2 + x ^ 2)))
        + n2 * (b ^ 2 / ((b ^ 2 + (d - x) ^ 2) * Real.sqrt (b ^ 2 + (d - x) ^ 2))) := by
  have hposa : (0 : ℝ) < a ^ 2 + x ^ 2 := by positivity
  have hposb : (0 : ℝ) < b ^ 2 + (d - x) ^ 2 := by positivity
  have hqa : (0 : ℝ) < Real.sqrt (a ^ 2 + x ^ 2) := Real.sqrt_pos.mpr hposa
  have hqb : (0 : ℝ) < Real.sqrt (b ^ 2 + (d - x) ^ 2) := Real.sqrt_pos.mpr hposb
  have ha2 : (0 : ℝ) < a ^ 2 := by positivity
  have hb2 : (0 : ℝ) < b ^ 2 := by positivity
  constructor
  · have hL := (leg_second a x ha).const_mul n1
    have hsub : HasDerivAt (fun z : ℝ => d - z) (-1) x := by
      simpa using (hasDerivAt_id x).const_sub d
    have hR : HasDerivAt (fun z : ℝ => (d - z) / Real.sqrt (b ^ 2 + (d - z) ^ 2))
        (-(b ^ 2 / ((b ^ 2 + (d - x) ^ 2) * Real.sqrt (b ^ 2 + (d - x) ^ 2)))) x := by
      have := (leg_second b (d - x) hb).comp x hsub
      simpa using this
    have := hL.sub (hR.const_mul n2)
    refine this.congr_deriv ?_
    ring
  · have t1 : 0 < n1 * (a ^ 2 / ((a ^ 2 + x ^ 2) * Real.sqrt (a ^ 2 + x ^ 2))) := by
      positivity
    have t2 : 0 < n2 * (b ^ 2 / ((b ^ 2 + (d - x) ^ 2)
        * Real.sqrt (b ^ 2 + (d - x) ^ 2))) := by positivity
    linarith

/-! ## 6. Total internal reflection (handle `tir`) -/

/-- **A critical angle exists exactly when the second medium is the rarer one.**
    `n1 sin thc = n2` has a solution `thc` in `[0, pi/2]` iff `n2 <= n1`.
    Forward: `thc = arcsin (n2/n1)`. Backward: `sin <= 1`. -/
theorem critical_angle_iff (n1 n2 : ℝ) (h1 : 0 < n1) (h2 : 0 < n2) :
    (∃ thc : ℝ, 0 ≤ thc ∧ thc ≤ Real.pi / 2 ∧ n1 * Real.sin thc = n2) ↔ n2 ≤ n1 := by
  constructor
  · rintro ⟨thc, _, _, hthc⟩
    have hs : Real.sin thc ≤ 1 := Real.sin_le_one thc
    nlinarith [hthc, hs, h1]
  · intro hle
    refine ⟨Real.arcsin (n2 / n1), ?_, Real.arcsin_le_pi_div_two _, ?_⟩
    · exact Real.arcsin_nonneg.mpr (by positivity)
    · have hlo : (-1 : ℝ) ≤ n2 / n1 := by
        have : (0 : ℝ) ≤ n2 / n1 := by positivity
        linarith
      have hhi : n2 / n1 ≤ 1 := (div_le_one h1).mpr hle
      rw [Real.sin_arcsin hlo hhi]
      field_simp

end WirohshRefraction

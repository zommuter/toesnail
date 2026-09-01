/-
  Lean attestation for the DREAMED essay `docs/dreamed/photon-energy-scaling.md`.

  STATUS: dreamed / UNREVIEWED. See `docs/dreamed/README.md`. This file is NOT part of the
  `verify` lake target and is NOT wired to `physics/*.toml` sidecars; it cannot break
  `make test`. It attests claims in the dreamed essay only, never in `physics/`.

  Sources of the claims, all from `docs/dreamed/photon-energy-scaling.md`:

    (wall1)  The single-mode Bose occupation `nbar x = 1/(exp x - 1)` at `x = h*nu/(kB*T)`
             is strictly decreasing on `x > 0` and tends to `0` as `x -> infinity`.
             This is wall 1 of the essay's three walls: the exhaust bath is empty in the
             optical and crowded in the microwave.

    (carnot) For a single-mode emitter at photon energy `E = h*nu` driven by a photon
             chemical potential `mu` (electrical work per emitted photon), the essay
             derives `COP = (E - mu)/mu`, and derives from detailed balance that a
             POSITIVE net photon flux from a cold side `Tc` to a hot side `Th` requires
             `(E - mu)/Tc <= E/Th`.  CLAIM: that constraint alone forces
             `COP <= Tc/(Th - Tc)`, the Carnot bound.  This is the honesty check on the
             essay's COP expression: no assumption about spectra, rates or mode counts
             is used, only the flux-sign condition.

    (nomax)  CLAIM (the essay's NEGATIVE result): at fixed harvested heat per photon
             `y = E - mu > 0`, the COP `y/(E - y)` is STRICTLY DECREASING in `E`.
             There is therefore no interior optimum in `h*nu/(kB*T)`: the "COP-optimal
             photon energy" the seed asked for does not exist, the supremum sits on the
             Carnot boundary.

    (wien4)  CLAIM (the essay's POSITIVE result): once the free-space spontaneous-emission
             scaling `A ~ nu^3` is included, the cooling POWER at fixed COP is
             proportional to `P y = y^4/(exp y - 1)` with `y = (h*nu - mu)/(kB*Tc)`, and
             its stationary points on `y > 0` are exactly the solutions of
             `4*(1 - exp (-y)) = y`.  That is the Wien displacement equation with
             exponent 4 (Wien's own frequency law is the exponent-3 member).  A solution
             exists in `(3,4)` and is unique there.  In Lambert-W form the condition is
             `(y - 4) * exp (y - 4) = -4 * exp (-4)`, i.e. `y = 4 + W(-4*exp(-4))`;
             Mathlib has no Lambert W, so the equivalence to the precondition equation is
             what is proved.  The essay's numeric value `y* = 3.920690395` comes from
             mpmath, NOT from here.

  Identifier mapping (owner convention, cf. `verify/Resogram.lean` and the sibling
  `docs/dreamed/lean/Lasercool.lean`): physical symbols spelled as in the essay,
      `x`  <-> h*nu/(kB*T)          `nbar` <-> mean occupation of the mode
      `E`  <-> h*nu                 `mu`   <-> photon chemical potential (= q*V)
      `y`  <-> (h*nu - mu)/(kB*Tc)  `Tc`, `Th` <-> cold load and hot sink temperature.
  No derivatives with respect to time occur, so the `x_t`/`x_tt` convention is unused.
  Greek letters are avoided so the ASCII source greps cleanly.

  NOT REPROVED HERE, cited instead: the sibling `docs/dreamed/lean/Statistics.lean`
  already proves `strictMonoOn_F : StrictMonoOn (fun u => u * exp u) (Ici (-1))`, the
  Lambert-W branch precondition, and `be_y_lt_one`, which is `x/(exp x - 1) < 1` on
  `x > 0` in disguise.  This file proves only what is new.

  EXPLICITLY OUT OF SCOPE (not proven, not claimed here):
    * that `COP = (E - mu)/mu` IS the coefficient of performance of any real device.
      The generalised-Planck detailed-balance derivation is done in the essay by hand
      and checked numerically; only its consequences are formalised.
    * every numeric value in the essay (`y* = 3.920690395`, `24.5 THz`, the wall table).
      Nothing numeric is attested beyond the bracketing `3 < y* < 4`.
    * that the Wien-4 stationary point is a MAXIMUM (the essay's second-derivative check
      `P''(y*) = -1.145` is mpmath, not Lean), and the ambient-occupation correction to
      `P` at Carnot fractions above ~0.2.
    * unity quantum efficiency, single-mode coupling, and every other physical
      assumption listed in the essay's assumption table.
-/
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Analysis.Calculus.Deriv.Pow
import Mathlib.Analysis.Calculus.Deriv.Inv
import Mathlib.Analysis.Calculus.Deriv.MeanValue
import Mathlib.Topology.Order.IntermediateValue

namespace CopOptimum

open Real Set Filter Topology

/-! ## Wall 1: the Bose occupation of the exhaust mode -/

/-- Mean occupation of a single field mode at `x = h*nu/(kB*T)`. -/
noncomputable def nbar (x : ℝ) : ℝ := 1 / (Real.exp x - 1)

theorem exp_sub_one_pos {x : ℝ} (hx : 0 < x) : 0 < Real.exp x - 1 := by
  have h := Real.add_one_lt_exp (ne_of_gt hx)
  linarith

/-- (wall1) The occupation is positive on `x > 0`. -/
theorem nbar_pos {x : ℝ} (hx : 0 < x) : 0 < nbar x :=
  div_pos one_pos (exp_sub_one_pos hx)

/-- (wall1) The occupation is strictly decreasing in `h*nu/(kB*T)`: raising the photon
    energy, or lowering the temperature, empties the mode.  Optical modes at 300 K are
    empty; microwave modes are crowded. -/
theorem strictAntiOn_nbar : StrictAntiOn nbar (Ioi (0 : ℝ)) := by
  intro a ha b hb hab
  simp only [mem_Ioi] at ha hb
  have hpa : 0 < Real.exp a - 1 := exp_sub_one_pos ha
  have hlt : Real.exp a - 1 < Real.exp b - 1 := by
    have := Real.exp_lt_exp.mpr hab
    linarith
  exact one_div_lt_one_div_of_lt hpa hlt

/-- (wall1) The occupation vanishes in the high-frequency (or low-temperature) limit:
    the optical vacuum is a free cold reservoir. -/
theorem nbar_tendsto_zero : Tendsto nbar atTop (𝓝 0) := by
  have h : Tendsto (fun x : ℝ => Real.exp x - 1) atTop atTop :=
    Real.tendsto_exp_atTop.atTop_add tendsto_const_nhds
  exact (h.inv_tendsto_atTop).congr (fun x => by simp [nbar, one_div])

/-! ## The coefficient of performance, its Carnot bound, and the absent optimum -/

/-- Coefficient of performance of a single-mode photonic heat pump: heat harvested per
    emitted photon `E - mu` over work spent per emitted photon `mu`. -/
noncomputable def COP (E mu : ℝ) : ℝ := (E - mu) / mu

/-- (carnot) The flux-sign condition alone forces the Carnot bound.

    `hflux` is the detailed-balance requirement that the emitter's occupation exceed the
    sink's, i.e. `(E - mu)/(kB*Tc) <= E/(kB*Th)` after cancelling `kB`.  Nothing else is
    assumed: no spectrum, no rate, no mode count.  Temperature ordering `0 < Tc < Th` and
    positivity of the work `0 < mu` are NAMED hypotheses. -/
theorem cop_le_carnot (E mu Tc Th : ℝ) (hTc : 0 < Tc) (hTh : Tc < Th) (hmu : 0 < mu)
    (hflux : (E - mu) / Tc ≤ E / Th) :
    COP E mu ≤ Tc / (Th - Tc) := by
  have hThpos : 0 < Th := lt_trans hTc hTh
  have hgap : 0 < Th - Tc := by linarith
  -- clear denominators in the flux condition
  have e1 : (E - mu) / Tc * (Tc * Th) = Th * (E - mu) := by field_simp
  have e2 : E / Th * (Tc * Th) = Tc * E := by field_simp
  have h1 : Th * (E - mu) ≤ Tc * E := by
    rw [← e1, ← e2]
    exact mul_le_mul_of_nonneg_right hflux (le_of_lt (mul_pos hTc hThpos))
  rw [COP, div_le_div_iff₀ hmu hgap]
  nlinarith

/-- (nomax) THE NEGATIVE RESULT. At fixed harvested heat per photon `y = E - mu > 0`, the
    COP `y/(E - y)` is strictly decreasing in the photon energy `E` on `E > y`.

    So there is no interior optimum in `h*nu/(kB*T)`: for a fixed heat harvest, cheaper
    photons are always better, and the supremum of the COP lies on the Carnot boundary
    `cop_le_carnot`, never at an interior stationary point.  The seed's "COP-optimal
    `h*nu/(kB*T)`" does not exist as posed. -/
theorem cop_strictAntiOn_of_photon_energy {y : ℝ} (hy : 0 < y) :
    StrictAntiOn (fun E : ℝ => y / (E - y)) (Ioi y) := by
  intro a ha b hb hab
  simp only [mem_Ioi] at ha hb
  have hpa : 0 < a - y := by linarith
  have hlt : a - y < b - y := by linarith
  exact div_lt_div_of_pos_left hy hpa hlt

/-! ## The Wien-4 power optimum -/

/-- Cooling power at fixed COP, in reduced form: `P y = y^4/(exp y - 1)`, where
    `y = (h*nu - mu)/(kB*Tc)` is the heat harvested per photon and the fourth power is
    `nu^3` (free-space spontaneous emission, wall 2) times one power of `y` (the heat
    each photon carries). -/
noncomputable def P (y : ℝ) : ℝ := y ^ 4 / (Real.exp y - 1)

theorem hasDerivAt_P {y : ℝ} (hy : 0 < y) :
    HasDerivAt P
      ((4 * y ^ 3 * (Real.exp y - 1) - y ^ 4 * Real.exp y) / (Real.exp y - 1) ^ 2) y := by
  have hne : Real.exp y - 1 ≠ 0 := ne_of_gt (exp_sub_one_pos hy)
  have hnum : HasDerivAt (fun t : ℝ => t ^ 4) (4 * y ^ 3) y := by
    simpa using (hasDerivAt_pow 4 y)
  have hden : HasDerivAt (fun t : ℝ => Real.exp t - 1) (Real.exp y) y := by
    simpa using (Real.hasDerivAt_exp y).sub_const 1
  simpa [P] using hnum.div hden hne

/-- (wien4) The first-order condition.  On `y > 0` the reduced cooling power is
    stationary exactly where `4*(1 - exp (-y)) = y`.  That is the Wien displacement
    equation with exponent 4; Wien's own frequency law is the exponent-3 member
    `3*(1 - exp (-y)) = y`. -/
theorem P_critical_iff {y : ℝ} (hy : 0 < y) :
    deriv P y = 0 ↔ 4 * (1 - Real.exp (-y)) = y := by
  have hpos : 0 < Real.exp y - 1 := exp_sub_one_pos hy
  have hne : Real.exp y - 1 ≠ 0 := ne_of_gt hpos
  have hy3 : y ^ 3 ≠ 0 := by positivity
  have hey : Real.exp y ≠ 0 := Real.exp_ne_zero y
  rw [(hasDerivAt_P hy).deriv, div_eq_zero_iff]
  constructor
  · rintro (h | h)
    · have hfac : y ^ 3 * (4 * (Real.exp y - 1) - y * Real.exp y) = 0 := by
        linear_combination h
      have h2 : 4 * (Real.exp y - 1) - y * Real.exp y = 0 := by
        rcases mul_eq_zero.mp hfac with h' | h'
        · exact absurd h' hy3
        · exact h'
      have : Real.exp (-y) = (Real.exp y)⁻¹ := by rw [Real.exp_neg]
      rw [this]
      field_simp
      linarith
    · exact absurd (pow_eq_zero_iff (n := 2) (by norm_num) |>.mp h) hne
  · intro h
    left
    have hinv : Real.exp (-y) = (Real.exp y)⁻¹ := by rw [Real.exp_neg]
    rw [hinv] at h
    have h2 : 4 * (Real.exp y - 1) - y * Real.exp y = 0 := by
      field_simp at h
      linarith
    linear_combination y ^ 3 * h2

/-- (wien4) The Lambert-W form.  Mathlib has no `W`, so the closed form
    `y = 4 + W(-4*exp(-4))` is stated as the equivalence with the precondition equation
    `(y - 4)*exp (y - 4) = -4*exp (-4)`, whose left side is the function
    `u * exp u` that the sibling `docs/dreamed/lean/Statistics.lean` proves strictly
    monotone on `Ici (-1)` (`strictMonoOn_F`).  Combined with `3 < y* < 4` below, the
    root lies at `y* - 4 ∈ (-1, 0)`, i.e. on the PRINCIPAL branch `W₀`. -/
theorem wien4_lambert_form (y : ℝ) :
    4 * (1 - Real.exp (-y)) = y ↔ (y - 4) * Real.exp (y - 4) = -4 * Real.exp (-4) := by
  have hy4 : Real.exp (y - 4) = Real.exp y * Real.exp (-4) := by
    rw [← Real.exp_add]; ring_nf
  have hny : Real.exp (-y) = (Real.exp y)⁻¹ := by rw [Real.exp_neg]
  have hey : (0 : ℝ) < Real.exp y := Real.exp_pos y
  have he4 : (0 : ℝ) < Real.exp (-4) := Real.exp_pos (-4)
  rw [hy4, hny]
  constructor
  · intro h
    have h' : 4 * Real.exp y - 4 = y * Real.exp y := by
      field_simp at h; linarith
    nlinarith [h']
  · intro h
    have h' : (y - 4) * Real.exp y = -4 := by
      have := mul_right_cancel₀ (ne_of_gt he4) (by linarith [h] : (y - 4) * Real.exp y * Real.exp (-4) = (-4 : ℝ) * Real.exp (-4))
      exact this
    field_simp
    linarith

/-- Auxiliary: `g y = 4*(1 - exp (-y)) - y`, whose zeros are the Wien-4 stationary
    points. -/
noncomputable def g (y : ℝ) : ℝ := 4 * (1 - Real.exp (-y)) - y

theorem hasDerivAt_g (y : ℝ) : HasDerivAt g (4 * Real.exp (-y) - 1) y := by
  have h : HasDerivAt (fun t : ℝ => Real.exp (-t)) (-Real.exp (-y)) y := by
    simpa using (Real.hasDerivAt_exp (-y)).comp y (hasDerivAt_neg y)
  have h3 : HasDerivAt (fun t : ℝ => 4 * (1 - Real.exp (-t)) - t) (4 * Real.exp (-y) - 1) y := by
    simpa using (HasDerivAt.const_mul (4 : ℝ) (h.const_sub (1 : ℝ))).sub (hasDerivAt_id y)
  exact h3

theorem continuous_g : Continuous g := by
  unfold g; fun_prop

/-- `exp 2 > 4`, from `exp 1 > 2`.  Needed to sign `g'` on `y ≥ 2`. -/
theorem four_lt_exp_two : (4 : ℝ) < Real.exp 2 := by
  have h1 : (2 : ℝ) < Real.exp 1 := by
    have := Real.add_one_lt_exp (x := (1 : ℝ)) (by norm_num)
    linarith
  have : Real.exp 2 = Real.exp 1 * Real.exp 1 := by
    rw [← Real.exp_add]; norm_num
  nlinarith [this, Real.exp_pos (1 : ℝ)]

/-- (wien4) `g` is strictly decreasing on `y ≥ 2`, so the Wien-4 root is unique there. -/
theorem strictAntiOn_g : StrictAntiOn g (Ici (2 : ℝ)) := by
  apply strictAntiOn_of_deriv_neg (convex_Ici 2) continuous_g.continuousOn
  intro y hy
  rw [interior_Ici] at hy
  simp only [mem_Ioi] at hy
  have h4 : (4 : ℝ) < Real.exp y := lt_of_lt_of_le four_lt_exp_two (Real.exp_le_exp.mpr (le_of_lt hy))
  have hpos : (0 : ℝ) < Real.exp y := Real.exp_pos y
  have : Real.exp (-y) < 1 / 4 := by
    rw [Real.exp_neg]
    rw [inv_lt_iff_one_lt_mul₀ hpos]
    linarith
  rw [(hasDerivAt_g y).deriv]
  linarith

/-- (wien4) A Wien-4 stationary point exists, and `3 < y* < 4`.  The essay's mpmath value
    is `y* = 3.920690395`; only the bracketing is attested here.  `g 4 = -4*exp (-4) < 0`
    is immediate; `g 3 = 1 - 4*exp (-3) > 0` needs only `exp 3 > 4`. -/
theorem wien4_root_exists : ∃ y ∈ Ioo (3 : ℝ) 4, 4 * (1 - Real.exp (-y)) = y := by
  have h3 : 0 < g 3 := by
    have h : (4 : ℝ) < Real.exp 3 := by
      have := Real.add_one_lt_exp (x := (3 : ℝ)) (by norm_num)
      linarith
    have hpos : (0 : ℝ) < Real.exp 3 := Real.exp_pos 3
    have : Real.exp (-3) < 1 / 4 := by
      rw [Real.exp_neg, inv_lt_iff_one_lt_mul₀ hpos]
      linarith
    simp only [g]
    linarith
  have h4 : g 4 < 0 := by
    have : (0 : ℝ) < Real.exp (-4) := Real.exp_pos (-4)
    simp only [g]
    linarith
  obtain ⟨y, hy, hgy⟩ :=
    intermediate_value_Ioo' (by norm_num : (3 : ℝ) ≤ 4) continuous_g.continuousOn
      (show (0 : ℝ) ∈ Ioo (g 4) (g 3) from ⟨h4, h3⟩)
  exact ⟨y, hy, by simp only [g] at hgy; linarith⟩

/-- (wien4) Uniqueness on `y ≥ 2`: the bracketed root is the only Wien-4 stationary point
    at or above `y = 2`. -/
theorem wien4_root_unique {a b : ℝ} (ha : 2 ≤ a) (hb : 2 ≤ b)
    (hga : 4 * (1 - Real.exp (-a)) = a) (hgb : 4 * (1 - Real.exp (-b)) = b) : a = b := by
  have hA : g a = 0 := by simp only [g]; linarith
  have hB : g b = 0 := by simp only [g]; linarith
  by_contra hne
  rcases lt_or_gt_of_ne hne with h | h
  · have := strictAntiOn_g ha hb h; rw [hA, hB] at this; exact lt_irrefl 0 this
  · have := strictAntiOn_g hb ha h; rw [hA, hB] at this; exact lt_irrefl 0 this

end CopOptimum

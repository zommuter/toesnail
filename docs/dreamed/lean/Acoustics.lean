/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`.

  Lean attestation for `docs/dreamed/acoustics.md`, seeded from the owner's
  `physics/acoustics.md` (ROADMAP "Acoustics pilot #2") and his physics.SE q/787284
  ("What are the Fresnel formulas for acoustics?", corpus row P-K).

  Everything here is a PROPOSAL for claims the owner has not yet marked; nothing is
  wired into the repo's verify sidecar. Placing `verify:` markers in
  `physics/acoustics.md` is the owner's call.

  Six claims are formalised. Conventions: positivity in NAMED hypotheses; derivatives
  spelled `f_x` / `f_xx` (subscript = differentiation variable, per the owner's
  convention); `HasDerivAt` witnesses, never bare `deriv` (junk-on-failure).

  1. `fresnel_from_matching` (handle `fresnel-n`)
     The two interface conditions at normal incidence -- pressure continuity
     `1 + r = t` and normal-velocity continuity `(1 - r)/Z1 = t/Z2` -- force
     `r = (Z2-Z1)/(Z2+Z1)` and `t = 2*Z2/(Z1+Z2)`. PRESSURE convention: `t` is the
     transmitted/incident PRESSURE amplitude ratio (the velocity convention has
     `t_u = 2*Z1/(Z1+Z2)` instead).
     OUT OF SCOPE: that the interface conditions themselves follow from the PDE
     (that is the essay's shoebox/pillbox story, and the owner's `(rho u_n)` box).

  2. `fresnel_energy` (handle `fresnel-energy`)
     Energy conservation: `r^2 + (Z1/Z2)*t^2 = 1` with the coefficients of claim 1.
     The weight `Z1/Z2` is the intensity conversion `I = p^2/Z` between the media.

  3. `matched_no_reflection` (handle `zmatch`)
     `r = 0 <-> Z1 = Z2`. Reflection sees ONLY the impedance.

  4. `matched_despite_refraction` + `matched_refracting_witness` (handle `zmatch-c`)
     Restating claim 3 in terms of (rho, c): `rho1*c1 = rho2*c2` kills `r` with NO
     hypothesis relating `c1` and `c2`; the witness instantiates `c2 = 2*c1` with
     matched impedances. This is the acoustics-vs-optics asymmetry: an interface
     invisible to reflection that still refracts.

  5. `laplace_newton_ratio` + `sqrt_gamma_air_bounds` (handle `newton-laplace`)
     `sqrt(gamma*p/rho) = sqrt(gamma) * sqrt(p/rho)` (the Laplace/Newton speed ratio
     is exactly `sqrt(gamma)`), and the numeric bound `1.183 < sqrt 1.4 < 1.184`.

  6. `right_mover_t` / `right_mover_tt` + `wave_from_linear_chain` (handle `waveq`)
     The calculus half: `tau |-> f (x - c*tau)` has first t-derivative
     `-c * f_x(x - c*tau)` and second t-derivative `c^2 * f_xx(x - c*tau)`, from
     `HasDerivAt` witnesses (a d'Alembert right-mover solves the wave equation).
     The algebra half: differentiated linearized continuity + momentum + the state
     relation + Clairaut, each a NAMED hypothesis, give `p_tt = c^2 * p_xx`.
     OUT OF SCOPE (stated, not proven): that the named mixed-partial hypotheses hold
     for actual solutions -- that is the genuine PDE content `physics/acoustics.md`
     itself never reaches (it stops before the wave equation; see the essay).

  Check (from `verify/`, one process, nice'd):
    nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/Acoustics.lean
-/
import Mathlib.Analysis.SpecialFunctions.Sqrt
import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.Calculus.Deriv.Comp
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity

namespace DreamedAcoustics

/- ------------------------------------------------------------------ -/
/- 1. Fresnel coefficients from the two matching conditions.          -/
/- ------------------------------------------------------------------ -/

/-- Handle `fresnel-n`: at normal incidence, pressure continuity (`1 + r = t`) and
    normal-velocity continuity (`(1-r)/Z1 = t/Z2`) determine the PRESSURE reflection
    and transmission coefficients uniquely: `r = (Z2-Z1)/(Z2+Z1)`, `t = 2*Z2/(Z2+Z1)`. -/
theorem fresnel_from_matching (Z1 Z2 r t : ℝ) (hZ1 : 0 < Z1) (hZ2 : 0 < Z2)
    (h_p : 1 + r = t)                -- [p] = 0 across the interface
    (h_u : (1 - r) / Z1 = t / Z2) :  -- [u_n] = 0 across the interface
    r = (Z2 - Z1) / (Z2 + Z1) ∧ t = 2 * Z2 / (Z2 + Z1) := by
  have hZ12 : Z2 + Z1 ≠ 0 := by positivity
  have h_u' : (1 - r) * Z2 = t * Z1 := by
    field_simp at h_u
    linarith
  constructor
  · rw [eq_div_iff hZ12]
    nlinarith [h_u', h_p]
  · rw [eq_div_iff hZ12]
    nlinarith [h_u', h_p]

/- ------------------------------------------------------------------ -/
/- 2. Energy conservation.                                            -/
/- ------------------------------------------------------------------ -/

/-- Handle `fresnel-energy`: with `r = (Z2-Z1)/(Z2+Z1)` and `t = 2*Z2/(Z2+Z1)` in the
    pressure convention, the reflected plus transmitted intensity fractions sum to 1:
    `r^2 + (Z1/Z2) * t^2 = 1`. The factor `Z1/Z2` converts the transmitted pressure
    amplitude into an intensity fraction (`I = p^2 / Z` per medium). -/
theorem fresnel_energy (Z1 Z2 : ℝ) (hZ1 : 0 < Z1) (hZ2 : 0 < Z2) :
    ((Z2 - Z1) / (Z2 + Z1)) ^ 2 + (Z1 / Z2) * (2 * Z2 / (Z2 + Z1)) ^ 2 = 1 := by
  have hZ12 : Z2 + Z1 ≠ 0 := by positivity
  have hZ2' : Z2 ≠ 0 := ne_of_gt hZ2
  field_simp
  ring

/- ------------------------------------------------------------------ -/
/- 3. Impedance matching kills reflection.                            -/
/- ------------------------------------------------------------------ -/

/-- Handle `zmatch`: the reflection coefficient vanishes exactly at impedance
    matching, `r = 0 <-> Z1 = Z2`. -/
theorem matched_no_reflection (Z1 Z2 : ℝ) (hZ1 : 0 < Z1) (hZ2 : 0 < Z2) :
    (Z2 - Z1) / (Z2 + Z1) = 0 ↔ Z1 = Z2 := by
  have hZ12 : Z2 + Z1 ≠ 0 := by positivity
  rw [div_eq_zero_iff]
  constructor
  · rintro (h | h)
    · linarith
    · exact absurd h hZ12
  · intro h
    left
    linarith

/-- Handle `zmatch-c` (first half): stated in material parameters, `rho1*c1 = rho2*c2`
    forces `r = 0` -- note there is NO hypothesis relating `c1` and `c2`. Reflection
    is blind to the sound speeds separately; only their product with density enters. -/
theorem matched_despite_refraction (ρ1 c1 ρ2 c2 : ℝ)
    (h_match : ρ1 * c1 = ρ2 * c2) :
    (ρ2 * c2 - ρ1 * c1) / (ρ2 * c2 + ρ1 * c1) = 0 := by
  rw [h_match]
  simp

/-- Handle `zmatch-c` (second half): a concrete impedance-matched interface with
    `c2 = 2*c1` -- invisible to reflection, yet it changes the sound speed by a
    factor 2 (so at oblique incidence it refracts, and at normal incidence it
    halves the wavelength). No optical analogue exists at normal incidence for
    nonmagnetic media, where `Z = Z0/n` locks impedance to index. -/
theorem matched_refracting_witness :
    ∃ ρ1 c1 ρ2 c2 : ℝ, 0 < ρ1 ∧ 0 < c1 ∧ 0 < ρ2 ∧ 0 < c2 ∧
      ρ1 * c1 = ρ2 * c2 ∧ c2 = 2 * c1 := by
  exact ⟨2, 1, 1, 2, by norm_num⟩

/- ------------------------------------------------------------------ -/
/- 4. Newton vs Laplace.                                              -/
/- ------------------------------------------------------------------ -/

/-- Handle `newton-laplace` (structural half): the Laplace (adiabatic) sound speed
    `sqrt(gamma*p/rho)` exceeds the Newton (isothermal) speed `sqrt(p/rho)` by exactly
    the factor `sqrt(gamma)`. Positivity of `gamma` is a NAMED hypothesis. -/
theorem laplace_newton_ratio (γ p ρ : ℝ) (hγ : 0 ≤ γ) :
    Real.sqrt (γ * p / ρ) = Real.sqrt γ * Real.sqrt (p / ρ) := by
  rw [mul_div_assoc, Real.sqrt_mul hγ]

/-- Handle `newton-laplace` (numeric half): `1.183 < sqrt 1.4 < 1.184`, so for air
    (`gamma = 7/5`) Newton's isothermal speed is low by a factor `1/sqrt(1.4)`,
    about 15.5 percent. -/
theorem sqrt_gamma_air_bounds : 1.183 < Real.sqrt 1.4 ∧ Real.sqrt 1.4 < 1.184 := by
  have h0 : (0 : ℝ) ≤ 1.4 := by norm_num
  have hsq : Real.sqrt 1.4 ^ 2 = 1.4 := Real.sq_sqrt h0
  have hnn : 0 ≤ Real.sqrt 1.4 := Real.sqrt_nonneg 1.4
  constructor
  · nlinarith [hsq, hnn]
  · nlinarith [hsq, hnn]

/- ------------------------------------------------------------------ -/
/- 5. The wave equation: calculus half and algebra half.              -/
/- ------------------------------------------------------------------ -/

/-- Handle `waveq` (calculus, first derivative): the right-moving profile
    `tau |-> f (x - c*tau)` has time derivative `-c * f_x (x - c*t)` at `t`,
    given a `HasDerivAt` witness for `f` at the point `x - c*t`. -/
theorem right_mover_t (f f_x : ℝ → ℝ) (c x t : ℝ)
    (hf : HasDerivAt f (f_x (x - c * t)) (x - c * t)) :
    HasDerivAt (fun τ => f (x - c * τ)) (-c * f_x (x - c * t)) t := by
  have haff : HasDerivAt (fun τ : ℝ => x - c * τ) (-c) t := by
    simpa using (hasDerivAt_const t x).sub ((hasDerivAt_id t).const_mul c)
  have h := hf.comp t haff
  simpa [Function.comp, mul_comm] using h

/-- Handle `waveq` (calculus, second derivative): differentiating once more, the
    right mover's second time derivative is `c^2 * f_xx (x - c*t)` -- the d'Alembert
    profile satisfies `p_tt = c^2 * p_xx` pointwise (its second x-derivative at the
    same point being `f_xx (x - c*t)` by the same argument with `c := -1` absorbed). -/
theorem right_mover_tt (f_x f_xx : ℝ → ℝ) (c x t : ℝ)
    (hfx : HasDerivAt f_x (f_xx (x - c * t)) (x - c * t)) :
    HasDerivAt (fun τ => -c * f_x (x - c * τ)) (c ^ 2 * f_xx (x - c * t)) t := by
  have h1 := right_mover_t f_x f_xx c x t hfx
  exact (h1.const_mul (-c)).congr_deriv (by ring)

/-- Handle `waveq` (algebra): the skeleton of the textbook derivation
    `physics/acoustics.md` stops short of. Given, at one point and as NAMED
    hypotheses: the t-differentiated linearized continuity equation
    (`rho_tt = -rho0 * u_xt`), the x-differentiated linearized momentum equation
    (`p_xx = -rho0 * u_tx`), equality of mixed partials (Clairaut), and the
    t-differentiated state relation (`p_tt = c^2 * rho_tt`), the pressure satisfies
    the wave equation `p_tt = c^2 * p_xx`. The four hypotheses are exactly the four
    calculus facts a full proof would have to establish for actual solutions. -/
theorem wave_from_linear_chain (ρ0 c p_tt p_xx ρ_tt u_xt u_tx : ℝ)
    (cont_t : ρ_tt = -(ρ0 * u_xt))
    (mom_x : p_xx = -(ρ0 * u_tx))
    (clairaut : u_xt = u_tx)
    (state_t : p_tt = c ^ 2 * ρ_tt) :
    p_tt = c ^ 2 * p_xx := by
  rw [state_t, cont_t, clairaut, mom_x]

end DreamedAcoustics

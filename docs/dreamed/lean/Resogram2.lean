/-
DREAMED, UNREVIEWED. See `docs/dreamed/README.md`.
Companion to `docs/dreamed/resogram-library.md` (AI-written, 2026-09-01, owner-dictated seed).

This file deliberately proves nothing that `verify/Resogram.lean` already proves: it does not
touch `edot_first_line` or `edot_deriv`. It formalises the ONE new claim the resogram library
turned up, plus the discrete-time stability fact the implementation rests on.

MAIN RESULT `ebar_minus_exact`.
`physics/Resogram.md` ends with a sliding half-period average carrying an `exp(+2*beta*t')`
kernel. Substituting the owner's own closed form `esol` and integrating, the kernel with the
OPPOSITE sign, `exp(-2*beta*t')`, collapses the whole expression to the bare envelope:

    (Omega/pi) * integral_0^{pi/Omega} e(t - t') * exp(-2*beta*t') dt'  =  C * omega * exp(-2*beta*t)

with every oscillatory term cancelling identically. This is a SURFACED FINDING about the
owner's text, not a correction to it: which sign he meant is his call. The AI emits findings;
it never edits the theory.

Checked with (from `verify/`, so this stays outside the lake target and cannot affect `make test`):
  nice -n19 lake env lean --threads=2 ../docs/dreamed/lean/Resogram2.lean
-/
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv
import Mathlib.Analysis.SpecialFunctions.Exp

open Real intervalIntegral

namespace DreamedResogram2

/-- The free-oscillator specific energy, exactly the owner's handle `esol`:
`e = (A^2 omega / 2) exp(-2 beta t) (omega + beta cos(2(Omega t + phi) - delta))`,
with `C` standing for the amplitude prefactor `A^2 omega / 2`. -/
noncomputable def esol (C omega beta Omega phi delta : ℝ) (t : ℝ) : ℝ :=
  C * Real.exp (-(2 * beta * t)) * (omega + beta * Real.cos (2 * (Omega * t + phi) - delta))

/-- The core cancellation: a cosine of constant frequency `2*Omega` integrates to zero over
exactly one half period `pi/Omega`, whatever its phase. This is what kills the ripple. -/
theorem cos_half_period_integral (A Omega : ℝ) (hO : Omega ≠ 0) :
    (∫ s in (0:ℝ)..(π / Omega), Real.cos (A - 2 * Omega * s)) = 0 := by
  have hderiv : ∀ s ∈ Set.uIcc (0:ℝ) (π / Omega),
      HasDerivAt (fun u : ℝ => Real.sin (A - 2 * Omega * u) / (-(2 * Omega)))
        (Real.cos (A - 2 * Omega * s)) s := by
    intro s _
    have h1 : HasDerivAt (fun u : ℝ => A - 2 * Omega * u) (-(2 * Omega)) s := by
      simpa using ((hasDerivAt_id s).const_mul (2 * Omega)).const_sub A
    have h2 := (Real.hasDerivAt_sin (A - 2 * Omega * s)).comp s h1
    have h3 := h2.div_const (-(2 * Omega))
    have hne : (-(2 * Omega)) ≠ 0 := by simpa using hO
    convert h3 using 1
    field_simp
  have hint : IntervalIntegrable (fun s : ℝ => Real.cos (A - 2 * Omega * s))
      MeasureTheory.volume 0 (π / Omega) := by
    apply Continuous.intervalIntegrable
    fun_prop
  rw [integral_eq_sub_of_hasDerivAt hderiv hint]
  have hstep : A - 2 * Omega * (π / Omega) = A - 2 * π := by
    field_simp
  rw [hstep]
  simp [Real.sin_sub_two_pi]

/-- The half-period average of `esol` against the kernel `exp(-2*beta*t')` is EXACTLY the
ripple-free envelope `C * omega * exp(-2*beta*t)`. Note `beta` is unconstrained: the
cancellation is algebraic, not asymptotic. -/
theorem ebar_minus_exact (C omega beta Omega phi delta t : ℝ) (hO : 0 < Omega) :
    (Omega / π) * (∫ s in (0:ℝ)..(π / Omega),
        esol C omega beta Omega phi delta (t - s) * Real.exp (-(2 * beta * s)))
      = C * omega * Real.exp (-(2 * beta * t)) := by
  have hOne : Omega ≠ 0 := ne_of_gt hO
  -- Rewrite the integrand: the two exponentials collapse, and the cosine's argument becomes
  -- a fixed phase minus 2*Omega*s.
  have hpt : ∀ s : ℝ,
      esol C omega beta Omega phi delta (t - s) * Real.exp (-(2 * beta * s))
        = C * Real.exp (-(2 * beta * t)) * omega
          + C * Real.exp (-(2 * beta * t)) * beta
              * Real.cos ((2 * (Omega * t + phi) - delta) - 2 * Omega * s) := by
    intro s
    unfold esol
    have hexp : Real.exp (-(2 * beta * (t - s))) * Real.exp (-(2 * beta * s))
        = Real.exp (-(2 * beta * t)) := by
      rw [← Real.exp_add]; ring_nf
    have harg : 2 * (Omega * (t - s) + phi) - delta
        = (2 * (Omega * t + phi) - delta) - 2 * Omega * s := by ring
    rw [harg]
    calc C * Real.exp (-(2 * beta * (t - s)))
            * (omega + beta * Real.cos ((2 * (Omega * t + phi) - delta) - 2 * Omega * s))
            * Real.exp (-(2 * beta * s))
        = (C * (Real.exp (-(2 * beta * (t - s))) * Real.exp (-(2 * beta * s))))
            * (omega + beta * Real.cos ((2 * (Omega * t + phi) - delta) - 2 * Omega * s)) := by
          ring
      _ = _ := by rw [hexp]; ring
  simp only [hpt]
  set K : ℝ := C * Real.exp (-(2 * beta * t)) with hK
  set A : ℝ := 2 * (Omega * t + phi) - delta with hA
  have hc : IntervalIntegrable (fun s : ℝ => K * beta * Real.cos (A - 2 * Omega * s))
      MeasureTheory.volume 0 (π / Omega) := by
    apply Continuous.intervalIntegrable; fun_prop
  have hconst : IntervalIntegrable (fun _ : ℝ => K * omega)
      MeasureTheory.volume 0 (π / Omega) := intervalIntegrable_const
  rw [integral_add hconst hc]
  rw [integral_const]
  rw [integral_const_mul, cos_half_period_integral A Omega hOne]
  have key : Omega / π * (π / Omega) = 1 := by
    field_simp
  simp only [sub_zero, mul_zero, add_zero, smul_eq_mul]
  rw [← mul_assoc, key, one_mul, hK]
  ring

/-- Discrete-time stability of the impulse-invariant resonator the library implements.
Its poles are `exp(-beta*T) * exp(± i * Omega * T)`, of modulus `exp(-beta*T)`, so the filter
is stable exactly when `beta > 0`: physical damping and numerical stability are the same
condition. `T > 0` is the sample period. -/
theorem pole_modulus_lt_one_iff (beta T : ℝ) (hT : 0 < T) :
    Real.exp (-(beta * T)) < 1 ↔ 0 < beta := by
  rw [Real.exp_lt_one_iff]
  constructor
  · intro h
    nlinarith
  · intro h
    nlinarith

/-- Marginal case, stated because the library's `test_undamped_conserves_energy` leans on it:
with `beta = 0` the poles sit exactly ON the unit circle, so the undamped resonator neither
decays nor grows. -/
theorem pole_modulus_eq_one_of_undamped (T : ℝ) : Real.exp (-((0:ℝ) * T)) = 1 := by
  simp

end DreamedResogram2

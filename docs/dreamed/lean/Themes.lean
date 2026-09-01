/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/methodology-themes.md` (Q10 of
  `docs/meeting-notes/2026-07-07-1257-corpus-dreaming-session.md`: which candidate
  methodology themes become NAMED themes of the book).

  Source of the claim (owner-authored, `physics/wirohsh.md:62-64`, verbatim):

      "Phi_m(phi) = e^{i m phi},  m in Z
       where the discreteness of m is a result of requiring Phi(phi+2pi) = Phi(phi)."

  and its converse-side complaint (`physics/wirohsh.md:30`): the Fourier frequency
  omega on the NON-compact time axis "has to be considered" continuous.

  This file proves the mathematical engine of candidate theme No. 1, "compactness =>
  discreteness => quantization", in BOTH directions, because the contrast IS the theme:

  1. `circle_quantizes` (handle `circle-quantizes`)
     For real `m`, the plane wave `theta |-> exp(I m theta)` is `2 pi`-periodic
     IF AND ONLY IF `m` is an integer. Forward: evaluate at `theta = 0`, reduce to
     `exp(I m 2pi) = 1`, and apply Mathlib's `Complex.exp_eq_one_iff`. This is the
     owner's line at wirohsh.md:64 with the implicit "and only these m" made explicit.

  2. `planeWave_hasDerivAt`, `line_never_quantizes` (handle `line-no-quantization`)
     On the full real line NO such constraint exists: for EVERY real `m` (integer or
     not) the same function solves the eigenvalue equation f'' = -(m^2) f, each
     derivative exhibited as a `HasDerivAt` witness (never bare `deriv`, per the house
     rule: `deriv` is junk-on-failure). The eigenvalue family { -m^2 : m real } is a
     continuum. This is the owner's continuous-omega complaint, proved rather than
     lamented.

  3. `box_quantizes`, `box_modes` (handle `box-quantizes`)
     Second instance of the same mechanism with a DIFFERENT boundary condition:
     `sin(k x)` vanishes at both walls `x = 0` and `x = L` iff `k = n pi / L` for an
     integer `n` (Dirichlet instead of periodic; the compact interval instead of the
     circle). Via Mathlib's `Real.sin_eq_zero_iff`.

  Reading the Lean symbols back into the owner's notation:

    `planeWave m`     his `Phi_m : phi |-> e^{i m phi}` (wirohsh.md:62), the angular
                      factor of the separated 2D Laplace solution; also, un-rotated,
                      the factor `e^{i omega t}` of his (Fourier) line.
    `m : R`           deliberately REAL, not integer: the theorem's content is that
                      the circle FORCES `m` into Z, so assuming it integer up front
                      would beg the question.
    `2 * pi`          the circumference of his compact `phi`-circle; the period
                      constraint `Phi(phi + 2pi) = Phi(phi)` is quantified over ALL
                      `theta`, exactly as his text states it.
    `-(m^2)`          his separation constant `m^2` (wirohsh.md:58), sign as it lands
                      on the angular equation `partial_phi^2 Phi = -m^2 Phi`.
    `k = n pi / L`    the particle-in-a-box wavenumber; NOT in the owner's corpus yet,
                      included as the second instance the essay proposes the theme
                      would cover if named.

  EXPLICITLY OUT OF SCOPE (do not read this file as more than it is):
    - Peter-Weyl, Dirac charge quantization, Matsubara frequencies: cited in the
      essay, proved nowhere in this repo.
    - The harmonic-oscillator COUNTEREXAMPLE to the theme's inverse (discreteness
      without compactness, from confinement) is checked by SymPy in the essay's
      computation block, not here.
    - Nothing here says anything about which themes the OWNER should name. That is
      Q10 and it is his.
-/
import Mathlib.Analysis.SpecialFunctions.Complex.Log
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Analysis.Complex.RealDeriv

namespace Toesnail.Themes

open Real

/-- The owner's angular factor `Phi_m(phi) = e^{i m phi}` (`physics/wirohsh.md:62`),
    with `m` deliberately a REAL parameter: the point of `circle_quantizes` is that
    the circle forces it into the integers. -/
noncomputable def planeWave (m : ℝ) : ℝ → ℂ :=
  fun x => Complex.exp (Complex.I * m * x)

/-- **Compactness quantizes** (handle `circle-quantizes`). `Phi_m` is `2 pi`-periodic
    iff `m` is an integer: the owner's `physics/wirohsh.md:64` ("the discreteness of m
    is a result of requiring `Phi(phi+2pi) = Phi(phi)`"), both directions. -/
theorem circle_quantizes (m : ℝ) :
    (∀ θ : ℝ, planeWave m (θ + 2 * π) = planeWave m θ) ↔ ∃ k : ℤ, m = k := by
  constructor
  · intro h
    have h0 := h 0
    simp only [planeWave, zero_add, Complex.ofReal_zero, mul_zero, Complex.exp_zero] at h0
    rw [Complex.exp_eq_one_iff] at h0
    obtain ⟨n, hn⟩ := h0
    push_cast at hn
    refine ⟨n, ?_⟩
    have h2 : (m : ℂ) * (2 * (π : ℂ) * Complex.I) = (n : ℂ) * (2 * (π : ℂ) * Complex.I) := by
      linear_combination hn
    have hne : (2 * (π : ℂ) * Complex.I) ≠ 0 := by
      refine mul_ne_zero (mul_ne_zero two_ne_zero ?_) Complex.I_ne_zero
      exact_mod_cast Real.pi_ne_zero
    have h3 : (m : ℂ) = (n : ℂ) := mul_right_cancel₀ hne h2
    exact_mod_cast h3
  · rintro ⟨k, rfl⟩ θ
    simp only [planeWave]
    have hsplit : Complex.I * ((k : ℝ) : ℂ) * ((θ + 2 * π : ℝ) : ℂ)
        = Complex.I * ((k : ℝ) : ℂ) * (θ : ℂ) + (k : ℂ) * (2 * (π : ℂ) * Complex.I) := by
      push_cast
      ring
    rw [hsplit, Complex.exp_add, Complex.exp_eq_one_iff.mpr ⟨k, rfl⟩, mul_one]

/-- First-derivative witness: `Phi_m' = i m Phi_m`, as a `HasDerivAt` (house rule:
    never a bare `deriv`, which is junk-on-failure). -/
theorem planeWave_hasDerivAt (m : ℝ) (x : ℝ) :
    HasDerivAt (planeWave m) (Complex.I * m * planeWave m x) x := by
  have hlin : HasDerivAt (fun z : ℂ => Complex.exp (Complex.I * m * z))
      (Complex.exp (Complex.I * m * x) * (Complex.I * m)) (x : ℂ) := by
    simpa using ((hasDerivAt_id (x : ℂ)).const_mul (Complex.I * (m : ℂ))).cexp
  have h := hlin.comp_ofReal
  rw [mul_comm (Complex.exp (Complex.I * ↑m * ↑x)) (Complex.I * ↑m)] at h
  exact h

/-- **Non-compactness does not quantize** (handle `line-no-quantization`). On the full
    real line, for EVERY real `m` the same `Phi_m` satisfies the eigenvalue equation
    `Phi_m'' = -(m^2) Phi_m`; nothing constrains `m`, so the eigenvalue family
    `{ -m^2 }` is a continuum. This is `physics/wirohsh.md:30`'s continuous-omega
    complaint, stated as a theorem: the second derivative of `Phi_m` (i.e. the
    derivative of `i m Phi_m`) is `-(m^2) Phi_m`, with no hypothesis on `m`. -/
theorem line_never_quantizes (m : ℝ) (x : ℝ) :
    HasDerivAt (fun y : ℝ => Complex.I * m * planeWave m y)
      (-((m : ℂ) ^ 2) * planeWave m x) x := by
  have h := (planeWave_hasDerivAt m x).const_mul (Complex.I * (m : ℂ))
  convert h using 1
  have hI : Complex.I * Complex.I = -1 := Complex.I_mul_I
  linear_combination (-((m : ℂ) ^ 2) * planeWave m x) * hI

/-- **The box quantizes too** (handle `box-quantizes`, wall at `L`): for `L ≠ 0`,
    `sin(k L) = 0` iff `k = n pi / L` with `n` an integer. Same mechanism as the
    circle, different boundary condition (Dirichlet, compact interval). -/
theorem box_quantizes {L : ℝ} (hL : L ≠ 0) (k : ℝ) :
    Real.sin (k * L) = 0 ↔ ∃ n : ℤ, k = n * π / L := by
  rw [Real.sin_eq_zero_iff]
  constructor
  · rintro ⟨n, hn⟩
    refine ⟨n, ?_⟩
    rw [eq_div_iff hL]
    linarith
  · rintro ⟨n, rfl⟩
    refine ⟨n, ?_⟩
    field_simp

/-- Both walls at once: `sin(k x)` vanishes at `x = 0` (automatic) and at `x = L`
    iff `k` sits on the discrete ladder `n pi / L`. -/
theorem box_modes {L : ℝ} (hL : L ≠ 0) (k : ℝ) :
    (Real.sin (k * 0) = 0 ∧ Real.sin (k * L) = 0) ↔ ∃ n : ℤ, k = n * π / L := by
  simp only [mul_zero, Real.sin_zero, true_and]
  exact box_quantizes hL k

end Toesnail.Themes

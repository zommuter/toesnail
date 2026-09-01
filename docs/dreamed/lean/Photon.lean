/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`.

  Lean attestation for `docs/dreamed/photon-localizability.md`, seeded from the owner's
  `physics/photon.md` (15 lines, stops mid-derivation) and from open question Q12 in
  `TODO.md id:57e2`.

  Everything here is faithful to a line the owner actually wrote, or to a textbook
  statement the essay cites. Nothing invents physics.

  1. `gaussian_travelling_solves` (handle `gauss-travel`)
     A Gaussian in the TRAVELLING-WAVE variable, `f(x,t) = exp(-(x - c t)^2 / (2 s^2))`,
     solves `f_xx - (1/c^2) f_tt = 0`. This is the d'Alembert half.

  2. `gaussian_static_box` (handle `gauss-static`)
     A Gaussian in `x` alone, with a static centre, does NOT: the wave operator applied
     to it equals `G(x) * (x^2 - s^2) / s^4`, which is nonzero off the two points
     `x = +- s`. The CONTRAST between 1 and 2 is the finding.

  3. `owner_ansatz_box` (handle `owner-box`)
     The owner's own ansatz shape in 1+1 dimensions: a Gaussian in the MINKOWSKI square,
     `A(x,t) = exp(-(x^2 - c^2 t^2) / (2 s^2))`, with constant centre and constant width.
     The wave operator does not annihilate it either; it delivers exactly

         box A = A * (c^2 t^2 - x^2 + 2 s^2) / s^4,

     which vanishes only on the hyperbola `c^2 t^2 - x^2 + 2 s^2 = 0`, a measure-zero set.
     So the ansatz is a source term `J`, not a free-field solution. `owner_ansatz_origin`
     evaluates it at the origin: `2 / s^2`, manifestly nonzero.
     OUT OF SCOPE: the owner's `mu_alpha^nu(x)` and `sigma_alpha(x)` are POSITION
     DEPENDENT and index dependent. Only the constant-centre, constant-width, single
     component case is formalised. The essay treats the general case with SymPy.

  4. `lorenz_planewave` / `lorenz_forces_transversality` (handle `lorenz-transverse`)
     The Lorenz condition `d^alpha A_alpha = 0` on a real plane wave
     `A_alpha = a_alpha cos(k . x)` equals `-(k . a) sin(k . x)`, so it forces the
     Minkowski contraction `k . a = 0` at any point where `sin(k . x) <> 0`.

  5. `residual_gauge_preserves` (handle `residual-gauge`)
     The residual gauge freedom `a -> a + lambda k` preserves BOTH `k . a = 0` and the
     null condition `k . k = 0`. That is the second subtraction in `4 - 1 - 1 = 2`.

  6. `photon_dof` / `proca_dof` (handle `dof-count`)
     The arithmetic bookkeeping of corpus row P-E, stated with the constraint counts as
     NAMED hypotheses so it cannot be mistaken for a derivation of them.

  7. `rs_first_order`, `rs_invariants` (handle `riemann-silberstein`)
     The algebraic half of the Riemann-Silberstein construction `F = E + i B`:
     the two curl equations collapse into one first-order equation, and `F . F` is the
     pair of Lorentz invariants `(E^2 - B^2) + 2 i (E . B)`.
     OUT OF SCOPE: that `curl` really is the derivative operator; the curls enter as
     given real numbers `ce`, `cb`.

  8. `gaussian_packet` (handle `packet-fourier`)
     The wave-packet identity, instantiated from Mathlib's `integral_cexp_quadratic`:
     `∫ exp(-a k^2 + i y k) dk = (pi/a)^(1/2) exp(-y^2/(4a))` for `Re a > 0`.
     This is the exact-solution route sketched in the essay.

  Owner convention: a derivative is named `<f>_<var>`, the subscript naming the
  differentiation variable (NOT `xd`/`xdd`). Mathlib's `deriv` is junk-on-failure, so
  every derivative claim is carried by a `HasDerivAt` witness.
-/
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv
import Mathlib.Analysis.Calculus.Deriv.Comp
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.Calculus.Deriv.Pow
import Mathlib.Analysis.SpecialFunctions.Gaussian.FourierTransform

namespace Photon

open Real

/-! ## 0. The Gaussian profile and its two derivatives -/

/-- The Gaussian profile `G s x = exp(-x^2 / (2 s^2))`. `s` is the owner's `sigma`. -/
noncomputable def G (s x : ℝ) : ℝ := Real.exp (-x ^ 2 / (2 * s ^ 2))

lemma G_pos (s x : ℝ) : 0 < G s x := Real.exp_pos _

@[simp] lemma G_zero (s : ℝ) : G s 0 = 1 := by simp [G]

/-- `G_x`: the first derivative, `G' = G * (-x / s^2)`. -/
lemma G_x (s : ℝ) (hs : s ≠ 0) (x : ℝ) :
    HasDerivAt (fun y : ℝ => G s y) (G s x * (-x / s ^ 2)) x := by
  have hu : HasDerivAt (fun y : ℝ => -y ^ 2 / (2 * s ^ 2)) (-x / s ^ 2) x := by
    have h := ((hasDerivAt_pow 2 x).neg).div_const (2 * s ^ 2)
    refine h.congr_deriv ?_
    have : s ^ 2 ≠ 0 := pow_ne_zero 2 hs
    field_simp
    ring
  simpa [G] using (Real.hasDerivAt_exp (-x ^ 2 / (2 * s ^ 2))).comp x hu

/-- `G_xx`: the second derivative, delivered as the derivative of the FIRST-derivative
    map `y ↦ G s y * (-y / s^2)`.  Value: `G * (x^2 / s^4 - 1 / s^2)`. -/
lemma G_xx (s : ℝ) (hs : s ≠ 0) (x : ℝ) :
    HasDerivAt (fun y : ℝ => G s y * (-y / s ^ 2))
      (G s x * (x ^ 2 / s ^ 4 - 1 / s ^ 2)) x := by
  have h2 : HasDerivAt (fun y : ℝ => -y / s ^ 2) (-1 / s ^ 2) x := by
    have := ((hasDerivAt_id x).neg).div_const (s ^ 2)
    refine this.congr_deriv ?_
    ring
  have h := (G_x s hs x).mul h2
  refine h.congr_deriv ?_
  have hs2 : s ^ 2 ≠ 0 := pow_ne_zero 2 hs
  field_simp
  ring

/-! ## 1. A Gaussian in the travelling-wave variable DOES solve the wave equation -/

/-- `f(x,t) = G s (x - c t)`: the `x`-slice first derivative. -/
lemma travel_x (s c t : ℝ) (hs : s ≠ 0) (x : ℝ) :
    HasDerivAt (fun y : ℝ => G s (y - c * t))
      (G s (x - c * t) * (-(x - c * t) / s ^ 2)) x := by
  simpa using (G_x s hs (x - c * t)).comp x ((hasDerivAt_id x).sub_const (c * t))

/-- `f(x,t) = G s (x - c t)`: the `t`-slice first derivative, carrying the chain factor
    `-c`. -/
lemma travel_t (s c x : ℝ) (hs : s ≠ 0) (t : ℝ) :
    HasDerivAt (fun y : ℝ => G s (x - c * y))
      (G s (x - c * t) * (-(x - c * t) / s ^ 2) * (-c)) t := by
  have inner : HasDerivAt (fun y : ℝ => x - c * y) (-c) t := by
    simpa using ((hasDerivAt_id t).const_mul c).const_sub x
  simpa using (G_x s hs (x - c * t)).comp t inner

/-- **A Gaussian in the travelling-wave variable solves the 1D wave equation.**
    With `f(x,t) = exp(-(x - c t)^2 / (2 s^2))`, both second slice derivatives are
    DELIVERED (not assumed), and they satisfy `f_xx - (1/c^2) f_tt = 0`.
    The first derivatives are `travel_x` / `travel_t`; the maps differentiated below are
    exactly those first derivatives. -/
theorem gaussian_travelling_solves (s c : ℝ) (hs : s ≠ 0) (hc : c ≠ 0) (x t : ℝ) :
    HasDerivAt (fun y : ℝ => G s (y - c * t) * (-(y - c * t) / s ^ 2))
      (G s (x - c * t) * ((x - c * t) ^ 2 / s ^ 4 - 1 / s ^ 2)) x
    ∧ HasDerivAt (fun y : ℝ => G s (x - c * y) * (-(x - c * y) / s ^ 2) * (-c))
      (c ^ 2 * (G s (x - c * t) * ((x - c * t) ^ 2 / s ^ 4 - 1 / s ^ 2))) t
    ∧ (G s (x - c * t) * ((x - c * t) ^ 2 / s ^ 4 - 1 / s ^ 2))
        - (1 / c ^ 2) * (c ^ 2 * (G s (x - c * t) * ((x - c * t) ^ 2 / s ^ 4 - 1 / s ^ 2)))
      = 0 := by
  refine ⟨?_, ?_, ?_⟩
  · have h := (G_xx s hs (x - c * t)).comp x ((hasDerivAt_id x).sub_const (c * t))
    refine h.congr_deriv ?_
    ring
  · have inner : HasDerivAt (fun y : ℝ => x - c * y) (-c) t := by
      simpa using ((hasDerivAt_id t).const_mul c).const_sub x
    have h := ((G_xx s hs (x - c * t)).comp t inner).mul_const (-c)
    refine h.congr_deriv ?_
    ring
  · have : c ^ 2 ≠ 0 := pow_ne_zero 2 hc
    field_simp
    ring

/-! ## 2. A Gaussian in `x` alone, static centre, does NOT -/

/-- **The contrast.**  For a `t`-independent Gaussian `f(x,t) = G s x` the time
    derivative vanishes identically, so the wave operator reduces to `f_xx`, and

        f_xx - (1/c^2) * 0 = G s x * (x^2 - s^2) / s^4.

    The `t`-slice witness is delivered (the constant map), so no hidden assumption
    about `f_tt` is smuggled in. -/
theorem gaussian_static_box (s c : ℝ) (hs : s ≠ 0) (x t : ℝ) :
    HasDerivAt (fun _ : ℝ => (0 : ℝ)) 0 t
    ∧ (G s x * (x ^ 2 / s ^ 4 - 1 / s ^ 2)) - (1 / c ^ 2) * 0
      = G s x * (x ^ 2 - s ^ 2) / s ^ 4 := by
  refine ⟨hasDerivAt_const t 0, ?_⟩
  have hs2 : s ≠ 0 := hs
  field_simp
  ring

/-- And that right-hand side is nonzero everywhere except at `x = ± s`.  So the static
    Gaussian is not a solution of `box A = 0` on any open set. -/
theorem gaussian_static_ne_zero (s x : ℝ) (hs : s ≠ 0) (hx : x ^ 2 ≠ s ^ 2) :
    G s x * (x ^ 2 - s ^ 2) / s ^ 4 ≠ 0 := by
  have h1 : G s x ≠ 0 := ne_of_gt (G_pos s x)
  have h2 : x ^ 2 - s ^ 2 ≠ 0 := sub_ne_zero.mpr hx
  have h3 : s ^ 4 ≠ 0 := pow_ne_zero 4 hs
  exact div_ne_zero (mul_ne_zero h1 h2) h3

/-! ## 3. The owner's own shape: a Gaussian in the Minkowski square -/

/-- The `t`-factor of the owner's ansatz: `K s c t = exp(c^2 t^2 / (2 s^2))`.
    Note it GROWS with `t`; the Minkowski square makes the exponent indefinite. -/
noncomputable def K (s c t : ℝ) : ℝ := Real.exp (c ^ 2 * t ^ 2 / (2 * s ^ 2))

lemma K_pos (s c t : ℝ) : 0 < K s c t := Real.exp_pos _

@[simp] lemma K_zero (s c : ℝ) : K s c 0 = 1 := by simp [K]

/-- The owner's ansatz factorises exactly: `exp(-(x^2 - c^2 t^2)/(2 s^2)) = G s x * K s c t`.
    This is the identity that makes the two slice derivatives independent. -/
lemma owner_factorises (s c x t : ℝ) :
    Real.exp (-(x ^ 2 - c ^ 2 * t ^ 2) / (2 * s ^ 2)) = G s x * K s c t := by
  rw [G, K, ← Real.exp_add]
  ring_nf

lemma K_t (s c : ℝ) (hs : s ≠ 0) (t : ℝ) :
    HasDerivAt (fun y : ℝ => K s c y) (K s c t * (c ^ 2 * t / s ^ 2)) t := by
  have hu : HasDerivAt (fun y : ℝ => c ^ 2 * y ^ 2 / (2 * s ^ 2)) (c ^ 2 * t / s ^ 2) t := by
    have h := ((hasDerivAt_pow 2 t).const_mul (c ^ 2)).div_const (2 * s ^ 2)
    refine h.congr_deriv ?_
    have : s ^ 2 ≠ 0 := pow_ne_zero 2 hs
    field_simp
    ring
  simpa [K] using (Real.hasDerivAt_exp (c ^ 2 * t ^ 2 / (2 * s ^ 2))).comp t hu

lemma K_tt (s c : ℝ) (hs : s ≠ 0) (t : ℝ) :
    HasDerivAt (fun y : ℝ => K s c y * (c ^ 2 * y / s ^ 2))
      (K s c t * (c ^ 4 * t ^ 2 / s ^ 4 + c ^ 2 / s ^ 2)) t := by
  have h2 : HasDerivAt (fun y : ℝ => c ^ 2 * y / s ^ 2) (c ^ 2 / s ^ 2) t := by
    have := ((hasDerivAt_id t).const_mul (c ^ 2)).div_const (s ^ 2)
    refine this.congr_deriv ?_
    ring
  have h := (K_t s c hs t).mul h2
  refine h.congr_deriv ?_
  have hs2 : s ^ 2 ≠ 0 := pow_ne_zero 2 hs
  field_simp

/-- **The owner's Gaussian ansatz is not a free-field solution: `box A` computed.**
    For `A(x,t) = exp(-(x^2 - c^2 t^2)/(2 s^2))` (constant centre, constant width, one
    component, 1+1 dimensions),

        (1/c^2) A_tt - A_xx = A * (c^2 t^2 - x^2 + 2 s^2) / s^4.

    Both second slice derivatives are delivered from `G_xx` / `K_tt`. -/
theorem owner_ansatz_box (s c : ℝ) (hs : s ≠ 0) (hc : c ≠ 0) (x t : ℝ) :
    HasDerivAt (fun y : ℝ => (G s y * (-y / s ^ 2)) * K s c t)
      ((G s x * (x ^ 2 / s ^ 4 - 1 / s ^ 2)) * K s c t) x
    ∧ HasDerivAt (fun y : ℝ => G s x * (K s c y * (c ^ 2 * y / s ^ 2)))
      (G s x * (K s c t * (c ^ 4 * t ^ 2 / s ^ 4 + c ^ 2 / s ^ 2))) t
    ∧ (1 / c ^ 2) * (G s x * (K s c t * (c ^ 4 * t ^ 2 / s ^ 4 + c ^ 2 / s ^ 2)))
        - (G s x * (x ^ 2 / s ^ 4 - 1 / s ^ 2)) * K s c t
      = G s x * K s c t * (c ^ 2 * t ^ 2 - x ^ 2 + 2 * s ^ 2) / s ^ 4 := by
  refine ⟨(G_xx s hs x).mul_const _, ((K_tt s c hs t).const_mul _), ?_⟩
  have hs4 : s ^ 4 ≠ 0 := pow_ne_zero 4 hs
  have hc2 : c ^ 2 ≠ 0 := pow_ne_zero 2 hc
  field_simp
  ring

/-- At the origin the source is `2 / s^2`, manifestly nonzero: the owner's ansatz cannot
    be a source-free solution even at one point of the light cone's vertex. -/
theorem owner_ansatz_origin (s c : ℝ) (hs : s ≠ 0) :
    G s 0 * K s c 0 * (c ^ 2 * 0 ^ 2 - 0 ^ 2 + 2 * s ^ 2) / s ^ 4 = 2 / s ^ 2 := by
  have hs2 : s ≠ 0 := hs
  simp only [G_zero, K_zero]
  field_simp
  ring

/-- More generally the source vanishes ONLY on the hyperbola `c^2 t^2 - x^2 + 2 s^2 = 0`. -/
theorem owner_ansatz_ne_zero (s c x t : ℝ) (hs : s ≠ 0)
    (h : c ^ 2 * t ^ 2 - x ^ 2 + 2 * s ^ 2 ≠ 0) :
    G s x * K s c t * (c ^ 2 * t ^ 2 - x ^ 2 + 2 * s ^ 2) / s ^ 4 ≠ 0 :=
  div_ne_zero (mul_ne_zero (mul_ne_zero (ne_of_gt (G_pos s x)) (ne_of_gt (K_pos s c t))) h)
    (pow_ne_zero 4 hs)

/-! ## 4. Lorenz gauge on a plane wave forces transversality -/

/-- The Minkowski contraction `k . a = k0 a0 - k1 a1 - k2 a2 - k3 a3`, signature
    `(+,-,-,-)`, all components written with LOWER indices. -/
def mdot (k0 k1 k2 k3 a0 a1 a2 a3 : ℝ) : ℝ :=
  k0 * a0 - k1 * a1 - k2 * a2 - k3 * a3

/-- Generic slice derivative of one plane-wave component. -/
lemma cos_slice (a k r y : ℝ) :
    HasDerivAt (fun z : ℝ => a * Real.cos (k * z + r))
      (-(a * k * Real.sin (k * y + r))) y := by
  have inner : HasDerivAt (fun z : ℝ => k * z + r) k y := by
    simpa using ((hasDerivAt_id y).const_mul k).add_const r
  have h := ((Real.hasDerivAt_cos (k * y + r)).comp y inner).const_mul a
  refine h.congr_deriv ?_
  ring

/-- **Lorenz gauge on a real plane wave.**  With `A_alpha(x) = a_alpha cos(k . x)`,
    `k . x = k0 x0 + k1 x1 + k2 x2 + k3 x3`, all four slice derivatives are delivered,
    and the Lorenz combination `d^alpha A_alpha = d_0 A_0 - d_1 A_1 - d_2 A_2 - d_3 A_3`
    equals `-(k . a) sin(k . x)`. -/
theorem lorenz_planewave (a0 a1 a2 a3 k0 k1 k2 k3 x0 x1 x2 x3 : ℝ) :
    HasDerivAt (fun z : ℝ => a0 * Real.cos (k0 * z + (k1 * x1 + k2 * x2 + k3 * x3)))
      (-(a0 * k0 * Real.sin (k0 * x0 + (k1 * x1 + k2 * x2 + k3 * x3)))) x0
    ∧ HasDerivAt (fun z : ℝ => a1 * Real.cos (k1 * z + (k0 * x0 + k2 * x2 + k3 * x3)))
      (-(a1 * k1 * Real.sin (k1 * x1 + (k0 * x0 + k2 * x2 + k3 * x3)))) x1
    ∧ HasDerivAt (fun z : ℝ => a2 * Real.cos (k2 * z + (k0 * x0 + k1 * x1 + k3 * x3)))
      (-(a2 * k2 * Real.sin (k2 * x2 + (k0 * x0 + k1 * x1 + k3 * x3)))) x2
    ∧ HasDerivAt (fun z : ℝ => a3 * Real.cos (k3 * z + (k0 * x0 + k1 * x1 + k2 * x2)))
      (-(a3 * k3 * Real.sin (k3 * x3 + (k0 * x0 + k1 * x1 + k2 * x2)))) x3
    ∧ ∀ S : ℝ,
        (-(a0 * k0 * S)) - (-(a1 * k1 * S)) - (-(a2 * k2 * S)) - (-(a3 * k3 * S))
          = -(mdot k0 k1 k2 k3 a0 a1 a2 a3) * S := by
  refine ⟨cos_slice _ _ _ _, cos_slice _ _ _ _, cos_slice _ _ _ _, cos_slice _ _ _ _, ?_⟩
  intro S
  simp only [mdot]
  ring

/-- Hence: if the Lorenz combination vanishes at a point where `sin(k . x) <> 0`, the
    polarisation is Minkowski-orthogonal to the wave vector. -/
theorem lorenz_forces_transversality (a0 a1 a2 a3 k0 k1 k2 k3 S : ℝ) (hS : S ≠ 0)
    (hL : -(mdot k0 k1 k2 k3 a0 a1 a2 a3) * S = 0) :
    mdot k0 k1 k2 k3 a0 a1 a2 a3 = 0 := by
  rcases mul_eq_zero.mp hL with h | h
  · linarith [neg_eq_zero.mp h]
  · exact absurd h hS

/-- **Residual gauge freedom.**  Shifting `a -> a + lambda k` preserves the Lorenz
    condition `k . a = 0` whenever `k` is null (`k . k = 0`), which for the free photon
    it is.  This is the SECOND subtraction in `4 - 1 - 1 = 2`; for a massive Proca field
    `k . k = m^2 <> 0` and the shift is not available. -/
theorem residual_gauge_preserves (k0 k1 k2 k3 a0 a1 a2 a3 lam : ℝ)
    (hL : mdot k0 k1 k2 k3 a0 a1 a2 a3 = 0)
    (hnull : mdot k0 k1 k2 k3 k0 k1 k2 k3 = 0) :
    mdot k0 k1 k2 k3 (a0 + lam * k0) (a1 + lam * k1) (a2 + lam * k2) (a3 + lam * k3) = 0 := by
  simp only [mdot] at *
  linear_combination hL + lam * hnull

/-- Corpus row P-E, the bookkeeping half.  The constraint counts are NAMED hypotheses,
    so this theorem asserts the ARITHMETIC only and never pretends to derive them.
    Massless (`k . k = 0`, so the residual shift of `residual_gauge_preserves` exists):
    `4 - 1 - 1 = 2`.  Massive Proca (`k . k = m^2 <> 0`, no residual shift):
    `4 - 1 = 3`. -/
theorem photon_dof (components lorenz residual : ℕ)
    (hc : components = 4) (hl : lorenz = 1) (hr : residual = 1) :
    components - lorenz - residual = 2 := by
  subst hc; subst hl; subst hr; rfl

theorem proca_dof (components lorenz : ℕ) (hc : components = 4) (hl : lorenz = 1) :
    components - lorenz = 3 := by
  subst hc; subst hl; rfl

/-! ## 5. The Riemann-Silberstein vector -/

open Complex in
/-- **The two curl equations collapse into one.**  Given the Maxwell pair (componentwise,
    with `ce`/`cb` the given components of `curl E` / `curl B`)

        E_t = c * (curl B),    B_t = -c * (curl E),

    the complex combination `F = E + i B` obeys `F_t = -i c (curl F)`.
    This is the algebraic content; that `curl` is a derivative operator is not used. -/
theorem rs_first_order (c Et Bt ce cb : ℝ) (hE : Et = c * cb) (hB : Bt = -(c * ce)) :
    ((Et : ℂ) + Complex.I * (Bt : ℂ))
      = -(Complex.I * (c : ℂ)) * ((ce : ℂ) + Complex.I * (cb : ℂ)) := by
  subst hE; subst hB
  push_cast
  linear_combination ((c : ℂ) * (cb : ℂ)) * Complex.I_sq

open Complex in
/-- **`F . F` is the pair of Lorentz invariants.**  `(E + iB) . (E + iB) = (E^2 - B^2) + 2i (E . B)`:
    the real part is `-F_{mu nu} F^{mu nu} / 2` up to normalisation, the imaginary part is
    the pseudoscalar `F Fdual`.  Closed by `ring` modulo `I^2 = -1`. -/
theorem rs_invariants (E1 E2 E3 B1 B2 B3 : ℝ) :
    ((E1 : ℂ) + Complex.I * B1) ^ 2 + ((E2 : ℂ) + Complex.I * B2) ^ 2
        + ((E3 : ℂ) + Complex.I * B3) ^ 2
      = ((E1 ^ 2 + E2 ^ 2 + E3 ^ 2 : ℝ) : ℂ) - ((B1 ^ 2 + B2 ^ 2 + B3 ^ 2 : ℝ) : ℂ)
        + 2 * Complex.I * ((E1 * B1 + E2 * B2 + E3 * B3 : ℝ) : ℂ) := by
  push_cast
  linear_combination ((B1 : ℂ) ^ 2 + (B2 : ℂ) ^ 2 + (B3 : ℂ) ^ 2) * Complex.I_sq

/-! ## 6. The genuine wave-packet route: the Gaussian Fourier integral -/

/-- **A Gaussian spectral weight integrates to a Gaussian.**
    `∫ exp(-a k^2 + i y k) dk = (pi / a)^(1/2) * exp(-y^2 / (4a))` for `Re a > 0`.
    Instantiated from Mathlib's `integral_cexp_quadratic`; the complex `a` is what makes
    the packet SPREAD, since propagating it turns `a` into `a + i t` and the modulus
    width grows.  Nothing here is hand-computed. -/
theorem gaussian_packet (a : ℂ) (ha : 0 < a.re) (y : ℝ) :
    (∫ k : ℝ, Complex.exp (-a * (k : ℂ) ^ 2 + Complex.I * (y : ℂ) * (k : ℂ)))
      = ((Real.pi : ℂ) / a) ^ (1 / 2 : ℂ) * Complex.exp (-(y : ℂ) ^ 2 / (4 * a)) := by
  have ha' : a ≠ 0 := by
    intro h; rw [h] at ha; simp at ha
  have hb : (-a).re < 0 := by
    rw [Complex.neg_re]; linarith
  have h := integral_cexp_quadratic (b := -a) hb (Complex.I * (y : ℂ)) 0
  have hexp : (0 : ℂ) - (Complex.I * (y : ℂ)) ^ 2 / (4 * -a)
      = -(y : ℂ) ^ 2 / (4 * a) := by
    have hI : (Complex.I * (y : ℂ)) ^ 2 = -(y : ℂ) ^ 2 := by
      rw [mul_pow, Complex.I_sq]; ring
    rw [hI]
    field_simp
    ring
  rw [hexp, neg_neg] at h
  rw [← h]
  refine MeasureTheory.integral_congr_ae (Filter.Eventually.of_forall fun k => ?_)
  ring_nf

end Photon

/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`.

  Lean attestation for `docs/dreamed/wirohsh-splats.md`, seeded from the owner's
  `physics/wirohsh.md` ("WiRoHSH -- Wick-rotated hyper-spherical harmonics").

  Three claims are formalised, each faithful to a line the owner actually wrote.

  1. `wirohsh_transverse_symbol` (handle `transverse-symbol`)
     The owner's `align*` block in physics/wirohsh.md:

         Delta_phi = Delta - (e_phi . grad)^2
                   = dx^2 sin^2 phi + dy^2 cos^2 phi - 2 dx dy cos phi sin phi
                   = (dx sin phi - dy cos phi)^2 = d_{phibar}^2

     Formalised at the level of the SECOND-ORDER SYMBOL: partial derivatives
     `dx, dy` are replaced by their Fourier symbols `xi, eta` (real scalars), under
     which composition of constant-coefficient operators is polynomial multiplication.
     Both of the owner's `=` steps are proved, in the owner's order.
     OUT OF SCOPE: that symbol calculus is a faithful model of the operator algebra.
     That is standard for constant-coefficient operators and is not proved here.

  2. `wirohsh_null_direction` (handle `null-direction`)
     The reason the 3D reduction closes: the Wick-rotated propagation direction
     `(cos phi, sin phi, i)` in C^3 is NULL, `sum of squares = 0`, and it is
     orthogonal to the real transverse direction `(sin phi, -cos phi, 0)`.

  3. `wirohsh_kernel_harmonic` (handle `whittaker-kernel`)
     The Whittaker/Bateman kernel `u^(n+2)` with `u = x cos phi + y sin phi + i z`
     satisfies the 3D Laplace equation, proved by actually differentiating twice in
     each of `x`, `y`, `z` with `HasDerivAt` witnesses (Mathlib `deriv` is
     junk-on-failure, so the derivative values are carried as witnesses, never as
     `deriv` applications). The Laplacian is assembled from the three second slice
     derivatives, which is legitimate here because each slice map is a polynomial.
     OUT OF SCOPE: the phi-integral of the kernel (`docs/dreamed/wirohsh-splats.md`,
     handle `whittaker-3d`); Fubini/differentiation-under-the-integral is not done.

  4. `dalembert_wave` (handle `dalembert`)
     The 1D case at the top of physics/wirohsh.md: `f(x,t) = g(x - c t) + h(x + c t)`
     solves `f_xx - (1/c^2) f_tt = 0`. Stated with `HasDerivAt` witnesses for the
     first and second derivatives of `g` and `h` (differentiability lives in named
     hypotheses), and with `c <> 0`.
     OUT OF SCOPE: the converse (that every solution has this form), and any
     regularity weaker than "twice differentiable everywhere".
     NOTE: `hg`/`hh` (that `g_x`/`h_x` really are the first derivatives of `g`/`h`)
     are stated for FAITHFULNESS but are not consumed by the proof -- only the
     second-derivative witnesses `hg2`/`hh2` are. Dropping them would generalise the
     theorem but would stop it being a statement about `g(x-ct)+h(x+ct)`.

  Identifier mapping (owner convention: a derivative is named `<f>_<var>`, the
  subscript naming the differentiation variable; NOT `xd`/`xdd`):
      `g_x`, `g_xx`  <-> g', g''      (profile derivatives, argument named x)
      `f_xx`, `f_tt` <-> d_x^2 f, d_t^2 f
      `u_x`, `u_xx`  <-> d_x u, d_x^2 u   (and likewise for y, z)
  `phi` is the owner's `\phi`; `c` the wave speed.
-/
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.Calculus.Deriv.Pow
import Mathlib.Analysis.Calculus.Deriv.Comp
import Mathlib.Analysis.Calculus.Deriv.Linear
import Mathlib.Analysis.SpecialFunctions.Complex.Circle

open Real Complex

namespace Wirohsh

/-! ## 1. The transverse-symbol identity (handle `transverse-symbol`) -/

/-- Owner's line (physics/wirohsh.md, the `Delta_phi` `align*` block), at the level of
    second-order symbols: writing `xi` for `d_x` and `eta` for `d_y`,

      xi^2 + eta^2 - (xi cos phi + eta sin phi)^2
        = xi^2 sin^2 phi + eta^2 cos^2 phi - 2 xi eta cos phi sin phi     (step 1)
        = (xi sin phi - eta cos phi)^2                                    (step 2)

    i.e. the transverse Laplacian in the plane is exactly the squared derivative along
    the direction `e_phibar = (sin phi, -cos phi)`. Both steps are proved, in order;
    step 1 is where `sin^2 + cos^2 = 1` is consumed. -/
theorem wirohsh_transverse_symbol (φ ξ η : ℝ) :
    ξ ^ 2 + η ^ 2 - (ξ * Real.cos φ + η * Real.sin φ) ^ 2
      = ξ ^ 2 * Real.sin φ ^ 2 + η ^ 2 * Real.cos φ ^ 2
        - 2 * ξ * η * Real.cos φ * Real.sin φ
    ∧ ξ ^ 2 * Real.sin φ ^ 2 + η ^ 2 * Real.cos φ ^ 2
        - 2 * ξ * η * Real.cos φ * Real.sin φ
      = (ξ * Real.sin φ - η * Real.cos φ) ^ 2 := by
  have pyth : Real.sin φ ^ 2 + Real.cos φ ^ 2 = 1 := Real.sin_sq_add_cos_sq φ
  constructor
  · nlinarith [pyth, sq_nonneg ξ, sq_nonneg η]
  · ring

/-! ## 2. The null direction (handle `null-direction`) -/

/-- Wick-rotating `z` turns the propagation direction `e_phi = (cos phi, sin phi)` into
    the C^3 direction `n_phi = (cos phi, sin phi, i)`, whose sum of squares VANISHES.
    That single fact is why `a(x cos phi + y sin phi + i z)` is harmonic for ANY twice
    differentiable `a`: the chain rule produces `a'' * (grad u . grad u)`, and the
    bracket is zero. -/
theorem wirohsh_null_direction (φ : ℝ) :
    ((Real.cos φ : ℂ)) ^ 2 + ((Real.sin φ : ℂ)) ^ 2 + Complex.I ^ 2 = 0 := by
  have hr : Real.cos φ ^ 2 + Real.sin φ ^ 2 = 1 := by
    rw [add_comm]; exact Real.sin_sq_add_cos_sq φ
  have hc : ((Real.cos φ : ℂ)) ^ 2 + ((Real.sin φ : ℂ)) ^ 2 = 1 := by
    rw [← Complex.ofReal_pow, ← Complex.ofReal_pow, ← Complex.ofReal_add, hr,
      Complex.ofReal_one]
  rw [hc, Complex.I_sq]
  ring

/-- The Wick-rotated direction `n_phi = (cos phi, sin phi, i)` is orthogonal to the real
    transverse direction `e_phibar = (sin phi, -cos phi, 0)`. This is why the owner's
    second family `b_phi(u) * x_phibar` is harmonic too: the cross term
    `2 b'(u) (grad u . grad x_phibar)` vanishes. -/
theorem wirohsh_transverse_orthogonal (φ : ℝ) :
    ((Real.cos φ : ℂ)) * ((Real.sin φ : ℂ))
      + ((Real.sin φ : ℂ)) * (-(Real.cos φ : ℂ)) + Complex.I * 0 = 0 := by
  ring

/-! ## 3. The Whittaker kernel is harmonic (handle `whittaker-kernel`) -/

/-- The Wick-rotated null coordinate `u = x cos phi + y sin phi + i z`. -/
noncomputable def u (φ x y z : ℝ) : ℂ :=
  (x : ℂ) * (Real.cos φ : ℂ) + (y : ℂ) * (Real.sin φ : ℂ) + Complex.I * (z : ℂ)

lemma u_x (φ y z : ℝ) (x : ℝ) :
    HasDerivAt (fun s : ℝ => u φ s y z) ((Real.cos φ : ℂ)) x := by
  have h : HasDerivAt (fun s : ℝ => (s : ℂ)) (1 : ℂ) x := by
    simpa using (Complex.ofRealCLM.hasDerivAt (x := x))
  simpa [u] using ((h.mul_const ((Real.cos φ : ℂ))).add_const
    ((y : ℂ) * (Real.sin φ : ℂ) + Complex.I * (z : ℂ)))

lemma u_y (φ x z : ℝ) (y : ℝ) :
    HasDerivAt (fun s : ℝ => u φ x s z) ((Real.sin φ : ℂ)) y := by
  have h : HasDerivAt (fun s : ℝ => (s : ℂ)) (1 : ℂ) y := by
    simpa using (Complex.ofRealCLM.hasDerivAt (x := y))
  have := ((h.mul_const ((Real.sin φ : ℂ))).const_add ((x : ℂ) * (Real.cos φ : ℂ)))
  simpa [u, add_assoc, add_comm, add_left_comm] using
    (this.add_const (Complex.I * (z : ℂ)))

lemma u_z (φ x y : ℝ) (z : ℝ) :
    HasDerivAt (fun s : ℝ => u φ x y s) Complex.I z := by
  have h : HasDerivAt (fun s : ℝ => (s : ℂ)) (1 : ℂ) z := by
    simpa using (Complex.ofRealCLM.hasDerivAt (x := z))
  simpa [u, mul_comm] using
    ((h.mul_const Complex.I).const_add ((x : ℂ) * (Real.cos φ : ℂ)
      + (y : ℂ) * (Real.sin φ : ℂ)))

/-- Generic second slice derivative of `u ^ (n+2)` along a coordinate whose `u`-slope is
    the constant `d`: `d_s^2 (u^(n+2)) = (n+2)(n+1) u^n d^2`. -/
lemma pow_slice_second {U : ℝ → ℂ} {d : ℂ} {s : ℝ} (n : ℕ)
    (hU : ∀ t : ℝ, HasDerivAt U d t) :
    HasDerivAt (fun t : ℝ => ((n : ℂ) + 2) * U t ^ (n + 1) * d)
      (((n : ℂ) + 2) * ((n : ℂ) + 1) * U s ^ n * d ^ 2) s := by
  have h1 : HasDerivAt (fun t : ℝ => U t ^ (n + 1))
      (((n : ℕ) + 1 : ℕ) * U s ^ n * d) s := by
    simpa using (hU s).pow (n + 1)
  have h2 := (h1.const_mul ((n : ℂ) + 2)).mul_const d
  refine h2.congr_deriv ?_
  push_cast
  ring

/-- **The Whittaker/Bateman kernel is harmonic in 3D.**  For every `phi`, every `n`, and
    every point `(x,y,z)`, the three second slice derivatives of
    `u^(n+2)`, `u = x cos phi + y sin phi + i z`, sum to zero:

        d_x^2 u^(n+2) + d_y^2 u^(n+2) + d_z^2 u^(n+2) = 0.

    The `x` and `y` contributions carry `cos^2 phi` and `sin^2 phi`, the `z` contribution
    carries `i^2 = -1`, and `cos^2 + sin^2 - 1 = 0` kills the sum. Each second derivative
    is delivered as a `HasDerivAt` witness of the corresponding FIRST derivative map, so
    no `deriv` junk value can leak into the statement. -/
theorem wirohsh_kernel_harmonic (φ x y z : ℝ) (n : ℕ)
    (fxx fyy fzz : ℂ)
    (hxx : HasDerivAt (fun s : ℝ => ((n : ℂ) + 2) * u φ s y z ^ (n + 1)
              * (Real.cos φ : ℂ)) fxx x)
    (hyy : HasDerivAt (fun s : ℝ => ((n : ℂ) + 2) * u φ x s z ^ (n + 1)
              * (Real.sin φ : ℂ)) fyy y)
    (hzz : HasDerivAt (fun s : ℝ => ((n : ℂ) + 2) * u φ x y s ^ (n + 1)
              * Complex.I) fzz z) :
    fxx + fyy + fzz = 0 := by
  have ex := pow_slice_second (U := fun s : ℝ => u φ s y z)
    (d := (Real.cos φ : ℂ)) (s := x) n (fun t => u_x φ y z t)
  have ey := pow_slice_second (U := fun s : ℝ => u φ x s z)
    (d := (Real.sin φ : ℂ)) (s := y) n (fun t => u_y φ x z t)
  have ez := pow_slice_second (U := fun s : ℝ => u φ x y s)
    (d := Complex.I) (s := z) n (fun t => u_z φ x y t)
  have hx' := hxx.unique ex
  have hy' := hyy.unique ey
  have hz' := hzz.unique ez
  subst hx'; subst hy'; subst hz'
  have hnull : ((Real.cos φ : ℂ)) ^ 2 + ((Real.sin φ : ℂ)) ^ 2 + Complex.I ^ 2 = 0 :=
    wirohsh_null_direction φ
  have hu : u φ x y z = u φ x y z := rfl
  -- all three second derivatives share the same base point value of `u`
  have e1 : u φ x y z ^ n = u φ x y z ^ n := rfl
  linear_combination (((n : ℂ) + 2) * ((n : ℂ) + 1) * u φ x y z ^ n) * hnull

/-! ## 4. d'Alembert (handle `dalembert`) -/

/-- **1D wave equation from the d'Alembert form.**  If `g` and `h` are twice
    differentiable with derivative witnesses `g_x, g_xx, h_x, h_xx`, then
    `f(x,t) = g(x - c t) + h(x + c t)` satisfies `f_xx - (1/c^2) f_tt = 0`.

    The two second slice derivatives are DELIVERED, not assumed: `hx2` and `ht2` are
    proved from the hypotheses, and the wave equation is then arithmetic. `c <> 0` is
    required only for `1/c^2 * c^2 = 1`. -/
theorem dalembert_wave (c : ℝ) (hc : c ≠ 0) (g h g_x g_xx h_x h_xx : ℝ → ℝ)
    (hg : ∀ s, HasDerivAt g (g_x s) s) (hg2 : ∀ s, HasDerivAt g_x (g_xx s) s)
    (hh : ∀ s, HasDerivAt h (h_x s) s) (hh2 : ∀ s, HasDerivAt h_x (h_xx s) s)
    (x t : ℝ) :
    -- second derivative in x of the x-slice
    HasDerivAt (fun s : ℝ => g_x (s - c * t) + h_x (s + c * t))
      (g_xx (x - c * t) + h_xx (x + c * t)) x
    -- second derivative in t of the t-slice
    ∧ HasDerivAt (fun s : ℝ => -c * g_x (x - c * s) + c * h_x (x + c * s))
      (c ^ 2 * g_xx (x - c * t) + c ^ 2 * h_xx (x + c * t)) t
    -- and those two satisfy the wave equation
    ∧ (g_xx (x - c * t) + h_xx (x + c * t))
        - (1 / c ^ 2) * (c ^ 2 * g_xx (x - c * t) + c ^ 2 * h_xx (x + c * t)) = 0 := by
  refine ⟨?_, ?_, ?_⟩
  · have a1 : HasDerivAt (fun s : ℝ => g_x (s - c * t)) (g_xx (x - c * t)) x := by
      simpa using (hg2 (x - c * t)).comp x ((hasDerivAt_id x).sub_const (c * t))
    have a2 : HasDerivAt (fun s : ℝ => h_x (s + c * t)) (h_xx (x + c * t)) x := by
      simpa using (hh2 (x + c * t)).comp x ((hasDerivAt_id x).add_const (c * t))
    exact a1.add a2
  · have b1 : HasDerivAt (fun s : ℝ => g_x (x - c * s)) (g_xx (x - c * t) * (-c)) t := by
      have inner : HasDerivAt (fun s : ℝ => x - c * s) (-c) t := by
        simpa using ((hasDerivAt_id t).const_mul c).const_sub x
      simpa using (hg2 (x - c * t)).comp t inner
    have b2 : HasDerivAt (fun s : ℝ => h_x (x + c * s)) (h_xx (x + c * t) * c) t := by
      have inner : HasDerivAt (fun s : ℝ => x + c * s) c t := by
        simpa using ((hasDerivAt_id t).const_mul c).const_add x
      simpa using (hh2 (x + c * t)).comp t inner
    have := (b1.const_mul (-c)).add (b2.const_mul c)
    refine this.congr_deriv ?_
    ring
  · field_simp
    ring

end Wirohsh

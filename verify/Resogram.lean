/-
  Lean attestation for the Resogram `verify:` rigor-debt markers.

  The instruments are SOURCE; their verdicts are CACHE (see `CONVENTIONS.md` §3 and
  `verify/README.md`). This file is the Lean tier for ONE owner-stated, SymPy-confirmed
  claim — the *algebraic* first-line identity of the energy-rate chain (handle `edot`).

  Claim (physics/Resogram.md, handle `edot`), first line only:

      e  = ½ẋ² + ½ω²x²
      ė  = ẋ(ẍ + ω²x) = −2βẋ² + ω²ẋy        (first line)

  with the equation of motion  ẍ = −2βẋ − ω²(x − y).

  This is the *algebraic* step: substitute the equation of motion into ẋ(ẍ + ω²x) and
  the −ω²x cross-term cancels, leaving −2βẋ² + ω²ẋy. The SymPy instrument
  `verify/resogram_edot.py` confirms it symbolically (VERDICT ✓); this is its Lean tier.

  Scope: the *derivative* step (that ė of e = ½ẋ²+½ω²x² is genuinely ẋ(ẍ+ω²x), via
  Mathlib `deriv`/chain-rule) is SEPARATE debt (ROADMAP id:b9bc), NOT proven here. We
  treat ẋ, ẍ as free reals and prove only the algebraic identity the first line asserts.
-/
import Mathlib

/-- First-line energy-rate identity for the driven harmonic oscillator (handle `edot`):
    after substituting the equation of motion `ẍ = −2βẋ − ω²(x−y)` into `ẋ(ẍ + ω²x)`,
    the `ω²x` cross-term cancels and the rate is `−2βẋ² + ω²ẋy`. Pure algebra.

    Identifier mapping (Lean rejects the combining-dot Latin letters `ẋ`/`ẍ` as
    identifier characters, so derivatives are spelled ASCII with a `_<var>` subscript
    naming the differentiation variable — this scales to PDEs mixing spatial/temporal
    derivatives, where a bare `…d`/`…dd` count would be ambiguous):
      `x_t`  ↔ ẋ   (first  time derivative ∂ₜx),
      `x_tt` ↔ ẍ   (second time derivative ∂ₜₜx).
    Future spatial / mixed derivatives follow the same scheme (`x_x`, `x_xx`, `x_xt`, …).
    `x y β ω` are spelled as in the doc (`β`, `ω` are valid Lean identifiers). The
    statement is otherwise the doc's `edot` first line verbatim. -/
theorem edot_first_line (x x_t x_tt y β ω : ℝ) (eom : x_tt = -2*β*x_t - ω^2*(x-y)) :
    x_t*(x_tt + ω^2*x) = -2*β*x_t^2 + ω^2*x_t*y := by
  subst eom; ring

/-- Derivative step for the Resogram energy rate (handle `edot_deriv`, ROADMAP id:b9bc):
    the specific energy `e = ½v² + ½ω²x²` has time derivative `ė = v(a + ω²x)`.

    No equation of motion is used here — this is the pure calculus step: if `x` has
    derivative `v` (velocity) and `v` has derivative `a` (acceleration), then `e`
    has the stated derivative by the chain rule.  The algebraic step (substituting the
    EOM into `v(a + ω²x)`) is the separate `edot_first_line` theorem above.

    Identifier mapping (consistent with `edot_first_line`):
      `x`, `v`, `a` are real-valued functions of time,
      `v t` ↔ ẋ, `a t` ↔ ẍ (at time `t`).
    `ω` is the angular frequency (real). -/
theorem edot_deriv (x v a : ℝ → ℝ) (ω : ℝ) (t : ℝ)
    (hx : HasDerivAt x (v t) t)          -- ẋ = v
    (hv : HasDerivAt v (a t) t)          -- ẍ = a
    : HasDerivAt (fun s => (1/2)*(v s)^2 + (1/2)*ω^2*(x s)^2)
                 (v t * (a t + ω^2 * x t)) t := by
  -- Build HasDerivAt for each summand, then combine with congr_deriv
  have hv2 : HasDerivAt (fun s => (1/2 : ℝ) * v s ^ 2) (1/2 * (2 * v t ^ 1 * a t)) t :=
    (hv.pow 2).const_mul _
  have hx2 : HasDerivAt (fun s => (ω^2/2 : ℝ) * x s ^ 2) (ω^2/2 * (2 * x t ^ 1 * v t)) t :=
    (hx.pow 2).const_mul _
  -- Rewrite derivative values; note x t^1 = x t, v t^1 = v t by ring
  have hv2' : HasDerivAt (fun s => (1/2 : ℝ) * v s ^ 2) (v t * a t) t :=
    hv2.congr_deriv (by ring)
  have hx2' : HasDerivAt (fun s => (ω^2/2 : ℝ) * x s ^ 2) (ω^2 * x t * v t) t :=
    hx2.congr_deriv (by ring)
  -- Add: hadd.f is (fun s => 1/2 * v s^2 + ω^2/2 * x s^2) and
  -- hadd.f' is v t * a t + ω^2 * x t * v t  =  v t * (a t + ω^2 * x t)
  have hadd := hv2'.add hx2'
  -- The function in hadd is Pi.add-based; our target differs by ring rewrites.
  -- Separate the two conversion goals explicitly.
  convert hadd using 1
  · -- function equality: (fun s => ...) = Pi.add ...
    funext s; simp only [Pi.add_apply]; ring
  · ring

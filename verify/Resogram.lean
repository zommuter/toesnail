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

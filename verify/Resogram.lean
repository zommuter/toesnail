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
    identifier characters, so the time derivatives are spelled ASCII):
      `xd`  ↔ ẋ   (first derivative),
      `xdd` ↔ ẍ   (second derivative).
    `x y β ω` are spelled as in the doc (`β`, `ω` are valid Lean identifiers). The
    statement is otherwise the doc's `edot` first line verbatim. -/
theorem edot_first_line (x xd xdd y β ω : ℝ) (eom : xdd = -2*β*xd - ω^2*(x-y)) :
    xd*(xdd + ω^2*x) = -2*β*xd^2 + ω^2*xd*y := by
  subst eom; ring

# /// script
# requires-python = ">=3.10"
# dependencies = ["sympy"]
# ///
"""verify:sympy [edot] — energy-rate chain for the driven harmonic oscillator.

Claim (physics/Resogram.md, handle `edot`) — owner-ratified form (2026-06-15):
    e  = ½ẋ² + ½ω²x²
    ė  = ẋ(ẍ + ω²x) = −2βẋ² + ω²ẋy          (first line)
       = −4βe + ω²(2βx² + ẋy)               (second line, corrected)

with the equation of motion  ẍ = −2βẋ − ω²(x − y).

History: the pilot located a sign discrepancy in the SECOND equality (the doc
originally wrote −4βe − ω²(2βx² − ẋy)). The owner ratified the correction via
/relay human on 2026-06-15 and the source now states the form above. This
instrument verifies the corrected closed form end-to-end (VERDICT ✓).

Run:  uv run verify/resogram_edot.py
Emits a finding only; it never edits the theory.
"""
import hashlib
from sympy import symbols, srepr, simplify, Eq, Rational

x, xd, xdd, y, beta, omega = symbols("x xd xdd y beta omega", real=True)

e = Rational(1, 2) * xd**2 + Rational(1, 2) * omega**2 * x**2
edot_chain = xd * (xdd + omega**2 * x)            # ė = ẋ(ẍ + ω²x)
eom = -2 * beta * xd - omega**2 * (x - y)         # ẍ from the equation of motion
edot = edot_chain.subs(xdd, eom)                  # ė after substituting ẍ

# First-line claim: ė = −2βẋ² + ω²ẋy
first = -2 * beta * xd**2 + omega**2 * xd * y
first_ok = simplify(edot - first) == 0

# Second-line claim (owner-ratified source form): ė = −4βe + ω²(2βx² + ẋy)
doc_second = -4 * beta * e + omega**2 * (2 * beta * x**2 + xd * y)
second_residual = simplify(edot - doc_second)

# Historical (pre-correction) doc form, kept for provenance: −4βe − ω²(2βx² − ẋy)
old_doc_second = -4 * beta * e - omega**2 * (2 * beta * x**2 - xd * y)

print("ė (substituted)         :", simplify(edot))
print("first-line claim holds  :", first_ok)
print("second-line residual    :", second_residual, "   (ė − source_RHS, must be 0)")
print()
if first_ok and second_residual == 0:
    print("VERDICT: ✓  full chain confirmed (owner-ratified corrected form)")
    print("  ė = ẋ(ẍ + ω²x) = −2βẋ² + ω²ẋy = −4βe + ω²(2βx² + ẋy)")
    print(f"  (the superseded doc form −4βe − ω²(2βx² − ẋy) was off by "
          f"{simplify(old_doc_second - edot)}.)")
else:
    print("VERDICT: ✗  source form does not match the symbolic ė — re-check Resogram.md handle edot")
    print(f"  residual ė − source_RHS = {second_residual}")

# Attestation hash for the full confirmed chain ė = ẋ(ẍ+ω²x) = −4βe + ω²(2βx²+ẋy).
CLAIM = Eq(edot_chain.subs(xdd, eom), doc_second)
print("\nCLAIM_SREPR :", srepr(CLAIM))
print("CLAIM_HASH8 :", hashlib.sha256(srepr(CLAIM).encode()).hexdigest()[:8])

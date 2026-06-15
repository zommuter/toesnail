# /// script
# requires-python = ">=3.10"
# dependencies = ["sympy"]
# ///
"""verify:sympy [edot] — energy-rate chain for the driven harmonic oscillator.

Claim (physics/Resogram.md, handle `edot`):
    e  = ½ẋ² + ½ω²x²
    ė  = ẋ(ẍ + ω²x) = −2βẋ² + ω²ẋy          (first line)
       = −4βe − ω²(2βx² − ẋy)               (second line, candidate discrepancy)

with the equation of motion  ẍ = −2βẋ − ω²(x − y).

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

# Second-line claim (as written in the doc): ė = −4βe − ω²(2βx² − ẋy)
doc_second = -4 * beta * e - omega**2 * (2 * beta * x**2 - xd * y)
second_residual = simplify(edot - doc_second)

# What the second line SHOULD be for the equality to hold:
correct_second = -4 * beta * e + omega**2 * (2 * beta * x**2 + xd * y)
correct_ok = simplify(edot - correct_second) == 0

print("ė (substituted)         :", simplify(edot))
print("first-line claim holds  :", first_ok)
print("doc second-line residual:", second_residual, "   (ė − doc_RHS)")
print("corrected form holds    :", correct_ok)
print()
if first_ok and second_residual == 0:
    print("VERDICT: ✓  full chain confirmed")
else:
    print("VERDICT: ✗  located discrepancy in the SECOND equality")
    print("  doc writes : ė = −4βe − ω²(2βx² − ẋy)")
    print("  correct    : ė = −4βe + ω²(2βx² + ẋy)")
    print(f"  the doc form is off by {simplify(doc_second - edot)} (= doc_RHS − ė)")
    print("  → sign error on the ω²-bracket: −(2βx² − ẋy) should be +(2βx² + ẋy).")

# Attestation hash is emitted only for the confirmed sub-claim (first line).
CLAIM = Eq(edot_chain.subs(xdd, eom), first)
print("\nCLAIM_SREPR :", srepr(CLAIM))
print("CLAIM_HASH8 :", hashlib.sha256(srepr(CLAIM).encode()).hexdigest()[:8])

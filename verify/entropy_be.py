# /// script
# requires-python = ">=3.10"
# dependencies = ["sympy"]
# ///
"""verify:sympy [be] — the N→∞ Bose-Einstein limit of the mean energy.

Claim (physics/entropy.md, handle `be`) — taking N→∞ in the finite-level
mean-energy formula (Z_1 = e^{-βE_1}, 0 < Z_1 < 1):

    lim_{N→∞} E/E_1 = Z_1/(1-Z_1) = 1/(e^{βE_1} - 1)

We re-derive the generic-branch mean-energy expression from first principles
(same first-principles sum as entropy_meanE.py, independent of that file so
this instrument stands alone) and take the SymPy limit N→∞ with Z_1 written
as e^{-x}, x > 0 (equivalent to 0 < Z_1 < 1, β,E_1 > 0), which lets SymPy
resolve the exponential decay unambiguously.

Run:  uv run verify/entropy_be.py
Emits a finding only; it never edits the theory.
"""
import hashlib
from sympy import Symbol, summation, simplify, srepr, exp, oo, limit

k = Symbol("k")
N = Symbol("N", integer=True, positive=True)
Z1 = Symbol("Z1", positive=True)
x = Symbol("x", positive=True)  # x = βE_1 > 0  ⟺  Z_1 = e^{-x} ∈ (0,1)

ZB = summation(Z1**k, (k, 0, N - 1))
kZsum = summation(k * Z1**k, (k, 0, N - 1))
meanE_generic = simplify(kZsum / ZB).args[-1][0]  # the Z1 != 1 (generic) branch

be_limit = simplify(limit(meanE_generic.subs(Z1, exp(-x)), N, oo))

beta, E1 = Symbol("beta", positive=True), Symbol("E1", positive=True)
target = 1 / (exp(beta * E1) - 1)

diff = simplify(be_limit.subs(x, beta * E1) - target)

print("lim_{N->oo} mean(k), Z1=e^-x :", be_limit)
print("claimed Bose-Einstein form    :", target)
print("difference                    :", diff)
print()
if diff == 0:
    print("VERDICT: ✓  N→∞ limit matches the claimed Bose-Einstein form")
else:
    print("VERDICT: ✗  mismatch — re-check entropy.md handle be")

# Attestation hash of the claimed BE form (in terms of β, E_1, matching the source).
CLAIM = target
print("\nCLAIM_SREPR :", srepr(CLAIM))
print("CLAIM_HASH8 :", hashlib.sha256(srepr(CLAIM).encode()).hexdigest()[:8])

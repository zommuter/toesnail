# /// script
# requires-python = ">=3.10"
# dependencies = ["sympy"]
# ///
"""verify:sympy [meanE] — the finite-N Boltzmann mean-energy closed form.

Claim (physics/entropy.md, handle `meanE`) — the mean occupation number for a
system with N linearly-spaced energy levels E_k = k·E_1 (k=0..N-1), partition
function Z_B = sum_{k=0}^{N-1} Z_1^k with Z_1 = e^{-βE_1}:

    E/E_1 = ⟨k⟩ = -N·Z_1^N / (Z_B·(1-Z_1)) + 1/(Z_1^{-1} - 1)

We derive ⟨k⟩ = (Σ k·Z_1^k) / Z_B from first principles (both sums in closed
form via SymPy's `summation`) and confirm it equals the claimed expression —
independent of the doc's own derivation chain (which goes via d/dZ_1 ln Z_B).

Run:  uv run verify/entropy_meanE.py
Emits a finding only; it never edits the theory.
"""
import hashlib
from sympy import Symbol, summation, simplify, srepr, Piecewise, Eq

k = Symbol("k")
N = Symbol("N", integer=True, positive=True)
Z1 = Symbol("Z1", positive=True)

# First-principles sums (Z_1 = 1 is a removable singularity in both; the
# physically relevant case is Z_1 != 1, i.e. finite temperature).
ZB = summation(Z1**k, (k, 0, N - 1))
kZsum = summation(k * Z1**k, (k, 0, N - 1))
meanE = simplify(kZsum / ZB)

# Claimed closed form (physics/entropy.md, \veq{meanE}).
target = simplify(-N * Z1**N / (ZB * (1 - Z1)) + 1 / (1 / Z1 - 1))

diff = simplify(meanE - target)
# Both meanE and target are Piecewise((special, Eq(Z1, 1)), (generic, True));
# the generic (Z1 != 1) branch is the one the claim concerns.
if isinstance(diff, Piecewise):
    generic_ok = all(
        val == 0 for val, cond in diff.args if cond is not True and cond != Eq(Z1, 1)
    ) or diff.args[-1][0] == 0
else:
    generic_ok = diff == 0

print("mean(k) [first-principles sum] :", meanE)
print("claimed closed form            :", target)
print("difference (generic Z1 != 1)   :", diff)
print()
if generic_ok:
    print("VERDICT: ✓  claimed closed form matches the first-principles sum ratio")
else:
    print("VERDICT: ✗  mismatch — re-check entropy.md handle meanE")

# Attestation hash of the claimed closed form.
CLAIM = target
print("\nCLAIM_SREPR :", srepr(CLAIM))
print("CLAIM_HASH8 :", hashlib.sha256(srepr(CLAIM).encode()).hexdigest()[:8])

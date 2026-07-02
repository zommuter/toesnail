# /// script
# requires-python = ">=3.10"
# dependencies = ["sympy"]
# ///
"""verify:sympy [fd] — the N=2 Fermi-Dirac special case of the mean energy.

Claim (physics/entropy.md, handle `fd`) — setting N=2 in the finite-level
mean-energy formula (Z_1 = e^{-βE_1}):

    E/E_1 |_{N=2} = Z_1/(1+Z_1) = 1/(e^{βE_1} + 1)

We re-derive the generic-branch mean-energy expression from first principles
(same first-principles sum as entropy_meanE.py, independent of that file so
this instrument stands alone), substitute N=2, and confirm it collapses to
the claimed Fermi-Dirac form.

Run:  uv run verify/entropy_fd.py
Emits a finding only; it never edits the theory.
"""
import hashlib
from sympy import Symbol, summation, simplify, srepr, exp

k = Symbol("k")
N = Symbol("N", integer=True, positive=True)
Z1 = Symbol("Z1", positive=True)

ZB = summation(Z1**k, (k, 0, N - 1))
kZsum = summation(k * Z1**k, (k, 0, N - 1))
meanE_generic = simplify(kZsum / ZB).args[-1][0]  # the Z1 != 1 (generic) branch

fd_val = simplify(meanE_generic.subs(N, 2))

beta, E1 = Symbol("beta", positive=True), Symbol("E1", positive=True)
target = 1 / (exp(beta * E1) + 1)

diff = simplify(fd_val.subs(Z1, exp(-beta * E1)) - target)

print("mean(k) |_{N=2}               :", fd_val)
print("claimed Fermi-Dirac form      :", target)
print("difference                    :", diff)
print()
if diff == 0:
    print("VERDICT: ✓  N=2 case matches the claimed Fermi-Dirac form")
else:
    print("VERDICT: ✗  mismatch — re-check entropy.md handle fd")

# Attestation hash of the claimed FD form (in terms of β, E_1, matching the source).
CLAIM = target
print("\nCLAIM_SREPR :", srepr(CLAIM))
print("CLAIM_HASH8 :", hashlib.sha256(srepr(CLAIM).encode()).hexdigest()[:8])

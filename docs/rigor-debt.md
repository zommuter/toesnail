# Rigor-debt inventory

A read-only pass over the mathematical docs, listing claims that are hand-waved, asserted-without-proof, or
explicitly unchecked — each tagged with the verification tier that would discharge it (see `CONVENTIONS.md`
§2). **This is a triage menu, not a work order.** Nothing here has been resolved or edited; the owner picks
which holes are worth closing. Where a step looks *suspect* it is flagged as a candidate to check, not
asserted wrong — resolution is the owner's call.

Tier legend: `sympy` = algebra/identity · `numeric` = a claimed evaluation/constant · `lean` = theorem/structural.

Two kinds of entry are kept distinct:
- **`verify:` markers** — AI-dischargeable per the working contract.
- **⚠ modeling tensions** — *owner-territory*: a modelling choice, not an algebra slip. Flag, don't resolve.

---

## physics/Resogram.md  *(pilot #1)*

- `verify:sympy` — the claimed analytical solution `x(t) = A cos(Ωt+φ)e^{-βt} + ∫…` actually solves
  `ẍ + 2βẋ + ω²(x−y) = 0` (substitute back). `Ω := √(ω²−β²)`.
- `verify:sympy` — the energy-rate chain `ė = ẋ(ẍ+ω²x) = −2βẋ² + ω²ẋy`, **and especially** the following
  equality `… = −4βe − ω²(2βx² − ẋy)`. *(Candidate discrepancy: expanding `−4βe` reintroduces a `−2βω²x²`
  term that does not obviously cancel — worth a clean symbolic check.)*
- `verify:sympy` — the energy-maintaining drive: from `ė=0, ẋ≠0` ⟹ `y = 2(β/ω²)ẋ`, and the ẋ-independent
  solution `ÿ = −ω²y` (i.e. drive at the *free* frequency ω, not the eigenfrequency Ω).
- `verify:numeric` — **"e ∝ (c + cos²(Ωt+φ))e^{−2βt}; too lazy to check whether c=0."** The canonical pilot
  target: determine c.
- `verify:sympy` — the energy-increase condition `|y| > 2(β/ω²)|ẋ|` with `sign(y)=sign(ẋ)`.

## physics/acoustics.md  *(pilot #2)*

- `verify:sympy` — ideal-gas manipulation `(1/ρ)∇p = (c²/γ)∇ln ρ + ∇(c²/γ)` from `p = (c²/γ)ρ`.
- `verify:sympy` — **viscous-term coefficient changes between equations:** `(u)` has `+⅓∇(∇·u)` (line ~30)
  but the linearized momentum eq has `+½∇(∇·u)` (line ~54). One is likely a transcription slip — check.
- `verify:sympy` — the mass-conservation Gauss/divergence step `∭∇·(ρu) = ∯(ρu)·dn`, and the "shoebox"
  conclusion that `n·(ρu)` is continuous.
- `verify:sympy` — Green's-first-identity step (`Γ=n` ⟹ `∭(n·∇)ψ = ∯ψ dσ`).
- `verify:sympy` — the vector-calculus identities used in the Helmholtz/continuity argument, e.g.
  `n·(∇×a) = −∇·(n×a) + a·(∇×n)`.
- `verify:lean` — the full Helmholtz-decomposition continuity argument (singularity-free `f ⟹ a, φ`
  continuous) as a structured proof, once the identities above are discharged.
- ⚠ **modeling tension (owner-territory):** linearization "assume `u₀=0` (which contradicts `u₀≫u` though…)"
  — a modelling-assumption conflict the author already flagged. *Surface only; the owner chooses the framing.*

## physics/lasercool.md

- Currently mostly conceptual (ASCII level diagrams + prose); few formal claims yet. Candidates as it grows:
- `verify:numeric` — the relativistic-Doppler shift relation for the absorbed vs spontaneously-emitted photon
  (the asymmetry that yields net cooling) once written as a formula.
- ⚠ **modeling tension (owner-territory):** the qualitative cooling/heating argument (red-shifted absorption
  ⟹ net cooling) is a physical-direction claim — the owner's to develop; AI verifies only once it's a formula.

## README.md  *(the QM spine)*

- `verify:lean` — uniqueness of the zero vector `|0⟩` ("for a given vector space the vector of norm zero is
  unique", footnote `uniqueZero`, marked "#TODO for later").
- `verify:lean` — Cauchy–Schwarz: "for two unit vectors the inner-product length is `≤1`, with equality iff
  parallel/anti-parallel." (Mathlib has this — a clean early Lean smoke target.)
- `verify:lean` — the stated inner-product axioms (conjugate symmetry, linearity, positive-definiteness)
  define an inner-product space; tie to Mathlib's `InnerProductSpace` for structural grounding.
- ⚠ **conceptual flag (owner-territory):** eq `t1` writes the coin state as `∝ p|heads⟩ + (1−p)|tails⟩` with
  *probabilities* as coefficients. In QM the coefficients are *amplitudes* (probabilities are |amplitude|²).
  This is plausibly a deliberate "math on demand" simplification — *surface only; the owner decides whether
  to address it now or later in the narrative.*
- ⚠ **out-of-scope flag:** "#TODO: try and proof whether omniscience is impossible?" — ill-posed as a formal
  claim without a definition; parked, not a `verify:lean` target yet.

---

*Generated as Deliverable #0 of the 2026-06-15 design meeting. To act on an item, the owner promotes it to an
inline `verify:` marker in the source doc (per `CONVENTIONS.md` §2), and the AI discharges it findings-only.*

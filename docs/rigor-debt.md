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

## physics/Resogram.md  *(pilot #1 — RUN 2026-06-15)*

Outcomes of the first end-to-end `verify:` pilot. Instruments live in `verify/resogram_*.py`
(re-runnable: `uv run verify/resogram_<handle>.py`); discharged claims carry an inline
`verified:` attestation in the source. Per the working contract the AI **surfaces** ✗ findings
and leaves `Resogram.md`'s math untouched — every resolution below is the owner's call.

- **[`sol`] `verify:sympy` — ✓ (partial).** The claimed analytical solution `x(t) = A cos(Ωt+φ)e^{-βt} + ∫…`
  solves `ẍ + 2βẋ + ω²(x−y) = 0`, `Ω := √(ω²−β²)`. `verify/resogram_sol.py` confirms symbolically that the
  homogeneous part solves the homogeneous ODE **and** that the convolution kernel satisfies `K(0)=0`,
  `K'(0)=ω²`, `K''+2βK'+ω²K=0`; by the Leibniz rule these give `ẍ+2βẋ+ω²x = ω²y`, i.e. the full equation.
  *No `verified:` attestation yet:* (a) the convolution assembly rests on the (standard) Leibniz step rather
  than one end-to-end symbolic substitution, and (b) **the rendered integrand has an unbalanced paren**
  (`\sin(\Omega (t-t')e^{…}` — missing `)` after `(t-t')`); the verified kernel is `sin(Ω(t−t'))·e^{−β(t−t')}`.
  Surfaced for the owner; not edited.
- **[`edot`] `verify:sympy` — ✗ located discrepancy.** Energy-rate chain `ė = ẋ(ẍ+ω²x) = −2βẋ² + ω²ẋy`:
  the **first** equality holds. The **second**, as written `ė = −4βe − ω²(2βx² − ẋy)`, is **wrong** — it is
  off by `−4βω²x²`. The candidate flagged at inventory time is confirmed: expanding `−4βe = −2βẋ² − 2βω²x²`,
  the correct closed form is `ė = −4βe + ω²(2βx² + ẋy)` (sign error on the ω²-bracket). `verify/resogram_edot.py`.
- **[`drive`] `verify:sympy` — ✓ (attested `claim=67223e71`).** From `ė=0, ẋ≠0` ⟹ `y = 2(β/ω²)ẋ`, and the
  ẋ-independent solution `ẏ=−2βx`, `ÿ = −ω²y` (drive at the *free* frequency ω, not the eigenfrequency Ω).
  `verify/resogram_drive.py`.
- **[`esol`] (was `cval`) `verify:numeric` — ✗→✓ RESOLVED + handle renamed.** *"e ∝ (c + cos²(Ωt+φ))e^{−2βt};
  too lazy to check whether c=0."* Answer: **c ≠ 0.** The free-oscillator energy is
  `e = (A²/2)e^{−2βt}(ω² + β²cos2θ + βΩ sin2θ) = (A²ω/2)e^{−2βt}(ω + β cos(2(Ωt+φ)−δ))`, `δ=atan2(Ω,β)`. It
  carries a **sin(2θ) term**, so the stated zero-phase `(c+cos²θ)` form is not exact for `β≠0`; forcing a
  match on the cos(2θ) coefficient gives `c = Ω²/(2β²) ≠ 0`. Owner adopted the exact form (`/relay human`
  2026-06-15); instrument re-pinned ✓. Handle renamed `cval`→`esol` (`/meeting` 2026-06-15) — old name
  encoded the now-answered "find c" question. `verify/resogram_esol.py`.
- **[`eincr`] `verify:sympy` — ✓ (attested `claim=d4c18e3b`).** The energy-increase condition
  `|y| > 2(β/ω²)|ẋ|` with `sign(y)=sign(ẋ)` is equivalent to `ė>0` and confirmed on both sign branches.
  `verify/resogram_eincr.py`.

**Cluster opened by the `esol` adoption (`/meeting` 2026-06-15) — RESOLVED in-document by the owner
(commit `236fa1b`, reconciled to REVIEW_ME 2026-06-15). Ticks are CLAIMs the next `/relay review` re-checks:**
- **energy-loss claim (id:559c) ✓.** ¶ now cites `(edot.3)` — the manifestly-≤0 first form `ė=−2βẋ²`.
- **`ymaint`/`yfree` exposition (id:0cb5) ✓ (acknowledged).** Owner accepted as exposition; results ✓
  (`resogram_drive.py`). Fuller steps deferred to subequation numbering (id:d2f4).
- **c-narrative (id:f9fe) ✓.** Owner removed the dangling "too lazy to check whether c=0" sentence; kept the
  pre-solution handwaving ¶ as framed.
- **sliding-average window (id:3999) ✓.** Corrected `2Ω∫₀^{1/2Ω}` → `(Ω/π)∫₀^{π/Ω}` (full-period average).

**NEW, spun out of `236fa1b` (tooling/render — AI-eligible):**
- **render regression (id:3b4c) ✓ FIXED.** `\ltag{e}` inside `\begin{aligned}` → MathJax `merror`; fixed by
  splitting into two `$$` blocks (`\ltag{e}` + ė-chain `\ltag{edot}` outer), owner-confirmed. Suite green.
- **subequation auto-numbering (id:d2f4, wishlist).** Auto-derive `(edot.1)…(edot.4)` handles so per-line
  tags render; also resolves the `[edot]` marker losing its active `\ltag{edot}`. Relates to R2/R3, `.mw`.

**Pilot scorecard:** 5 claims run · 3 ✓ (`sol` partial, `drive`, `eincr`) · 2 ✗ located discrepancies
(`edot`, `cval`). The loop ran end-to-end and survived two real errors — which was the point. No `verify:lean`
target here (algebra is SymPy's job); Lean is scoped separately (`TODO.md` id `3317`).

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

## physics/toesnail.md  *(the QM spine)*

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

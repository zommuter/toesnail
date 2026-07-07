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

- **[`sol`] `verify:sympy` — ✓ (partial); badge `\sorry` (open).** The claimed analytical solution
  `x(t) = A cos(Ωt+φ)e^{-βt} + ∫…` solves `ẍ + 2βẋ + ω²(x−y) = 0`, `Ω := √(ω²−β²)`.
  `verify/resogram_sol.py` confirms symbolically that the homogeneous part solves the homogeneous ODE
  **and** that the convolution kernel satisfies `K(0)=0`, `K'(0)=ω²`, `K''+2βK'+ω²K=0`; by the Leibniz
  rule these give `ẍ+2βẋ+ω²x = ω²y`, i.e. the full equation. *No `verified:` attestation yet:* the
  convolution assembly rests on the (standard) Leibniz step rather than one end-to-end symbolic
  substitution — hence the in-prose badge stays `\veq{sol}\sorry` (the repo's one remaining `\sorry`).
  *(The integrand's unbalanced-paren typo flagged here originally was owner-ratified + fixed 2026-06-15
  via /relay human — render fix only, verdict unchanged.)*
- **[`edot`] `verify:sympy` — ✗→✓ RESOLVED; `verify:lean` — ✓ lean-attested (tier `sympy+lean`).**
  Energy-rate chain `ė = ẋ(ẍ+ω²x) = −2βẋ² + ω²ẋy`: the **first** equality holds. The **second**, as
  written `ė = −4βe − ω²(2βx² − ẋy)`, was **wrong** — off by `−4βω²x²`; corrected to
  `ė = −4βe + ω²(2βx² + ẋy)` (owner-ratified 2026-06-15). The algebraic substitution step
  (`ẋ(ẍ+ω²x)` with `ẍ = −2βẋ − ω²(x−y)`) is now attested at two tiers:
  `resogram_edot.py@54710d91` (SymPy, `claim=b575864e`) and `Resogram.lean@a036b80d` (Lean4+Mathlib,
  same claim-hash — kernel-checked). SymPy-as-gate dataset: SymPy ✓ correctly predicted the
  lean-provable claim; this is one datapoint supporting SymPy as a cheap pre-filter for Lean targets.
  Attestation: `verified:sympy+lean [edot] claim=b575864e by=resogram_edot.py@54710d91,Resogram.lean@a036b80d`.
- **[`edot_deriv`] `verify:lean` — ✓ lean-attested (tier `lean` only, SymPy-blind).**
  Derivative step: `e = ½v² + ½ω²x²` has time derivative `ė = v(a + ω²x)` — the pure calculus step
  (chain rule / product rule), with no equation of motion assumed. Proven in Lean4+Mathlib via
  `HasDerivAt.pow` + `HasDerivAt.const_mul` + `HasDerivAt.add` (`Resogram.lean@a036b80d`,
  `claim=f359c0bf`). **SymPy-blind**: this is the contrast datapoint for the SymPy-as-gate eval —
  SymPy handles algebra symbolically but `HasDerivAt` (differentiability witness) is purely a
  Lean/Mathlib concern. Attestation: `verified:lean [edot_deriv] claim=f359c0bf by=Resogram.lean@a036b80d`.
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

**Pilot scorecard:** 5 claims run · 5 ✓ (`sol` partial, `drive`, `eincr`, `edot`, `esol`) · 2 ✗ located,
owner-resolved (`edot` sign error, `esol`/`cval` c≠0). The loop ran end-to-end and survived two real errors
— which was the point. `[edot]` now carries a `verify:lean` attestation tier too (Lean4+Mathlib kernel-checked,
Resogram.lean@3c516103) — the algebraic step is the first `sympy+lean` dual-attested claim in this repo.

## physics/acoustics.md  *(pilot #2)*

- `verify:sympy` — ideal-gas manipulation `(1/ρ)∇p = (c²/γ)∇ln ρ + ∇(c²/γ)` from `p = (c²/γ)ρ`.
  **Pre-confirmed 2026-07-07 (SymPy session probe, general `c²/γ(x⃗)` + `ρ(x⃗)`): identity holds ✓** —
  the eventual instrument should green immediately once the owner places the marker.
- `verify:sympy` — **viscous-term coefficient changes between equations:** `(u)` has `+⅓∇(∇·u)` (line ~30)
  but the linearized momentum eq has `+½∇(∇·u)` (line ~54). **SHARPENED 2026-07-07 (SymPy, session probe):
  the operator `Δu + c·∇(∇·u)` is exactly linear in `u`** (`T(u+εv) = T(u)+εT(v)` verified symbolically,
  component-wise 3D), so linearization *cannot* change the coefficient — the `½` on the linearized line is
  the suspect transcription (the compressible-Newtonian form with Stokes' hypothesis is `⅓`). Owner fixes
  or ratifies; AI does not edit the line.
- `verify:sympy` — the mass-conservation Gauss/divergence step `∭∇·(ρu) = ∯(ρu)·dn`, and the "shoebox"
  conclusion that `n·(ρu)` is continuous.
- `verify:sympy` — Green's-first-identity step (`Γ=n` ⟹ `∭(n·∇)ψ = ∯ψ dσ`).
- `verify:sympy` — the vector-calculus identities used in the Helmholtz/continuity argument, e.g.
  `n·(∇×a) = −∇·(n×a) + a·(∇×n)`. **Pre-confirmed 2026-07-07 (SymPy session probe, general 3D fields
  `n⃗(x⃗)`, `a⃗(x⃗)`): identity holds ✓.**
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

## physics/entropy.md  *(recovered page — markers placed 2026-06-18; sections added to this inventory 2026-07-07)*

- **[`meanE`]/[`be`]/[`fd`] `verify:sympy` — ✓ DISCHARGED** (relay seam id:e9e9, 2026-07-02): the finite-N
  mean-occupation closed form, its N→∞ Bose–Einstein limit, and the N=2 Fermi–Dirac case. Instruments
  `verify/entropy_{meanE,be,fd}.py`; attestations in `physics/entropy.toml`; in-prose badges flipped
  `\sympyc`→`\sympy`.
- **[`lambertw`] `\leanc` (open)** — split per /meeting id:3d2a D1: the l.53–57 algebra chain → its own
  `\sympyc` handle (OWNER places the split marker — REVIEW_ME box open, gates ROADMAP id:5d31); the W
  closed-form line → `\definition`; the W branch/domain claim stays Lean-queued (id:37cc).
- ⚠ **modeling note (owner-territory):** the two-level BE/FD identification ("bosonic two-level system")
  is a physical-interpretation claim wrapping verified algebra — interpretation stays the owner's.

## crypto/fhe.md  *(recovered page — markers placed 2026-06-18)*

- **[`stirling`] `\sympyc` (open, GATED on owner):** the constant term in `Π_n = log₂((2^n)!)`'s expansion
  reads `ln√(2π)` but base-2 consistency requires `log₂√(2π)` (≈0.407-bit offset, confirmed symbolically +
  numerically — REVIEW_ME box, 2026-07-01/02). Instrument `verify/fhe_stirling.py` (id:76e5) un-gates once
  the owner fixes or ratifies the line.
- **[`ocount`]/[`semidestr`]/[`bij24`] `\leanc` (open)** — combinatorial counts, Mathlib-tractable
  (`Fintype.card_pi` / `Nat.choose`+`Finset.card` / `Fintype.card_perm`); each awaits its own frozen-signature
  scoping per /meeting id:3d2a D2 (queue id:37cc).
- Complementary numeric instrument (counter-indicator only, never the badge): regenerate the n=2 tables and
  cross-check `crypto/fhe.ods` (the spreadsheet IS the worked computation — a natural attestation target).

## physics/wirohsh.md  *(recovered page — owner DEFERRED marker placement 2026-06-16)*

- Candidates surfaced in REVIEW_ME (2026-06-16), unmarked by owner choice — kept here as the triage menu:
  `verify:sympy` the tangential-Laplacian reduction `Δ_φ = (∂_x sinφ − ∂_y cosφ)² = ∂_{φ̄}²`;
  `verify:sympy` the 1D back-rotation `f = f⁺(x−ct) + f⁻(x+ct)`.
- **Not yet markable:** the page has unfinished derivations (empty `align` blocks near the end + the
  `Refraction` stub) — no closed claim to badge; an owner content question, not a tooling one.

## physics/photon.md  *(recovered page — rough stub, no closed result)*

- No `\veq` candidates yet (Ansatz only, no closed claim).
- ⚠ **structural caution (surfaced 2026-07-07, dreaming session §1.7 / TODO id:57e2 Q12):** interpreting the
  Gaussian ansatz's `μ_α(x)` as "the photon's position" will collide with the Newton–Wigner
  non-localizability result (no position operator for massless helicity ≥1) — guard the *interpretation*
  before the algebra accumulates. Owner decides whether/how to meet it.

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

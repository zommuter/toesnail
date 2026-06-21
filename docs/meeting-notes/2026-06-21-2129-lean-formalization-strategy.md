# 2026-06-21 — Lean-formalization strategy for verify pilots (id:3d2a)

**Started:** 2026-06-21 21:29
**Session:** 9bc09e4f-2913-426a-9351-fcd301dfd76c
**Attendees:** 🏗️ Archie (architect), 😈 Riku (devil's advocate), ✂️ Petra (productivity), 🔬 Lennart (Lean4/Mathlib tier-discharge, re-onboard), 🔬 Greta (proof-engineering / axiom hygiene / model-vs-artifact fidelity, re-onboard)
**Topic:** How to formalize the verify pilots that escalated to Lean — `lambertw` (Mathlib has no Lambert W) and the FHE combinatorial counts (`ocount`/`bij24`/`semidestr`, Mathlib-tractable) — per-claim [ROUTINE]/[HARD] sizing, file org, and whether to adopt PhysLean.

## Agenda
1. `lambertw`: W-free reformulation vs PhysLean dependency vs defer — what a faithful claim attests.
2. FHE combinatorial counts: per-claim [ROUTINE]/[HARD] sizing, file org, faithful modelling.
3. Escalation policy + immediate scope.

## Discussion

### Agenda 1 — lambertw
🔬 **Lennart:** `entropy.md:53–57` is elementary algebra (`y=x/(e^x∓1) ⟺ −ye^{∓y}=−xe^{−x}`) — SymPy/Lean both do it, no W. Line 58 (`x=−W(…)`) is the *definition* of W, not a theorem; the earlier SymPy probe failed because it round-tripped W back in (opaque to `simplify`).
🔬 **Greta:** Content splits: (i) the algebraic reduction (cheap, mechanizable) and (ii) the W *branch + domain* (`−ye^{∓y}∈[−1/e,…)`, single-valued) — only (ii) needs W formalised, and marking the whole line `\lean` would mean re-proving W exists (definitional, missing from Mathlib).
😈 **Riku / ✂️ Petra:** PhysLean out — ≈GB Mathlib-scale dep, version-pin cost, unconfirmed it has W, fails N=2. Bank the cheap half now, isolate (ii).
🔬 **Lennart / 🏗️ Archie:** Split the handle (like `edot`/`edot_deriv`): `\sympy` on the algebra step, `\definition` + deferred branch-caveat on the closed form.

### Agenda 2 — FHE combinatorial counts
🔬 **Lennart:** Mathlib lemmas all present — `ocount`=`Fintype.card_fun`, `bij24`=`Fintype.card_perm` (+`=24` by `decide`), `semidestr`-count=`Nat.choose`/`Finset.card`.
🔬 **Greta:** (1) Theorem must state general-`n` formula then instantiate `n=2` (else `=24` is a tautology). (2) `semidestr` is two claims — the *count* (mechanizable) and "balanced ⟺ semi-destructive" (crypto modelling, owner judgment).
😈 **Riku:** The `edot_deriv` lesson: `[HARD]→[ROUTINE]` needs the signature frozen in-meeting.
🏗️ **Archie:** File org: per-page `verify/Entropy.lean` + `verify/FHE.lean`, into `tests/test_lean.sh`.
Draft signatures (starting points, not contracts): `ocount` `Fintype.card ((Fin n→Bool)→(Fin m→Bool)) = 2^(m*2^n)`; `bij_count` `Fintype.card (Equiv.Perm (Fin n→Bool)) = (2^n)!`; `semidestr_count` `#{f | #{i|f i}=2^(n-1)} = (2^n).choose (2^(n-1))`.

### Agenda 3 — escalation policy + scope
🔬 **Greta:** Ladder: SymPy-if-closes → else Lean → else honest open-debt badge; never `\definition` as a dodge; numeric is a counter-indicator only.
😈 **Riku:** Risk of perpetual `\leanc` black-hole — mitigated because `\leanc` is *honest* open debt and each `[HARD]` claim gets one-shot scoping when prioritised.
✂️ **Petra:** Ships now = the `[ROUTINE]` SymPy bucket; the five `[HARD]` Lean claims queue individually.

## Decisions
- **D1 — `lambertw` SPLIT.** Algebra (`entropy.md:53–57`) → `\sympy` [ROUTINE] (`verify/entropy_lambertw.py`); closed-form line (l.59) → `\definition` + a deferred caveat that the W branch+domain is unverified. **Out of scope: PhysLean** (N=2 unmet; unconfirmed it has W; revisit only if ≥2 claims need a non-Mathlib construct). <!-- id:7306 -->
- **D2 — all Lean counts `[HARD]` first.** `ocount`/`bij24`/`semidestr`-count/`semidestr`-identification/`lambertw`-branch each get an individual scoping pass (consume model-fidelity + freeze signature, the `edot_deriv` pattern) before `[ROUTINE]` — no bulk-freeze (the model is owner-judgment). File org: `verify/Entropy.lean` + `verify/FHE.lean`. Out of scope: writing the proofs now. <!-- id:37cc -->
- **D3 — tier-escalation ladder codified.** SymPy-if-closes → else Lean (if Mathlib/model supports) → else honest open-debt badge naming the desired tier (`\sympyc`/`\numericc`/`\leanc`). `\definition` is never a dodge for a real claim; numeric is a complementary counter-indicator, never the badge. Ship the `[ROUTINE]` SymPy bucket; execution handed off to relay/executor. <!-- id:2709 -->
- **D4 — (forward-flag, cross-project) `.mw` → Lean4 lowering.** Can a `.mw` document's fragments *generate* Lean4 proof obligations (the document itself becomes machine-provable), vs `.mw` only tracking external instruments? Ties `mathematical-writing` `id:358f`. Out of scope here. → routed to mathematical-writing inbox <!-- routed:733c -->

## Action items
- [ ] **[ROUTINE] SymPy instrument bucket** — `verify/entropy_{be,fd,meanE}.py`, `verify/fhe_stirling.py` (named correction terms + `O(2^{-n})` remainder, not eval-at-a-few-n), `verify/entropy_lambertw.py` (algebra l.53–57); `physics/entropy.toml` + `crypto/fhe.toml` sidecars; split the `lambertw` marker per D1; `tests/test_verify.sh` wiring; on green flip `\sympyc→\sympy`. Contract: suite green, one `VERDICT: ✓`/instrument, sidecar non-drift. ~1 executor session, hand off to relay. (2026-06-21-2129-lean-formalization-strategy.md) <!-- id:7306 -->
- [ ] **[HARD] Lean claims queued individually** — `ocount`/`bij24`/`semidestr`-count/`semidestr`-identification/`lambertw`-branch; each needs a scoping `/meeting` (fidelity + frozen signature) before `[ROUTINE]`, all `\leanc` until then; `verify/Entropy.lean`+`verify/FHE.lean`. (2026-06-21-2129-lean-formalization-strategy.md) <!-- id:37cc -->
- [ ] **[ROUTINE] document the tier-escalation ladder (D3)** in `CONVENTIONS.md` verify-marker section. (2026-06-21-2129-lean-formalization-strategy.md) <!-- id:2709 -->
- [ ] **(forward-flag, cross-project) `.mw`→Lean4 lowering research (D4)** → routed to mathematical-writing inbox <!-- routed:733c -->

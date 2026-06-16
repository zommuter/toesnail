# 2026-06-16 — REVIEW_ME backlog walk (D5 session)

**Started:** 2026-06-16 14:21
**Session:** a0fc1442-59e6-4ae8-aff7-df31f89f3048
**Attendees:** 🏗️ Archie (architect), 😈 Riku (devil's advocate), ✂️ Petra (productivity)
**Topic:** Resolve the 3 open REVIEW_ME judgment boxes — confirm the encoded interpretation or correct it.

## Surfaced discoveries
- [2026-06-16 mathematical-writing] `.mw` staleness DAG keys edges on regex symbol refs — structurally blind to transcription fidelity; cited witness is `ebar = Omega/pi*e`.
- [2026-06-15 toesnail] A single owner-ratified sign fix propagated 4 hand-checkable discrepancies through Resogram with no staleness-checker.

## Agenda
1. **id:d2f4** — subequation dot-numbering wishlist: confirm DEFERRED disposition.
2. **id:0e63** — `.mw` mirror fidelity: design + ratify re-transcription, implement, tick.
3. **id:6501** — `@manual` HUMAN-integration walk: confirm human-only.

## Discussion

### Box 1 — id:d2f4 (subequation numbering) — trivial confirm

✂️ **Petra:** Dispositioned 8 hours ago via `/relay human`: deferred pending `.mw`, stays open as tracked
wishlist, no pool work. Nothing has changed. No design decision to re-litigate.

😈 **Riku:** Box stays `- [ ]` (open, not ticked, not dropped). A tick would falsely signal "done."

### Box 3 — id:6501 (@manual HUMAN-integration walk) — trivial confirm

✂️ **Petra:** `@manual` visual check — equations in a real browser, VS Code KaTeX macros. Cannot be performed
or ticked in a meeting. Render *correctness* is machine-checked (`test_mathjax.cjs`); this is the visual/editor
last mile.

😈 **Riku:** Never auto-tick a `@manual` box — that's the point of the REVIEW_ME section header.

### Box 2 — id:0e63 (.mw mirror fidelity) — the chewy one

🏗️ **Archie:** The mirror `verify/mirror/resogram_esol.mw` had three blocks. Two were already faithful: `e`
matches `Resogram.md:85` (`esol`), `y` matches `:52` (`ymaint`). Two infidelities owner rejected:
1. `ebar = Omega/pi * e` collapses the source's half-period convolution integral (`Resogram.md:107`,
   `(Ω/π)∫₀^{π/Ω} e(t-t')·e^{+2βt'} dt'`) to a scalar multiply — drops the integral and growth kernel.
2. `delta` is a dangling free symbol; source `:85` carries `δ=atan2(Ω,β)` as a derived result.

🏗️ **Archie:** From `mathematical_writing/dag.py` (id:ad8c): the DAG keys edges on regex symbol extraction,
and its own docstring names this exact box as the limitation: "ebar = Omega/pi*e … leaves stale_after_edit
green because the edge holds for ANY RHS containing e … fidelity is NOT a DAG-checkable property." A
faithful re-transcription still keeps every test green:
```
delta = atan2(Omega, beta)
e     = (A**2 * omega / 2) * exp(-2*beta*t) * (omega + beta*cos(2*(Omega*t + phi) - delta))
ebar  = Omega/pi * Integral(e.subs(t, t - tp) * exp(2*beta*tp), (tp, 0, pi/Omega))
y     = 2 * beta / omega**2 * xd
```
- `ebar`'s RHS still contains bare `e` → `e`→`ebar` staleness edge holds.
- `e`'s RHS contains `delta` → `delta`→`e`→`ebar` chain the owner asked for.

😈 **Riku:** Three checks: (a) Is this an AI theory edit? No — transcribing owner-stated math from
`:52/85/107` into `.mw` syntax; the fidelity gate is the owner confirming. (b) Does `e.subs(t,t-tp)` break
anything? No — hook + test call `parse`+`stale_after_edit` only, never the eval core. (c) Minimum evidence
to tick: owner eyeballs the diff against the source; no test can do it (id:ad8c).

✂️ **Petra:** Scope guard holds — one section, four blocks, no new abstraction. Owner is in the room;
drafting now is cheaper than a relay round-trip.

**Owner ratification (D3):** "Draft faithful → implement now → tick" — owner confirmed the four-block draft
faithfully transcribes `Resogram.md:52/85/107`. After ExitPlanMode: implement → `test_mw_mirror.sh` green →
owner eyeballs diff → tick.

**Implementation:** mirror rewritten to faithful four-block form. `bash tests/test_mw_mirror.sh` PASS (E_CIT_STALE True, EBAR_STALE True, Y_STALE False). `bash tests/run.sh` SUITE: PASS. Owner confirmed diff faithful.

## Decisions
- **D1 (id:d2f4) — CONFIRM deferral.** Subequation dot-numbering stays OPEN tracked wishlist deferred pending
  `.mw`. Box stays `- [ ]`. Out of scope: building subequation-numbering machinery now.
- **D2 (id:6501) — CONFIRM human-only.** `@manual` HUMAN-integration walk stays OPEN as a human task; never
  auto-ticked. Out of scope: automating the visual check.
- **D3 (id:0e63) — re-transcribe the mirror faithfully, RESOLVED.** `verify/mirror/resogram_esol.mw` now has
  four blocks: `delta = atan2(Omega, beta)` (own fragment); `e` unchanged; `ebar` as faithful half-period
  convolution with exponential kernel; `y` unchanged. Inline `$e$` prose citation preserved. `test_mw_mirror.sh`
  green. `id:0e63` ticked in REVIEW_ME.md, ROADMAP.md (fidelity-fix sub-item), and TODO.md.
- **Permanent finding:** `.mw` DAG is documented-blind to transcription fidelity (id:ad8c). `id:0e63` can
  never be test-ticked; owner confirmation is the only gate. This is a durable architectural constraint.

## Action items
- [x] Implement D3: rewrite `verify/mirror/resogram_esol.mw`, run `test_mw_mirror.sh` + `tests/run.sh`,
  tick `id:0e63` across REVIEW_ME/ROADMAP/TODO. DONE this session. <!-- id:0e63 -->
- [ ] (tracking) id:d2f4 stays open per D1 (deferral confirmed). id:6501 stays open per D2 (human-only). No new TODO minting needed. <!-- id:8afc -->

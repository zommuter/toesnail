# TODO

## Current

- [ ] Relay: 1 open ROADMAP item (HARD — strong model only: id:3317 Lean); 0 ROUTINE open (fca7 Makefile, 9868 CI done). Confirm CI run green on GitHub after push (id:9868 done-check). edot/cval verify instruments re-pinned ✗→✓ (2026-06-15 /relay review, id:9135 follow-up #1). Remaining open: owner-only cval c-narrative prose (REVIEW_ME) — ROUTED 2026-06-15 to /meeting --cross (owner call, /relay human). <!-- id:e27e -->

- [ ] Deliverable #1 — pilot Resogram end-to-end: equation handles + `verify:` markers + real SymPy/Lean
  checks of its energy derivation and the "is c=0?" question. Acoustics = pilot #2. Scoped + contracted
  2026-06-15 (docs/meeting-notes/2026-06-15-1409-resogram-verify-pilot-scope.md); decomposed below.
  **Cheap half done 2026-06-15** (SymPy: 3 ✓ / 2 ✗ located discrepancies); only Lean (3317) remains. <!-- id:01a7 -->
    `_includes/custom-head.html` + handles on the ~5 marked Resogram claims. Pipeline verified by
    `tests/test_render.sh` (local Jekyll build). (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:96ad -->
    (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:d0bf -->
    (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:9b2d -->
  - [ ] Write ≥1 Lean proof (`ė` first-line identity); stand up Lean4+Mathlib via `lake`, `verify/Resogram.lean`.
    Heaviest item; deferred to its own session. (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:3317 -->
    (drive + eincr attested; sol withheld pending owner paren-fix.) (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:ee36 -->
    (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:7340 -->
    grammar + §3 carve-out. (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:3f57 -->
- [ ] Automated `verify:`/`verified:` staleness checker (walks source, recomputes hashes, flags drift). GATED:
- [ ] Automated `verify:`/`verified:` staleness checker (walks source, recomputes hashes, flags drift). GATED: acoustics pilot #2 supplies the N=2 second consumer. **Corroborating instance 2026-06-15 (`/relay human`):** the edot/cval instrument re-pin (✗→✓ + attestation re-derivation after the owner corrected the source) had to be deferred to "next review" BY HAND — exactly the drift this checker would flag. NB `.mw` shipped id:dae5 the same day (headless dependency-DAG + 3-state staleness propagation over fragment handles); when this checker is built, REUSE that DAG rather than reinventing hash-walking — it already does prose-citation-stale propagation. (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:04bb -->
- [x] Owner review: Resogram pilot findings — (a) `edot` 2nd equality wrong, correct is `ė=−4βe+ω²(2βx²+ẋy)`;
  (b) `cval` c≠0 (`c=Ω²/(2β²)`, energy phase-shifted); (c) `sol` integrand unbalanced paren. AI surfaced,
  did not edit; owner decides each. (docs/rigor-debt.md) **RESOLVED 2026-06-15 (owner-ratified via /relay
  human):** (a) sign correction applied; (b) exact phase-shifted form adopted; (c) one-char paren fix
  applied. Two follow-ups left open (REVIEW_ME): next-`/relay review` instrument re-pin for edot+cval
  (✗→✓, attestations) and the owner-only `cval` c-narrative reconciliation. <!-- id:9135 -->
- [ ] `[HUMAN]` integration pass — walk `tests/HUMAN-integration.md`: visual sanity in a browser + confirm
  VS Code applies `.vscode/settings.json` macros (render correctness is now machine-checked). <!-- id:6501 -->
- [ ] **Resogram energy block: render regression — `\tag` inside `aligned` → MathJax `merror`, suite RED /
  CI red on `236fa1b`.** Owner moved `\ltag{e}` inside the aligned env (valid only on the outer `$$`). KaTeX
  tolerates it; MathJax (the site) does not. Owner to confirm fix approach (interim single block tag vs.
  land subequation numbering id:d2f4). Tooling/render fix, but in the theory file. <!-- id:3b4c -->
- [ ] Wishlist: automated subequation dot-numbering — derive `(edot.1)…(edot.4)` handles from a parent handle
  so per-line tags render; also re-attaches the `[edot]` verify marker to an active `\ltag`. Relates to R2/R3
  (id:445e) + `.mw`. (/meeting 2026-06-15) <!-- id:d2f4 -->
- [ ] ROADMAP R2/R3 — rendered ✓-emoji on verified equations (hover/tooltip verify status) + a legible
  in-document annotation syntax to supersede illegible HTML `verify:` comments; design before changing
  rendered output. (/meeting 2026-06-15, 2026-06-15-2111-resogram-energy-chain-reconciliation.md) <!-- id:445e -->

## Done
- [x] Resogram energy-chain located-discrepancy cluster — RESOLVED in-document by owner (commit `236fa1b`,
  reconciled to REVIEW_ME 2026-06-15): energy-loss claim cites (edot.3) (id:559c); ymaint/yfree accepted as
  exposition, results ✓ (id:0cb5); c-narrative dangling-`c` sentence removed (id:f9fe); sliding-average window
  corrected to `(Ω/π)∫₀^{π/Ω}` (id:3999). Spun out 2 tooling items (id:3b4c render regression, id:d2f4
  subequation numbering). Ticks re-checked by next /relay review. <!-- id:f9fe -->
- [x] Rename Resogram energy handle `cval`→`esol` (analytical energy SOLUTION; old name encoded the answered
  "find c" question) — source `\ltag`/markers, `verify/resogram_esol.py`, `test_verify.sh`, `verify/README.md`;
  attestation re-pinned `@e6722a73` (claim `18d3f7a7` unchanged); test_verify green 5✓ — /meeting 2026-06-15,
  covered by `tests/test_verify.sh`. <!-- id:adfc -->

  (test-only mathjax-full + katex), `tests/` suite (`test_verify.sh`, `test_render.sh`, `test_mathjax.cjs`,
  `run.sh` — all green), `tests/HUMAN-integration.md`. Building + rendering locally root-caused + fixed THREE
  latent render bugs: (1) **no page had a `layout`** (→ headless, no MathJax); (2) kramdown default math engine
  (→ MathJax-2 `math/tex` tags MathJax 3 ignores); (3) **in-document `\gdef` macros break MathJax** (KaTeX-only)
  → moved `\ltag` to MathJax config + `.vscode/settings.json`; removed `\gdef` from Resogram + toesnail.
  2026-06-15. <!-- id:d1da -->

  (siblings via toesnail-owned marker schema); runtime-layer couplings parked as questions routed to `.mw`
  + collAIb. (docs/meeting-notes/2026-06-15-1351-mw-collaib-frontend-scoping.md) <!-- id:921b -->
  (docs/meeting-notes/2026-06-15-1257-repo-topology-and-mw-aligned-authoring.md) <!-- id:8676 -->
  (docs/meeting-notes/2026-06-15-1257-repo-topology-and-mw-aligned-authoring.md) <!-- id:e3af -->
  (docs/meeting-notes/2026-06-15-1257-repo-topology-and-mw-aligned-authoring.md) <!-- id:3435 -->

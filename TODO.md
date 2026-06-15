# TODO

## Current

- [ ] Deliverable #1 — pilot Resogram end-to-end: equation handles + `verify:` markers + real SymPy/Lean
  checks of its energy derivation and the "is c=0?" question. Acoustics = pilot #2. Scoped + contracted
  2026-06-15 (docs/meeting-notes/2026-06-15-1409-resogram-verify-pilot-scope.md); decomposed below. <!-- id:01a7 -->
  - [ ] Establish MathJax handle mechanism (`tex:{tags:'ams',macros}`) in `_includes/custom-head.html` + handles
    on the ~5 marked Resogram claims. (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:96ad -->
  - [ ] Author inline `verify:` markers (instrument pointers) on the five Resogram claims, `physics/Resogram.md`.
    (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:d0bf -->
  - [ ] Write `verify/` SymPy scripts (one per claim) + `verify/README.md`; run all five, capture ✓/✗/inconclusive.
    (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:9b2d -->
  - [ ] Write ≥1 Lean proof (`ė` first-line identity); stand up Lean4+Mathlib via `lake`, `verify/Resogram.lean`.
    Heaviest item; may be its own session. (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:3317 -->
  - [ ] Compute composite hashes + write `verified:` attestation markers for discharged claims, `physics/Resogram.md`.
    (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:ee36 -->
  - [ ] Annotate `docs/rigor-debt.md` with per-claim outcomes (incl. ✗ located-discrepancy narrative).
    (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:7340 -->
  - [ ] Update `CONVENTIONS.md` — §1 KaTeX→MathJax + "already"→"as of pilot"; §2 tier-as-floor; attestation
    grammar + §3 carve-out. (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:3f57 -->
- [ ] Automated `verify:`/`verified:` staleness checker (walks source, recomputes hashes, flags drift). GATED:
  acoustics pilot #2 supplies the N=2 second consumer. (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:04bb -->

## Done

- [x] Scoping session — collAIb × toesnail × `.mw` three-repo relationship: content-layer edge resolved
  (siblings via toesnail-owned marker schema); runtime-layer couplings parked as questions routed to `.mw`
  + collAIb. (docs/meeting-notes/2026-06-15-1351-mw-collaib-frontend-scoping.md) <!-- id:921b -->
- [x] Split spine from portal: move README → `physics/toesnail.md` (`/toesnail`); new portal README at `/`. — committed 715a11d on 2026-06-15
- [x] Cross-project dependency map `docs/dependencies.md` (toesnail × .mw × collAIb, direction + strength). — committed 715a11d on 2026-06-15
- [x] Re-tree repo per D1 (`physics/`, `essays/`, README root index); permalinks unchanged.
  (docs/meeting-notes/2026-06-15-1257-repo-topology-and-mw-aligned-authoring.md) <!-- id:8676 -->
- [x] Write one-page `CONVENTIONS.md` per D2.
  (docs/meeting-notes/2026-06-15-1257-repo-topology-and-mw-aligned-authoring.md) <!-- id:e3af -->
- [x] Deliverable #0 — rigor-debt inventory (`docs/rigor-debt.md`), tier-tagged, no resolutions.
  (docs/meeting-notes/2026-06-15-1257-repo-topology-and-mw-aligned-authoring.md) <!-- id:3435 -->

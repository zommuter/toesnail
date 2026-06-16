# TODO Archive

## 2026-06
  - [x] Establish MathJax handle mechanism (`tex:{tags:'ams'}` + in-document `\gdef` macros) in
  - [x] Author inline `verify:` markers (instrument pointers) on the five Resogram claims, `physics/Resogram.md`.
  - [x] Write `verify/` SymPy scripts (one per claim) + `verify/README.md`; run all five, capture ✓/✗/inconclusive.
  - [x] Compute composite hashes + write `verified:` attestation markers for discharged claims, `physics/Resogram.md`.
  - [x] Annotate `docs/rigor-debt.md` with per-claim outcomes (incl. ✗ located-discrepancy narrative).
  - [x] Update `CONVENTIONS.md` — §1 KaTeX→MathJax + "already"→"as of pilot"; §2 tier-as-floor; attestation
- [x] Local Jekyll toolchain + relay-style TDD: `Gemfile` (jekyll 4 + minima + plugins), `package.json`
- [x] Scoping session — collAIb × toesnail × `.mw` three-repo relationship: content-layer edge resolved
- [x] Split spine from portal: move README → `physics/toesnail.md` (`/toesnail`); new portal README at `/`. — committed 715a11d on 2026-06-15
- [x] Cross-project dependency map `docs/dependencies.md` (toesnail × .mw × collAIb, direction + strength). — committed 715a11d on 2026-06-15
- [x] Re-tree repo per D1 (`physics/`, `essays/`, README root index); permalinks unchanged.
- [x] Write one-page `CONVENTIONS.md` per D2.
- [x] Deliverable #0 — rigor-debt inventory (`docs/rigor-debt.md`), tier-tagged, no resolutions.
- [x] Owner review: Resogram pilot findings — (a) `edot` 2nd equality wrong, correct is `ė=−4βe+ω²(2βx²+ẋy)`;
- [x] Resogram energy block render regression (`\tag` inside `aligned` → MathJax `merror`) — FIXED 2026-06-15
- [x] `[MEETING]` Two-tier **relay-aware commit-hook** — DESIGN RESOLVED 2026-06-16
- [x] Resogram energy-chain located-discrepancy cluster — RESOLVED in-document by owner (commit `236fa1b`,
- [x] Rename Resogram energy handle `cval`→`esol` (analytical energy SOLUTION; old name encoded the answered
- [x] Implement v1 `post-commit` hook: deterministic HARD tier (`.mw` DAG library over a one-section Resogram
  `.mw` mirror) → `git notes --ref=refs/notes/verify append` `status:pending`; relay-context no-op (`RELAY_SKIP`
  authoritative + `/worktrees/` path fallback); graceful-degrade when `.mw` unavailable; **never calls an LLM**.
  (docs/meeting-notes/2026-06-16-0635-relay-aware-commit-hook.md) <!-- id:8757 -->
- [x] Git config setup (document in `CLAUDE.md`): `notes.rewriteRef = refs/notes/verify` +
  `notes.rewriteMode = concatenate` (default `overwrite` drops merged notes on squash).
  (docs/meeting-notes/2026-06-16-0635-relay-aware-commit-hook.md) <!-- id:d5f9 -->
- [x] Stand up the one-section Resogram `.mw` mirror the HARD tier reads (realizes deferred `id:04bb` via
  `.mw` DAG-as-library; mirror ONE section only — N=2 guard).
  (docs/meeting-notes/2026-06-16-0635-relay-aware-commit-hook.md) <!-- id:0e63 -->
- [x] Tests for the hook: pending-note-on-owner-commit, relay-worktree no-op, graceful-degrade-without-`.mw`,
  concatenate-on-squash, loose-note detection via `merge-base --is-ancestor`.
  (docs/meeting-notes/2026-06-16-0635-relay-aware-commit-hook.md) <!-- id:211c -->

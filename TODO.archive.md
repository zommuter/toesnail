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
- [x] Recovered-pages infra: render-test coverage extended to ALL 5 recovered pages (entropy/wirohsh/photon/fhe/supertool — all verified render-clean; the wirohsh/photon "fails to render" claim was wrong) [ROUTINE] DONE 2026-06-16 <!-- id:7fd7 -->
  - [x] Stand up `verify/` lake project pinned `v4.30.0-rc2` (lakefile.toml + lean-toolchain + lake-manifest.json
    committed; `.gitignore` += `.lake/`; `verify/README.md` lake-build + optional btrfs-reflink footnote) and
    prove `edot_first_line` in `verify/Resogram.lean` via `subst; ring`. SCOPED 2026-06-16 (D1/D2; toolchain
    present, Mathlib pinned to research_lean's cached rev → fast `cache get`). Contract: `cd verify && lake build`
    exits 0, no `sorry`. (2026-06-16-0827-lean-edot-proof-mathlib-bringup.md) **DONE 2026-06-16** (strong-execute opus, /relay executor --afk; `lake build` exit 0 + no `sorry` + full `tests/run.sh` PASS + CI green; ẋ/ẍ→x_t/x_tt Lean-identifier naming (owner convention, scales to PDE spatial/mixed); `Resogram.lean` filehash 3c516103 for id:1335). id:5776/1335/3275 now UNBLOCKED. <!-- id:3317 -->
  - [x] Add `tests/test_lean.sh` (SKIP w/o lake; else `lake build` + `grep -L sorry`) wired into `tests/run.sh`;
    CI stays SKIP (D4). Contract: `bash tests/run.sh` PASSes; SKIPs cleanly where lake absent.
    DONE 2026-06-16 (executor; ROADMAP `[x]`); re-verified green 2026-06-16 /relay review (real `lake build` exit 0, no `sorry`).
    (2026-06-16-0827-lean-edot-proof-mathlib-bringup.md) <!-- id:5776 -->
  - [x] Compressed multi-tier `verified:` marker (D5): escalate `edot` → `verified:sympy+lean` in
    `physics/Resogram.md`; add the `verified:<tiers> claim=<h8> by=<inst>@<h8>[,…]` grammar to `CONVENTIONS.md`.
    DONE 2026-06-16 (executor; ROADMAP `[x]`); re-verified 2026-06-16 /relay review (marker present at Resogram.md:42 w/ `Resogram.lean@3c516103`; grammar in CONVENTIONS.md §2; `test_verify.sh` parses green).
    (2026-06-16-0827-lean-edot-proof-mathlib-bringup.md) <!-- id:1335 -->
  - [x] Annotate `docs/rigor-debt.md`: edot lean-attested; record per-tier outcome (SymPy-as-gate dataset, D5).
    DONE 2026-06-16 (executor; ROADMAP `[x]`); re-verified 2026-06-16 /relay review (`[edot]` row shows `sympy+lean` w/ both instrument pointers + SymPy-as-gate datapoint).
    (2026-06-16-0827-lean-edot-proof-mathlib-bringup.md) <!-- id:3275 -->
- [x] `[HUMAN]` integration pass — walk `tests/HUMAN-integration.md`: visual sanity in a browser + confirm
  VS Code applies `.vscode/settings.json` macros (render correctness is now machine-checked). DONE 2026-06-16 (owner-walked all 3 [HUMAN] boxes, /relay human). <!-- id:6501 -->
  by splitting into two `$$` blocks (`\ltag{e}` + ė-chain `\ltag{edot}` outer), owner-confirmed; suite green,
  covered by `tests/test_mathjax.cjs`. <!-- id:3b4c -->

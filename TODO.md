# TODO

## Current

- [ ] Relay: open ROADMAP items — ROUTINE (commit-hook cluster: id:8757 post-commit hook, id:d5f9 git-config+doc; Lean `edot` cluster tooling: id:5776 test_lean.sh, id:1335 multi-tier marker, id:3275 rigor-debt annotation; red suite id:211c authored) + HARD (id:3317 Lean bring-up+proof [HARD+INTENSIVE, lean-build]) [id:0e63 mirror fidelity RESOLVED 2026-06-16 /meeting D3: faithful four-block .mw mirror owner-ratified + test green] + 2 deferred-HARD/gated (id:b9bc derivative debt multi-day, id:9d8c CI Lean gated). Verify-hook JUDGMENT boxes RESOLVED 2026-06-16 (/relay human, id:d8bf): git-notes schema (8757/d5f9) owner-ratified — v1 {status,findings} + forward-compat {triaged,processed,verdict,review_me} FROZEN; mirror fidelity (0e63) RESOLVED 2026-06-16 (/meeting D3, owner-ratified: faithful four-block .mw mirror). Lean cluster SCOPED + promoted to ROADMAP 2026-06-16 /relay review (meeting 0827-lean-edot; toolchain confirmed present). (fca7 Makefile, 9868 CI done). edot/esol (handle renamed from `cval` 2026-06-15) verify instruments re-pinned ✗→✓ + verified green (2026-06-16 /relay review, id:9135 closed). Resogram c-narrative + energy-chain cluster RESOLVED by owner in-document (236fa1b: id:559c/0cb5/f9fe/3999, all REVIEW_ME boxes ticked). Open owner/design work: subequation numbering (id:d2f4), R2/R3 verify-emoji (id:445e), HUMAN-integration walk (id:6501). <!-- id:e27e -->

- [ ] Deliverable #1 — pilot Resogram end-to-end: equation handles + `verify:` markers + real SymPy/Lean
  checks of its energy derivation and the "is c=0?" question. Acoustics = pilot #2. Scoped + contracted
  2026-06-15 (docs/meeting-notes/2026-06-15-1409-resogram-verify-pilot-scope.md); decomposed below.
  **Cheap half done 2026-06-15** (SymPy: 3 ✓ / 2 ✗ located discrepancies); only Lean (3317) remains. <!-- id:01a7 -->
    `_includes/custom-head.html` + handles on the ~5 marked Resogram claims. Pipeline verified by
    `tests/test_render.sh` (local Jekyll build). (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:96ad -->
    (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:d0bf -->
    (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:9b2d -->
  - [ ] Stand up `verify/` lake project pinned `v4.30.0-rc2` (lakefile.toml + lean-toolchain + lake-manifest.json
    committed; `.gitignore` += `.lake/`; `verify/README.md` lake-build + optional btrfs-reflink footnote) and
    prove `edot_first_line` in `verify/Resogram.lean` via `subst; ring`. SCOPED 2026-06-16 (D1/D2; toolchain
    present, Mathlib pinned to research_lean's cached rev → fast `cache get`). Contract: `cd verify && lake build`
    exits 0, no `sorry`. (2026-06-16-0827-lean-edot-proof-mathlib-bringup.md) <!-- id:3317 -->
  - [ ] Add `tests/test_lean.sh` (SKIP w/o lake; else `lake build` + `grep -L sorry`) wired into `tests/run.sh`;
    CI stays SKIP (D4). Contract: `bash tests/run.sh` PASSes; SKIPs cleanly where lake absent.
    (2026-06-16-0827-lean-edot-proof-mathlib-bringup.md) <!-- id:5776 -->
  - [ ] Compressed multi-tier `verified:` marker (D5): escalate `edot` → `verified:sympy+lean` in
    `physics/Resogram.md`; add the `verified:<tiers> claim=<h8> by=<inst>@<h8>[,…]` grammar to `CONVENTIONS.md`.
    (2026-06-16-0827-lean-edot-proof-mathlib-bringup.md) <!-- id:1335 -->
  - [ ] Annotate `docs/rigor-debt.md`: edot lean-attested; record per-tier outcome (SymPy-as-gate dataset, D5).
    (2026-06-16-0827-lean-edot-proof-mathlib-bringup.md) <!-- id:3275 -->
- [ ] NEW `verify:lean` debt — derivative step `ė = ẋ(ẍ+ω²x)` (differentiate `e=½ẋ²+½ω²x²` via Mathlib
  `deriv`/chain-rule, multi-day). Owner: "we can't have unverified maths dangling around" — tracked, not dropped.
  (2026-06-16-0827-lean-edot-proof-mathlib-bringup.md) <!-- id:b9bc -->
- [ ] (Forward-flag, GATED) CI Lean/Mathlib build — parked; ~60-min cold build for one one-liner. Gate: warranted
  only if local kernel-checking proves insufficient. (2026-06-16-0827-lean-edot-proof-mathlib-bringup.md) <!-- id:9d8c -->
    (drive + eincr attested; sol withheld pending owner paren-fix.) (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:ee36 -->
    (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:7340 -->
    grammar + §3 carve-out. (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:3f57 -->
- [ ] Automated `verify:`/`verified:` staleness checker (walks source, recomputes hashes, flags drift). GATED:
- [ ] Automated `verify:`/`verified:` staleness checker (walks source, recomputes hashes, flags drift). GATED: acoustics pilot #2 supplies the N=2 second consumer. **Corroborating instance 2026-06-15 (`/relay human`):** the edot/cval instrument re-pin (✗→✓ + attestation re-derivation after the owner corrected the source) had to be deferred to "next review" BY HAND — exactly the drift this checker would flag. NB `.mw` shipped id:dae5 the same day (headless dependency-DAG + 3-state staleness propagation over fragment handles); when this checker is built, REUSE that DAG rather than reinventing hash-walking — it already does prose-citation-stale propagation. (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:04bb -->
  (b) `cval` c≠0 (`c=Ω²/(2β²)`, energy phase-shifted); (c) `sol` integrand unbalanced paren. AI surfaced,
  did not edit; owner decides each. (docs/rigor-debt.md) **RESOLVED 2026-06-15 (owner-ratified via /relay
  human):** (a) sign correction applied; (b) exact phase-shifted form adopted; (c) one-char paren fix
  applied. Two follow-ups left open (REVIEW_ME): next-`/relay review` instrument re-pin for edot+cval
  (✗→✓, attestations) and the owner-only `cval` c-narrative reconciliation. <!-- id:9135 -->
- [ ] `[HUMAN]` integration pass — walk `tests/HUMAN-integration.md`: visual sanity in a browser + confirm
  VS Code applies `.vscode/settings.json` macros (render correctness is now machine-checked). <!-- id:6501 -->
  by splitting into two `$$` blocks (`\ltag{e}` + ė-chain `\ltag{edot}` outer), owner-confirmed; suite green,
  covered by `tests/test_mathjax.cjs`. <!-- id:3b4c -->
- [ ] Wishlist: automated subequation dot-numbering — derive `(edot.1)…(edot.4)` handles from a parent handle
  so per-line tags render; also re-attaches the `[edot]` verify marker to an active `\ltag`. Relates to R2/R3
  (id:445e) + `.mw`. (/meeting 2026-06-15) <!-- id:d2f4 -->
  (docs/meeting-notes/2026-06-16-0635-relay-aware-commit-hook.md). Split decided: HARD tier (deterministic
  `.mw` DAG) → non-blocking **post-commit hook** writing ephemeral `git notes` on `refs/notes/verify`
  (`pending`→`triaged`→`processed`, never deleted = observe-first logger); SOFT tier (LLM, incl. b7b1
  dangling-symbol) → `/relay review` where Claude Code is the model (no ToS issue). REVIEW_ME stays the
  durable record; `/relay human` owns the `valid|noise` verdict. Coupling kept LOOSE (graceful-degrade,
  never a commit gate). Decomposed into id:8757/d5f9/0e63/211c below + routed findings. <!-- id:d8bf -->
- [ ] ROADMAP R2/R3 — rendered ✓-emoji on verified equations (hover/tooltip verify status) + a legible
  in-document annotation syntax to supersede illegible HTML `verify:` comments; design before changing
  rendered output. (/meeting 2026-06-15, 2026-06-15-2111-resogram-energy-chain-reconciliation.md) <!-- id:445e -->
- [ ] **Cross-project (triad):** add the owner's Diplomarbeit `.git` repo — a fully finished LaTeX project —
  as a **second acceptance/test corpus** for the `.mw`/toesnail/collAIb triad (N=2 beyond toesnail's
  north-star physics docs; exercises `.mw` ingest + verification on real finished LaTeX). **MIRRORED in
  `mathematical-writing/TODO.md` under the same `id:6ab8`** — keep both copies in sync MANUALLY (no automated
  cross-PROJECT sync: relay `--cross-ledger` is intra-repo only, inbox routing is one-way). Wherever it's
  worked/closed, tick the twin. Likely resolved in a manual `/meeting`. <!-- id:6ab8 -->
- [ ] **Cross-project (triad) — `/meeting`:** discuss the potentially connecting dots between **zkm
  infrastructure** (embeddings / semantic retrieval / knowledge-mgmt) and the `.mw`/toesnail/collAIb triad.
  toesnail is the documented hub (`docs/dependencies.md`); this would extend the dependency map with a zkm
  node. **MIRRORED in `zkm/TODO.md` under the same `id:4159`** — keep both copies in sync MANUALLY; tick the
  twin wherever closed. Likely a manual `/meeting`. <!-- id:4159 -->
- [ ] **Comment / annotation system for the GH Pages site** (idea salvaged from the archived `gtnsd` repo,
  see `gtnsd-archive` branch). Candidates: hypothes.is annotation overlay, staticman, `ghpages-ghcomments`,
  or a Jekyll static-comments recipe. Ties into collAIb's "live `verify:` assist UI" (annotation = surfacing
  rigor-debt in-page) and the `[edot]`-style handles (anchor targets). NB the gtnsd-era worry "how do
  annotations survive content changing over time?" is the inflownistration/staleness problem (`.mw` `id:aae4`).
  Design before wiring; low priority. <!-- id:d973 -->

## Done
  reconciled to REVIEW_ME 2026-06-15): energy-loss claim cites (edot.3) (id:559c); ymaint/yfree accepted as
  exposition, results ✓ (id:0cb5); c-narrative dangling-`c` sentence removed (id:f9fe); sliding-average window
  corrected to `(Ω/π)∫₀^{π/Ω}` (id:3999). Spun out 2 tooling items (id:3b4c render regression, id:d2f4
  subequation numbering). Ticks re-checked by next /relay review. <!-- id:f9fe -->
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

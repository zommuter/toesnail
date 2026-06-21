# TODO

## Current

- [ ] Relay: ALL ROUTINE + HARD bring-up CLOSED 2026-06-16 (re-verified /relay review 20260616-1957). Done: commit-hook cluster (id:8757 post-commit hook, id:d5f9 git-config+doc, id:211c red suite), Lean `edot` cluster tooling (id:5776 test_lean.sh, id:1335 multi-tier marker, id:3275 rigor-debt annotation), HARD bring-up (id:3317 Lean bring-up+proof [HARD+INTENSIVE, lean-build]), id:0e63 mirror fidelity (/meeting D3: faithful four-block .mw mirror owner-ratified + test green), fca7 Makefile, 9868 CI. ONLY OPEN: 2 deferred-HARD/gated, NOT executor work (id:b9bc derivative debt multi-day gated behind id:3317; id:9d8c CI Lean forward-flag gated). Verify-hook JUDGMENT boxes RESOLVED 2026-06-16 (/relay human, id:d8bf): git-notes schema (8757/d5f9) owner-ratified — v1 {status,findings} + forward-compat {triaged,processed,verdict,review_me} FROZEN; mirror fidelity (0e63) RESOLVED 2026-06-16 (/meeting D3, owner-ratified: faithful four-block .mw mirror). Lean cluster SCOPED + promoted to ROADMAP 2026-06-16 /relay review (meeting 0827-lean-edot; toolchain confirmed present). (fca7 Makefile, 9868 CI done). edot/esol (handle renamed from `cval` 2026-06-15) verify instruments re-pinned ✗→✓ + verified green (2026-06-16 /relay review, id:9135 closed). Resogram c-narrative + energy-chain cluster RESOLVED by owner in-document (236fa1b: id:559c/0cb5/f9fe/3999, all REVIEW_ME boxes ticked). Open owner/design work: subequation numbering (id:d2f4), R2/R3 verify-emoji (id:445e). HUMAN-integration walk (id:6501) DONE 2026-06-16 (owner-walked, /relay human). <!-- id:e27e -->

- [ ] (MEETING candidate) Better workflow for math/Lean-formalization design sessions — e.g. meeting-rpg with
  in-session formula rendering (so equation-heavy decisions like id:b9bc's HasDerivAt signature are legible
  during discussion), or possibly a collAIb regime instead. To be scoped in a dedicated /meeting. <!-- id:2f99 -->
- [ ] `verify:` pilot candidates in recovered pages — OWNER PICKED 2026-06-16 (/relay human): mark **entropy** BE/FD+Lambert-W (sympy) + **fhe** enumeration/`.ods` (numeric); **wirohsh DEFERRED**. Owner places the markers (physics/crypto content is Human-only); then instrument plumbing is [ROUTINE]. See REVIEW_ME. **ENTROPY markers PLACED 2026-06-18** (owner-directed, /walk): `physics/entropy.md` carries `\veq{meanE}\sympyc` (E/E₁ closed-form chain l.22), `\veq{be}\sympyc` (Bose–Einstein N→∞ limit l.27), `\veq{fd}\sympyc` (Fermi–Dirac N=2 l.35), `\veq{lambertw}\sympyc` (Lambert-W inversion l.59) — all `\sympyc` = OPEN-DEBT (desired SymPy, not yet verified, id:feb8). NEXT [ROUTINE]: build `verify/entropy_{be,fd,meanE,lambertw}.py` + `physics/entropy.toml` sidecar + wire into `test_verify.sh`; on green swap `\sympyc`→`\sympy`. `lambertw` ESCALATED `\sympyc`→`\leanc` [HARD] 2026-06-18 (owner-ratified): SymPy CONFIRMED can't close the transcendental inversion (probe; ==y False both ∓ branches), numeric is counter-indicator-only not an assurance tier → faithful tier is Lean. NEEDS a scoping `/meeting` (Mathlib Lambert-W capability-gap risk + frozen signature + DoD) — like edot_deriv. So entropy splits: be/fd/meanE = `\sympyc` [ROUTINE] instruments; lambertw = `\leanc` [HARD]. **FHE markers PLACED 2026-06-18** (owner picked all 4; AI-authored carriers per owner delegation, RATIFY in REVIEW_ME): `crypto/fhe.md` carries `\veq{stirling}\sympyc` (Πₙ Stirling, l.12 in place), `\veq{ocount}\sympyc` (new carrier after l.8; caveat: sympy attests only exponent algebra, not the count), `\veq{semidestr}\numericc` (new carrier after l.68, binom=6), `\veq{bij24}\numericc` (new carrier after l.74, =24). NEXT [ROUTINE] once ratified: numeric instruments cross-checking `fhe.ods`/`fhe.py` + `crypto/fhe.toml` sidecar + test_verify wiring. <!-- id:8807 -->
- [ ] Deliverable #1 — pilot Resogram end-to-end: equation handles + `verify:` markers + real SymPy/Lean
  checks of its energy derivation and the "is c=0?" question. Acoustics = pilot #2. Scoped + contracted
  2026-06-15 (docs/meeting-notes/2026-06-15-1409-resogram-verify-pilot-scope.md); decomposed below.
  **Cheap half done 2026-06-15** (SymPy: 3 ✓ / 2 ✗ located discrepancies); Lean tier landed 2026-06-16 (id:3317 `edot` first-line proof). Remaining: the ROUTINE follow-ons id:5776/1335/3275 (test wiring, marker upgrade, rigor-debt annotation). <!-- id:01a7 -->
    `_includes/custom-head.html` + handles on the ~5 marked Resogram claims. Pipeline verified by
    `tests/test_render.sh` (local Jekyll build). (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:96ad -->
    (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:d0bf -->
    (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:9b2d -->
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
- [ ] Wishlist: automated subequation dot-numbering — derive `(edot.1)…(edot.4)` handles from a parent handle
  so per-line tags render; also re-attaches the `[edot]` verify marker to an active `\ltag`. Relates to R2/R3
  (id:445e) + `.mw`. (/meeting 2026-06-15) **OPTION (owner obs 2026-06-18, entropy.md):** don't hand-invent
  per-line subhandles — `\veq{h}` only the lines that need a STABLE/citeable handle and let amsmath's native
  auto-enumeration number the ephemeral steps for free (verified: tagged line shows `(lambertw ∘?)`, untagged
  lines keep `(12)`/`(13)` in BOTH engines; KaTeX `\veq` is `\tag`-only — no `\label` — so it's legal mid-align).
  CAVEAT: auto-numbers are NOT stable (`\eqref`-able) — they renumber on any insertion above; so the division is
  `\veq`=cited/verify-debt, auto-number=visible-step-only. <!-- id:d2f4 -->
  (docs/meeting-notes/2026-06-16-0635-relay-aware-commit-hook.md). Split decided: HARD tier (deterministic
  `.mw` DAG) → non-blocking **post-commit hook** writing ephemeral `git notes` on `refs/notes/verify`
  (`pending`→`triaged`→`processed`, never deleted = observe-first logger); SOFT tier (LLM, incl. b7b1
  dangling-symbol) → `/relay review` where Claude Code is the model (no ToS issue). REVIEW_ME stays the
  durable record; `/relay human` owns the `valid|noise` verdict. Coupling kept LOOSE (graceful-degrade,
  never a commit gate). Decomposed into id:8757/d5f9/0e63/211c below + routed findings. <!-- id:d8bf -->
- [ ] **(toesnail) [ROUTINE] Sync authoring docs to the implemented `\veq{h}\tier` form.** The 2026-06-18 corpus migration (`a9d2`/`dce9`) moved markers to `\veq{h}\tier` (badges `\sorry`→? `\sympy`→∘ `\numeric`→△ `\lean`→✓ `\sympylean`→✓✓; open-debt = tier-less `\veq{h}\sorry` OR tier-naming `\veq{h}\sympyc`/`\numericc`/`\leanc` per RESOLVED `id:feb8`, NOT `\sympy*`), but the AUTHORING docs still teach the retired `<!-- verify:tier -->` HTML comment: `CONVENTIONS.md` §2 marker table (l.50-63), `CLAUDE.md` rigor-debt-markers (l.39-49), `ARCHITECTURE.md` (l.20), and the `REVIEW_ME.md` `verify:`-pilot owner instruction. Replace each with `\veq` syntax; KEEP the D4 point that tooling MAY write the badge arg while the equation/claim inside `\veq{…}` stays human-only theory (the original scope of this item). Surfaced via `/relay human` 2026-06-18 (my pilot-marker advice wrongly cited the retired HTML form because these docs lagged the migration). (docs/meeting-notes/2026-06-18-0729-veq-macro-verify-carrier.md D2-D4) <!-- id:9fdc -->
- [ ] **(forward-flag)** `\veq{}` is the natural vehicle for subequation labelling (`id:d2f4`) and ✓-emoji render variants (`id:445e`); design separately, after the KaTeX pilot (`id:e0b7`). (docs/meeting-notes/2026-06-18-0729-veq-macro-verify-carrier.md) <!-- id:7b2b -->
- [ ] **(forward-flag, later) autolabel-suggestion** — tool-suggested equation handles for un-labelled display equations (so `\veq{…}` handles don't have to be hand-invented). Owner flag 2026-06-18: collAIb-side or `.mw`-side? Decide the home. Relates to the `.mw` parser (`id:358f`) + collAIb assist role. <!-- id:7743 -->
- [ ] **(forward-flag, later) notation-implies-annotation sanity checks** — owner 2026-06-18: toesnail uses non-standard "handwavy physics" notation whose OPERATOR carries semantic meaning the verify/annotation layer can leverage as a SANITY CHECK: (a) `:=` directly implies a **definition** (should still get a handle/label — the `:=`↔`\definition`-annotation relationship becomes a cross-check); (b) `\approx` may imply a **Lean-provable `\mathcal{O}(…)`** step; (c) `\dot=` (non-standard) less formally denotes a **linear approximation**; and more as the corpus grows. The tool would infer/verify the expected annotation kind from the operator. Ties to the annotation-kind taxonomy meeting (definition/assumption/… — deferred) and the `.mw` verify engine (`id:358f`). <!-- id:8ddc -->
- [ ] ROADMAP R2/R3 — rendered ✓-emoji on verified equations (hover/tooltip verify status) + a legible
  in-document annotation syntax to supersede illegible HTML `verify:` comments; **`\veq{}` macro is the designed vehicle** (2026-06-18-0729-veq-macro-verify-carrier.md D3); implement render variants after `id:e0b7` KaTeX pilot + `id:dce9` migration land. (/meeting 2026-06-15, 2026-06-15-2111-resogram-energy-chain-reconciliation.md) <!-- id:445e -->
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
- [ ] **(non-blocker) GitHub file-view doesn't render `\veq`/custom macros** (owner obs 2026-06-18, image). GitHub's
  repo markdown-math preview uses a SANDBOXED MathJax subset that (a) can't see our macros — `\veq`, `\sympy`,
  `\sympyc`, … are defined only in `_includes/custom-head.html` (the published Pages site) + `.vscode/settings.json`
  (editor), NOT loadable into GitHub's renderer; and (b) forbids commands like `\operatorname` ("macro not
  allowed", seen on Resogram's `\operatorname{sign}`). So `.md` files viewed ON github.com render math raw/broken;
  the **published Pages site renders fine** (it loads custom-head.html). Inherent to the source-stays-plain +
  central-macro-def design (we forbid in-doc `\gdef`, which GitHub wouldn't honor anyway). Options to weigh later:
  a README banner pointing readers to the live site for math; a GitHub-compatible macro fallback (hard — no
  per-repo macro config); or swap `\operatorname{…}`→`\mathrm{…}` where owner-content allows. Low priority. <!-- id:bf21 -->
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

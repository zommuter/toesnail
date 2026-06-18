# TODO

## Current

- [ ] Relay: ALL ROUTINE + HARD bring-up CLOSED 2026-06-16 (re-verified /relay review 20260616-1957). Done: commit-hook cluster (id:8757 post-commit hook, id:d5f9 git-config+doc, id:211c red suite), Lean `edot` cluster tooling (id:5776 test_lean.sh, id:1335 multi-tier marker, id:3275 rigor-debt annotation), HARD bring-up (id:3317 Lean bring-up+proof [HARD+INTENSIVE, lean-build]), id:0e63 mirror fidelity (/meeting D3: faithful four-block .mw mirror owner-ratified + test green), fca7 Makefile, 9868 CI. ONLY OPEN: 2 deferred-HARD/gated, NOT executor work (id:b9bc derivative debt multi-day gated behind id:3317; id:9d8c CI Lean forward-flag gated). Verify-hook JUDGMENT boxes RESOLVED 2026-06-16 (/relay human, id:d8bf): git-notes schema (8757/d5f9) owner-ratified — v1 {status,findings} + forward-compat {triaged,processed,verdict,review_me} FROZEN; mirror fidelity (0e63) RESOLVED 2026-06-16 (/meeting D3, owner-ratified: faithful four-block .mw mirror). Lean cluster SCOPED + promoted to ROADMAP 2026-06-16 /relay review (meeting 0827-lean-edot; toolchain confirmed present). (fca7 Makefile, 9868 CI done). edot/esol (handle renamed from `cval` 2026-06-15) verify instruments re-pinned ✗→✓ + verified green (2026-06-16 /relay review, id:9135 closed). Resogram c-narrative + energy-chain cluster RESOLVED by owner in-document (236fa1b: id:559c/0cb5/f9fe/3999, all REVIEW_ME boxes ticked). Open owner/design work: subequation numbering (id:d2f4), R2/R3 verify-emoji (id:445e). HUMAN-integration walk (id:6501) DONE 2026-06-16 (owner-walked, /relay human). <!-- id:e27e -->

- [ ] (MEETING candidate) Better workflow for math/Lean-formalization design sessions — e.g. meeting-rpg with
  in-session formula rendering (so equation-heavy decisions like id:b9bc's HasDerivAt signature are legible
  during discussion), or possibly a collAIb regime instead. To be scoped in a dedicated /meeting. <!-- id:2f99 -->
- [ ] `verify:` pilot candidates in recovered pages — OWNER PICKED 2026-06-16 (/relay human): mark **entropy** BE/FD+Lambert-W (sympy) + **fhe** enumeration/`.ods` (numeric); **wirohsh DEFERRED**. Owner places the `verify:` markers (physics/crypto content is Human-only); then instrument plumbing is [ROUTINE]. See REVIEW_ME. <!-- id:8807 -->
- [ ] Deliverable #1 — pilot Resogram end-to-end: equation handles + `verify:` markers + real SymPy/Lean
  checks of its energy derivation and the "is c=0?" question. Acoustics = pilot #2. Scoped + contracted
  2026-06-15 (docs/meeting-notes/2026-06-15-1409-resogram-verify-pilot-scope.md); decomposed below.
  **Cheap half done 2026-06-15** (SymPy: 3 ✓ / 2 ✗ located discrepancies); Lean tier landed 2026-06-16 (id:3317 `edot` first-line proof). Remaining: the ROUTINE follow-ons id:5776/1335/3275 (test wiring, marker upgrade, rigor-debt annotation). <!-- id:01a7 -->
    `_includes/custom-head.html` + handles on the ~5 marked Resogram claims. Pipeline verified by
    `tests/test_render.sh` (local Jekyll build). (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:96ad -->
    (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:d0bf -->
    (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:9b2d -->
- [ ] `verify:lean` debt — derivative step `edot_deriv` (`ė=ẋ(ẍ+ω²x)`). **RE-SCOPED `[ROUTINE]` + `[PILOT —
  Sonnet-on-Lean4]` 2026-06-16 /meeting**: fidelity judgment consumed; prove a FROZEN `HasDerivAt` signature
  in `verify/Resogram.lean` (`by` body only) + lean-only marker + rigor-debt row. See ROADMAP id:b9bc for the
  frozen signature, proof sketch, DoD, and pilot note. (2026-06-16-2257-edot-deriv-lean-formalization.md) <!-- id:b9bc -->
- [x] **(toesnail) KaTeX/MathJax `\veq[…]{…}` feasibility pilot** — DONE 2026-06-18 — define trial `\veq`/`\veq*` macro (tag+`\label`+✓-emoji by tier) in `_includes/custom-head.html` (MathJax) and `.vscode/settings.json` (KaTeX); assert `\veq[lean]{edot}`, `\veq[sorry]{edot}`, `\veq*{x}` render in BOTH via `tests/test_mathjax.cjs`. Check name against siunitx/physics/mathtools/unicode-math; if `\veq` collides use `\vtag`; if `[…]` infeasible use `\veq{edot:lean}`. Gate on `id:a9d2`. (docs/meeting-notes/2026-06-18-0729-veq-macro-verify-carrier.md D7) — **SPIKE RUN 2026-06-18 (`/relay --afk`):** the D3/D7 preferred `\veq[tier]{h}` optional-arg form is **INFEASIBLE — KaTeX 0.16.47 has no optional-argument macro support** (`\newcommand[2][sorry]` → parse error); BOTH fallbacks render in BOTH engines: colon `\veq{h:tier}` (D7 default, but tier leaks into the `\eqref` handle) and 2-mandatory `\veq{h}{tier}` (clean `\eqref{h}`, needs a `sorry` sentinel). **Round-2 pilot (colon-split + tier→emoji):** KaTeX can't split a *braced* colon arg (delimited `\def` needs the bare `\veq h:tier;` form, no braces) and has **no `\ifx`** for string→emoji mapping → portable badges need per-tier **macros** (`\leanbadge`→`\checkmark`), i.e. the `\veq{h}{\tierbadge}` 2-arg form; a handle containing a colon is also immune in that form. This collapses the fork onto **2-mandatory `\veq{h}{\tierbadge}`** (evidence-recommended). **Round-3:** a delimited `\def` (`\veq edot;lean;`) parses in both raw engines (trailing `;` required; `\veq*` fine via `\@ifstar`) but is **not deployable** — the project's no-in-doc-`\def` rule forces central config, and `.vscode/settings.json` (JSON) can't hold the JS-function form a delimited KaTeX macro needs; the 2-brace form deploys via plain string macros in both configs. **Round-4 (owner idea, evidence-favoured):** `\veq{h}` as a 1-arg `\ltag` drop-in FOLLOWED BY a standalone badge macro (`\veq{edot}\lean`), absence=implicit sorry — both `\veq` and the badge macros are simple string macros (JSON-deployable in both configs), migration is a pure `\ltag`→`\veq` rename, and the trailing badge is a separate tool-maintained token (badge=tooling/equation=human, maps to D6 brace). Deployable options are now (a) 2-brace and (d) trailing-badge; owner picks. **Round-5 (owner: annotations ≠ verify-only — also definition (Resogram `\delta`), assumption, …):** owner prefers (d) + `\@ifstar` + an OPEN annotation-macro family. Piloted: `\@ifstar` IS JSON-deployable from a string macro (`\veq{h}` numbered / `\veq*{h}` unnumbered); `\veq{delta}\definition`, `\veq{a1}\assumption`, and composed `\veq{edot}\definition\lean` all render in both engines as simple string macros. **OWNER RATIFIED form (d) 2026-06-18** (`\veq[*]{label}[\tier]`-style). Name check: `\veq` + tier macros (`\sorry`/`\sympy`/`\numeric`/`\lean`/`\sympylean`) all FREE in both engines. `@`-shorthand deferred (bonus). Kind taxonomy + final name = separate `/meeting`, NOT blocking. **DONE 2026-06-18** (Sonnet bg agent, integrated): form (d) implemented in BOTH central configs — `\veq`/`\veqNum`/`\veqStar` (via `\@ifstar`) + verify-tier macros `\sorry`→`?`, `\sympy`→`○`, `\numeric`→`△`, `\lean`→`✓`, `\sympylean`→`✓✓`; `tests/test_mathjax.cjs` asserts `\veq{h}`/`\veq*{h}`/`\veq{h}\lean`/composed render + clean `\eqref` in BOTH engines; full suite green; `\ltag` kept intact (additive — the rename is a9d2). Glyph choices + the `sympy+lean` tier spelling (must match `.mw` + `Resogram.toml`) → owner eyeball (REVIEW_ME `id:e0b7`). **`.mw` `id:358f` also DONE** (Opus bg agent) → both gates for the a9d2/dce9 migration are now CLEARED. <!-- id:e0b7 -->
- [ ] **(toesnail, GATES NOW CLEARED — id:e0b7 ✓ + .mw id:358f ✓) Execute `a9d2` migration** — rename `\ltag`→`\veq` corpus-wide; convert 5 Resogram HTML-comment markers to `\veq{h}\tier` badges + `physics/Resogram.toml` sidecar; rewrite `tests/test_verify.sh` (join badge↔sidecar by handle, assert sidecar-handles ⊆ source-handles); update `test_render.sh` `\ltag` guard. **OWNER-GATED, NOT executor-eligible:** this edits `physics/Resogram.md` (marker→badge conversion + the `\ltag`→`\veq` rename in prose), which the relay scope guard makes human-only — the AI surfaces the conversion; the owner ratifies it (the `.md`/test/sidecar plumbing IS tooling, but it lands in a physics file). Tier strings in `Resogram.toml` must match `.mw` exactly (e.g. `sympy+lean`). (docs/meeting-notes/2026-06-18-0729-veq-macro-verify-carrier.md) <!-- id:dce9 -->
- [ ] (GATED — forward-flag, gate: id:e0b7 KaTeX pilot AND routed:8587 .mw side) Migrate toesnail's `<!-- verify/verified -->` HTML-comment markers to `\veq[…]{…}` badge + per-file `<stem>.toml` sidecar (D3–D5, 2026-06-18-0729-veq-macro-verify-carrier.md). Owner is "_strongly_ against HTML comments". Original gate was routed:e4df (.mw brace design); that design is now delivered by this meeting; new gates are: (1) id:e0b7 KaTeX/MathJax `\veq[...]` feasibility pilot; (2) routed:8587 .mw side implementation. <!-- id:a9d2 -->
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
  (id:445e) + `.mw`. (/meeting 2026-06-15) <!-- id:d2f4 -->
  (docs/meeting-notes/2026-06-16-0635-relay-aware-commit-hook.md). Split decided: HARD tier (deterministic
  `.mw` DAG) → non-blocking **post-commit hook** writing ephemeral `git notes` on `refs/notes/verify`
  (`pending`→`triaged`→`processed`, never deleted = observe-first logger); SOFT tier (LLM, incl. b7b1
  dangling-symbol) → `/relay review` where Claude Code is the model (no ToS issue). REVIEW_ME stays the
  durable record; `/relay human` owns the `valid|noise` verdict. Coupling kept LOOSE (graceful-degrade,
  never a commit gate). Decomposed into id:8757/d5f9/0e63/211c below + routed findings. <!-- id:d8bf -->
- [ ] **(toesnail, relay-contract note)** Clarify in `CONVENTIONS.md` + relay scope that tooling MAY write the `\veq` **badge arg** (derived attestation), but the equation/claim inside `\veq{…}` stays human-only theory. (docs/meeting-notes/2026-06-18-0729-veq-macro-verify-carrier.md D4) <!-- id:9fdc -->
- [ ] **(forward-flag)** `\veq{}` is the natural vehicle for subequation labelling (`id:d2f4`) and ✓-emoji render variants (`id:445e`); design separately, after the KaTeX pilot (`id:e0b7`). (docs/meeting-notes/2026-06-18-0729-veq-macro-verify-carrier.md) <!-- id:7b2b -->
- [ ] **(deferred design) `\veq*` unnumbered / sub-step / inline-math variant** — `\veq{h}\tier` (numbered, badge-in-tag) landed under `id:e0b7`; the STAR variant for sub-steps (e.g. the commented `edot.1`/`edot_deriv`) and inline math is deferred. Owner intent: `\veq*` shows a tag with the badge only (no number), `\quad`-spaced. Three snags found (2026-06-18): (1) `\tag` inside an `aligned` env that already has a `\tag` → "Multiple \tag" error, and we can't assume an `&`-align context; (2) inline math can't use `\tag` at all; (3) KaTeX needs a 2-arg macro to reference `#1` (no `\label` to absorb the handle invisibly), so a badge-only KaTeX `\veq*` is awkward. Interim: `\quad`+badge inline (no tag). Needs a coherent design. <!-- id:a138 -->
- [ ] **(deferred design) `\tier*` open-debt notation** — owner idea: `\sympy*`/`\lean*` = "wants this verifier, not yet verified" (asterisk = unverified, names the desired tier), nicer than a generic `\sorry`. Snag (2026-06-18): with the single-token unbraced 2nd arg, `\veq{h}\sympy*` leaves the `*` orphaned (the arg grabs only `\sympy`). Needs a distinct mechanism (braces — which the owner dislikes; or per-tier open-macros like `\osympy`; or a different marker). Until resolved, open debt uses `\sorry`. <!-- id:feb8 -->
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

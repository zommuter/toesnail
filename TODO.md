# TODO

## Current

- [x] Relay: ALL ROUTINE + HARD bring-up CLOSED 2026-06-16 (re-verified /relay review 20260616-1957). Done: commit-hook cluster (id:8757 post-commit hook, id:d5f9 git-config+doc, id:211c red suite), Lean `edot` cluster tooling (id:5776 test_lean.sh, id:1335 multi-tier marker, id:3275 rigor-debt annotation), HARD bring-up (id:3317 Lean bring-up+proof [HARD+INTENSIVE, lean-build]), id:0e63 mirror fidelity (/meeting D3: faithful four-block .mw mirror owner-ratified + test green), fca7 Makefile, 9868 CI. ONLY OPEN: 2 deferred-HARD/gated, NOT executor work (id:b9bc derivative debt multi-day gated behind id:3317; id:9d8c CI Lean forward-flag gated). Verify-hook JUDGMENT boxes RESOLVED 2026-06-16 (/relay human, id:d8bf): git-notes schema (8757/d5f9) owner-ratified — v1 {status,findings} + forward-compat {triaged,processed,verdict,review_me} FROZEN; mirror fidelity (0e63) RESOLVED 2026-06-16 (/meeting D3, owner-ratified: faithful four-block .mw mirror). Lean cluster SCOPED + promoted to ROADMAP 2026-06-16 /relay review (meeting 0827-lean-edot; toolchain confirmed present). (fca7 Makefile, 9868 CI done). edot/esol (handle renamed from `cval` 2026-06-15) verify instruments re-pinned ✗→✓ + verified green (2026-06-16 /relay review, id:9135 closed). Resogram c-narrative + energy-chain cluster RESOLVED by owner in-document (236fa1b: id:559c/0cb5/f9fe/3999, all REVIEW_ME boxes ticked). Open owner/design work: subequation numbering (id:d2f4), R2/R3 verify-emoji (id:445e). HUMAN-integration walk (id:6501) DONE 2026-06-16 (owner-walked, /relay human). <!-- id:e27e -->

- [x] **(MEETING — RESOLVED 2026-06-21) Lean-formalization strategy for verify pilots needing constructs beyond base Mathlib.** Spun
  out 2026-06-18 from the entropy+FHE pilots. Two buckets: (A) **genuine Mathlib gaps** — `lambertw` (Mathlib
  has NO Lambert W, confirmed; restate the inversion W-free via `exp`/`Real.log` + the defining `w·e^w` relation,
  OR source it from an external lib); investigate the **PhysLean / physicslib** project (physics Lean library;
  not local — remote lead) for non-Mathlib lemmas; design the general approach for "non-trivial syntax not in
  Mathlib" (owner 2026-06-18). (B) **tractable-in-Mathlib combinatorial counts** — FHE `ocount` (`Fintype.card_pi`),
  `bij24` (`Fintype.card_perm`=`n!`), `semidestr` (`Nat.choose`+`Finset.card`); card lemmas CONFIRMED present, so
  these are Lean targets that need frozen signatures + [ROUTINE]-vs-[HARD] sizing (the `edot_deriv` treatment),
  NOT capability-blocked. All four currently `\leanc` open-debt. Decide per-claim sizing + the W-free/PhysLean
  path here. **RESOLVED 2026-06-21 (/meeting `docs/meeting-notes/2026-06-21-2129-lean-formalization-strategy.md`):** D1 lambertw SPLIT (algebra→sympy [ROUTINE], closed-form→\definition+deferred W-branch caveat, no PhysLean); D2 all Lean counts [HARD] first (per-claim scoping, verify/Entropy.lean+FHE.lean); D3 tier ladder codified; D4 .mw→Lean4 routed. Spun into id:7306/37cc/2709 + routed:733c below. <!-- id:3d2a -->
- [ ] **[ROUTINE] SymPy instrument bucket** (/meeting id:3d2a D1/D3) — `verify/entropy_{be,fd,meanE}.py`, `verify/fhe_stirling.py` (named correction terms + `O(2^{-n})` remainder, NOT eval-at-a-few-n), `verify/entropy_lambertw.py` (algebra l.53–57); `physics/entropy.toml` + `crypto/fhe.toml` sidecars; split the `lambertw` marker per D1 (algebra step→`\sympyc`, closed-form l.59→`\definition`); `tests/test_verify.sh` wiring; on green flip `\sympyc`→`\sympy`. Suite green, one `VERDICT: ✓`/instrument, sidecar non-drift. ~1 executor session → hand off to relay. **NB 2026-07-01 (relay review):** ROADMAP id:7306 covers the four already-placed `\sympyc` instruments only; the `lambertw` algebra instrument + D1 marker split are gated on OWNER marker placement → ROADMAP id:5d31 + REVIEW_ME box (this line's tick does NOT cover them). **NB 2026-07-02 (relay review):** id:7306 hard-split (auto, id:3801) — 3 of 4 instruments SHIPPED as seam id:e9e9 (`entropy_{meanE,be,fd}.py` + `physics/entropy.toml` + badge flips, verified genuine); the `fhe_stirling` seam id:76e5 is GATED on an owner content fix (fhe.md:12 constant term `ln√(2π)` should be `log₂√(2π)` — REVIEW_ME box). (2026-06-21-2129-lean-formalization-strategy.md) <!-- id:7306 -->
- [ ] **[HARD] Lean claims — queued individually** (/meeting id:3d2a D2) — `ocount` (`Fintype.card_fun`), `bij24` (`Fintype.card_perm`), `semidestr`-count (`Nat.choose`), `semidestr`-identification (balanced⟺semi-destructive, owner modelling), `lambertw`-branch/domain. Each needs its OWN scoping `/meeting` (fidelity-consume + freeze signature, edot_deriv pattern) before `[ROUTINE]`; all stay `\leanc` until then. `verify/Entropy.lean` + `verify/FHE.lean` (mirror resogram_*.py), into `tests/test_lean.sh`. Draft signatures in the meeting note. (2026-06-21-2129-lean-formalization-strategy.md) <!-- id:37cc -->
- [x] **[ROUTINE] document the tier-escalation ladder** (/meeting id:3d2a D3) in `CONVENTIONS.md` verify-marker section: SymPy-if-closes → else Lean → else honest open-debt badge naming the desired tier (`\sympyc`/`\numericc`/`\leanc`); `\definition` is never a dodge for a real claim; numeric is a complementary counter-indicator, never the assurance badge. **DONE 2026-07-01 (executor), verified genuine 2026-07-02 review** — `CONVENTIONS.md` §2 ladder + both clauses; `tests/test_conventions_ladder.sh` green + wired into `tests/run.sh`. (2026-06-21-2129-lean-formalization-strategy.md) <!-- id:2709 -->
- [ ] **(forward-flag, cross-project) `.mw`→Lean4 lowering research** (/meeting id:3d2a D4) — can a `.mw` document lower its fragments to Lean4 proof obligations (machine-provable document) vs only tracking external instruments? MIRRORED to `mathematical-writing` inbox (routed:733c); ties `.mw` id:358f. (2026-06-21-2129-lean-formalization-strategy.md) <!-- routed:733c --> <!-- id:4976 -->
- [ ] (MEETING candidate) Better workflow for math/Lean-formalization design sessions — e.g. meeting-rpg with <!-- id:2f99 -->
  in-session formula rendering (so equation-heavy decisions like id:b9bc's HasDerivAt signature are legible
  during discussion), or possibly a collAIb regime instead. To be scoped in a dedicated /meeting.
- [ ] `verify:` pilot candidates in recovered pages — OWNER PICKED 2026-06-16 (/relay human): mark **entropy** BE/FD+Lambert-W (sympy) + **fhe** enumeration/`.ods` (numeric); **wirohsh DEFERRED**. Owner places the markers (physics/crypto content is Human-only); then instrument plumbing is [ROUTINE]. See REVIEW_ME. **ENTROPY markers PLACED 2026-06-18** (owner-directed, /walk): `physics/entropy.md` carries `\veq{meanE}\sympyc` (E/E₁ closed-form chain l.22), `\veq{be}\sympyc` (Bose–Einstein N→∞ limit l.27), `\veq{fd}\sympyc` (Fermi–Dirac N=2 l.35), `\veq{lambertw}\sympyc` (Lambert-W inversion l.59) — all `\sympyc` = OPEN-DEBT (desired SymPy, not yet verified, id:feb8). NEXT [ROUTINE]: build `verify/entropy_{be,fd,meanE,lambertw}.py` + `physics/entropy.toml` sidecar + wire into `test_verify.sh`; on green swap `\sympyc`→`\sympy`. `lambertw` ESCALATED `\sympyc`→`\leanc` [HARD] 2026-06-18 (owner-ratified): SymPy CONFIRMED can't close the transcendental inversion (probe; ==y False both ∓ branches), numeric is counter-indicator-only not an assurance tier → faithful tier is Lean. NEEDS a scoping `/meeting` (Mathlib Lambert-W capability-gap risk + frozen signature + DoD) — like edot_deriv. So entropy splits: be/fd/meanE = `\sympyc` [ROUTINE] instruments; lambertw = `\leanc` [HARD]. **FHE markers PLACED + RESHAPED 2026-06-18** (owner ratified): owner rejected AI display-carriers → marked counts INLINE with `\veqs`, and re-tiered combinatorial counts to Lean (`\definition` is a bad downgrade; sympy-can't⇒Lean). `crypto/fhe.md`: `\veq{stirling}\sympyc` (l.12 display, [ROUTINE]), `\veqs{ocount}\leanc` (l.8 inline, Fintype.card_pi), `\veqs{semidestr}\leanc` (l.67 inline, Nat.choose), `\veqs{bij24}\leanc` (l.74 inline, Fintype.card_perm). The 3 `\leanc` counts are Mathlib-tractable → Lean meeting `id:3d2a` for sizing; stirling = lone [ROUTINE] sympy instrument. Entropy fidelity RATIFIED (owner); lambertw also `\leanc`→`id:3d2a`. <!-- id:8807 -->
- [ ] Deliverable #1 — pilot Resogram end-to-end: equation handles + `verify:` markers + real SymPy/Lean <!-- id:01a7 -->
  checks of its energy derivation and the "is c=0?" question. Acoustics = pilot #2. Scoped + contracted
  2026-06-15 (docs/meeting-notes/2026-06-15-1409-resogram-verify-pilot-scope.md); decomposed below.
  **Cheap half done 2026-06-15** (SymPy: 3 ✓ / 2 ✗ located discrepancies); Lean tier landed 2026-06-16 (id:3317 `edot` first-line proof). Remaining: the ROUTINE follow-ons id:5776/1335/3275 (test wiring, marker upgrade, rigor-debt annotation).
    `_includes/custom-head.html` + handles on the ~5 marked Resogram claims. Pipeline verified by
    `tests/test_render.sh` (local Jekyll build). (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:96ad -->
    (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:d0bf -->
    (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:9b2d -->
- [ ] (Forward-flag, GATED) CI Lean/Mathlib build — parked; ~60-min cold build for one one-liner. Gate: warranted <!-- id:9d8c -->
  only if local kernel-checking proves insufficient. (2026-06-16-0827-lean-edot-proof-mathlib-bringup.md)
    (drive + eincr attested; sol withheld pending owner paren-fix.) (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:ee36 -->
    (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:7340 -->
    grammar + §3 carve-out. (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:3f57 -->
- [ ] Automated `verify:`/`verified:` staleness checker (walks source, recomputes hashes, flags drift). GATED: acoustics pilot #2 supplies the N=2 second consumer. **Corroborating instance 2026-06-15 (`/relay human`):** the edot/cval instrument re-pin (✗→✓ + attestation re-derivation after the owner corrected the source) had to be deferred to "next review" BY HAND — exactly the drift this checker would flag. NB `.mw` shipped id:dae5 the same day (headless dependency-DAG + 3-state staleness propagation over fragment handles); when this checker is built, REUSE that DAG rather than reinventing hash-walking — it already does prose-citation-stale propagation. (2026-06-15-1409-resogram-verify-pilot-scope.md) <!-- id:04bb -->
  (b) `cval` c≠0 (`c=Ω²/(2β²)`, energy phase-shifted); (c) `sol` integrand unbalanced paren. AI surfaced,
  did not edit; owner decides each. (docs/rigor-debt.md) **RESOLVED 2026-06-15 (owner-ratified via /relay
  human):** (a) sign correction applied; (b) exact phase-shifted form adopted; (c) one-char paren fix
  applied. Two follow-ups left open (REVIEW_ME): next-`/relay review` instrument re-pin for edot+cval
  (✗→✓, attestations) and the owner-only `cval` c-narrative reconciliation. <!-- id:9135 -->
- [ ] Wishlist: automated subequation dot-numbering — derive `(edot.1)…(edot.4)` handles from a parent handle <!-- id:d2f4 -->
  so per-line tags render; also re-attaches the `[edot]` verify marker to an active `\ltag`. Relates to R2/R3
  (id:445e) + `.mw`. (/meeting 2026-06-15) **OPTION (owner obs 2026-06-18, entropy.md):** don't hand-invent
  per-line subhandles — `\veq{h}` only the lines that need a STABLE/citeable handle and let amsmath's native
  auto-enumeration number the ephemeral steps for free (verified: tagged line shows `(lambertw ∘?)`, untagged
  lines keep `(12)`/`(13)` in BOTH engines; KaTeX `\veq` is `\tag`-only — no `\label` — so it's legal mid-align).
  CAVEAT: auto-numbers are NOT stable (`\eqref`-able) — they renumber on any insertion above; so the division is
  `\veq`=cited/verify-debt, auto-number=visible-step-only.
  (docs/meeting-notes/2026-06-16-0635-relay-aware-commit-hook.md). Split decided: HARD tier (deterministic
  `.mw` DAG) → non-blocking **post-commit hook** writing ephemeral `git notes` on `refs/notes/verify`
  (`pending`→`triaged`→`processed`, never deleted = observe-first logger); SOFT tier (LLM, incl. b7b1
  dangling-symbol) → `/relay review` where Claude Code is the model (no ToS issue). REVIEW_ME stays the
  durable record; `/relay human` owns the `valid|noise` verdict. Coupling kept LOOSE (graceful-degrade,
  never a commit gate). Decomposed into id:8757/d5f9/0e63/211c below + routed findings. <!-- id:d8bf -->
- [x] **(toesnail) [ROUTINE] Sync authoring docs to `\veq{h}\tier` form — DONE** (relay executor ~2026-06-19; ROADMAP id:9fdc `[x]`). Retired the `<!-- verify:tier -->` HTML comment in CONVENTIONS/CLAUDE/ARCHITECTURE/REVIEW_ME. TODO checkbox reconciled 2026-06-21 (/meeting cross-ledger). (docs/meeting-notes/2026-06-18-0729-veq-macro-verify-carrier.md D2-D4) <!-- id:9fdc -->
- [ ] **(forward-flag)** `\veq{}` is the natural vehicle for subequation labelling (`id:d2f4`) and ✓-emoji render variants (`id:445e`); design separately, after the KaTeX pilot (`id:e0b7`). (docs/meeting-notes/2026-06-18-0729-veq-macro-verify-carrier.md) <!-- id:7b2b -->
- [ ] **(render, owner 2026-06-18) inline `\veqs` should HIDE the handle/label and show the tier in PARENTHESES.** <!-- id:9c41 -->
  Currently `\veqs{h}\tier` renders the handle visibly (KaTeX `#1\quad #2`; the residual `id:a138` cosmetic) and
  the badge bare. For inline use (the FHE counts `\veqs{ocount}\leanc` etc.) the owner wants NO label shown and
  the tier badge wrapped in parens, e.g. inline `… 2^{m2^n} (✓?)` not `… ocount ✓?`. Affects both engines
  (`_includes/custom-head.html` MathJax + `.vscode/settings.json` KaTeX) — note KaTeX 2-arg macros must reference
  `#1`, so hiding it may need `\hphantom`/a 1-arg inline variant. Add a `test_mathjax.cjs` assertion.
- [ ] **(render, owner 2026-06-18) COLOR-CODE the tier badges in general.** Give each verification tier a colour <!-- id:b7e5 -->
  (e.g. `\sorry` red, `\sympy`/`\sympyc` amber, `\numeric` blue, `\lean` green, `\sympylean` deep-green) so the
  rigor state is glanceable. Both engines: KaTeX `\htmlClass`/`\color`, MathJax `\color`/CSS class (mind KaTeX
  metric warnings — prefer `\htmlClass` + CSS over raw `\color` where possible). Colour choices = owner. Extends
  the badge family (`\sorry`/`\sympy`/`\numeric`/`\lean`/`\sympylean` + `\<tier>c` open-debt). Relates to R2/R3
  (`id:445e`). Add `test_mathjax.cjs` coverage.
- [ ] **(forward-flag, later) autolabel-suggestion** — tool-suggested equation handles for un-labelled display equations (so `\veq{…}` handles don't have to be hand-invented). Owner flag 2026-06-18: collAIb-side or `.mw`-side? Decide the home. Relates to the `.mw` parser (`id:358f`) + collAIb assist role. <!-- id:7743 -->
- [ ] **(forward-flag, later) notation-implies-annotation sanity checks** — owner 2026-06-18: toesnail uses non-standard "handwavy physics" notation whose OPERATOR carries semantic meaning the verify/annotation layer can leverage as a SANITY CHECK: (a) `:=` directly implies a **definition** (should still get a handle/label — the `:=`↔`\definition`-annotation relationship becomes a cross-check); (b) `\approx` may imply a **Lean-provable `\mathcal{O}(…)`** step; (c) `\dot=` (non-standard) less formally denotes a **linear approximation**; and more as the corpus grows. The tool would infer/verify the expected annotation kind from the operator. Ties to the annotation-kind taxonomy meeting (definition/assumption/… — deferred) and the `.mw` verify engine (`id:358f`). <!-- id:8ddc -->
- [ ] ROADMAP R2/R3 — rendered ✓-emoji on verified equations (hover/tooltip verify status) + a legible <!-- id:445e -->
  in-document annotation syntax to supersede illegible HTML `verify:` comments; **`\veq{}` macro is the designed vehicle** (2026-06-18-0729-veq-macro-verify-carrier.md D3); implement render variants after `id:e0b7` KaTeX pilot + `id:dce9` migration land. (/meeting 2026-06-15, 2026-06-15-2111-resogram-energy-chain-reconciliation.md)
- [ ] **Cross-project (triad):** add the owner's Diplomarbeit `.git` repo — a fully finished LaTeX project — <!-- id:6ab8 -->
  as a **second acceptance/test corpus** for the `.mw`/toesnail/collAIb triad (N=2 beyond toesnail's
  north-star physics docs; exercises `.mw` ingest + verification on real finished LaTeX). **MIRRORED in
  `mathematical-writing/TODO.md` under the same `id:6ab8`** — keep both copies in sync MANUALLY (no automated
  cross-PROJECT sync: relay `--cross-ledger` is intra-repo only, inbox routing is one-way). Wherever it's
  worked/closed, tick the twin. Likely resolved in a manual `/meeting`.
- [ ] **Cross-project (triad) — `/meeting`:** discuss the potentially connecting dots between **zkm <!-- id:4159 -->
  infrastructure** (embeddings / semantic retrieval / knowledge-mgmt) and the `.mw`/toesnail/collAIb triad.
  toesnail is the documented hub (`docs/dependencies.md`); this would extend the dependency map with a zkm
  node. **MIRRORED in `zkm/TODO.md` under the same `id:4159`** — keep both copies in sync MANUALLY; tick the
  twin wherever closed. Likely a manual `/meeting`.
- [ ] **(non-blocker) GitHub file-view doesn't render `\veq`/custom macros** (owner obs 2026-06-18, image). <!-- id:bf21 -->
  GitHub's repo markdown-math preview uses a SANDBOXED MathJax subset that (a) can't see our macros — `\veq`, `\sympy`,
  `\sympyc`, … are defined only in `_includes/custom-head.html` (the published Pages site) + `.vscode/settings.json`
  (editor), NOT loadable into GitHub's renderer; and (b) forbids commands like `\operatorname` ("macro not
  allowed", seen on Resogram's `\operatorname{sign}`). So `.md` files viewed ON github.com render math raw/broken;
  the **published Pages site renders fine** (it loads custom-head.html). Inherent to the source-stays-plain +
  central-macro-def design (we forbid in-doc `\gdef`, which GitHub wouldn't honor anyway). Options to weigh later:
  a README banner pointing readers to the live site for math; a GitHub-compatible macro fallback (hard — no
  per-repo macro config); or swap `\operatorname{…}`→`\mathrm{…}` where owner-content allows. Low priority.
- [ ] **Comment / annotation system for the GH Pages site** (idea salvaged from the archived `gtnsd` repo, <!-- id:d973 -->
  see `gtnsd-archive` branch). Candidates: hypothes.is annotation overlay, staticman, `ghpages-ghcomments`,
  or a Jekyll static-comments recipe. Ties into collAIb's "live `verify:` assist UI" (annotation = surfacing
  rigor-debt in-page) and the `[edot]`-style handles (anchor targets). NB the gtnsd-era worry "how do
  annotations survive content changing over time?" is the inflownistration/staleness problem (`.mw` `id:aae4`).
  Design before wiring; low priority.

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

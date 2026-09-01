# TODO

## Current

- [ ] **[OWNER] TOE roadmap — decide the open questions from the 2026-07-07 evaluation session** <!-- id:57e2 -->
  (`docs/meeting-notes/2026-07-07-1228-toe-roadmap-evaluation.md` §6–7 +
  `…-1240-mw-collaib-toe-needs.md` §Open questions). Ratified already: D1 voice+themes,
  D3 tags→mechanism (routed:91ab/1a68 to `.mw`), D4 audience "everyone" (layered reading),
  D5 love wing = game theory/simulations + essays. Still open: **Q2/D2** Galilei-first vs
  Poincaré-first vs hybrid (both elaborated in note §7); **Q6** status-macro names
  (`\derived`/`\empirical`/`\hypothesis`? — `\input` impossible, TeX primitive; feasibility
  probe PASS 2026-07-07: all 3 free + `\veq{h}\derived\sorry` stacking clean in BOTH engines,
  see 1240 note — pure naming choice now); **Q7** aside
  taxonomy (trivial/prereq/advanced vs numeric levels); **Q8** chapter granularity (one file
  per roadmap step? gates the `.mw` cross-file-DAG question F5). **Extended by the 2026-07-07
  dreaming session** (`…-1257-corpus-dreaming-session.md`): **Q9** ratify an information wing
  (fhe+entropy+Landauer/Shannon)? **Q10** which candidate methodology themes become named
  (compactness⇒discreteness⇒quantization + reversibility-is-sacred recommended)? **Q11** adopt
  the 7-stage love-wing arc (Resogram→Strogatz→Kuramoto→games→Gottman)? **Q12** accept the
  Newton–Wigner non-localizability caution flag on photon.md's Gaussian ansatz? **Planning aid:**
  `…-1318-math-on-demand-curriculum.md` maps per-step NEEDS/defer/corpus — notes the corpus gap at
  step 3 (projective reps/Bargmann, no exercising file), reads as Q1-evidence for the Fock route
  (step 6's ladder ops become a callback), and its per-step "defer" lists are the Q7 aside inventory.
  **Extended by the 2026-07-08 SE-corpus mining + lasercool deep dive**
  (`…-2026-07-08-1056-se-corpus-mining-and-lasercool-deepdive.md`): **Q13/Q14/Q15 RATIFIED
  2026-07-08** (note §5b) — promotion set P-C/P-A/M-1+M-2 (→ id:e552), lasercool anchors adopted,
  `docs/se-corpus.md` seeded. Still open here: **Q16** (external, owner-only) self-answer q/669175 —
  draft ready at `docs/drafts/q669175-answer-draft.md` (owner edits/posts); optionally expert-check the
  "open" claims with Denis Seletskiy first (contact path via Leitenstorfer, note §5c); P-F (VSH under
  Poincaré) still open on two SE sites.
  Owner-only (theory direction); next `/meeting` or owner walk.

- [ ] **[OWNER] Author the promoted SE subjects (Q13, ratified 2026-07-08)** — P-C Casimir→field-equations <!-- id:e552 -->
  (q/27195 as step-5 headline exploration/epigraph), P-A discrete-Noether aside (q/8518, step 4↔1),
  M-1+M-2 generators + matrix-exp/BCH lemmas (step-3/4 gap material); plus the ratified lasercool.md
  section anchors (Q14) **+ the owner's 2026-07-08 closing-thought candidate section "photon-energy
  scaling: laser → LED → maser"** (note §5d: k_BT/hν gain vs the three walls — n̄_th occupation,
  Einstein A∝ν³, Nyquist/mode-count; EL cooling Santhanam 2012 / Zhu 2019 / TPX Oksanen 2020;
  Albanese 2020 spin-ensemble maser-cooling as the existence proof; incl. a SymPy-able candidate
  original mini-result: the COP-optimal hν/k_BT, which the literature apparently never states).
  Physics content = Human-only; the AI's role stays findings/citations
  (`docs/meeting-notes/2026-07-08-1056-…` + `docs/se-corpus.md`). No deadline — owner's pace.

- [ ] [INPUT — meeting] **Lean4-formalize the laser-exhaust entropy bound (owner-declared 2026-07-08)** — prove <!-- id:c9d4 -->
  (im)possibility of stimulated-only cooling honestly decomposed per the tier ladder: (a) `[derivation]`
  single-mode bosonic entropy S(n̄)=(1+n̄)ln(1+n̄)−n̄ln n̄ properties (≥0, per-photon S/n̄→0 as n̄→∞) —
  Mathlib real-analysis, tractable; (b) `[derivation]` the steady-state Clausius balance ⇒ "zero-entropy
  exhaust ⇒ cooling efficiency ≤ ε(n̄)" as an ℝ-inequality against a FROZEN mode-sum model; (c) `[input]`
  NOT provable: that a laser beam is well-modeled as few modes with n̄~10⁸, and the second law itself
  (axioms at this level) — so the Lean result is conditional, and quantitative (bound ~2.7×10⁻⁹, not 0;
  Ruan PRB 75, 214304 Eq. 34 + Mungan JOSA B 20, 1075 flux temperatures are the source inequalities).
  Owner may also pursue a five-level no-reabsorption target design alongside (note: reabsorption is not
  the binding constraint — the quantum-defect/flux-temperature ceiling is; see 2026-07-08-1056 note §3).
  Needs its own scoping /meeting (freeze model + signature, edot_deriv pattern) before any [ROUTINE] slice. (/meeting id:3d2a D1/D3) — `verify/entropy_{be,fd,meanE}.py`, `verify/fhe_stirling.py` (named correction terms + `O(2^{-n})` remainder, NOT eval-at-a-few-n), `verify/entropy_lambertw.py` (algebra l.53–57); `physics/entropy.toml` + `crypto/fhe.toml` sidecars; split the `lambertw` marker per D1 (algebra step→`\sympyc`, closed-form l.59→`\definition`); `tests/test_verify.sh` wiring; on green flip `\sympyc`→`\sympy`. Suite green, one `VERDICT: ✓`/instrument, sidecar non-drift. ~1 executor session → hand off to relay. **NB 2026-07-01 (relay review):** ROADMAP id:7306 covers the four already-placed `\sympyc` instruments only; the `lambertw` algebra instrument + D1 marker split are gated on OWNER marker placement → ROADMAP id:5d31 + REVIEW_ME box (this line's tick does NOT cover them). **NB 2026-07-02 (relay review):** id:7306 hard-split (auto, id:3801) — 3 of 4 instruments SHIPPED as seam id:e9e9 (`entropy_{meanE,be,fd}.py` + `physics/entropy.toml` + badge flips, verified genuine); the `fhe_stirling` seam id:76e5 is GATED on an owner content fix (fhe.md:12 constant term `ln√(2π)` should be `log₂√(2π)` — REVIEW_ME box). (2026-06-21-2129-lean-formalization-strategy.md) <!-- id:7306 -->
- [ ] [HARD] ** Lean claims — queued individually** (/meeting id:3d2a D2) — `ocount` (`Fintype.card_fun`), `bij24` (`Fintype.card_perm`), `semidestr`-count (`Nat.choose`), `semidestr`-identification (balanced⟺semi-destructive, owner modelling), `lambertw`-branch/domain. Each needs its OWN scoping `/meeting` (fidelity-consume + freeze signature, edot_deriv pattern) before `[ROUTINE]`; all stay `\leanc` until then. `verify/Entropy.lean` + `verify/FHE.lean` (mirror resogram_*.py), into `tests/test_lean.sh`. Draft signatures in the meeting note. (2026-06-21-2129-lean-formalization-strategy.md) <!-- id:37cc -->
- [ ] **(forward-flag, cross-project) `.mw`→Lean4 lowering research** (/meeting id:3d2a D4) — can a `.mw` document lower its fragments to Lean4 proof obligations (machine-provable document) vs only tracking external instruments? MIRRORED to `mathematical-writing` inbox (routed:733c); ties `.mw` id:358f. (2026-06-21-2129-lean-formalization-strategy.md) <!-- routed:733c --> <!-- id:4976 -->
- [ ] [INPUT — meeting] (MEETING candidate) Better workflow for math/Lean-formalization design sessions — e.g. meeting-rpg with <!-- id:2f99 -->
  in-session formula rendering (so equation-heavy decisions like id:b9bc's HasDerivAt signature are legible
  during discussion), or possibly a collAIb regime instead. To be scoped in a dedicated /meeting.
- [ ] [ROUTINE] `verify:` pilot candidates in recovered pages — OWNER PICKED 2026-06-16 (/relay human): mark **entropy** BE/FD+Lambert-W (sympy) + **fhe** enumeration/`.ods` (numeric); **wirohsh DEFERRED**. Owner places the markers (physics/crypto content is Human-only); then instrument plumbing is . See REVIEW_ME. **ENTROPY markers PLACED 2026-06-18** (owner-directed, /walk): `physics/entropy.md` carries `\veq{meanE}\sympyc` (E/E₁ closed-form chain l.22), `\veq{be}\sympyc` (Bose–Einstein N→∞ limit l.27), `\veq{fd}\sympyc` (Fermi–Dirac N=2 l.35), `\veq{lambertw}\sympyc` (Lambert-W inversion l.59) — all `\sympyc` = OPEN-DEBT (desired SymPy, not yet verified, id:feb8). NEXT [ROUTINE]: build `verify/entropy_{be,fd,meanE,lambertw}.py` + `physics/entropy.toml` sidecar + wire into `test_verify.sh`; on green swap `\sympyc`→`\sympy`. `lambertw` ESCALATED `\sympyc`→`\leanc` [HARD] 2026-06-18 (owner-ratified): SymPy CONFIRMED can't close the transcendental inversion (probe; ==y False both ∓ branches), numeric is counter-indicator-only not an assurance tier → faithful tier is Lean. NEEDS a scoping `/meeting` (Mathlib Lambert-W capability-gap risk + frozen signature + DoD) — like edot_deriv. So entropy splits: be/fd/meanE = `\sympyc` [ROUTINE] instruments; lambertw = `\leanc` [HARD]. **FHE markers PLACED + RESHAPED 2026-06-18** (owner ratified): owner rejected AI display-carriers → marked counts INLINE with `\veqs`, and re-tiered combinatorial counts to Lean (`\definition` is a bad downgrade; sympy-can't⇒Lean). `crypto/fhe.md`: `\veq{stirling}\sympyc` (l.12 display, [ROUTINE]), `\veqs{ocount}\leanc` (l.8 inline, Fintype.card_pi), `\veqs{semidestr}\leanc` (l.67 inline, Nat.choose), `\veqs{bij24}\leanc` (l.74 inline, Fintype.card_perm). The 3 `\leanc` counts are Mathlib-tractable → Lean meeting `id:3d2a` for sizing; stirling = lone [ROUTINE] sympy instrument. Entropy fidelity RATIFIED (owner); lambertw also `\leanc`→`id:3d2a`. <!-- id:8807 -->
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
- [ ] [INPUT — meeting] Wishlist: automated subequation dot-numbering — derive `(edot.1)…(edot.4)` handles from a parent handle <!-- id:d2f4 -->
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
- [ ] **(forward-flag)** `\veq{}` is the natural vehicle for subequation labelling (`id:d2f4`) and ✓-emoji render variants (`id:445e`); design separately, after the KaTeX pilot (`id:e0b7`). (docs/meeting-notes/2026-06-18-0729-veq-macro-verify-carrier.md) <!-- id:7b2b -->
- [ ] **(forward-flag, later) autolabel-suggestion** — tool-suggested equation handles for un-labelled display equations (so `\veq{…}` handles don't have to be hand-invented). Owner flag 2026-06-18: collAIb-side or `.mw`-side? Decide the home. Relates to the `.mw` parser (`id:358f`) + collAIb assist role. <!-- id:7743 -->
- [ ] **(forward-flag, later) notation-implies-annotation sanity checks** — owner 2026-06-18: toesnail uses non-standard "handwavy physics" notation whose OPERATOR carries semantic meaning the verify/annotation layer can leverage as a SANITY CHECK: (a) `:=` directly implies a **definition** (should still get a handle/label — the `:=`↔`\definition`-annotation relationship becomes a cross-check); (b) `\approx` may imply a **Lean-provable `\mathcal{O}(…)`** step; (c) `\dot=` (non-standard) less formally denotes a **linear approximation**; and more as the corpus grows. The tool would infer/verify the expected annotation kind from the operator. Ties to the annotation-kind taxonomy meeting (definition/assumption/… — deferred) and the `.mw` verify engine (`id:358f`). <!-- id:8ddc -->
- [ ] ROADMAP R2/R3 — rendered ✓-emoji on verified equations (hover/tooltip verify status) + a legible <!-- id:445e -->
  in-document annotation syntax to supersede illegible HTML `verify:` comments; **`\veq{}` macro is the designed vehicle** (2026-06-18-0729-veq-macro-verify-carrier.md D3); implement render variants after `id:e0b7` KaTeX pilot + `id:dce9` migration land. (/meeting 2026-06-15, 2026-06-15-2111-resogram-energy-chain-reconciliation.md)
- [ ] [INPUT — meeting] **Cross-project (triad):** add the owner's Diplomarbeit `.git` repo — a fully finished LaTeX project — <!-- id:6ab8 -->
  as a **second acceptance/test corpus** for the `.mw`/toesnail/collAIb triad (N=2 beyond toesnail's
  north-star physics docs; exercises `.mw` ingest + verification on real finished LaTeX). **MIRRORED in
  `mathematical-writing/TODO.md` under the same `id:6ab8`** — keep both copies in sync MANUALLY (no automated
  cross-PROJECT sync: relay `--cross-ledger` is intra-repo only, inbox routing is one-way). Wherever it's
  worked/closed, tick the twin. Likely resolved in a manual `/meeting`.
- [ ] [INPUT — meeting] **Cross-project (triad) — `/meeting`:** discuss the potentially connecting dots between **zkm <!-- id:4159 -->
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
- [ ] [INPUT — meeting] **Comment / annotation system for the GH Pages site** (idea salvaged from the archived `gtnsd` repo, <!-- id:d973 -->
  see `gtnsd-archive` branch). Candidates: hypothes.is annotation overlay, staticman, `ghpages-ghcomments`,
  or a Jekyll static-comments recipe. Ties into collAIb's "live `verify:` assist UI" (annotation = surfacing
  rigor-debt in-page) and the `[edot]`-style handles (anchor targets). NB the gtnsd-era worry "how do
  annotations survive content changing over time?" is the inflownistration/staleness problem (`.mw` `id:aae4`).
  Design before wiring; low priority.

- [ ] [INPUT — meeting] [INBOUND routed:b0c5 from loderite] Investigate the T-matrix (EM-scattering) ↔ Gaussian-splat ↔ WiRoHSH (Wick-rotated hyper-spherical harmonics) relationship — can a precomputed per-geometry response basis (T-matrix analogy) represent Gaussian splats compactly via WiRoHSH? loderite may become a showcase if applicable. <!-- id:ff32 -->
  **NB 2026-07-16 (relay review, reverse-handoff §5b):** qualified `[INPUT — meeting]`; NOT executor work and
  deliberately NOT promoted to ROADMAP. This is an open *physics-direction* research question — it names no
  concrete change with an observable done-state, and this repo's hard constraint reserves theory direction to the
  owner (`CLAUDE.md`: the AI never invents physics or decides narrative direction). Needs an owner scoping
  `/meeting` to rule on whether the T-matrix↔splat↔WiRoHSH correspondence is real and what (if anything) toesnail
  should author; only a tooling slice falling out of that ruling could later become `[ROUTINE]`. Existing surface:
  `physics/wirohsh.md`.

- [ ] [INBOUND routed:59e7 from mathematical-writing] ESSAY CANDIDATE (owner-authored, flagged not auto-written — narrative is the owner's domain per the working contract; same terms as mathematical-writing id:aae4's gtnsd essay flag): adapt the "Bloch Truth" material into an essays/ piece. **BLOCKED on routed:c196** — the 2026-07-17 .mw meeting found no thesis statement exists in 412 session files, and an essay cannot be written on a non-thesis. Origin quote: knowledge/sessions/claude-ai/2025-08-05_breaking_project_paralysis_cbae6cd6.md:1334 — "the Bloch Truth (might need a better name) might be useful for the AI logic core in the second (ZFC?) layer where incompleteness applies (core layer should only be complete, e.g. ZF without C)". <!-- id:4bb2 -->
- [ ] [INBOUND routed:a9bd from mathematical-writing] Lean contract for id:37cc DECIDED (not yet executing): mw ROUTES author-written Lean, never generates it — the claim goes in a `verification` fragment tagged `{@lean}` (existing brace-attribute syntax, NO new grammar), returning a 3-state result (proven/pending/failed) + backend tag; your 37cc claims can flow through this instead of raw `verify/*.lean`. NOTE `pending` at the Backend.discharge layer means ONLY an unfilled `sorry` (in-flight never materializes as a result) — the 'same UI state as in-flight' equivalence is editor-badge semantics, not API semantics. AUDIT FINDING: mw's Lean fragment type and both backends ALREADY EXIST (`backends.py:139`, lean_backend.py, lean_lsp.py); the gap was pure wiring, so no separate Lean design meeting is needed on your side. Also relevant to 37cc's per-claim scopings: mw ratified that prose NEVER carries a tier (a verified claim needs a formal display block) and carved statement-correspondence checking as mw id:15b0 — nothing yet verifies a Lean theorem still states its displayed claim after an equation edit. Not a buildable dependency until mw id:67ea discharges a real theorem end-to-end. <!-- id:7a42 -->
- [ ] [INBOUND routed:5f53 from project_manager /meeting 2026-08-20] Record near TODO.md:123 that the `gtnsd-archive` orphan branch is MIRRORED into `~/src/inflownistration` (whole-branch history import, 21 commits, root c9147ce 2017-12-28, tip 353972e) and that **toesnail's copy stays the CANONICAL PUBLIC record** — this repo has a public GitHub remote, the new one is fievel-only, so pruning gtnsd-archive here on the grounds that 'it lives in inflownistration now' would delete the only public record of the 2017 coinage. No new privacy exposure either way (the content is already public); this is purely a do-not-prune guard. <!-- id:7f2f -->
- [ ] [INBOUND routed:4f85 from mathematical-writing id:de24] Re-derive verify/'s Lean pin from lodelore's already-built Mathlib instead of rebuilding — the lean-toolchain-pin-policy D2 escape has fired (it says the fleet follows in one bump once Mathlib reaches a stable Lean release; lodelore is on stable v4.32.2 while toesnail/verify, mathematical-writing and relay-core sit on the release-candidate v4.30.0-rc2). DO NOT hand-write a version string — D1 forbids authored pins; the value is a function of the vendored Mathlib rev. Procedure: cp --reflink=auto from ~/src/lodelore/lean/.lake (verified 2026-08-22: complete package set incl. mathlib/batteries/aesop/Qq/proofwidgets, 12 GB, and lodelore + toesnail + mw are all on the SAME btrfs device /dev/nvme0n1p2, so extents are genuinely shared — near-instant, ~zero disk), then read the toolchain out of the copied tree, exactly as mathematical-writing's tests/lean_fixture/setup-fixture.sh:85 already does. Mathlib oleans are a pure function of (toolchain, mathlib rev) so they are reusable across projects — NO Mathlib rebuild is needed. The only thing that genuinely compiles is toesnail's OWN verify/ proof layer against the newer Mathlib, and that is also the only place proofs can break, so this item carries the real risk of the fleet bump. Own-pace: land when convenient, but land on the DERIVED value, not a copied literal, or the fleet re-diverges. <!-- id:4b04 -->
- [ ] [INBOUND routed:710d from mathematical-writing] SUPERSEDES routed:4f85 (its instruction to re-derive from lodelore's Mathlib is WITHDRAWN). Meeting 2026-08-22-1402 retired the bump-together cadence entirely (amends mathematical-writing docs/lean-toolchain-policy.md D2, whose justification 'toesnail pays the ~7 GB Mathlib build cost' no longer holds). You are NOT required to align to v4.32.2 and NOT required to re-derive from anyone. New disposition: toesnail bumps its Mathlib rev whenever it wants, independently; a new tool repo 'leancow' owns CoW reflinking and owns the derivation for treeless repos, so mathematical-writing no longer derives its fixture from toesnail's tree. Action for you: none urgent — adopt leancow's wrapper once it ships (it makes a second consumer on your rev cost ~0 extra disk instead of ~11 GB). Note the index keys on the Mathlib rev from lake-manifest.json, NOT the toolchain string. <!-- id:2479 -->
- [ ] **[OWNER] Triage the dreamed exploration batch** (`docs/dreamed/`, 32 essays + 33 Lean files + 1 runnable library, 2026-09-01) <!-- id:2460 -->
  AI-generated, owner-seeded, UNREVIEWED. Index with per-essay headline claims:
  `docs/dreamed/README.md`. Every Lean file re-verified by the coordinator (exit 0, zero `sorry`,
  461 theorems); `bash tests/run.sh` still PASSes; the tree sits outside the lake targets so
  `make test` is unaffected. **FILED 2026-09-01 on the owner's instruction** -- the findings now
  live in their proper ledgers, listed below, and this line is the index rather than the content.
  **No recommendation was ratified**; a delegated agent's verdict is never self-settling.
  - **Owner decisions** -> `REVIEW_ME.md` (id:8e64): ten located findings in owner content
    (`wirohsh.md:82` smooth-vs-analytic; `toesnail.md:79`/`:89` ordering clash; `toesnail.md:105`
    real-vs-complex Cauchy-Schwarz; `toesnail.md:59` `t1` probabilities-as-amplitudes;
    `entropy.md:59` lambertw branch id:8777; `Resogram.md:118` ebar sign id:93f5; `acoustics.md`
    unstated adiabatic assumption; `Narrativium.md` Ian Stewart; `wirohsh.md` seven notation snags;
    `photon.md` ansatz + covariance id:25a0), plus ten recommendations awaiting ratification
    (id:ff32 NO-GO on five grounds now, Q2/Q6/Q7/Q8/Q9/Q10/Q11/Q12, the five-level laser NO-GO,
    closing collAIb's assist role, and the Wien-4 candidate result).
  - **Tooling** -> `ROADMAP.md`: id:ac7b (the verify hook runs a constant probe and never reads the
    commit diff; 164 notes, all pending, one findings string), id:17ee (`se-corpus.md` rows M-1 and
    P-C misattributed), id:3381 (`dependencies.md` missing the dotclaude-skills node).
  - **Cross-repo** -> shared inbox: routed:e7cc (helferli/zelegator have NO shared contract artifact
    while id:29e3 is due at the 2026-09-10 demo gate -- time-critical), routed:c9c1 (zelegator's
    eval set is saturated and cannot score a distilled student), routed:c050 (loderite
    ARCHITECTURE.md:76 greedy-meshing claim is void), routed:537e (a .mw DAG catches propagation
    but not origination; differential testing recommended for fidelity).
  Deciding what (if anything) to promote from `docs/dreamed/` into `physics/` or `essays/` remains
  owner-only theory direction. Nothing there was promoted, and no physics file was edited.
  AI-generated, owner-seeded, UNREVIEWED. Nothing was filed into any ledger by design --
  a delegated agent's verdict is a recommendation, never self-settling -- so this item exists
  only so the batch is not invisible. **No verdict below is ratified.** Index with per-essay
  headline claims: `docs/dreamed/README.md`. Every Lean file re-verified by the coordinator
  (exit 0, zero `sorry`); `bash tests/run.sh` still PASSes; the tree is outside the lake
  targets so `make test` is unaffected.
  **Located findings in OWNER content, awaiting his ruling:** (a) `physics/wirohsh.md:82`
  "in smooth regions those are perfectly sufficient" is false -- the line is analytic vs
  non-analytic; (b) `physics/toesnail.md:79` vs `:89` (complex numbers declared unorderable,
  then `<Psi|Psi> > 0` written for one); (c) `physics/toesnail.md:105` Cauchy-Schwarz equality
  case is the real-space one, over C it is the unit circle; (d) `physics/toesnail.md:59` `t1`
  uses probabilities as coefficients, so it can arise from a unitary only if p is 0 or 1;
  (e) `physics/entropy.md:59` lambertw needs the `W_{-1}` branch (relates `id:37cc`/`id:5d31`);
  (f) `physics/Resogram.md:118` prints `e^{+2*beta*t'}` where the opposite sign cancels every
  ripple term (a reading exists on which the printed form is right -- his call);
  (g) `physics/acoustics.md` never states its adiabatic assumption and never derives the wave
  equation; its permalink is spelled `Accoustics`; (h) `essays/Narrativium.md:18,22` spell Ian
  Stewart as "I. Steward"; (i) four notation snags in `physics/wirohsh.md` (L58, L88, L97, L154).
  **Located findings in TOOLING/ledgers:** (j) `hooks/post-commit` runs a CONSTANT probe and
  never reads the commit diff -- 164 notes on `refs/notes/verify`, all `status:pending`, 0
  triaged, 0 processed, one distinct findings string; (k) `docs/se-corpus.md` row M-1 mislabels
  its posts (337971 is the curl-generalization question, not the self-answered dilation) and row
  P-C is wrong about q/27195's mechanism (variational, not an eigenvalue equation);
  (l) `docs/dependencies.md` has no `dotclaude-skills` node.
  **Recommendations awaiting ratification:** NO-GO on `id:ff32` (five independent breaks now);
  Q2 hybrid C1; Q9 ratify-with-membership-corrected; Q10 theme ranking; Q11 adopt-with-three-
  amendments; Q12 a one-line epistemic aside; Q6 extend the existing kinds; the five-level laser
  NO-GO at theorem strength; and closing collAIb's "live verify: assist UI" edge as not-taken.
  **Cross-repo, time-critical:** no shared zelegator/helferli contract artifact exists while
  `helferli id:29e3` is due at the 2026-09-10 demo gate (see `docs/dreamed/zelegator-helferli.md`).
  Deciding what (if anything) to promote is owner-only theory direction.
  AI-generated, owner-seeded, UNREVIEWED. Nothing from it was filed into any ledger by design --
  a delegated agent's verdict is a recommendation, never self-settling -- so this item exists only
  so the batch is not invisible. **No verdict below is ratified.** Awaiting the owner's ruling:
  (a) the recommended NO-GO on ROADMAP `id:ff32` (T-matrix / Gaussian-splat / WiRoHSH), with one
  gated salvage; (b) a branch qualifier on the `lambertw` step at `physics/entropy.md:59` (claimed
  correct only on `W_{-1}` in the bosonic case; principal branch gives `beta*E_1 = 0` identically)
  -- relates to `id:37cc`/`id:5d31`; (c) an ordering clash located at `physics/toesnail.md:79` vs
  `:89` (complex numbers declared unorderable, then `<Psi|Psi> > 0` written for one); (d) the
  real-vs-complex Cauchy-Schwarz equality case at `physics/toesnail.md:105` ("parallel or
  anti-parallel" is the real condition; over C it is the whole unit circle); (e) four notation
  snags in `physics/wirohsh.md` (L58, L88, L97, L154) plus the completed 3D reduction; (f) a
  critique of `docs/drafts/q669175-answer-draft.md` (relates to Q16 in `id:57e2`); (g) whether
  corpus row M-5's welding of Goedel and Lawvere into one line should be split. Index with
  per-essay headline claims: `docs/dreamed/README.md`. Each essay has a "Surfaced for the owner"
  section. Deciding what (if anything) to promote is owner-only theory direction.
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

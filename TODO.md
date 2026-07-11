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

- [ ] [HARD — meeting] **Lean4-formalize the laser-exhaust entropy bound (owner-declared 2026-07-08)** — prove <!-- id:c9d4 -->
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
- [ ] **[HARD] Lean claims — queued individually** (/meeting id:3d2a D2) — `ocount` (`Fintype.card_fun`), `bij24` (`Fintype.card_perm`), `semidestr`-count (`Nat.choose`), `semidestr`-identification (balanced⟺semi-destructive, owner modelling), `lambertw`-branch/domain. Each needs its OWN scoping `/meeting` (fidelity-consume + freeze signature, edot_deriv pattern) before `[ROUTINE]`; all stay `\leanc` until then. `verify/Entropy.lean` + `verify/FHE.lean` (mirror resogram_*.py), into `tests/test_lean.sh`. Draft signatures in the meeting note. (2026-06-21-2129-lean-formalization-strategy.md) <!-- id:37cc -->
- [ ] **(forward-flag, cross-project) `.mw`→Lean4 lowering research** (/meeting id:3d2a D4) — can a `.mw` document lower its fragments to Lean4 proof obligations (machine-provable document) vs only tracking external instruments? MIRRORED to `mathematical-writing` inbox (routed:733c); ties `.mw` id:358f. (2026-06-21-2129-lean-formalization-strategy.md) <!-- routed:733c --> <!-- id:4976 -->
- [ ] [HARD — meeting] (MEETING candidate) Better workflow for math/Lean-formalization design sessions — e.g. meeting-rpg with <!-- id:2f99 -->
  in-session formula rendering (so equation-heavy decisions like id:b9bc's HasDerivAt signature are legible
  during discussion), or possibly a collAIb regime instead. To be scoped in a dedicated /meeting.
- [ ] `verify:` pilot candidates in recovered pages — OWNER PICKED 2026-06-16 (/relay human): mark **entropy** BE/FD+Lambert-W (sympy) + **fhe** enumeration/`.ods` (numeric); **wirohsh DEFERRED**. Owner places the markers (physics/crypto content is Human-only); then instrument plumbing is [ROUTINE]. See REVIEW_ME. **ENTROPY markers PLACED 2026-06-18** (owner-directed, /walk): `physics/entropy.md` carries `\veq{meanE}\sympyc` (E/E₁ closed-form chain l.22), `\veq{be}\sympyc` (Bose–Einstein N→∞ limit l.27), `\veq{fd}\sympyc` (Fermi–Dirac N=2 l.35), `\veq{lambertw}\sympyc` (Lambert-W inversion l.59) — all `\sympyc` = OPEN-DEBT (desired SymPy, not yet verified, id:feb8). NEXT [ROUTINE]: build `verify/entropy_{be,fd,meanE,lambertw}.py` + `physics/entropy.toml` sidecar + wire into `test_verify.sh`; on green swap `\sympyc`→`\sympy`. `lambertw` ESCALATED `\sympyc`→`\leanc` [HARD] 2026-06-18 (owner-ratified): SymPy CONFIRMED can't close the transcendental inversion (probe; ==y False both ∓ branches), numeric is counter-indicator-only not an assurance tier → faithful tier is Lean. NEEDS a scoping `/meeting` (Mathlib Lambert-W capability-gap risk + frozen signature + DoD) — like edot_deriv. So entropy splits: be/fd/meanE = `\sympyc` [ROUTINE] instruments; lambertw = `\leanc` [HARD]. **FHE markers PLACED + RESHAPED 2026-06-18** (owner ratified): owner rejected AI display-carriers → marked counts INLINE with `\veqs`, and re-tiered combinatorial counts to Lean (`\definition` is a bad downgrade; sympy-can't⇒Lean). `crypto/fhe.md`: `\veq{stirling}\sympyc` (l.12 display, [ROUTINE]), `\veqs{ocount}\leanc` (l.8 inline, Fintype.card_pi), `\veqs{semidestr}\leanc` (l.67 inline, Nat.choose), `\veqs{bij24}\leanc` (l.74 inline, Fintype.card_perm). The 3 `\leanc` counts are Mathlib-tractable → Lean meeting `id:3d2a` for sizing; stirling = lone [ROUTINE] sympy instrument. Entropy fidelity RATIFIED (owner); lambertw also `\leanc`→`id:3d2a`. <!-- id:8807 -->
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
- [ ] [HARD — meeting] Wishlist: automated subequation dot-numbering — derive `(edot.1)…(edot.4)` handles from a parent handle <!-- id:d2f4 -->
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
- [ ] [HARD — pool] **(render, owner 2026-06-18) COLOR-CODE the tier badges in general.** Give each verification tier a colour *(author-then-run: pool proposes 2-3 accessibility-checked palette options + preview render; owner ratifies the pick)* <!-- id:b7e5 -->
  (e.g. `\sorry` red, `\sympy`/`\sympyc` amber, `\numeric` blue, `\lean` green, `\sympylean` deep-green) so the
  rigor state is glanceable. Both engines: KaTeX `\htmlClass`/`\color`, MathJax `\color`/CSS class (mind KaTeX
  metric warnings — prefer `\htmlClass` + CSS over raw `\color` where possible). Colour choices = owner. Extends
  the badge family (`\sorry`/`\sympy`/`\numeric`/`\lean`/`\sympylean` + `\<tier>c` open-debt). Relates to R2/R3
  (`id:445e`). Add `test_mathjax.cjs` coverage. **PROMOTED to ROADMAP 2026-07-02 review** (same id;
  AUTHOR half only — palette options + previews → REVIEW_ME owner pick; the run half stays gated on the pick).
- [ ] **(forward-flag, later) autolabel-suggestion** — tool-suggested equation handles for un-labelled display equations (so `\veq{…}` handles don't have to be hand-invented). Owner flag 2026-06-18: collAIb-side or `.mw`-side? Decide the home. Relates to the `.mw` parser (`id:358f`) + collAIb assist role. <!-- id:7743 -->
- [ ] **(forward-flag, later) notation-implies-annotation sanity checks** — owner 2026-06-18: toesnail uses non-standard "handwavy physics" notation whose OPERATOR carries semantic meaning the verify/annotation layer can leverage as a SANITY CHECK: (a) `:=` directly implies a **definition** (should still get a handle/label — the `:=`↔`\definition`-annotation relationship becomes a cross-check); (b) `\approx` may imply a **Lean-provable `\mathcal{O}(…)`** step; (c) `\dot=` (non-standard) less formally denotes a **linear approximation**; and more as the corpus grows. The tool would infer/verify the expected annotation kind from the operator. Ties to the annotation-kind taxonomy meeting (definition/assumption/… — deferred) and the `.mw` verify engine (`id:358f`). <!-- id:8ddc -->
- [ ] ROADMAP R2/R3 — rendered ✓-emoji on verified equations (hover/tooltip verify status) + a legible <!-- id:445e -->
  in-document annotation syntax to supersede illegible HTML `verify:` comments; **`\veq{}` macro is the designed vehicle** (2026-06-18-0729-veq-macro-verify-carrier.md D3); implement render variants after `id:e0b7` KaTeX pilot + `id:dce9` migration land. (/meeting 2026-06-15, 2026-06-15-2111-resogram-energy-chain-reconciliation.md)
- [ ] [HARD — meeting] **Cross-project (triad):** add the owner's Diplomarbeit `.git` repo — a fully finished LaTeX project — <!-- id:6ab8 -->
  as a **second acceptance/test corpus** for the `.mw`/toesnail/collAIb triad (N=2 beyond toesnail's
  north-star physics docs; exercises `.mw` ingest + verification on real finished LaTeX). **MIRRORED in
  `mathematical-writing/TODO.md` under the same `id:6ab8`** — keep both copies in sync MANUALLY (no automated
  cross-PROJECT sync: relay `--cross-ledger` is intra-repo only, inbox routing is one-way). Wherever it's
  worked/closed, tick the twin. Likely resolved in a manual `/meeting`.
- [ ] [HARD — meeting] **Cross-project (triad) — `/meeting`:** discuss the potentially connecting dots between **zkm <!-- id:4159 -->
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
- [ ] [HARD — meeting] **Comment / annotation system for the GH Pages site** (idea salvaged from the archived `gtnsd` repo, <!-- id:d973 -->
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

# Human review queue <!-- budget: 15 min -->

Judgment calls for the owner — **theory decisions the AI surfaced but must never make.**
A ticked box = "owner confirms this interpretation/correction"; to correct one, edit the
cited source (or leave a note under the item) and the next review re-derives. Resolved via
`/relay human` or `/meeting`. Max ~10 open boxes.

> These are owner-ratified by design (the no-AI-vibe-thinking-the-theory constraint). A
> `.mw`/collAIb tool may later *pre-fill a suggested fix* for a sufficiently-clear item,
> but a human still accepts it — the suggestion is a draft, not a merge.

## Resogram verify-pilot — located discrepancies (collectively TODO `id:9135`)

- [x] `verify/resogram_edot.py` (handle `edot`, `docs/rigor-debt.md`) — **located algebra
  discrepancy.** The doc's 2nd equality `ė = −4βe − ω²(2βx² − ẋy)` is wrong (off by
  `−4βω²x²`); SymPy confirms the correct closed form is `ė = −4βe + ω²(2βx² + ẋy)` (sign on
  the ω²-bracket). **Owner:** confirm the correction (then fix `physics/Resogram.md`) or
  re-derive. AI will not edit the math.
  **RESOLVED 2026-06-15 (owner-ratified, /relay human):** owner confirmed the sign correction;
  source `edot` block now reads `−4βe + ω²(2βx² + ẋy)`. Re-check: `git show` on `physics/Resogram.md`
  handle `edot`; `verify/resogram_edot.py` derives this end-to-end. **Instrument re-pinned 2026-06-15
  (/relay review):** `resogram_edot.py` verdict ✗→✓, `test_verify.sh` pins edot=✓, `verified:sympy [edot]
  claim=b575864e by=resogram_edot.py@54710d91` attestation added.
- [x] `verify/resogram_cval.py` (handle `cval`) — **"is c=0?" answered: c ≠ 0.** The free
  oscillator's energy is phase-shifted: `e = (A²ω/2)e^{−2βt}(ω + β cos(2(Ωt+φ) − δ))`,
  `δ=atan2(Ω,β)`; the stated `(c+cos²(Ωt+φ))e^{−2βt}` form omits a `sin(2θ)` term, and
  forcing a cos(2θ) match gives `c = Ω²/(2β²) ≠ 0`. **Owner:** confirm the finding and the
  preferred framing (keep the approximate form with a note, or adopt the exact one).
  **RESOLVED 2026-06-15 (owner-ratified, /relay human): ADOPT THE EXACT FORM.** Source `cval`
  equation now states `e = (A²ω/2)e^{−2βt}(ω + β cos(2(Ωt+φ)−δ))`, `δ=atan2(Ω,β)`. Re-check:
  `physics/Resogram.md` handle `cval`; `verify/resogram_cval.py` derives this exact form.
  **Instrument re-pinned 2026-06-15 (/relay review):** `resogram_cval.py` verdict ✗→✓, `test_verify.sh`
  pins cval=✓, `verified:numeric [cval] claim=18d3f7a7 by=resogram_cval.py@a64cfdc0` attestation added.
  **ONE follow-up STILL OPEN (box below):** the surrounding c-narrative reconciliation (owner-only prose).
- [x] `physics/Resogram.md` (handle `sol`) — **integrand typo.** The rendered solution has
  an unbalanced paren `\sin(\Omega (t-t')e^{-\beta(t-t')}` (missing `)` after `(t-t')`); the
  SymPy-verified kernel is `sin(Ω(t−t'))·e^{−β(t−t')}`. **Owner:** confirm the one-char fix.
  **RESOLVED 2026-06-15 (owner-ratified, /relay human):** one-char fix applied; integrand now reads
  `\sin(\Omega (t-t'))e^{-\beta(t-t')}`. Pure render fix — no verdict/instrument change (sol stays ✓).

## Resogram energy-method chain — located discrepancies (`/meeting` 2026-06-15)

> The c-narrative reconciliation (routed here via `/relay human`) opened into a small **cluster**: the
> `edot` sign fix propagates through the energy-method section, and a late-night averaging window looks
> suspect. Per the owner's call (`/meeting` 2026-06-15) each discrepancy was **flagged in place** with a
> visible `🚧 located rigor-debt` callout in `physics/Resogram.md`. **AI flags only — the owner authors
> every physics/prose fix (the vibe-veto holds).** Canonical `.mw` motivating example.
>
> **Owner resolved the cluster in-document (commit `236fa1b` "re: resogram", reconciled here 2026-06-15):**
> responses given as inline `**re**` notes against the callouts; boxes ticked below from those edits. Ticks
> are CLAIMs the next `/relay review` re-derives. **Two NEW items spun out of the owner's edits** (render
> regression + subequation numbering — see bottom).

- [x] `verify/resogram_cval.py` → `resogram_esol.py`, handle `cval`→`esol` — **rename DONE (`/meeting` 2026-06-15).**
  The old `cval` ("find the constant c") name was answered and obsolete; `esol` = the analytical energy
  SOLUTION. Mechanical sweep across `\ltag`, the `[esol]` verify/verified markers, the instrument file,
  `test_verify.sh`, and `verify/README.md`; attestation re-pinned `by=resogram_esol.py@e6722a73`
  (claim hash unchanged `18d3f7a7`). `tests/test_verify.sh` green (5✓/0✗, esol pinned ✓). <!-- id:adfc -->

- [x] `physics/Resogram.md` (¶ before `ymaint`) — **energy-loss claim — RESOLVED by owner (`236fa1b`).** The
  ¶ now reads "it would be clear **from (edot.3)** that a free oscillator … would permanently loose energy",
  citing the manifestly-≤0 first form `ė = −2βẋ²`. Owner `**re**`: "okay, explicitly mentioned (edot.3)".
  ⚠️ The `(edot.3)` reference depends on the subequation tags that don't yet render — see id:3b4c / id:d2f4. <!-- id:559c -->

- [x] `physics/Resogram.md` (handles `ymaint`/`yfree`) — **terse derivation — ACKNOWLEDGED by owner (`236fa1b`).**
  Owner `**re** same`: accepted as an exposition gap (results machine-verified ✓ by `resogram_drive.py`,
  unaffected by the `edot` sign fix). Fuller step-by-step exposition is deferred to the subequation
  auto-numbering wishlist (id:d2f4). <!-- id:0cb5 -->

- [x] `physics/Resogram.md` (`esol` prose) — **c-narrative — RESOLVED by owner (`236fa1b`).** The dangling
  "I'm too lazy to check whether $c=0$, doesn't matter anyway" sentence was removed (now just "This hints at
  a sensible sliding average:"); the pre-solution handwaving ¶ ($-2\beta e$ averaging) was kept as framed.
  Successor to id:9135; summary id:e27e. <!-- id:f9fe -->

- [x] `physics/Resogram.md` (sliding average $\bar e$) — **window — RESOLVED by owner (`236fa1b`).** Corrected
  from $2\Omega\int_0^{1/2\Omega}$ to $\frac{\Omega}{\pi}\int_0^{\pi/\Omega}$ — a proper full-period average
  over the `β cos` term's period $\pi/\Omega$. The late-night `1/(2Ω)` (blame: `0249a41` 2021-01-31 00:56)
  is fixed. <!-- id:3999 -->

## Spun out of the owner's `236fa1b` edits (tooling / render — AI-eligible)

- [x] `physics/Resogram.md` energy block — **render regression — FIXED (owner-confirmed, 2026-06-15).** The
  `\ltag{e}`-inside-`aligned` → MathJax `merror` was un-broken by splitting into two `$$` blocks (`e` tagged
  `\ltag{e}`; the ė-chain `aligned` tagged `\ltag{edot}` on the outer block). No math changed. `tests/run.sh`
  green again (MathJax + KaTeX both render); CI green on the fix commit. Owner picked the split over an
  interim single tag. <!-- id:3b4c -->

- [ ] **Wishlist: automated subequation dot-numbering** — derive `(edot.1)…(edot.4)` handles from a parent
  handle so per-line tags render (amsmath `subequations`/`align` style), letting the owner cite individual
  derivation steps. The owner currently has them commented out (`%\ltag{edot.N}`). Nice-to-have (owner, sugar):
  re-align the `=` signs of `(e)` and `(edot)` across the now-split blocks — the two-`$$` split (render fix
  id:3b4c) aligns each block independently; owner notes `.mw` may make this moot. (Handle drift is RESOLVED by
  the split: `\ltag{e}` on the energy block, `\ltag{edot}` on the ė-chain's outer block re-attaches the
  `[edot]` marker.) Relates to ROADMAP R2/R3 (id:445e) and `.mw`. <!-- id:d2f4 -->

## Visual / manual (run these — never auto-ticked)

- [ ] `@manual` Walk `tests/HUMAN-integration.md` (TODO `id:6501`): equations render in a
  real browser + VS Code preview applies `.vscode/settings.json`. Render *correctness* is
  machine-checked (`test_mathjax.cjs`); this is the visual/editor-integration last mile.

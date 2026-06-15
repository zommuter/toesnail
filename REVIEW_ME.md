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
> suspect. Per the owner's call (`/meeting` 2026-06-15) each discrepancy is now **flagged in place** with a
> visible `🚧 located rigor-debt` callout in `physics/Resogram.md` until the owner fixes it. **AI flags
> only — the owner authors every physics/prose fix (the vibe-veto holds).** This is the canonical `.mw`
> motivating example: a single sign correction with no consistency-checker to catch the fallout.

- [x] `verify/resogram_cval.py` → `resogram_esol.py`, handle `cval`→`esol` — **rename DONE (`/meeting` 2026-06-15).**
  The old `cval` ("find the constant c") name was answered and obsolete; `esol` = the analytical energy
  SOLUTION. Mechanical sweep across `\ltag`, the `[esol]` verify/verified markers, the instrument file,
  `test_verify.sh`, and `verify/README.md`; attestation re-pinned `by=resogram_esol.py@e6722a73`
  (claim hash unchanged `18d3f7a7`). `tests/test_verify.sh` green (5✓/0✗, esol pinned ✓). <!-- id:adfc -->

- [ ] `physics/Resogram.md` (¶ before `ymaint`) — **energy-loss claim cites the wrong form.** "A free
  oscillator would permanently loose energy" is stated as obvious, but the cited `edot`
  (ė = −4βe + ω²(2βx² + ẋy)) is not manifestly ≤ 0. *Finding (owner to confirm):* the first form
  ė = −2βẋ² (at y=0) **is** manifestly ≤ 0 — lean the wording on that. Owner edits prose; AI flags only. <!-- id:559c -->

- [ ] `physics/Resogram.md` (handles `ymaint`/`yfree`) — **terse derivation, possibly post-`edot`-fix.**
  Owner flagged skipped steps and worried the sign fix broke the chain. *Finding (owner to confirm):* the
  **results** are machine-verified ✓ (`verify/resogram_drive.py`) and unaffected by the fix (which touched
  only `edot`'s second equality, not the first form they derive from) — so this is an **exposition** gap,
  not a correctness one. Owner decides whether to expand the shown steps. <!-- id:0cb5 -->

- [ ] `physics/Resogram.md` (handle `esol`, prose) — **c-narrative reconciliation.** The exact `esol` form
  removed the constant `c`, but the ¶ above ("$\dot e$ varies between zero and $-4\beta e$ … averaging to
  $\dot e\approx -2\beta e$") and the ¶ below ("too lazy to check whether $c=0$") still reason in terms of
  the removed `c`. *Finding (owner to confirm):* the exact form's period-average plausibly reproduces the
  $-2\beta$ rate the handwaving guessed — promoting guess→result. **Owner rewrites the prose; AI must not.**
  (Routed here via `/relay human`, then opened into this cluster at `/meeting` 2026-06-15. Successor to the
  pilot follow-up id:9135; summary tracked under id:e27e.) <!-- id:f9fe -->

- [ ] `physics/Resogram.md` (handle for the sliding average $\bar e$) — **suspect averaging window.** The
  upper limit $\frac{1}{2\Omega}$ is ≈ 0.16 of the `β cos` term's period $\pi/\Omega$, so it is not an
  obvious full-period average. `git blame`: the line dates to the original commit `0249a41` at
  **2021-01-31 00:56** (just before 1 AM), carried unchanged since — consistent with the owner's
  late-night-error hypothesis. **Owner:** re-derive the intended window. <!-- id:3999 -->

## Visual / manual (run these — never auto-ticked)

- [ ] `@manual` Walk `tests/HUMAN-integration.md` (TODO `id:6501`): equations render in a
  real browser + VS Code preview applies `.vscode/settings.json`. Render *correctness* is
  machine-checked (`test_mathjax.cjs`); this is the visual/editor-integration last mile.

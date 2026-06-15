# Human review queue <!-- budget: 15 min -->

Judgment calls for the owner — **theory decisions the AI surfaced but must never make.**
A ticked box = "owner confirms this interpretation/correction"; to correct one, edit the
cited source (or leave a note under the item) and the next review re-derives. Resolved via
`/relay human` or `/meeting`. Max ~10 open boxes.

> These are owner-ratified by design (the no-AI-vibe-thinking-the-theory constraint). A
> `.mw`/collAIb tool may later *pre-fill a suggested fix* for a sufficiently-clear item,
> but a human still accepts it — the suggestion is a draft, not a merge.

## Resogram verify-pilot — located discrepancies (collectively TODO `id:9135`)

- [ ] `verify/resogram_edot.py` (handle `edot`, `docs/rigor-debt.md`) — **located algebra
  discrepancy.** The doc's 2nd equality `ė = −4βe − ω²(2βx² − ẋy)` is wrong (off by
  `−4βω²x²`); SymPy confirms the correct closed form is `ė = −4βe + ω²(2βx² + ẋy)` (sign on
  the ω²-bracket). **Owner:** confirm the correction (then fix `physics/Resogram.md`) or
  re-derive. AI will not edit the math.
- [ ] `verify/resogram_cval.py` (handle `cval`) — **"is c=0?" answered: c ≠ 0.** The free
  oscillator's energy is phase-shifted: `e = (A²ω/2)e^{−2βt}(ω + β cos(2(Ωt+φ) − δ))`,
  `δ=atan2(Ω,β)`; the stated `(c+cos²(Ωt+φ))e^{−2βt}` form omits a `sin(2θ)` term, and
  forcing a cos(2θ) match gives `c = Ω²/(2β²) ≠ 0`. **Owner:** confirm the finding and the
  preferred framing (keep the approximate form with a note, or adopt the exact one).
- [ ] `physics/Resogram.md` (handle `sol`) — **integrand typo.** The rendered solution has
  an unbalanced paren `\sin(\Omega (t-t')e^{-\beta(t-t')}` (missing `)` after `(t-t')`); the
  SymPy-verified kernel is `sin(Ω(t−t'))·e^{−β(t−t')}`. **Owner:** confirm the one-char fix.

## Visual / manual (run these — never auto-ticked)

- [ ] `@manual` Walk `tests/HUMAN-integration.md` (TODO `id:6501`): equations render in a
  real browser + VS Code preview applies `.vscode/settings.json`. Render *correctness* is
  machine-checked (`test_mathjax.cjs`); this is the visual/editor-integration last mile.

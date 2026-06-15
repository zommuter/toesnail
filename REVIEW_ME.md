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

## Narrative follow-up from the cval exact-form adoption (owner-only prose)

- [ ] `physics/Resogram.md` (handle `cval`, prose) — **c-narrative reconciliation.** Adopting the
  exact phase-shifted `cval` form (2026-06-15) removed the constant `c`, but the surrounding prose
  still references it: the ¶ above ("$\dot e$ varies between zero and $-4\beta e$ … averaging to
  $\dot e\approx -2\beta e$") and the ¶ below ("I'm too lazy to check whether $c=0$, doesn't matter
  anyway"). **Owner:** rewrite/trim this narrative to match the exact form (AI must not edit the
  theory prose). Until then the section is internally inconsistent by design — flagged, not hidden.
  **ROUTED 2026-06-15 (owner call, /relay human):** owner chose to resolve this in a `/meeting --cross`
  prose-reconciliation session; box stays OPEN until then. Concrete seam: line 86 of `physics/Resogram.md`
  ("too lazy to check whether $c=0$") dangles the removed constant `c`; the line 69 pre-solution
  handwaving ¶ ($-4\beta e$ … averaging $-2\beta e$) may be tolerable as framed.

## Visual / manual (run these — never auto-ticked)

- [ ] `@manual` Walk `tests/HUMAN-integration.md` (TODO `id:6501`): equations render in a
  real browser + VS Code preview applies `.vscode/settings.json`. Render *correctness* is
  machine-checked (`test_mathjax.cjs`); this is the visual/editor-integration last mile.

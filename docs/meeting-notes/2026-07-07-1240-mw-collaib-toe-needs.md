# What the TOE roadmap needs from `.mw` (and collAIb) — needs analysis

**Date:** 2026-07-07 · **Mode:** afk (surface-don't-act; no other repo's ledger edited)
**Companion to:** `2026-07-07-1228-toe-roadmap-evaluation.md` (D1–D5 ratifications)
**Ground truth surveyed:** `~/src/mathematical-writing` CLAUDE.md/ROADMAP/TODO (state:
ROADMAP drained, id:9298 says "needs a HANDOFF (design/meeting) pass"); `~/src/collaib`
CLAUDE.md (Phase 2, stale-reference observer v1 in flight).

## Findings — mapped to the TOE ratifications

### F1. D3 (epistemic-status tags) is ~80% already built in `.mw` — naming is the gap
`.mw` id:358f (LANDED 2026-06-18) gives an **open-enum** annotation family
`{@<kind> [<tier>]}` + `\veq{h}` trailing-macro lowering + per-file `<stem>.toml`
sidecar. Open-enum means `derivation`/`input`/`hypothesis` kinds slot in with **no
parser change**. What's actually needed:
- **Owner naming ratification (toesnail side).** ⚠️ `\input` is a TeX primitive —
  cannot be a macro name. Candidates: `\derived` / `\empirical` / `\hypothesis`, or a
  single parameterized `\status{...}`. Same pilot discipline as id:e0b7 (KaTeX has no
  optional-arg macros — 1-arg forms only).
- **Orthogonality is already honoured by design:** epistemic status (how the link is
  justified) is a *different axis* than verification tier (`\sorry`→`\lean`) — a
  `[derivation]` claim can still carry open `\sorry` debt. id:358f's multi-macro
  lowering (`\veq{h}\derived\sorry`) supports stacking today.
- Render badge styling + a grep/lint one-liner (mirror `grep -rn '\\veq'`).

### F2. D4 (layered reading, "everyone" audience) maps onto an existing `.mw` seam —
but the render side is unbuilt
`.mw`'s architecture already separates **authoring granularity from rendering
granularity** (D1; §3.2 blackbox/collapsed verification is the precedent). The TOE
needs the same mechanism generalized to prose: a skip-tag kind (e.g.
`{@aside trivial|prereq|advanced}`) + collapsed/expandable rendering, so
"skippable trivial-maths entertainment sections" are one annotation, not a fork of the
text. **New design item for the next `.mw` meeting** — the fragment model carries it;
webview rendering does not yet.

### F3. The TOE spine shifts `.mw`'s verification weight toward Lean — with honest gaps
Resogram debt is SymPy-shaped (algebraic identities). TOE chapters 1–5 are
*structural* claims (monoid→group, ℕ construction, ray reps, Casimirs) — Lean/Mathlib
territory: Mathlib has `Monoid`/`Group`/`Nat` foundations, but **Wigner classification
and Bargmann central extensions are not in Mathlib** — those claims will sit at
`\sorry` (or `\lean`-aspirational) for a long time. Consequences to surface for `.mw`
scheduling: the persistent Lean server (current backend is one-shot `lake env lean`)
and the `sorry`-scaffolding TODO view rise in value; long-lived open debt is the
*expected* state, which F1's status-vs-tier orthogonality makes honest rather than
embarrassing.

### F4. Prose-bound claims (`.mw` id:ffbe) get much more important
The "everyone" voice (D4) states many claims in prose, not display math. `.mw`'s
forward-flag id:ffbe (verification annotation bound to a prose span — the
`{#h}{@verify}` brace form id:358f already lowers) is exactly this, currently
unsettled. TOE is the consumer that justifies designing it. Surface for the `.mw`
meeting; not promoted from here (afk).

### F5. Cross-file DAG — probable gap, needs confirmation
TOE will be many chapters/files; chapter 7 (gauging) depends on chapter 3
(projective reps) definitions. `.mw`'s cache is content-addressed (not per-document —
good), but the DAG/staleness engine and "one persistent Lean server **per open
document**" read as single-document-scoped. Whether typed links can target another
file's handles (and staleness propagates across files) is **unconfirmed** — flagged
as an explicit question for the `.mw` meeting, not asserted as missing.

### F6. collAIb — no new asks; existing gates are the right ones
- The two ratified spikes already cover the triad: **verifiable suggestions**
  (collaib `routed:f18b`, consuming `.mw`'s landed `POST /verify` endpoint id:47d4)
  and **toesnail-on-collAIb** (`routed:214d`). TOE adds a real corpus + motivation;
  it does not change their kill-criteria. Let them run.
- collAIb's v1 **stale-reference observer** (D12) is incidentally the right primitive
  for D1's "recurring methodology themes": theme terms ("invariant", "ray", "deform &
  contract") are exactly the defined-term category it tracks. Note only — no work item.
- D5 (game-theory/simulation love wing) needs `.mw` *computation* cells (already
  Phase-1 core) — simulations are the computation tier, not a verifier tier;
  `\numeric` stays a falsifier badge per the tier-ladder decision (id:3d2a D3).

## Routing (afk-conservative)
One inbox bundle to `mathematical-writing` feeding its already-requested design
meeting (extends `routed:91ab`, which covered F1+F2 in brief): F1 naming pilot
dependency, F2 layered-reading render, F3 Lean-weight evidence, F4 ffbe elevation,
F5 cross-file-DAG question. No `.mw`/collAIb ledger was edited from here.

## Open questions for the owner
- **Q6 — status-macro names:** `\derived`/`\empirical`/`\hypothesis` (1-arg-free
  trailing badges, KaTeX-safe) — ratify or rename? (`\input` is impossible; TeX primitive.)
  - **Feasibility probe run 2026-07-07 (afk, mirrors id:e0b7 discipline): PASS.**
    Against the REAL central configs (`.vscode/settings.json` macros, KaTeX 0.16.47;
    `_includes/custom-head.html` macros, mathjax-full): all three names are **free**
    (undefined ⇒ error in both engines — no builtin collision; NB MathJax's
    `noundefined` package masks this as red-text, test without it), and **stacking
    works**: `\veq{probe}\derived\sorry` and `\veqs{probe}\hypothesis\leanc` render
    clean in BOTH engines with zero-arg trailing-badge bodies
    (`\;{\scriptsize\text{[der.]}}` style). So Q6 is a pure naming/typography choice —
    no engine constraint. Probe script kept in the session scratchpad; promote to
    `tests/` only when the owner ratifies names (then it becomes the red spec).
- **Q7 — aside taxonomy:** are three reader layers enough (`trivial` = skippable for
  physicists, `prereq` = skippable for laypersons on reread, `advanced` = optional
  depth), or is a numeric level cleaner?
- **Q8 — chapter granularity:** one `.md` per roadmap step (11 files) or fewer,
  larger files? Bears directly on how urgent F5 (cross-file DAG) is.

# Cross-project dependencies — toesnail × `.mw` × collAIb

How the three projects' progress depends on each other, and *how strongly*. This is the tracking artifact
for the parked **collAIb × toesnail × `.mw` scoping session** (TODO `id:921b`). Canonical copy lives here in
toesnail (the hub of the relationship); review and update it at that session.

## The three nodes

- **toesnail** (this repo) — the theoretical-physics content / research. The *use-case*.
- **`.mw`** ([`mathematical-writing`](../../mathematical-writing/)) — a future literate format/VS-Code tool
  keeping prose + computation + machine-checked proofs mutually consistent.
- **collAIb** (`~/src/collaib`) — a PWA where a **local** LLM watches the document and offers brief,
  non-intrusive side-panel observations ("calm co-author over your shoulder").

## Dependency edges

`A → B` = "A's progress needs / leans on B". Strength: **none / weak / medium / strong**. *Blocking?* = does
B being absent stop A today?

| From → To | Strength | Blocking? | Nature of the dependency |
|---|---|---|---|
| toesnail → `.mw` | **weak** | no | By design (decision D2): toesnail is authored now in plain markdown with `verify:` markers; `.mw` would make the verification workflow *ergonomic*, but toesnail progresses fully without it. Deliberately decoupled. |
| `.mw` → toesnail | **strong** | no (it's a *requirements* dep, not a build dep) | toesnail is `.mw`'s **north-star / acceptance corpus**: it drives what `.mw` must support (tiered SymPy/Lean verification of real derivations, the handle model, staleness across prose↔proof). `.mw`'s design is validated against toesnail content. |
| toesnail → collAIb | **weak** | no | collAIb could provide a *live in-editor UI* surfacing `verify:` rigor-debt while authoring — a nice-to-have. toesnail works with `grep -rn 'verify:'` today. |
| collAIb → toesnail | **none** | n/a | collAIb is a general writing tool; toesnail is just one possible document it could observe. |
| `.mw` ↔ collAIb | **medium — UNRESOLVED** | no | **The main coupling to resolve.** Overlapping authoring-surface: collAIb's *observe-don't-edit* panel vs `.mw`'s verification/assist UI. Open question — does collAIb's observer *become* `.mw`'s assist panel, do they share components, or stay siblings? Could collapse to **strong** (merge) or **weak** (siblings) depending on that call. |

## Picture

```
        requirements / north-star (STRONG)
   .mw  ◀───────────────────────────────────  toesnail
    │                                            ▲
    │  overlapping authoring-surface             │  live verify: assist UI
    │  (MEDIUM, UNRESOLVED) ◀───┐                │  (WEAK, optional)
    ▼                          │                │
 collAIb  ─────────────────────┘────────────────┘
```

- toesnail is the **source of requirements** but is **operationally independent** of both tools (weak
  outgoing edges) — it can keep progressing in plain markdown regardless of either tool's state.
- `.mw` and collAIb are **tools that serve** the toesnail use-case.
- The only genuinely *coupled, undecided* edge is **`.mw` ↔ collAIb**.

## What to watch / next decision

1. **Resolve the `.mw` ↔ collAIb edge** at the scoping session: merge (collAIb's observer → `.mw`'s assist
   panel), share components, or keep sibling. This is the one decision that changes the whole graph's shape.
2. Keep toesnail's outgoing edges **weak on purpose** — if toesnail ever *requires* `.mw` to make progress,
   the decoupling decision (D2) has been violated; revisit deliberately, don't drift into it.
3. If this map proves useful, mirror a one-line pointer to it from `.mw`'s and collAIb's `CLAUDE.md`
   (not yet done — observe-first; do it when the scoping session confirms the relationship is stable).

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
| `.mw` ↔ collAIb (content layer) | **weak — RESOLVED (siblings)** | no | Resolved at the scoping session (2026-06-15, `id:921b`). They do **not** integrate directly; both are independent *consumers* of toesnail's plain-text **marker/handle/tier schema** (toesnail owns it, in `CONVENTIONS.md`). *Share data, not UI* — a shared UI component across the PWA/VS-Code platform line was rejected. |
| `.mw` ↔ collAIb (runtime layer) | **PARKED — not decided** | no | Three couplings flagged as *questions* to the owners, **not** decisions toesnail imposes (see "Parked runtime questions" below). Only one coherent direction emerged: `.mw` owns a headless protocol-driven verification core; collAIb's PWA *could* be an alternate selectable front-end. **Parked ≠ chosen** — none is committed; revisit on the tripwire below. |

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
- The `.mw` ↔ collAIb edge is **resolved at the content layer (siblings)** and **parked at the runtime layer**
  (see below) — settled at the 2026-06-15 scoping session (`docs/meeting-notes/2026-06-15-1351-mw-collaib-frontend-scoping.md`).

## Parked runtime questions (routed to the tool owners — *questions, not decisions*)

The scoping session found only one coherent integration direction and parked it as three orthogonal
questions, each routed to the owner repo (toesnail does **not** decide these):

1. **collAIb PWA as an alternate front-end to `.mw`.** Precondition `.mw` should want anyway: a
   **front-end-agnostic, protocol-driven verification core** (generalize the persistent-Lean-server dispatch
   into a front-end⇄core protocol). *Tension:* `.mw` explicitly names "web-hosted runtime" a non-goal —
   relaxing it is `.mw`'s owner's call.
2. **collAIb's LLM observer as an optional tier-0 plugin inside `.mw`** — advisory `verify:`-marker
   suggestions only, never a machine-checked badge (so it can't pollute the SymPy/CrossHair/Lean tiers).
3. **Sibling contract (= the resolved content-layer edge):** always true regardless of 1 & 2.

**Tripwire to revisit 1 & 2:** when *liveness* becomes a real need (collAIb flagging a marker stale on edit,
pre-save) OR when `.mw` ships a headless front-end⇄core protocol seam.

## What to watch

1. Keep toesnail's outgoing edges **weak on purpose** — if toesnail ever *requires* `.mw` to make progress,
   the decoupling decision (prior D2) has been violated; revisit deliberately, don't drift into it.
2. If this map proves useful, mirror a one-line pointer to it from `.mw`'s and collAIb's `CLAUDE.md`
   (not yet done — observe-first; do it when the relationship is confirmed stable).

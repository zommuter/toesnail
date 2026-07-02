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

## Witnessed instances (real evidence for the parked scoping, `id:921b`)

- **2026-06-15 — `/relay human` Resogram triage exercised the `.mw → toesnail` STRONG edge live.**
  Owner ratified three SymPy-located discrepancies; applying them produced exactly the two things
  `.mw`/collAIb exist to automate:
  1. **Prose↔computation staleness.** Adopting the exact `cval` form *changed a claim* and orphaned the
     surrounding prose still citing the now-removed constant `c` — a human had to hand-detect it and open
     a REVIEW_ME box. This is verbatim `.mw`'s id:dae5 differentiator (shipped the same day): *editing a
     definition marks the claim AND the prose citation that desugars from it STALE, unrelated prose
     untouched.* The `cval` case is a ready-made acceptance witness for that DAG — **now realized** in
     `.mw` as `examples/resogram_cval.mw` + `tests/test_resogram_cval_staleness.py` (`.mw` id:b7b1):
     the differentiator passes on this real content, and an xfail(strict) RED-specs a *gap* the episode
     exposed — `stale_after_edit` catches a changed definition (`$e$` citation + downstream average go
     stale) but NOT a *dangling* citation (the removed constant `c` orphans its `$c$` prose citation).
     Authoring that witness *also* surfaced a second, unrelated `.mw` fix (id:d80d): the eval/DAG
     namespace treated every SymPy-callable name as a function, so the physics variable `beta` resolved
     to SymPy's Beta function (`int * FunctionClass`). Fixed by a call-position rule (a name is a
     function only where applied, `name(…)`), so `beta`/`gamma`/`zeta` are usable symbols. → real
     dogfooding moves the tool, not just validates it.
  2. **verify→verified re-pin cascade.** Correcting the `edot`/`cval` source left the verify instruments +
     pinned `test_verify.sh` verdicts + attestations stale; re-deriving them was deferred to "next review"
     **by hand**. `.mw`'s eval-core + staleness would re-run the verification fragment and flip the badge
     automatically (toesnail's own `id:04bb` staleness-checker is the plain-markdown stopgap for this).
  3. **collAIb tripwire HIT.** The parked runtime Q2 (collAIb LLM observer as an optional tier-0 advisory
     plugin) and the "live verify: assist UI" edge both describe precisely what would have surfaced (1)
     *at edit time, pre-save* — "this paragraph still references `c`, which your edit removed." This is a
     concrete instance of the revisit-tripwire ("liveness becomes a real need").

## Current tool-capability map & the two-tier detection proposal (2026-06-15)

Grounded snapshot of what each sibling can do for toesnail **today** (read from the repos 2026-06-15,
after the Resogram energy-chain episode), and the proposal that fell out of it. **Meeting task queued for
next session — see TODO id:d8bf.** This is design analysis, not a committed plan.

### `.mw` today (v0.3.0) — the HARD / deterministic tier
- **Usable now, headless library:** parser + SymPy evaluator + content-addressed cache + a dependency-DAG
  with 3-state staleness (PENDING/PROVEN/STALE). `stale_after_edit(old, new)` returns the stale fragment set.
- **Proven on this content:** `examples/resogram_cval.mw` + `tests/test_resogram_cval_staleness.py` pass —
  the differentiator works on the real Resogram episode (edit `esol` → its inline `$e$` citation + the
  downstream `ē` average flag stale; unrelated `y` untouched).
- **Caveats:** (1) **No Markdown importer** → can't lift `physics/Resogram.md` losslessly; using it means a
  hand-maintained `.mw` *mirror* (double-entry — the D2 decoupling tax; cheap for one section, not repo-wide).
  (2) **No preview / no Lean / no dispatcher** (all deferred HARD). (3) **Dangling-symbol gap** `xfail id:b7b1`:
  it keys on *changed* definitions, not *removed* symbols — so it would NOT have caught the `c`-removal orphan
  (the origin of this episode). Owner design call pending in `.mw`, blocking a merge there.

### collAIb today (v0.2.0) — the SOFT / advisory tier
- **Runnable PWA, observer loop live:** local-LLM (Ollama/OpenAI-compatible) streams brief observations on a
  2s-idle debounce. Works now.
- **But:** watches only its **in-browser Tiptap buffer** — **no filesystem access**, no verify-marker
  awareness, no diff-aware "you removed `c`" check wired. So it **cannot watch `Resogram.md` today**; the only
  current path is copy-paste a section for generic prose feedback (low value for physics-specific needs).
- **The 80%-built valuable use:** `change-tracker.js` (detects deleted spans) + `observation.js` (typed,
  confidence-thresholded, exact-substring-anchored observations) already exist and are tested but **unwired**.
  The tripwire use-case ("flag the dangling-`c` at edit time, pre-save") needs file-I/O + a prompt tweak +
  wiring those two — a ~2–3 day feature build (the parked runtime Q; tripwire HIT this episode, see above).

### The synthesis: two complementary detection tiers on the same commit-diff
The episode's manual hunt split cleanly into what each sibling automates:

| | HARD tier (deterministic) | SOFT tier (advisory) |
|---|---|---|
| tool | `.mw` DAG (`stale_after_edit`) | collAIb's observer *brain* (prompt + local LLM) |
| catches | changed-definition staleness (`esol`→`ē`) | dangling refs (`c`), exposition, "asserted-not-shown" |
| usable today as | headless library (needs a `.mw` mirror) | headless script (needs prompt + Ollama) |
| output | machine-checked stale-set | advisory notes (never a badge) |

### Proposal — a **relay-aware commit-hook** (NOT yet decided; meeting topic id:d8bf)
Both tiers fire on the **commit diff**, emit findings into REVIEW_ME / inline `🚧` callouts, and the owner
responds with the `**re** (status:)` vocabulary — the full **detect → respond** loop, automating most of this
session's manual hunt. Key realization: **you don't need either sibling's heavy shell** — not `.mw`'s importer
nor collAIb's PWA file-I/O. You need `.mw`'s DAG *as a library* (= toesnail's deferred `id:04bb` staleness
checker) and collAIb's *brain* as a headless diff-observer script. toesnail's git-commit workflow (not
live-typing) makes the commit-hook the right trigger, not an editor.

**"Relay-aware"** = the hook must NOT fire/interfere during relay executor or pool **worktree** commits (they
commit in worktrees outside the repo tree; the hook would either double-run or fight the integrator). Gate it
on: not inside a relay worktree, no live lease held, or an explicit skip env flag. Open design questions for
the meeting: pre-commit vs post-commit vs post-merge; the `.mw`-mirror double-entry cost vs waiting for an
importer; soft-tier noise control / confidence threshold; and **whether `id:b7b1` (dangling-symbol detection)
should be routed to this soft tier rather than `.mw`'s deterministic core** (this episode argues yes). Weigh
against the *observe-before-preventing* heuristic — this episode is N=1; the hook is partly its own logger.

## What to watch

1. Keep toesnail's outgoing edges **weak on purpose** — if toesnail ever *requires* `.mw` to make progress,
   the decoupling decision (prior D2) has been violated; revisit deliberately, don't drift into it. The
   commit-hook proposal (id:d8bf) must preserve this: `.mw`/collAIb stay *optional* assists, never a gate.
2. If this map proves useful, mirror a one-line pointer to it from `.mw`'s and collAIb's `CLAUDE.md`
   (not yet done — observe-first; do it when the relationship is confirmed stable).

> **2026-07-02 Fable consulting cross-dive:** a full CODE/TODO/PROSE classification of every triad +
> satellite edge (chidiai, zkm, collAIb spikes, leAIrn2learn, Diplomarbeit), a meeting-order plan, and a
> proposal (P6) to extend THIS map + resolve the hub ambiguity lives at
> `mathematical-writing/docs/meeting-notes/2026-07-02-1000-fable-consulting-grand-truth-triad.md`.
> It also found one live twin-drift instance (collaib id:f68b's gate id:47d4 shipped 2026-06-25, unannotated).

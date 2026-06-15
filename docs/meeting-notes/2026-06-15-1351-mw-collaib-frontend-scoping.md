# 2026-06-15 — toesnail × `.mw` × collAIb: three-repo relationship scoping

**Started:** 2026-06-15 13:51
**Session:** 9da4120f-e70e-44ec-bf56-49f5b1e57eb9
**Facilitator:** Zommuter
**Attendees:** 🏗️ Archie (architect), 😈 Riku (devil's advocate), ✂️ Petra (productivity),
🔬 Lennart (formal-methods / `.mw` verification lens), 🗺️ Flora (information-flow / routing topology) *(new)*,
🌐 Polly (PWA / cross-platform web delivery) *(new)*
**Topic:** Resolve the one undecided dependency edge — `.mw` ↔ collAIb — and pin collAIb's role (if any) for
toesnail's `verify:` rigor-debt. Scope only; build nothing. (Closes forward-flag `id:921b`.)

## Surfaced discoveries
- [2026-06-15 mathematical-writing] A *pending* verification and an unfilled `sorry` proof hole are the same
  UI state ("not yet discharged") — one placeholder badge serves both; verification is fire-and-forget.
- [2026-06-15 toesnail] Author plain-markdown now with greppable tier-tagged `verify:` markers + stable
  handles, adopting only standalone-valuable conventions so a future `.mw` migration is mechanical.

## Grounding facts (repo inspection at meeting start)
- **collAIb** (`~/src/collaib`): browser **PWA**. Tiptap/ProseMirror + Y.js CRDT; a **local** LLM watches the
  keystroke/diff stream and emits brief *advisory* side-panel comments ("calm co-author"). Phase 1. CDN-only,
  no build step. Already talks to a local LLM endpoint over HTTP/SSE (DroidClaw). Relay-managed.
- **`.mw`** (`~/src/mathematical-writing`): **VS Code extension** + literate `.mw` plaintext format. Tiered
  *machine-checked* verification (SymPy / CrossHair / Lean4+Mathlib), fragment DAG, persistent Lean server fed
  claims over stdio/LSP. **Explicit non-goals: real-time multi-user collaboration, web-hosted runtime.**
- **toesnail** (this repo): the content / north-star. Outgoing edges to both tools are **weak by design**
  (prior meeting's D2 decoupling). `grep -rn 'verify:'` is today's rigor-debt UI.

## The crux (two boundaries, not one)
The `.mw` ↔ collAIb edge crosses **two** boundaries simultaneously:
1. **Platform** — collAIb = browser PWA; `.mw` = VS Code extension that *names web-hosted runtime a non-goal*.
2. **Modality** — collAIb's observer = fuzzy, non-deterministic LLM judgement; `.mw`'s verification = hard,
   machine-checked, deterministic badges. The toesnail role collAIb was flagged for (surfacing `verify:`
   markers) is itself *deterministic grep* — closer to `.mw`'s nature than to collAIb's LLM-observer nature.

## Agenda
1. Resolve the `.mw` ↔ collAIb edge: merge / share-core / siblings / defer-with-tripwire.
2. collAIb's concrete role (if any) for toesnail's `verify:` rigor-debt.
3. What lands *now* in toesnail vs deferred.

## Discussion

### Agenda 1 — the `.mw` ↔ collAIb relationship
Round 1 converged (Archie/Lennart/Flora/Petra/Polly) on **siblings via a toesnail-owned marker schema**: the
`verify:` marker lives in the *document* (plain text, grep-addressable, tool-agnostic) by deliberate design
(prior D2 — "the marker is just a structured TODO, no `.mw`-specific syntax"). Anything that surfaces
rigor-debt — collAIb, `.mw`, or `grep` — consumes the *same plain-text marker*; the tools need not know about
each other, only agree on the schema **toesnail owns**. A literal *merge* (collAIb's PWA observer *becomes*
`.mw`'s VS-Code assist panel) is not a merge but a third project — different platforms, and `.mw`'s machine-
checked badge channel must not be polluted by fuzzy LLM opinion. Riku named the one capability a merge buys
that siblings can't: **liveness** (flag a marker stale *on edit*, pre-save/pre-grep). Polly's rule: *share
data, not UI* — UI across a PWA/VS-Code line is expensive and re-paid every framework bump.

**Owner ruling (D1a):** chose **share-a-core**, reframed as a **selectable front-end** architecture, and asked
the room to consider running collAIb in VS Code *or* using the collAIb PWA as a front-end for `.mw` — "what
would make sense, if any?"

### Agenda 1b — selectable front-end, which direction
Only **one** direction is coherent (Archie/Polly/Lennart/Flora): **`.mw` owns a headless, protocol-driven
verification core** (its Lean dispatch is *already* designed as "a long-lived server fed claims over
stdio/LSP"); collAIb's PWA becomes an **alternate selectable front-end** — a thin client to a `.mw`
verification daemon, the *same shape* as collAIb's existing local-endpoint client, just pointed at `.mw`
instead of (or beside) the LLM. The reverse — **collAIb inside VS Code** — is low payoff (the calm-observer
UX trapped in a worse container, competing with Monaco + `.mw`'s own panel); dropped. Riku's guard: `.mw`
**explicitly names web-hosted runtime a non-goal**, so a PWA front-end is *not toesnail's call to impose* —
the only safe output is a *question routed to `.mw`*. Lennart's reconciliation: the enabling precondition (a
**front-end-agnostic core with a stable protocol seam**) is something `.mw` should want *for its own sake*;
keeping it headless makes "a PWA could mount it" *free optionality*, satisfying Petra's N=2 with a real
future second consumer.

**Owner ruling (D1b):** park as **open questions** routed to the owners. **Plus:** also consider **collAIb as
a plugin to `.mw`** — its LLM observer as an optional pre-formal **tier-0** plugin inside `.mw`. Lennart: this
is the cleanest coupling — collAIb's observer never emits a `✓` badge, it emits *advisory `verify:`-marker
suggestions* ("you probably want a `verify:numeric` here"), so it slots in *without* polluting the
deterministic tiers. Three orthogonal couplings result, each parked as its own question (front-end / tier-0
plugin / sibling-schema).

### Agenda 2 & 3 — collAIb's role for toesnail markers, and what lands now
Agenda 2 collapses: toesnail **owns the marker/handle/tier vocabulary** (`CONVENTIONS.md`); collAIb, `.mw`,
`grep` are *consumers*. toesnail's outgoing edge to collAIb stays **weak** — `grep -rn 'verify:'` is today's
UI; nothing collAIb does is on toesnail's critical path; **no collAIb-specific work enters this repo**.
Agenda 3 is pure bookkeeping: update `docs/dependencies.md`, route two cross-repo **question**-TODOs to the
inbox. Riku's closing integrity check: the map edit must not *overstate* — content-layer edge resolved
(siblings), runtime-layer edges **parked, not decided**; a future reader must not read "we routed questions"
as "we chose to build a PWA front-end."

## Decisions

- **D1 — Content layer: siblings via a toesnail-owned schema.** toesnail owns the marker/handle/tier
  vocabulary (`verify:sympy|numeric|lean`, handle-id format, "pending == `sorry` == not-yet-discharged");
  `.mw`, collAIb, `grep` are independent consumers. No direct `.mw`↔collAIb repo dependency. Edge collapses
  from "medium — UNRESOLVED" to **weak/resolved (siblings)**. *Out of scope:* any shared UI component —
  rejected (PWA/VS-Code platform line; share data, not UI).
- **D2 — Runtime layer: three couplings PARKED as questions to the owners (not decided).** Only coherent
  front-end direction: `.mw` owns a headless protocol-driven core; collAIb's PWA could be an alternate
  selectable front-end. Parked questions: (i) collAIb PWA as alternate **front-end** to `.mw`'s core;
  (ii) collAIb's observer as an optional **tier-0 plugin** inside `.mw` (advisory marker suggestions only,
  never a machine-checked badge); (iii) the always-true sibling contract (= D1). *Out of scope / NOT decided:*
  building (i)/(ii); a `.mw` daemon protocol; collAIb-in-VS-Code (dropped); and **overriding `.mw`'s
  web-hosted-runtime non-goal** — that is `.mw`'s owner's call. These ship as questions carrying this
  meeting's reasoning, not impositions.
- **D3 — toesnail's footprint is bookkeeping only; prior D2 decoupling preserved.** No code, no `.mw`/collAIb
  machinery enters toesnail; `grep -rn 'verify:'` remains the rigor-debt UI. **Tripwire to revisit the parked
  edges:** when *liveness* becomes a real need (collAIb flagging a marker stale on edit, pre-save) OR when
  `.mw` ships a headless front-end⇄core protocol seam. *Out of scope:* promoting toesnail's outgoing edges
  above "weak" — doing so violates the prior meeting's D2 and must be a deliberate, revisited decision.

## Action items
1. [done this session] Update `docs/dependencies.md`: collapse the `.mw`↔collAIb edge to **siblings at the
   content layer**; record the three **parked runtime-layer questions** + the **liveness tripwire**; keep
   "parked ≠ decided" unambiguous. <!-- id:921b -->
2. → routed to mathematical-writing inbox <!-- routed:b771 -->
3. → routed to collaib inbox <!-- routed:1624 -->

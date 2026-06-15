# Meeting — toesnail: repo topology & `.mw`-aligned authoring strategy

**Started:** 2026-06-15 12:57
**Session:** 7fd92a81-6e7e-4129-80de-d4d2b03d8c15
**Facilitator:** Zommuter
**Attendees:** 🏗️ Archie (architect), 😈 Riku (devil's advocate), ✂️ Petra (productivity),
🗺️ Flora (information-flow / content-type) *(new)*, 🔬 Lennart (formal-methods / `.mw` verification lens) *(new)*

## Topic
toesnail is to become the **north-star use-case** of [`mathematical-writing` (`.mw`)](../../../mathematical-writing/).
It holds 5 docs at very different maturity. Two questions: (1) single repo, or split / re-tree? (2) how to
proceed on toesnail content *now*, as independently of `.mw` as possible but preparing for it.

**Hard constraint (owner):** direction is dictated by the owner — **no AI "vibe-thinking" of physics.** AI
assists with structure, rigor-checking, tooling, and Lean4-style formal proofs only.

## Context
- `README.md` — TOESNAIL spine: QM-from-scratch "math on demand" pedagogical TOE narrative (flagship).
- `lasercool.md` — laser-cooling physics ("save the planet" fascination); partial, mostly conceptual.
- `acoustics.md` — Navier–Stokes / acoustics derivations; self-flagged contradiction (`u₀≫u` vs `u₀=0`).
- `Resogram.md` — driven harmonic oscillator energy method; self-flagged hand-wave ("too lazy to check c=0").
- `Narrativium.md` — cultural essay on storytelling; **zero math** (the odd one out).
- Jekyll/GitHub-Pages site with explicit `permalink:` front-matter → file location is independent of URL.

## Decisions

### D1 — Repo topology: single repo + shallow re-tree
One repo (honours the TOE umbrella + unified Jekyll site). `README.md` stays root as the TOE index;
`physics/` holds `lasercool.md`/`acoustics.md`/`Resogram.md`; `essays/` holds `Narrativium.md`. Permalinks
explicit → `git mv` changes no public URL; fully reversible. **Rejected:** per-topic repo split (fragments
site/cross-links, ~irreversible); splitting Narrativium to its own repo (breaks the umbrella). The math/essay
boundary is now *structural*, so the `.mw` migration target is an obvious folder, not scattered files.

### D2 — `.mw`-readiness: minimal standalone-valuable conventions only
Adopt only conventions that pay off **even if `.mw` never ships**, documented in one-page `CONVENTIONS.md`:
1. **Stable equation handles** — formalize the existing `\ltag`/`\eqref` habit (content-meaningful ids).
2. **Tier-tagged rigor-debt markers** — greppable HTML comments `verify:sympy` / `verify:numeric` /
   `verify:lean`. A marker is *just a structured TODO* — no `.mw`-specific syntax `.mw` could redefine.
3. **Source stays plain** — diff-friendly markdown, no inline computed outputs (mirrors `.mw`'s
   "source authoritative, cache disposable").
**Deferred** (it's `.mw`'s job): cache layout, DAG edges, fragment granularity, verification wiring.

### D3 — Working mode & first deliverable
**Operating contract (owner constraint made mechanical):** the AI **emits findings and fills owner-stated
proofs — it never edits the theory.** The `verify:` marker is the unit of work: `verify:sympy`/`numeric` →
✓-with-check or ✗-with-located-discrepancy; `verify:lean` → discharged proof or `sorry`-scaffold. It does not
invent claims, choose which physics to pursue, or silently "fix" derivations — discrepancies are located and
surfaced; the owner decides every resolution.
**Sequence:** mechanical groundwork (re-tree + `CONVENTIONS.md`) → **#0** read-only rigor-debt inventory
across the 4 math docs (no resolutions) → **#1** pilot **Resogram** end-to-end (real SymPy/Lean checks). N=2:
no reusable "verification pass" process until run on two docs; **acoustics = pilot #2** (its `u₀≫u` tension is
a *modeling* choice, deliberately chosen to exercise flag-don't-resolve).

## Amendment — collAIb integration (forward-flag, not designed here)
`~/src/collaib` (PWA; a **local** LLM watches the document and offers brief non-intrusive side-panel
observations — "calm co-author over your shoulder") might integrate with toesnail and/or `.mw`. Its
*observe-don't-edit* model is D3's guardrail as a live UI (could surface `verify:` rigor-debt while authoring,
theory-untouched), and it overlaps `.mw`'s future authoring surface. **A genuine three-repo architecture
question (toesnail × `.mw` × collAIb) — too big for an amendment; flagged for a dedicated scoping session.**

## Post-meeting refinement (same session)
Owner refined D1: the TOESNAIL spine (the QM-from-scratch narrative, formerly `README.md`, `permalink: /`)
**moves to `physics/toesnail.md`** (`permalink: /toesnail`); a proper portal/landing `README.md` (`permalink: /`)
now explains the project, the `.mw` relationship, and navigation. Also added `docs/dependencies.md` tracking
the toesnail × `.mw` × collAIb dependency edges + strengths (the tracking artifact for action item 5).

## Action items
1. Re-tree toesnail per D1 (`physics/`, `essays/`, README at root); verify permalinks unchanged. **[done this session]** <!-- id:8676 -->
2. Write one-page `CONVENTIONS.md` per D2. **[done this session]** <!-- id:e3af -->
3. Deliverable #0 — read-only rigor-debt inventory (`docs/rigor-debt.md`), tier-tagged, no resolutions. **[done this session]** <!-- id:3435 -->
4. Deliverable #1 — pilot Resogram end-to-end (handles + markers + real SymPy/Lean checks of its energy derivation + the "is c=0?" question). Acoustics = pilot #2. <!-- id:01a7 -->
5. Forward-flag — dedicated scoping session for the collAIb × toesnail × `.mw` three-repo relationship. <!-- id:921b -->

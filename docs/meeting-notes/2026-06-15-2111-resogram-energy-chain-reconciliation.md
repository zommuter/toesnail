# 2026-06-15 — Resogram energy-method chain: `cval`→`esol` & the located-discrepancy cluster

**Started:** 2026-06-15 21:11
**Session:** c972b0b2-f8a2-49cf-90c3-5cc240bac7f8
**Attendees:** 🏗️ Archie (architect — document structure & verify-marker consistency), 😈 Riku (devil's advocate — constraint adherence), ✂️ Petra (productivity — scope)
**Topic:** Reconcile the `cval` exact-form adoption's orphaned c-narrative — which opened into a cluster of propagated discrepancies in the Resogram energy-method section.

## Surfaced discoveries
None from `discoveries.md` (no `EMBED_ENDPOINT`); no GitHub prior art / open issues. No orphan-scan candidates.

## Context
`/relay human` routed a single REVIEW_ME box here: the `cval` exact form adopted 2026-06-15 removed the
constant `c`, but two surrounding prose ¶s still referenced it. In the meeting the owner widened the scope
substantially — the `edot` sign fix (2026-06-15) propagates through the whole energy-method derivation with
no consistency-checker to catch the fallout. **This is the canonical `.mw` motivating example.**

## Agenda
1. Direction & scope of the c-narrative reconciliation.
2. Execution mechanics: annotation workflow, the `cval` handle rename, REVIEW_ME inventory.

## Discussion
🏗️ Archie surfaced the structural fact (AI rigor-check, not a decision): `c` appears nowhere in the adopted
`cval` form; its non-oscillating-offset role is now carried by the `ω` term. Riku enforced the hard
constraint — annotations must be **flags, not fixes**; the AI emits findings, the owner derives. Petra split
mechanical (AI-assistable) from owner-only work.

The owner then expanded the scope (verbatim direction): the `edot` non-positivity claim isn't proven; `ymaint`
"skipped quite some steps and probably became wrong after the sign fix… that chain is the very reason for
.mw's (upcoming) existence"; `cval` "there's no longer a reason for that label" → rename; preferred workflow
"annotating the .md file from REVIEW_ME's until I fix them. AI _assistance_ is permitted… good call on the
vibe-veto"; and a hunch the sliding-average window is a tiredness mistake ("check git blame… rather late in
the evening").

**Findings emitted (owner to confirm — AI did not edit the theory):**
- `:44` energy-loss claim cites `edot` (not manifestly ≤0); the first form `ė=−2βẋ²` (y=0) *is* ≤0.
- `ymaint`/`yfree` **results are machine-verified ✓** (`resogram_drive.py`) and survived the `edot` sign fix
  (which changed only edot's *second* equality, not the first form they derive from) → the owner's worry is
  an **exposition** gap, not a correctness break.
- `git blame`: the suspect `\bar e` window `1/(2Ω)` dates to the original commit `0249a41` at **2021-01-31
  00:56** — corroborating the late-night-error hypothesis. The window is ≈0.16 of the `β cos` period `π/Ω`.

The owner authorized AI-*assisted* annotation (vibe-veto upheld), chose **visible markdown blockquote
callouts** over illegible HTML comments, and named the renamed handle **`esol`** (energy solution).
Forward-looking ideas the owner raised were captured as ROADMAP/routed items (R1–R4 below) rather than built.

## Decisions
- **D1 — Handle rename `cval`→`esol` (DONE this session).** The old name encoded the now-answered "find the
  constant c" question; `esol` = the analytical energy SOLUTION. Mechanical sweep: `\ltag`, the `[esol]`
  verify/verified markers, `verify/resogram_cval.py`→`resogram_esol.py`, `tests/test_verify.sh`,
  `verify/README.md`. Attestation re-pinned `by=resogram_esol.py@e6722a73` (claim hash unchanged
  `18d3f7a7`); `tests/test_verify.sh` green (5✓/0✗). *Out of scope:* rewriting append-only history
  (RELAY_LOG, resolved REVIEW_ME boxes, prior meeting notes keep the `cval` name).
- **D2 — Flag-in-place workflow (DONE this session).** Each located discrepancy gets a visible
  `> 🚧 Located rigor-debt` blockquote callout in `physics/Resogram.md`, stating the finding as
  "owner to confirm", never as a fix. The AI touched **no** equation body and **no** prose sentence.
  *Out of scope:* the actual physics/prose fixes (owner-only) and re-deriving `esol` (already ✓).
- **D3 — Discrepancy inventory (DONE this session).** Five REVIEW_ME boxes track the cluster (rename = `[x]`;
  energy-loss id:559c, ymaint/yfree id:0cb5, c-narrative id:9135, sliding-average id:3999 = open). Logged in
  `docs/rigor-debt.md`.
- **D4 — Vibe-veto reaffirmed.** AI *assistance* (annotation, rename, mechanical sweeps, findings) is
  permitted; authoring the theory/prose is owner-only. The five callouts and boxes are re-checkable CLAIMs
  for the next `/relay review`.

## Action items
- [x] Rename `cval`→`esol` across source handle, markers, instrument, test, README; re-pin attestation; verify green — this session, D1. <!-- id:adfc -->
- [ ] `physics/Resogram.md` :44 — recite the energy-loss claim against the `ė=−2βẋ²` form (owner prose). <!-- id:559c -->
- [ ] `physics/Resogram.md` `ymaint`/`yfree` — decide whether to expand the terse (but ✓-verified) derivation (owner prose). <!-- id:0cb5 -->
- [ ] `physics/Resogram.md` `esol` ¶s — reconcile the c-narrative with the exact form (owner prose; successor to id:9135, summary id:e27e). <!-- id:f9fe -->
- [ ] `physics/Resogram.md` `\bar e` — re-derive the sliding-average window `1/(2Ω)` (owner). <!-- id:3999 -->
- [ ] toesnail ROADMAP: **R2/R3** — rendered ✓-emoji on verified equations (with hover/tooltip verify status) + a *legible* in-document annotation syntax to supersede illegible HTML `verify:` comments. Design before changing rendered output. <!-- id:445e -->
- [ ] **R1** — `.mw` "prose-claim ≈ exact-statement" equivalence tooling (owner's "this prose is mostly equivalent to the following exact statement"; AI-assistable) → routed to mathematical-writing inbox <!-- routed:af75 -->
- R4 (playful later follow-up, no id yet): a "human-error-probability vs. time-of-day" plot — inspired by the 00:56 corroboration. Captured here; the owner can promote it if wanted.

## Notes
This session is the live `.mw` north-star case: a single sign correction (`edot`) with no staleness-checker
left four downstream claims to be re-checked by hand. See TODO id:04bb (the verify staleness checker, which
should reuse `.mw`'s dependency-DAG) and `docs/dependencies.md`.

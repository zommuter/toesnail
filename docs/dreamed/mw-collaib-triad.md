---
title: The triad from the north star
permalink: /dreamed/mw-collaib-triad
---

> **DREAMED, UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This file *proposes*; the owner disposes. Nothing here may be promoted into `physics/` or
> `essays/` without the owner authoring the move. The `\veq` badges below claim something about
> [`lean/Triad.lean`](lean/Triad.lean) **only**, and are deliberately not wired into
> `physics/*.toml` or `tests/test_verify.sh`. Findings about `mathematical-writing` and
> `collaib` are **surfaced with file and line, never edited**; both repos were read-only here.

**Seed (owner-carried):** ".mw itself and collaib deserve some dreaming as well." toesnail is
the declared north-star use-case of `.mw` (`CLAUDE.md`, `docs/dependencies.md`), so this is
the triad seen from the north star rather than from either tool.

# 0. Headline

`.mw` is **live and well past its differentiator**: the staleness DAG, the sidecar, the tier
ladder and a persistent Lean LSP backend all ship, at v0.12.0 (2026-08-26). collAIb is
**dormant**: last commit 2026-07-20, clean tree, 43 days idle, `package.json` still
`"version": "0.0.0"`. In the same window toesnail's own commit hook wrote **158 `git notes`**
and **zero** of them was ever triaged. So the triad's real problem is not a missing tool. It
is that the two detectors that DID ship both terminate in a channel nobody reads, and the one
thing neither can ever do -- tell a faithful transcription from an unfaithful one -- is the
thing the `edot` incident actually needed.

The sharpest available statement, and the one this essay's Lean file carries: **a DAG catches
propagation, not origination.** It would have caught all four of the `edot` incident's
downstream discrepancies and none of the sign error that caused them. That is not a gap in
`.mw`; it is a theorem about what any staleness checker can promise, and it bounds the whole
project's advertisement.

# 1. Where the three projects actually are

Read directly from the repos on 2026-09-01.

| | version | last commit | state | evidence |
|---|---|---|---|---|
| **toesnail** | (no manifest) | 2026-09-01 | **live**, actively dreaming | this session |
| **`.mw`** | 0.12.0 | 2026-08-26 13:46 | **live**, relay-managed, four releases in August | `pyproject.toml:3`, `CHANGELOG.md` v0.10.0 / v0.11.0 / v0.12.0 |
| **collAIb** | 0.0.0 | 2026-07-20 11:59 | **DORMANT** 43 days, clean tree | `package.json:3`, `git log -1` |

`.mw`'s August was substantive, not maintenance: v0.10.0 keyed the Lean server pool by
`fragment.source` (id:74e7), v0.12.0 landed sticky staleness through
`Dispatcher.invalidate_statement` (id:15b0). `src/` is 2,871 lines of Python across twelve
modules. collAIb's last commit is a relay handoff that *promoted a backlog* rather than
shipping code; its final feature commit, `2887892` on 2026-07-13, is a service-worker fix for
hosting. Spike #2 (`id:f68b`, the `.mw` `POST /verify` client) shipped and sits in
`verify-client.js`; Spike #3 (`id:ae40`, import a real toesnail page) never started. Dormant,
not dead: the tree is clean, nothing is half-finished, and it would restart from a good state.

# 2. What `.mw` does today versus what toesnail asked for

The needs list is the 2026-07-07 note `docs/meeting-notes/2026-07-07-1240-mw-collaib-toe-needs.md`
(F1 to F6). Four of the six went through a `.mw` design meeting ten days later,
`mathematical-writing/docs/meeting-notes/2026-07-17-1005-toe-driven-needs-bundle.md` (D1 to D7),
so several are **settled rather than open** and one was closed by dissolution. The table below
is what I verified in code and ledgers, not what the docs promise.

| Need | `.mw` today | Gap | Evidence |
|---|---|---|---|
| **F1** epistemic-status tags | Open-enum annotation family + `\veq` lowering ship; kinds are declared in the convention file with arity (D1); toesnail's naming probe passed in both KaTeX and MathJax | **Render only.** Status and tier must occupy two visually separate slots (D2); unbuilt | `mathematical-writing/TODO.md:9` open; `parser.py:145` `_macro_to_annotation`; probe result in the 07-07 note Q6 |
| **F2** layered reading / asides | Fragment model carries it; the aside *kind* is one convention-file line | **Gated on toesnail, not on `.mw`.** Blocked on Q7 (aside taxonomy), which is the owner's | `mathematical-writing/TODO.md:10`, "[GATED on toesnail Q7]" |
| **F3** Lean weight for the TOE spine | Persistent Lean server per PROJECT ships (`lean_lsp.py`, 420 lines); pool keyed by `fragment.source` (v0.10.0) | **Two real limits.** (a) The pool key is a perf identity, never a semantic one: each discharge full-replaces the document, so claim 2 cannot see claim 1's `def` even inside one file. (b) Lean results bypass the content-addressed cache, so the reproducibility promise does not yet cover the Lean tier | (a) `mathematical-writing/CLAUDE.md`, "Lean invocation" para, recorded honestly by its own authors; (b) `mathematical-writing/TODO.md:24` forward-flag |
| **F4** prose-bound verification | **Closed by dissolution, not built.** D4 ratified: a verified claim must be stated in a formal display block; prose never carries a tier, it cites the formal twin by typed link and goes stale one hop | This is a *narrowing of the ask*, and toesnail should notice: the "everyone" voice (roadmap D4) states many claims in prose, and each now needs a formal twin authored beside it | `mathematical-writing/TODO.archive.md:43`; 07-17 note D4 |
| **F5** cross-file DAG | `Fragment.source` exists (`parser.py:142`, id:5e98) and the handle folds source in | **`dag.py` still has no path handling**; cross-file staleness is unbuilt and gated on toesnail Q8 | `mathematical-writing/TODO.md:12`; `dag.py` has no `Path` import |
| **F6** collAIb | Spike #2 shipped; spike #3 never ran | Dormant, see §5 | `collaib/TODO.md:15` |

Two things the table settles that the prose around it does not.

**F5's own ledger line has staled, which is a textbook case of the disease.**
`mathematical-writing/TODO.md:12` still reads "Gap CONFIRMED and structural: `Fragment` has no
source field, `dag.py` has no path handling." The first clause has been false since id:5e98
landed (`parser.py:142` declares `source: Optional[str]`); the second is still true. A ledger
line describing code, half-invalidated by a commit, with nothing to notice: `id:aae4`
inflownistration in the wild, inside the repo built to prevent it. It is worth more as a
witness than as a defect.

**`.mw` has moved past being a promise.** Anyone reasoning from the 2026-06-15 snapshot in
`docs/dependencies.md` ("no preview / no Lean / no dispatcher") is two months stale. That
section is honest about being a snapshot, but toesnail's ROADMAP still leans on it.

# 3. The fidelity blind spot

`mathematical_writing/dag.py:14-24` states the limit in its own module docstring, which is to
its authors' credit:

> `_extract_defines_uses` and `_data_symbols` use a regex to pull identifiers from fragment
> source. An edge B→A is added whenever `A.uses ∩ B.defines ≠ ∅`. This detects that a
> fragment *uses* a symbol, but **never** whether its formula is the *right* one.

The witness they chose is toesnail's own mirror: `ebar = Omega/pi*e` is an unfaithful reduction
of a half-period convolution integral, and `stale_after_edit` stays green, because the edge
holds for **any** right-hand side containing `e`. The consequence recorded in
`ARCHITECTURE.md:192-204` is that fidelity "remains an owner/strong-model gate, never a `.mw`
automated check."

A correction to the framing this essay was seeded with: **`id:ad8c` is closed**, and it was
never a plan to automate fidelity. It was a `[ROUTINE]` doc item to *write the limitation down*
and it did exactly that (`mathematical-writing/ROADMAP.archive.md:115`). No item in either repo
currently targets automated fidelity, so "what would a fidelity checker even be" is genuinely
open, not in flight.

Four candidates, evaluated rather than listed.

**(a) Round-tripping: regenerate the prose from the computation and diff.** Mechanizable in
principle, useless here. The generator would have to produce the owner's voice, which means an
LLM, which means the diff is against a fabrication. The direction is also backwards: toesnail's
rule is *source stays plain, source is authoritative* (`CLAUDE.md`), and round-tripping asserts
the computation is authoritative and the prose derived. Reject.

**(b) Semantic hash over the parsed expression tree.** Strongest candidate, and **already
half-built**: `physics/Resogram.toml` pins `claim = "b575864e"`, an srepr content-hash of the
SymPy expression, not of the source text. It normalizes away whitespace, renaming and
associativity, then compares. It catches the *drift* case exactly (mirror and source once
agreed and no longer do) and imports no new trust assumption beyond SymPy's normal form. It
does **not** catch the original mistranscription, because there is nothing to compare a first
transcription against. Partial by construction.

**(c) Differential testing: evaluate both forms numerically at random points.** Mechanizable
and well suited here, because the physics is analytic and the free parameters are few;
`resogram_esol.py` already evaluates numerically. Two honest limits: it is a *falsifier*, never
a prover, which is the role `CONVENTIONS.md:95` assigns `\numeric` ("a cross-check; it never
substitutes for the actual assurance tier"); and it assumes the sampling domain is legitimate,
which for a branch-cut-laden expression is a real risk (the sibling `lambertw-statistics.md`
is an essay whose entire finding was a branch choice). Of the four, this is the one that would
have caught the documented failure: `Omega/pi*e` and the convolution integral disagree at
almost every sample point.

**(d) LLM judge with a calibration protocol.** Imports a trust assumption of a different kind,
a verdict with no kernel behind it. It is also the only candidate that can read a *prose* claim
against a formula. The repo's own rule (global `CLAUDE.md`, "mechanize first") reserves the LLM
for cases the mechanical layer cannot resolve and makes those **fail loudly**. Under that rule
an LLM fidelity judge is admissible only as a tier-0 advisory that can never set a badge, which
is exactly the shape `docs/dependencies.md` already parked as runtime question 2. Calibration
needs a labelled corpus of faithful and unfaithful mirrors; the repo has one datapoint.

**Recommendation, the owner's to ratify:** (c) then (b). Differential testing is the only one
that catches origination at all, it fits the existing `\numeric` falsifier semantics without
inventing a tier, and it is a small script rather than an architecture. (b) is already
half-present in `claim=` and should be finished before anything new is built. (d) stays
advisory-only. *Weakness of this recommendation:* (c) is a falsifier, so a green
differential test is not evidence of fidelity, and a reader who sees a badge will read it as
one. That is the same misreading `CONVENTIONS.md` already fights, and adding a second numeric
channel makes it likelier, not less.

# 4. The `edot` incident, and exactly what a DAG would have caught

Reconstructed from `docs/meeting-notes/2026-06-15-2111-resogram-energy-chain-reconciliation.md`,
`REVIEW_ME.md:266-330` and `docs/rigor-debt.md:33-80`.

The sequence: a SymPy instrument (`verify/resogram_edot.py`) **located an algebra error** in
the second equality of the `edot` chain. The owner corrected the source. The correction, plus
the adoption of an exact `cval` form, then propagated. Four claims needed re-checking by hand:
the energy-loss claim citing the wrong form (`id:559c`), the `ymaint`/`yfree` exposition
(`id:0cb5`), the c-narrative orphaned by the removal of the constant `c` (`id:f9fe`), and the
sliding-average window, which turned out to be a genuine 2021-01-31 00:56 error (`id:3999`).
All four were found by a human reading the section.

Now be exact about which capability does what.

$$ \operatorname{stale}(S) \;=\; \{\, c \;:\; \exists\, e \in S,\ c \rightsquigarrow e \,\} \veq{prop}\lean $$

**Would have been caught by the DAG:** all four propagated items, in the sense that the DAG
flags the claims *reachable from* the edited definition. This is the theorem `reaches_trans`
in `lean/Triad.lean`: whatever depends, through any chain, on a stale claim is stale. The
`cval` case is not hypothetical; `.mw` ships it as `examples/resogram_cval.mw` plus
`tests/test_resogram_cval_staleness.py`, on this exact content. The dangling-`c` orphan
(`id:f9fe`) was an `xfail` when `docs/dependencies.md` was written and is now folded into
`stale_after_edit` via `dangling_after_edit` (`dag.py:304`, `dag.py:424`).

**Would NOT have been caught:** the `edot` sign error itself, and the 2021 averaging window.
Neither is a staleness event. Nothing upstream changed; the claims were simply wrong from the
moment they were written. A checker that sees only the dependency graph and the edit set is
structurally incapable of distinguishing a correct quiescent document from a wrong one:

$$ \mathsf{chk}(\mathrm{dep},\ \mathrm{edited}) \ \ \text{is independent of}\ \ \mathrm{correct} \veq{orig}\lean $$

That is `checker_blind_to_correctness` and `propagation_without_origination` in the Lean file:
two worlds with the same dependency graph and the same (empty) edit set, one entirely correct
and one entirely wrong, receive identical verdicts, and that verdict is "nothing stale".

What found the sign error was **an instrument**, `resogram_edot.py`, running a SymPy check of
the claim against its derivation. Not the DAG. The honest division of labour: **instruments**
(SymPy, Lean, numeric) catch origination, one claim at a time, and only where someone chose to
instrument; **the DAG** catches propagation, automatically, across everything; and **nothing
yet** catches an uninstrumented claim that was wrong on arrival, a set that is currently large
(`docs/rigor-debt.md:78` scores five claims run, out of a repo of many).

This bounds what `.mw` can ever advertise. "Keeps prose, computation and proofs mutually
consistent" is true and is a *relative* guarantee: consistent with each other, not correct.
The `edot` episode is the north-star witness for the first half and, read carefully, the
counterexample to any stronger reading of the second.

# 5. collAIb: superseded in practice, by the evidence

Is a "calm co-author observer PWA" the right shape for the `verify:` assist role, or does the
commit hook plus `/relay review` that toesnail already has cover it? The evidence is one-sided.
The two-tier design (`docs/meeting-notes/2026-06-16-0635-relay-aware-commit-hook.md`, D1 to D6)
put the deterministic HARD tier in a `post-commit` hook and routed the LLM SOFT tier to
`/relay review`, explicitly **not** to collAIb. That shipped on 2026-06-16. collAIb's last
feature commit is 2026-07-13 and its last commit of any kind is 2026-07-20. The shape that got
built is the hook; the shape that went quiet is the PWA. Six weeks of silence after a
competing design ships is evidence, not coincidence.

But the hook is not a success story either, and pretending otherwise would be the sycophantic
reading. Two located problems.

**The HARD tier does not look at the commit.** `hooks/post-commit:66-73` finds the `e`
definition in `verify/mirror/resogram_esol.mw`, appends `" + 0  # probe"` to it, and reports
which handles go stale. That is a fixed self-test of the mirror, run identically on every
commit, with no reference to what the commit changed. The evidence is in the notes: 158 notes
since 2026-06-16 carry exactly **two** distinct `findings=` strings, and the change between
them is a handle hash moving when the mirror itself was edited, not a signal about any commit.

**Nothing consumes the notes.** D4 specified a lifecycle `pending` → `triaged` → `processed
verdict:valid|noise`. Census of `refs/notes/verify`: 158 notes, 158 `status:pending`, zero
`triaged`, zero `processed`. The detector fires and the resolution silently no-ops, which is
the exact anti-pattern the global instructions name ("a deterministic detector that *finds* a
problem but whose resolution silently no-ops is the anti-pattern").

**Recommendation, the owner's to ratify.** Do not revive collAIb for the `verify:` assist
role. Close the "live verify: assist UI" edge in `docs/dependencies.md` as **not taken**, and
let collAIb be what it independently is: a general local-LLM writing PWA whose one triad-facing
asset, `verify-client.js`, already works process-to-process. Spend the equivalent effort on
making the hook's HARD tier diff-driven and giving `/relay review` a note-triage pass, because
those are the two half-built things blocking the loop that was actually chosen.

*Weakness, stated plainly:* it reads six weeks of dormancy as a verdict when it may just be the
owner's attention elsewhere, and the tripwire `docs/dependencies.md` set for revisiting collAIb
was **liveness** ("flagging a marker stale at edit time, pre-save"), which the commit hook does
not provide and never will, since it fires after the fact. If the owner's authoring pain is at
typing time rather than commit time, the hook does not supersede collAIb at all and this
recommendation is wrong. Only he can answer that.

# 6. The speculative half

Labelled speculative. Each states what would make it decidable.

**S1. The proof-carrying document.** Every rendered claim links to a machine-checkable
artifact, and the *render fails* if the artifact is stale. This corpus is a crude manual
version: each dreamed essay carries `\veq{h}\lean` badges and a "Lean attestation" section
naming theorems, file, command and exit status, and a human ran the command. Mechanizing it
means `tests/test_render.sh` refusing to build a page whose badge outruns its sidecar, which
`.mw` already has the pieces for: D5 of the 07-17 meeting ratified that an anchor asserting a
tier with no sidecar entry is an **ERROR**, symmetric with `dangling_attestations`.
*Decidable by:* wiring `sidecar_diagnostics` into `tests/run.sh` on one file and seeing whether
the build breaks for a real reason within a month, or only ever for bookkeeping. If every
break is bookkeeping, the gate is noise and should stay a warning.

**S2. Content-addressed claims.** A claim's identity is the hash of its normalized expression,
so moving text never breaks an attestation. `physics/Resogram.toml` already keys `claim` by
srepr hash but keys the *entry* by handle, a human-chosen name in the source. This is exactly
the `id:d973` annotation-anchoring problem. The sibling `docs/dreamed/essay-wing.md` proved the
add/remove asymmetry (`driftFree_insert_source` versus `removal_orphans`): the drift check
survives adding a source handle and not removing one, so deleting a marked equation silently
orphans its attestation. `lean/Triad.lean` adds the finer half: an offset anchor at or after an
insertion point *moves* while a content hash does not, and `insertion_breaks_offset` versus
`insertion_preserves_content` shows an offset re-binding silently to the **wrong** fragment,
which no dangling check can see because nothing dangles. *Decidable by:* re-keying one sidecar
by content hash and replaying the repo's own history over it; the question is how often a
legitimate edit changes the normalized expression without changing the claim, which the git
history answers with no new tooling.

**S3. Tier lattices rather than a tier ladder.** The sibling `docs/dreamed/q6-q7-q8-apparatus.md`
proved in `lean/Apparatus.lean` that the tier ladder is a **partial order and not linear**
(`ladder_not_linear`), with `\numeric` a genuine off-ramp, and that the status axis is
orthogonal to it (`no_status_pins_tier`, 25 apparatus states). If that holds, "tier floor" in
`physics/Resogram.toml` asks for a join in a lattice, not a threshold on a chain, and
`tier_at_least` (`dag.py:542`) implements a chain. A third axis is ratified but unbuilt: axiom
scope, mechanized by Lean's `#print axioms` (07-17 D3). *Decidable by:* checking whether any
real claim in the repo needs a floor that is a join of two incomparable tiers. If none does
after the acoustics pilot, the chain is adequate and the lattice is over-design.

# 7. The smallest ask list, ordered by manual pain removed

Every row cites the manual step it retires. **All are recommendations; the owner ratifies.**

1. **Make the hook's HARD tier read the commit diff.** Pain: `hooks/post-commit:66-73` runs a
   constant probe, so the entire detector is decorative. 158 notes, two distinct findings. This
   needs no `.mw` change at all; it is a toesnail fix, and it is first because everything below
   is worth less until the detector detects something.
2. **A note-triage pass in `/relay review`.** Pain: 158 notes, all `pending`, zero triaged. D5
   specified the pass; it was never built. Also toesnail-side, also no `.mw` dependency.
3. **`.mw`: finish `sidecar_diagnostics` as a callable gate over a `.md` file.** Pain:
   `tests/test_verify.sh:44-80` reimplements, in inline Python inside a bash heredoc, the claim
   hash and file hash drift checks that `dag.py:486` (`sidecar_staleness`),
   `dag.py:517` (`dangling_attestations`) and `dag.py:556` (`tier_floor_violations`) already
   implement. That duplication is the highest-value single deletion available.
4. **`.mw`: cross-file DAG (F5), unblocked by answering Q8.** Pain: the TOE spine is eleven
   steps and chapter 7 depends on chapter 3. The gate is toesnail's, not `.mw`'s. Answering Q8
   costs one decision; not answering it leaves `id:6df6` parked indefinitely.
5. **A markdown importer, or a decision to never have one.** Pain: `verify/mirror/resogram_esol.mw`
   is a hand-maintained double-entry copy of one section, whose fidelity is guarded by nothing
   (§3), and the mirror is what the hook reads. Either the importer removes the double entry, or
   the owner rules the mirror permanent and the fidelity gate gets a named owner and a checklist.
   Ranked last because it is the largest build and the current cost is one section.

Explicitly **not** on this list: reviving collAIb, building an LLM fidelity judge, and the tier
lattice. Each is defensible; none removes a manual step being paid today.

## The mirror, in `.mw` form

For orientation, the actual artifact the hook reads (`verify/mirror/resogram_esol.mw`), whose
`ebar` line is the fidelity witness of §3:

```computation
ebar = Omega/pi * Integral(e.subs(t, t - tp) * exp(2*beta*tp), (tp, 0, pi/Omega))
```

Every DAG edge around that line holds for any right-hand side mentioning `e`. That is the
whole blind spot in one line of the repo's own tooling.

## Lean attestation

File: `docs/dreamed/lean/Triad.lean`. Theorems: `reaches_seed`, `reaches_step`, `reaches_trans`,
`not_reaches_of_no_path`, `mem_of_closed`, `mem_staleSet_iff`, `checker_blind_to_correctness`,
`no_checker_flags_origination`, `propagation_without_origination`, `content_anchor_stable`,
`offset_anchor_shifts`, `offset_anchor_stable_before`, `insertion_breaks_offset`,
`insertion_preserves_content`, `anchors_diverge_under_insertion`; instance `decidableReaches`.
Checked with

```
cd /home/tobias/src/toesnail/verify
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/Triad.lean
```

Exit status 0, no output, zero `sorry`, 2026-09-01.

Scope of what is proved, honestly: `Reaches` is *defined* as reachability, so the propagation
theorems are about the specification, and the content of Part 1 is that the computed
`Finset` fixpoint `staleSet` equals it, which yields decidability. Part 2's checker model
takes blindness structurally (`correct` is not an argument), which is a modelling choice that
mirrors `dag.py`'s actual signature rather than a discovery. Part 3 models an edit as an
insertion only; deletions are the sibling `EssayWing.lean`'s `removal_orphans`.

## Surfaced for the owner

Located, never edited. Nothing here was written into `TODO.md`, `ROADMAP.md` or `REVIEW_ME.md`.

1. **`hooks/post-commit:66-73` (toesnail) runs a constant probe.** The HARD tier appends
   `" + 0  # probe"` to the mirror's `e` definition and reports the resulting stale set. It
   never reads the commit's diff. Census: 158 notes on `refs/notes/verify`, two distinct
   `findings=` strings, `hard_tier=ok` in all 158. Whether this was the intended v1 scope is
   the owner's call; the design note's framing ("both tiers fire on the **commit diff**",
   `docs/dependencies.md`) reads as if it is not.
2. **The `git notes` lifecycle never advanced.** 158 `status:pending`, 0 `triaged`, 0
   `processed`, from 2026-06-16 to 2026-09-01. D4/D5 of the commit-hook meeting specify the
   transitions and `/relay review` owns them.
3. **`mathematical-writing/TODO.md:12` (id:6df6) is half-stale.** "Gap CONFIRMED and
   structural: `Fragment` has no source field" has been false since id:5e98;
   `src/mathematical_writing/parser.py:142` declares `source: Optional[str]`. The `dag.py`
   half is still true. Read-only finding, routed nowhere.
4. **`docs/dependencies.md` §"Current tool-capability map" is a 2026-06-15 snapshot** that now
   understates `.mw` by three releases ("no preview / no Lean / no dispatcher" are all out of
   date). It labels itself a snapshot, so this is a staleness of *citation*: toesnail's ROADMAP
   reasoning still leans on it.
5. **F4 was closed by dissolution on the `.mw` side** (07-17 D4: prose never carries a tier),
   while toesnail's TOE roadmap D4 wants an "everyone" voice that states claims in prose. Those
   are compatible only if every prose claim gets an authored formal twin, an authoring cost the
   toesnail roadmap has not priced.
6. **`\numeric` would have caught the `ebar` mirror error** and is the only mechanizable
   candidate that catches origination at all (§3c), while `CONVENTIONS.md:95` deliberately
   demotes it to a cross-check. Worth a ruling on whether a differential-testing fidelity check
   may exist *outside* the tier vocabulary.

## Follow-up leads

1. **Replay the repo's git history against a content-keyed sidecar.** Decidable by counting how
   many historical commits would have re-keyed an entry without changing the claim; if that
   count is near zero, S2 is safe to adopt.
2. **Instrument-coverage census.** `docs/rigor-debt.md:78` scores five claims run. Decidable by
   `grep -rn '\\veq' .` against the sidecar keys: the ratio is the size of the "wrong on
   arrival, uninstrumented" set that §4 says nothing currently guards.
3. **Ask whether the authoring pain is at typing time or commit time.** Decidable only by the
   owner; it is the single fact that determines whether §5's collAIb recommendation holds.
4. **Try a differential-testing pass on the four `esol` handles.** Decidable in an afternoon:
   sample the free parameters, compare the mirror's `ebar` against the convolution integral,
   and see whether the disagreement is loud enough to be a usable signal or lost in the
   branch-cut noise.
5. **Price the F4 formal-twin cost on one real page.** Decidable by taking one "everyone"-voice
   section of `physics/toesnail.md` and authoring a formal twin for every prose claim in it;
   the count and the effort answer whether D4's narrowing is affordable at TOE scale.

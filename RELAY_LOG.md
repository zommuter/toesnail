# Relay log <!-- merge=union; append-only — never edit or reorder past entries -->

## 2026-09-07 10:32 — executor (claude-sonnet-5)

Worked id:0183 -- wired `test_ci.sh` and `test_make.sh` into `tests/run.sh`'s tier loop. Both tests already existed and passed standalone but were armed nowhere, so `bash tests/run.sh` never ran them (the id:d35a silent-no-op class); one-line addition, nothing else touched. Verified both individually (exit 0 each) and via a full `bash tests/run.sh` run (SUITE: PASS, exit 0) which now includes them. Friction: the full suite's `test_lean.sh` tier does a real `lake exe cache get` + build under high host load (load average ~20, swap-heavy), so the run took well over the 120s foreground timeout and had to be backgrounded -- unrelated to this item, just noting the wall-clock cost of the definition-of-done check on this repo.
refactor: none needed -- one-line addition to an existing loop, no new duplication.

## 2026-07-17 18:35 — reviewer (claude-opus-4-8, fable-standin, relay-loop)

Handoff toesnail: reconciled id:8807 verify-pilot parent as a gated @container ROADMAP twin (executor work already fully decomposed into seams e9e9/76e5/5d31/37cc); no new promotable work; unpromoted-scan promote=0, roadmap-lint --strict clean. [id:8807]

## 2026-09-07 10:06 — reviewer (claude-opus-5, relay-loop)

Reviewed toesnail over `relay-ckpt-20260717-1835`..HEAD (33 commits, 109 files, +27,723 lines). The window
contains NO executor work: it is the 2026-09-01/09-04 owner-seeded `docs/dreamed/` batch (32 essays + Lean
companions + one runnable library under `docs/dreamed/resogram-lib/`), four cross-project inbox ingests, and
three ledger-filing commits. Nothing was closed by an executor, so nothing was verified-green this pass.

test-integrity: `gaming-scan.sh` emitted `ADDED_SKIP:docs/dreamed/resogram-lib/tests/test_core.py:142` and
`:172`. Both are FALSE POSITIVES and are reported as such, not waved away: each is an English comment inside a
NEW file (`# Skip the first ring-up cycle…`, `# skip the first two half periods`), not a skip decorator, and the
file is a dreamed-batch artifact under `docs/` that no repo tier runs. Zero DELETED_TEST, zero REMOVED_ASSERT.
`tests/` itself is byte-identical across the window, so §2b's resurrection and fixture-special-casing checks
have no candidates. Provenance greps for `@owner-accepted:`, `@owner-answered:` and `<!-- answer-src:` over
every commit in the window: zero hits, added or modified. No `[host:]` tags, so §2c does not apply.

tiers (review.md §3, all named, none skipped): `bash tests/run.sh` ran all 12 declared tiers GREEN, exit 0 —
test_verify, test_verify_entropy_routine, test_render, test_verify_hook, test_mw_mirror, test_lean,
test_page_coverage, test_crypto_exclude, test_conventions_ladder, test_toolchain_pointer, test_mathjax.cjs,
test_veqs_inline.cjs. NO tier was skip-recorded: Ruby, node_modules and the lake toolchain were all present
(the Lean tier ran a real `lake build` at load ~22, hence the wall time). CI's three-job subset and
`package.json`'s `test:math` are both strictly contained in that set. Residual manual tier unchanged:
`tests/HUMAN-integration.md`.

Tier ENUMERATION found a real gap, filed as `[ROUTINE] id:0183`: `tests/test_ci.sh` (`# roadmap:9868`) and
`tests/test_make.sh` (`# roadmap:fca7`) exist, carry roadmap headers, and PASS when run by hand (verified, exit
0 each) — but neither is in `tests/run.sh`'s tier list, so this repo's stated definition-of-done never runs
them and both closed items' regression guards are unarmed. `tests/test_verify_entropy.sh` is deliberately NOT
in that item: it is the still-RED spec for gated seam id:76e5 (verified exit 1), correctly excluded.

Main finding — `ROADMAP.md` carried the same `md-merge` stacked-body damage `584e93e` repaired in `TODO.md`.
`bcecee6` filed `id:ac7b`, `id:17ee` and `id:3381` as `[ROUTINE]`; all three head lines landed at the top of
`## Gated forward-flags — NOT yet executor work` with ALL THREE bodies stacked under `id:3381`. So `ac7b` and
`17ee` carried no acceptance criteria at all, and `roadmap-lint` rejected all three as `PARKED-POOL-LANE` —
pool-executable lane under a parked heading, i.e. structurally undispatchable (the `id:d35a` class). Three
genuine executor items were invisible from 2026-09-01 to today. Moved into a new `### Dreamed-batch tooling
findings` section under `## Items`, each body re-attached to its own head line; no text changed, added or
dropped. `roadmap-lint` now exits clean. Third occurrence of this shape, so it is a tool defect — already
tracked upstream as `dotclaude-skills id:4f0f`, nothing new filed (REVIEW_ME box notes the one half 4f0f may
not cover: 4f0f is about EDITING a wrapped item, this was INSERTION where the failure is PLACEMENT).

Second finding — `ROADMAP id:9d8c`'s typed `gated-on:` edge, ticked DONE in REVIEW_ME on 2026-07-19, parsed to
NOTHING. Written as `<!-- gated-on: id5776-local-lake-build-gate -->`; `lib-typed-edges.sh` extracts
`(?<=<!-- gated-on:)[0-9a-f,]+(?= -->)`, so both the space after the colon and the non-4-hex payload miss.
`gated-on:5776` would also have been the wrong edge — id:5776 is `[x]` closed, so the gate would read CLEARED
and unpark an item the owner deliberately parked. Replaced with `<!-- owner-hold:local-lake-build-gate-suffices
-->` (id:d119, the marker for an intentionally-unclearable hold) and surfaced for owner ratification, since
changing gate semantics on a parked forward-flag is his call, not mine.

relay-doctor: cross-ledger drift clean; TODO conformance 0 non-conforming (the `grammar-continuation` lines are
the advisory id:0d7c line-shrink signal, report-only, untouched); main checkout clean; mechanical-orphan clean.
`orphan-scan --shipped` reported two UNMARKED-GATE hits, `id:9d8c` (fixed above) and `id:4bb2` (blocked on the
CROSS-REPO token `routed:c196`, which the local-4-hex `gated-on:` grammar cannot express at all — surfaced to
REVIEW_ME, changed nothing). Fleet-level doctor findings (4 parked orphans in other repos, relay-core shadow
mismatches, one install-drift `relay/scripts/lib-archive-idempotency.py` missing from the install tree) are not
toesnail's and were not written into this repo's ledgers.

spec-drift: `CLAUDE.md` `## Relay contract` pointer refreshed v9 → v18 (marker only; body already current).
README/ARCHITECTURE describe what shipped — the window added no user-facing surface, only `docs/`.

reverse-handoff §5b: six newly-added open TODO items. Four are `[INBOUND routed:*]` cross-repo notes (id:7a42,
id:4b04, id:2479 — the last two superseding each other, no local action) and two are `[OWNER]` triage items
(id:2460, id:6646) that are owner-only theory direction, correctly not promoted. The fifth, `id:7f2f`
(routed:5f53), WAS execution-ready — a do-not-prune guard for the `gtnsd-archive` orphan branch — and was small
enough to do here rather than burn an executor turn: recorded in `CLAUDE.md`'s `gtnsd-archive` bullet and
ticked. Deviation stated on the line itself: the inbound asked for `TODO.md:123`, but `CLAUDE.md` is the only
place in the repo that describes the branch, so that is where a reader about to prune it will actually look.

refactor: none needed — this unit wrote only ledger and doc lines; no code surface to clean up.
4 open [ROUTINE] after re-derivation (id:3381, id:17ee, id:ac7b, id:0183) — all four newly dispatchable, three
of them only because the placement damage above was repaired.
[id:ac7b, id:17ee, id:3381, id:0183, id:9d8c, id:7f2f]

## 2026-09-07 10:27 — reviewer (claude-opus-5, fable-standin, relay-loop)

review(toesnail): un-parked 3 [ROUTINE] items md-merge had filed under a gated heading with stacked bodies (ac7b/17ee/3381); fixed id:9d8c's non-parsing gated-on edge; filed id:0183 (2 test tiers never run); 12/12 tiers green, zero skips [id:ac7b,17ee,3381,0183,9d8c,7f2f]

## 2026-09-07 10:33 — executor (sonnet, relay-loop)

Wired test_ci.sh and test_make.sh into tests/run.sh's tier loop (id:0183), closing the silent-no-op gap where both regression guards existed but never ran under `bash tests/run.sh`. [id:0183]

## 2026-09-07 — executor (claude-sonnet-5, relay-loop)

Worked id:3381 -- added `dotclaude-skills` as a fourth node to `docs/dependencies.md`'s cross-project dependency map, plus two edge rows (`dotclaude-skills → toesnail` strong/non-blocking for the engineering process: relay executor, the relay-aware commit-hook design, ledger helpers; `toesnail → dotclaude-skills` weak, since it manages toesnail generically with no toesnail-specific requirement feeding back). Documentation only, matching the existing table/bullet format; no code touched. Full `bash tests/run.sh` SUITE: PASS (12/12 tiers green, including a real `lake exe cache get` + build under the Lean tier -- took well over 120s wall time, backgrounded and waited out, unrelated to this item).
refactor: none needed -- one bullet + two table rows added to an existing doc, no new duplication.

2 open [ROUTINE] after re-derivation (id:17ee, id:ac7b) -- id:3381 closed this session; both remaining items are untouched by this change (docs/se-corpus.md corpus-row fix and the verify commit-hook diff-awareness item).
[id:3381]

## 2026-09-07 10:39 — executor (sonnet, relay-loop)

Added dotclaude-skills as a fourth node (+2 edge rows) to docs/dependencies.md (id:3381); full 12/12-tier suite green [id:3381]

## 2026-09-07 — executor (claude-sonnet-5, relay-loop)

Worked id:17ee -- fixed the two misattributed rows in `docs/se-corpus.md` (M-1/P-C cluster). Row M-1 wrongly tagged `337971` as the dilation-generator post and marked it self-answered; split it into a new row M-1b with its real subject (curl generalized to non-3D via de Rham/Hodge) and its own open owner question (can A be d_1^{-1} and d_{n-2}^{-1} simultaneously for n≠3?); M-1 now correctly attaches `(self-answered)` to `116633`+`a/116639`. Row P-C's summary "Casimir eigenvalue eqs as field eqs" was restated as the actual VARIATIONAL mechanism (stationarity of `<psi|p^2-m0^2|psi>`, not an eigenvalue read-off), and both answers (Schreiber: worldline-SUSY -> Dirac via the odd generator, not W^2; Misha: symmetry alone underdetermines the spectrum) are now recorded. No row's Status changed (owner judgment, out of scope); mechanical inventory correction only, no physics/essays content touched. Full `bash tests/run.sh` SUITE: PASS (all tiers green, unchanged by this doc-only edit).
refactor: none needed -- two table-row edits in an existing markdown file, no new duplication.

1 open [ROUTINE] after re-derivation (id:ac7b) -- id:17ee closed this session.
[id:17ee]

## 2026-09-07 10:46 — executor (sonnet, relay-loop)

Fixed the two misattributed docs/se-corpus.md rows (id:17ee): split 337971 out of row M-1 into its own row M-1b with its real subject, and restated P-C's mechanism as variational instead of eigenvalue-based, recording both SE answers. [id:17ee]

## 2026-09-07 — reviewer (claude-opus-5, fable-standin, relay-loop)

Chain-end review of the three executor units this run. **Window note, stated because it changes what
was audited:** the literal latest checkpoint (`relay-ckpt-20260907-1046`) is this run's OWN last
executor tag and yields ZERO commits, so a mechanical `$LAST`..HEAD would have reviewed nothing and
returned a vacuous green. Audited `relay-ckpt-20260907-1027`..HEAD instead -- the last REVIEW
checkpoint, which is the window that actually contains the chain (14 commits: id:0183, id:3381,
id:17ee, plus their merges/ticks/archives).

test-integrity: `gaming-scan.sh` emitted NOTHING -- zero DELETED_TEST, zero ADDED_SKIP, zero
REMOVED_ASSERT. `tests/` changed by exactly one line in the whole window (`run.sh`'s loop, id:0183's
deliverable), so §2b's resurrection and fixture-special-casing checks have no candidates: no test file
was modified, so no original version can have been weakened. Provenance greps over every commit for
`@owner-accepted:`, `@owner-answered:` and `<!-- answer-src:`: zero hits, added or modified. No
`[host:]` tags, so §2c does not apply. Faked-clean-tree (§2b.5): no stash/reset/checkout language in
any commit or log entry, and each item's acceptance behaviour is present in its diff. `refactor:`
lines present on all three, each `none needed` with a stated reason, and each diff genuinely is a
one-liner or two table rows -- no contradicted claim.

tiers (§3, all named, none skipped): `bash tests/run.sh` ran **14** tiers GREEN, exit 0 (SUITE: PASS)
-- test_verify, test_verify_entropy_routine, test_render, test_verify_hook, test_mw_mirror, test_lean,
test_page_coverage, test_crypto_exclude, test_conventions_ladder, test_toolchain_pointer, **test_ci,
test_make**, test_mathjax.cjs, test_veqs_inline.cjs. Zero skip-records: Ruby, node_modules and the
lake toolchain were all present (test_lean ran a real `lake build` at load ~18-21, hence the wall
time). The count going 12 -> 14 IS id:0183's observable close. `tests/test_verify_entropy.sh` re-checked
independently rather than inherited from last review's claim: still RED (exit 1, `crypto/fhe.toml:
missing`), correctly outside the loop as the gated id:76e5 spec. Both newly-wired tests read and
confirmed substantive (real asserts on live repo state, not placeholders). Residual manual tier
unchanged: `tests/HUMAN-integration.md`.

**Finding (§2d over-reach / §4 accuracy) -- id:3381's diff asserts a dependency that does not exist.**
The new `dotclaude-skills -> toesnail` edge was ranked **strong** on three legs; leg (2), "its git
hooks (relay-aware commit-hook design, id:d8bf) gate toesnail's commit workflow", is wrong twice over.
`id:d8bf` is a TOESNAIL id: its meeting note is `docs/meeting-notes/2026-06-16-0635-relay-aware-commit-hook.md`
IN THIS REPO (the path in the node bullet resolves here, not in dotclaude-skills), and the hook it
produced is this repo's own `hooks/post-commit`. And this repo sets `core.hooksPath=hooks`, so
dotclaude-skills' global hooks do not run here AT ALL -- `relay-doctor` classifies the shadowing as
DELIBERATE, an owner call. A map whose own filing reason was derived-doc drift had therefore acquired
a drifted row. NOT gaming and not a scope superset: the item authorised "add the node and its edges",
which is exactly what landed, so id:3381 stays CLOSED. Corrected inline in both the node bullet and
the edge row. What I did NOT do on my own judgment: re-rank the strength. Leg (1) (the relay itself)
is genuinely process-blocking, so **strong** still stands on one leg -- surfaced to REVIEW_ME for the
owner to re-rank at the parked `id:921b` scoping session, which `docs/dependencies.md` itself names as
the review venue.

spec-drift (§4): `tests/README.md` opened with "This repo is **not** under `/relay` handoff (no
executor sessions, no `ROADMAP.md`/`RELAY_LOG.md`...)" -- false, and verified false rather than assumed:
both files exist and 28 executor sessions sit on the log across `RELAY_LOG.md`+`.archive.md`. Its tier
table also listed 4 files against a 14-tier suite, a gap this window widened by two. Fixed both: the
framing sentence now states the repo IS relay-managed, and the tier list now points at `run.sh`'s loop
as authoritative (naming all 14, plus why `test_verify_entropy.sh` is deliberately outside it) while
leaving the original table as the per-layer detail it accurately is. `CLAUDE.md`'s `## Relay contract`
pointer is v18, matching the canonical marker -- no refresh needed. README/ARCHITECTURE otherwise
describe what shipped; the window added no user-facing surface.

relay-doctor: cross-ledger drift clean; roadmap-lint clean (every open item carries a recognized lane
tag + id); mechanical-orphan clean; TODO conformance reports only the advisory id:0d7c line-shrink
classes (grammar-continuation / shape-prose / decided-left-open), report-only, untouched.
`orphan-scan --shipped` reports the same two UNMARKED-GATE hits as last review, id:9d8c and id:4bb2,
both already carrying open REVIEW_ME boxes -- nothing new filed, no duplicate box. Fleet-level doctor
findings (relay-core shadow mismatches, etc.) are not toesnail's and were not written here.

reverse-handoff §5b: zero newly-added open TODO/ROADMAP items in the window (`git diff` for added
`- [ ]` lines returns nothing) -- the window is executor-only, so there is nothing to qualify.

roadmap re-derivation: id:0183, id:3381 and id:17ee verified genuinely green and already ticked by
their executors; no item reopened. **1 open [ROUTINE] remains, id:ac7b** (verify commit-hook reads the
actual commit diff + note lifecycle) -- fully specified with acceptance, tests and a done-check, so it
is dispatchable now, not underspecified. Note `ROADMAP.md:212` still wears the retired `[HARD - hands]`
spelling; it sits under `## Human-only -- NOT in the executor queue`, so lint exempts it and the
delimiter migration says never to hand-swap one in isolation -- left alone deliberately.

refactor: none needed -- this unit wrote ledger, doc and log lines only; no code surface to clean up.
1 open [ROUTINE] after re-derivation (id:ac7b).
[id:0183, id:3381, id:17ee, id:ac7b]

## 2026-09-07 10:56 — reviewer (claude-opus-5, fable-standin, relay-loop)

review(toesnail): id:0183/3381/17ee verified genuinely green (14/14 tiers, zero skips, gaming-scan clean); corrected a false git-hook dependency edge id:3381 introduced and a tests/README that denied the repo is relay-managed; 1 open [ROUTINE] (ac7b) [id:0183,3381,17ee,ac7b]

## 2026-09-07 — executor (claude-sonnet-5, relay-loop)

Worked id:ac7b — `hooks/post-commit`'s HARD tier no longer simulates a constant probe against
the hardcoded `e` definition; it now reads the ACTUAL committed diff of
`verify/mirror/resogram_esol.mw` (parent-commit content vs this commit's content) and runs
`mathematical_writing.dag.stale_after_edit` on the real before/after fragments, so the note's
`findings=` line is a function of what the commit actually changed. A commit that doesn't
touch the mirror at all now short-circuits to an explicit `findings=none (mirror unchanged in
this commit)` with no parsing/probing invoked, instead of the old content-independent constant.
Extended `tests/test_verify_hook.sh` with two new cases (7: editing two independent mirror
sections in separate commits produces different findings strings; 8: a commit touching only an
unrelated file produces the explicit unchanged-mirror finding) against a new mirror-bearing
sandbox helper (`make_mirror_sandbox`) seeded with two independent computation clusters so an
edit to one doesn't stale the other. All 8 cases in `tests/test_verify_hook.sh` pass; full
`bash tests/run.sh` is green (14/14 tiers, real Lean/Jekyll/npm run, no skips — the Lean tier's
`lake exe cache get` re-downloaded mathlib into this fresh worktree, ~5.5 min wall time,
unrelated to this item).
The note-lifecycle half of the item ("either implement the pending/triaged/processed transition
or delete the field") is left as-is on purpose: a consumer IS planned for it, just not yet
built — the `/relay review` triage pass (routed:6cc0) and the `/relay human` owner-verdict pass
(routed:f42b) are the designed consumers per the 2026-06-16 meeting's D4/D5
(docs/meeting-notes/2026-06-16-0635-relay-aware-commit-hook.md), and building those
review/human-mode passes is out of this tooling-only post-commit hook's scope. This unit
addresses the constant-probe half, which was the part actually reachable from the hook file
alone.
Friction: none — item was fully specified with acceptance, tests and a done-check.
refactor: none needed — the fix replaces the probe body in place, reusing the existing
skip/status-formatting structure; no new duplication introduced.
0 open [ROUTINE] after re-derivation.
[id:ac7b]

## 2026-09-07 11:07 — executor (sonnet, relay-loop)

id:ac7b: hooks/post-commit now diffs the mirror against the parent commit and runs stale_after_edit on the real before/after instead of a constant simulated probe; findings are a function of the commit. [id:ac7b]

## 2026-09-07 11:42 — reviewer (claude-opus-5, relay-loop)

Review of window `relay-ckpt-20260907-1107`..HEAD (2 commits, both owner/coordinator-attributed, no
executor unit ran). `59f07e6` added the dreamed "Bloch Truth" cluster (4 essays + 4 Lean files);
`11fa873` archived one aged done TODO entry. Nothing was closed, so no item was verified green and none
was reopened.

Trust-but-verify: `gaming-scan.sh` clean (no DELETED_TEST / ADDED_SKIP / REMOVED_ASSERT). No file under
`tests/` or `verify/` was touched in the window, so the resurrection and fixture-special-casing checks
have no candidates. Provenance greps found no `@owner-accepted:` / `@owner-answered:` / `answer-src:`
introduced or removed. §2d over-reach does not apply: no ROADMAP item closed this window.

Three claims in `59f07e6`'s message were re-derived rather than taken on report. Zero `sorry` in all
four new Lean files: confirmed by grep, 0/0/0/0. "Outside the lake targets, so `make test` is
unaffected": confirmed, `verify/lakefile.toml` has `defaultTargets = ["Resogram"]` and one `lean_lib`.
The index's 39 -> 43 count: confirmed, 43 essays and 43 Lean files on disk.

Test tiers (id:f032), all enumerated from `Makefile`, `package.json` and `.github/workflows/ci.yml`:
`make test` -> `tests/run.sh`, 14 tiers, ALL RAN, ALL PASS, zero skips. The Lean tier really built
(8314 lake jobs, mathlib cache hit), not a toolchain skip. `npm run test:math` and the 3 CI steps are
proper subsets of run.sh and ran inside it. One tier is deliberately NOT wired and stayed that way:
`tests/test_verify_entropy.sh` (`# roadmap:7306`) is the still-RED spec for the gated `id:76e5`/`id:5d31`
seams, documented as such in ROADMAP.md and the archives. Manual tier `tests/HUMAN-integration.md`
remains a human pass (irreducibly visual, MathJax runs client-side); NOT counted green.

Spec drift (§4), fixed inline: `docs/dreamed/` was absent from `CLAUDE.md`'s Structure list, from
`README.md` and from `ARCHITECTURE.md` -- 43 essays, 43 Lean files, 2 runnable suites and a bespoke
`capped.sh` runner with no durable description anywhere. Added a `CLAUDE.md` bullet carrying the three
facts a contributor would otherwise re-derive: nothing there is ratified (one neutral `[OWNER]` TODO
pointer per batch, never a ROADMAP/REVIEW_ME filing); the tree IS published at `/dreamed/<slug>`; its
Lean sits outside the lake targets; and its Lean/Python run under `capped.sh` (systemd scope,
`MemoryMax`, `MemorySwapMax=0`, `CPUQuota`), with exit 137 meaning the cap fired. Conventions only, no
status.

Reverse-handoff (§5b): the one new open item this window, `id:c454`, is an `[OWNER]` triage pointer for
the dreamed batch. Owner-only theory direction with pending rulings, explicitly not self-settling, so it
is correctly NOT promoted to ROADMAP and was left as a TODO item per §5b's design-judgment branch.

relay-doctor: cross-ledger drift clean; `roadmap-lint` clean (every open item carries a recognized lane
tag + id). `todo-conformance` reports many `grammar-continuation` plus 3 `shape-prose` and 1
`grammar-item-title-long` findings, all pre-existing and all the known ledger line-shrink class
(dotclaude-skills `id:55f6`/`id:0d7c`); no new box filed, the tooling for that lands upstream.
`orphan-scan --shipped` reports two UNMARKED-GATE items, `id:9d8c` and `id:4bb2`; both ALREADY have open
REVIEW_ME boxes (lines 200 and 212), so no duplicate was added.

One new REVIEW_ME box, `id:8b1c`: the 43 published `/dreamed/*` pages have zero render coverage, and the
coverage guard cannot notice, because `test_mathjax.cjs` walks a hardcoded 7-entry `DOCS` array and
`test_page_coverage.sh` merely asserts 5 named pages appear in that same array -- the list is checked
against itself. Surfaced with three dispositions rather than fixed: gating `make test` on unratified
exploration prose may be exactly the wrong answer, and that is the owner's call.

0 open [ROUTINE] after re-derivation. The single `[ROUTINE]` substring in ROADMAP.md is prose inside
`id:8807`'s `@container` line describing how its TODO twin was historically tagged, not a lane tag.
[id:8b1c]

## 2026-09-07 11:48 — reviewer (claude-opus-5, fable-standin, relay-loop)

review: window clean (no executor unit ran); 14/14 tiers green incl. real Lean build; documented docs/dreamed/ conventions in CLAUDE.md; surfaced id:8b1c (43 published /dreamed pages, zero render coverage, self-checking allowlist) [id:8b1c]

## 2026-09-07 16:35 — reviewer (claude-opus-5, fable-standin, relay-loop)

review: 5 Bloch Truth commits verified green (14/14 tiers, zero skips; id:c086 numbers reproduced, 4 dreamed Lean files re-elaborated); no gaming; 5 findings surfaced, nothing reopened [id:8b1c,c086,987e,0fba,ef6b,bcc6,a4bc,ff4c,9d8c]

## 2026-09-08 -- reviewer (claude-opus-5, relay-loop)

review: 15 commits since relay-ckpt-20260907-1635, all foreground/owner-session work (pascalized
carry-back, an 58-distillation audit, the null-vector fix, three `/relay human` rulings). No executor
unit ran, so no ROADMAP item was closed and none was reopened. Test integrity: gaming-scan.sh clean
(zero DELETED_TEST/ADDED_SKIP/REMOVED_ASSERT), no test file modified (only additive: new advisory
tier `test_carryback.sh` + its `run.sh` wiring), so no resurrection case to run; no `@owner-accepted`
or `@owner-answered` anywhere in the diff. Tiers: 14 blocking + 2 advisory all RAN and passed, zero
SKIPs (test_verify, test_verify_entropy_routine, test_render, test_verify_hook, test_mw_mirror,
test_lean incl. a real `lake build`, test_page_coverage, test_crypto_exclude, test_conventions_ladder,
test_toolchain_pointer, test_ci, test_make, test_mathjax.cjs, test_veqs_inline.cjs; advisory
test_dreamed_render.cjs 84 pages, test_carryback.sh 8 present / 0 missing / 2 refused). CI declares
only a subset of these and is covered by test_ci. `test_verify_entropy.sh` stays deliberately outside
the loop (RED spec for gated id:76e5). roadmap-lint clean, orphan-scan --cross-ledger clean,
todo-conformance has no missing-id/orphan class (its 296 continuation + 33 shape-prose findings are
the pre-existing dotclaude-skills id:0d7c line-shrink class, not new).
Reverse-handoff (review.md 5b): six items were added to TODO.md this window. `id:0720` was the only
execution-ready one and is PROMOTED to ROADMAP.md as `[ROUTINE]`, reusing its token, with acceptance
transcribed from the owner's ruling unchanged and a RED spec `tests/test_dreamed_lean_pin.sh`
(`# roadmap:0720`) whose load-bearing assertions are that a mutated `.lean` file AND a mutated
toolchain pin each drive the checker non-zero -- the ruling's own "the pin is a trigger, not just
documentation". `id:e029` `[INPUT - decision]`, `id:e562` `[INPUT - meeting]` and the four `[OWNER]`
triage items (`a1aa`, `ed2b`, `781e`, `52ea`) are owner judgement and correctly stay out of the queue.
Findings: 2 REVIEW_ME boxes (the `[REFUSED: …]` marker in test_carryback.sh is an author-controlled
exemption, safe only while the tier is advisory; `id:e562`'s unmarked gate). relay-doctor: no
toesnail-specific finding.
refactor: none needed -- this unit added a promotion, a RED spec and two review boxes; nothing to unify.

## 2026-09-08 18:07 — reviewer (claude-opus-5, fable-standin, relay-loop)

review: 15 owner-session commits audited clean (gaming-scan zero, no provenance markers, 14 blocking + 2 advisory tiers green with zero SKIPs); promoted id:0720 to [ROUTINE] with a RED spec; 2 REVIEW_ME boxes; nothing reopened [id:0720]

## 2026-09-08 — executor (claude-sonnet-5)

Worked id:0720 -- implemented the pinned-good hash + Mathlib/toolchain drift guard for
`docs/dreamed/lean/*.lean`: `verify/dreamed_lean_pin.sh` (pure hash/pin comparison, no
`lake` on PATH needed) checked against a new baseline `docs/dreamed/lean-pins.json` (56
recorded hashes + the current toolchain/Mathlib rev pin), with the pin restated in
`docs/dreamed/README.md` for a reader of the "machine-checked" claims. Wired
`tests/test_dreamed_lean_pin.sh` into `tests/run.sh`'s blocking tier and updated its
now-stale RED-spec header comment. `bash tests/test_dreamed_lean_pin.sh` and the full
`bash tests/run.sh` both exit 0.
Friction: none -- the RED spec's four sub-assertions ((a) hash coverage, (b) both file-
and pin-drift trigger non-zero and name the file, (c) the pin is reader-facing, and the
no-`lake`-needed constraint) fully determined the implementation; no ambiguity.
refactor: none needed -- new detector + baseline file, wiring into run.sh's existing
list is the only change to prior code.

## 2026-09-08 18:15 — executor (sonnet, relay-loop)

Closed id:0720: pinned-good hash + Mathlib/toolchain drift guard for docs/dreamed/lean/*.lean (verify/dreamed_lean_pin.sh + docs/dreamed/lean-pins.json), wired into tests/run.sh; full suite green. [id:0720]

## 2026-09-08 18:52 — reviewer (claude-opus-5, fable-standin, relay-loop)

review: window `relay-ckpt-20260908-1807`..HEAD, 6 commits, one executor unit (`id:0720`). The
latest tag at dispatch was the EXECUTOR's own checkpoint `relay-ckpt-20260908-1815` at HEAD, so
the literal review.md §1 window is empty; the honest audit window is the previous REVIEWER
checkpoint, and that is what was used. Test-integrity: `gaming-scan.sh` clean (zero
DELETED_TEST/ADDED_SKIP/REMOVED_ASSERT). One test file was modified, `tests/test_dreamed_lean_pin.sh`
-- resurrection check RUN and it is comment-only: `diff` of the pre-window body against the current
body beyond the header block is byte-identical, so no assertion moved. No `@owner-accepted`,
`@owner-answered` or `answer-src:` introduced anywhere in the diff, and no line already carrying one
was modified. No `[host:` tag, so §2c does not apply.
Tiers (§3, run-or-record-skip): 15 blocking + 2 advisory all RAN and passed, ZERO skips --
test_verify, test_verify_entropy_routine, test_render, test_verify_hook, test_mw_mirror, test_lean
(a real `lake build`), test_page_coverage, test_crypto_exclude, test_conventions_ladder,
test_toolchain_pointer, test_ci, test_make, test_dreamed_lean_pin (NEW this window),
test_mathjax.cjs, test_veqs_inline.cjs; advisory test_dreamed_render.cjs (84 pages, no breaks) and
test_carryback.sh. `SUITE: PASS`. `test_verify_entropy.sh` stays deliberately outside the loop (RED
spec for gated `id:76e5`). Load context for the timing: `uptime` load average 5.00 at the start of
the run.
`id:0720` VERIFIED GREEN, not taken on report: all four acceptance assertions were watched firing --
56/56 recorded hashes matching the tree, the recorded toolchain and Mathlib rev matching
`verify/lean-toolchain` and `verify/lake-manifest.json`, a mutated `.lean` file driving the checker
non-zero AND naming the drifted file, a mutated toolchain pin driving it non-zero (the ruling's own
"the pin is a trigger, not just documentation"), and the checker running on a minimal PATH with no
`lake`. §2d over-reach: the cited ratified source is the owner's 2026-09-08 `/relay human` ruling,
re-read at its TODO `id:0720` transcription rather than at the ROADMAP restatement; the diff is not
a superset of it -- nothing re-elaborates, which is precisely the half the owner rejected on cost.
§2b.6 refactor claim (`none needed`) is consistent with the diff: a new detector, a new baseline
file, and one wiring line.
Spec drift (§4), both FIXED here: `tests/README.md` still called the tier list "14 automated tiers"
and listed `test_dreamed_lean_pin.sh` as a still-RED spec deliberately outside `run.sh` -- false as
of this window's own commit, now 15 and blocking. `ARCHITECTURE.md` §3 opened "`tests/run.sh` =
three layers", a count that has been wrong for longer; reworded to name the three as the FOUNDING
layers and point at `run.sh`'s loop as authoritative, rather than minting a new number that rots
the same way. The `## Relay contract` pointer is v18 and matches the canonical marker -- no refresh.
Findings: ONE new REVIEW_ME box -- the new guard is in `make test` but NOT in CI, which runs three
named tests and never `tests/run.sh`; since the drift it guards arrives as a commit, the guard today
only fires for whoever runs the full suite locally. Three options offered with their costs, the
middle one (CI runs `run.sh`) deliberately priced because it drags `test_lean`'s cold Mathlib build
into every push, the cost `id:9d8c` is parked on. Box `id:ef6b` (the question `id:0720` answers) was
annotated ANSWERED + DELIVERED + independently verified, and left UNTICKED on purpose: this file's
header defines a tick as the owner's confirmation, the same call the `id:8b1c` box records.
relay-doctor: no toesnail-specific finding (0 issues for this repo; the parked orphans and
relay-core shadow mismatches it reports belong to other repos). roadmap-lint clean, `--strict`
clean. orphan-scan `--cross-ledger` clean; `--shipped` reports the two known UNMARKED-GATEs
(`id:9d8c`, `id:e562`), both already carrying REVIEW_ME boxes, no TICK-READY items.
todo-conformance has no missing-id and no orphan class -- its 296 continuation + 33 shape-prose +
20 long-title findings are the pre-existing dotclaude-skills `id:0d7c` line-shrink class, unchanged.
Reverse-handoff (§5b): NO open item was added to TODO.md or ROADMAP.md in this window, so there was
nothing to qualify. `routine_open` = 0 -- every one of the 13 open ROADMAP items is GATED, `[INPUT
- meeting]`, `[INPUT - decision]` or `[HARD - hands]`; there is no executor work left in the queue.
Nothing reopened.
refactor: none needed -- this unit corrected two stale doc claims and wrote one review box; there is
no code here to unify.

## 2026-09-08 19:02 — reviewer (claude-opus-5, fable-standin, relay-loop)

review: id:0720 verified genuinely green (all 4 acceptance assertions watched firing, 15 blocking + 2 advisory tiers, zero skips); gaming-scan clean, resurrection check comment-only; fixed tier-count drift in tests/README.md + ARCHITECTURE.md; 1 REVIEW_ME box (guard not in CI); nothing reopened; routine_open=0 [id:0720,ef6b]

## 2026-09-11 — reviewer (claude-opus-5, relay-loop)

Reviewed `relay-ckpt-20260908-1902`..HEAD, 2 commits, BOTH owner-authored -- so there was no executor
work to trust-but-verify and the pass is a doc/test-integrity audit rather than an anti-gaming one.
`gaming-scan.sh` clean (no DELETED_TEST / ADDED_SKIP / REMOVED_ASSERT). No file under `tests/` or
`verify/` was touched by the window, so the resurrection and fixture-special-casing checks have no
candidates. No `@owner-accepted`, `@owner-answered` or `answer-src:` marker was introduced or
modified. Tiers run: `tests/run.sh` -- 13 blocking bash + 2 blocking node (`test_mathjax.cjs`,
`test_veqs_inline.cjs`) all PASS, including `test_lean.sh` with a REAL `lake build` (8314 jobs, cache
hit), plus the 2 advisory tiers (`test_dreamed_render.cjs`, `test_carryback.sh`) which by design never
gate. Zero skipped tiers; `npm run test:math` and the four CI steps are subsets of that run. No
`verify-negative-cases.py` tier exists in this repo, so §3(d) does not apply.

Two findings, both filed as REVIEW_ME boxes. `id:9772`: the `id:0720` CI step landed with nothing
asserting it stays there. `tests/test_ci.sh` asserted exactly three references and PASSed
byte-identically before and after the step was added, so the owner's resolution note citing that PASS
as verification was citing a test that could not distinguish the two states. Fixed here -- the file now
asserts the workflow references `verify/dreamed_lean_pin.sh`, keyed on the script path and not the
step label, and the assertion was proved discriminating by negative control (strip the step from a
scratch copy of `ci.yml`: fails at exactly the new assertion, nowhere earlier). `id:9c03`: the stated
rationale for ROADMAP's "Meeting-gated backlog" section -- that `/relay human`'s gather "reads
ROADMAP.md + REVIEW_ME.md, not TODO.md" -- was true in 2026-07-20 and is false since `id:4e67` added a
TODO.md human-lane scan with dedup. Verified live, not inferred: the gather emits `id:c9d4`, `id:e029`
and `id:e562`, all TODO-only. Nothing is double-counted (each mirrored id appears once), so this is a
lapsed rationale rather than a live defect, and retiring the seven mirror lines is the owner's call.

The window's lane-delimiter conversion was verified rather than assumed: `roadmap-lint.sh` reports
every open item as carrying a recognized lane, and `gather-human-backlog.sh` resolves both the new
ASCII-hyphen `[INPUT - meeting]` lines (`hard_meeting`) and the still-em-dash venue-keyed `hands` line
at `ROADMAP.md:190` (`hard_hands`), so no lane went invisible to dispatch. That surviving tag is
deliberate and documented in `10b9ca3`: `lane-convert.sh` never auto-converts it. Refreshed the
`CLAUDE.md` relay-contract pointer v18 -> v19. relay-doctor: 0 repo-scoped issues -- cross-ledger
clean, roadmap-lint clean, mechanical-orphan clean, main-checkout residue clean, 0 missing-id and 0
orphan TODO lines; the 296 continuation / 33 shape-prose / 20 long-title findings are the unchanged
dotclaude-skills `id:0d7c` line-shrink class. `orphan-scan --shipped` reports the same two known
UNMARKED-GATEs (`id:9d8c`, `id:e562`) as last pass, no TICK-READY items. Reverse-handoff (§5b): the
window added no open TODO/ROADMAP item, so there was nothing to qualify. Over-reach check (§2d):
nothing was closed this pass, and the one behaviour change (the CI step) matches the owner's ratified
option (c) exactly -- one step invoking one script, not a `tests/run.sh` wiring, so it is not a
superset. `routine_open` = 0; all 13 open ROADMAP items are GATED, `[INPUT - meeting]`,
`[INPUT - decision]` or the venue-keyed `hands` line. Nothing reopened.
Friction: none.
refactor: none needed -- the only code change is one added assertion in an existing test, with no
duplication introduced and nothing to extract.

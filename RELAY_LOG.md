# Relay log <!-- merge=union; append-only — never edit or reorder past entries -->

## 2026-09-07 10:32 — executor (claude-sonnet-5)

Worked id:0183 -- wired `test_ci.sh` and `test_make.sh` into `tests/run.sh`'s tier loop. Both tests already existed and passed standalone but were armed nowhere, so `bash tests/run.sh` never ran them (the id:d35a silent-no-op class); one-line addition, nothing else touched. Verified both individually (exit 0 each) and via a full `bash tests/run.sh` run (SUITE: PASS, exit 0) which now includes them. Friction: the full suite's `test_lean.sh` tier does a real `lake exe cache get` + build under high host load (load average ~20, swap-heavy), so the run took well over the 120s foreground timeout and had to be backgrounded -- unrelated to this item, just noting the wall-clock cost of the definition-of-done check on this repo.
refactor: none needed -- one-line addition to an existing loop, no new duplication.

## 2026-07-07 18:51 — reviewer (claude-opus-4-8, fable-standin, relay-loop)

review: verify green window since relay-ckpt-20260704-1759 (docs+ledger+unwired probe; 11/11 tiers green, gaming-scan clean); id:b7e5 drift legit author-then-run; routine_open=0

## 2026-07-07 19:05 — reviewer (claude-opus-4-8, fable-standin, relay-loop)

review: window since relay-ckpt-20260704-1759 re-verified green (11/11 tiers PASS, gaming-scan clean); b7e5 drift = legit author-then-run split; contract v6 current; routine_open=0 [id:b7e5,57e2]

## 2026-07-08 11:28 — reviewer (claude-fable-5, relay-next)

SE-corpus mining + lasercool deep dive session reviewed: 4 docs commits audited (scope-guard clean, suite green); Q13-Q15 ratified, Q16 → REVIEW_ME; id:b7e5 drift = known author-then-run split

## 2026-07-08 11:37 — reviewer (claude-fable-5, relay-next)

lane-grammar fix: id:e552 → conforming [HARD — hands] checkbox item (owner-flagged violation); id:c9d4 Lean entropy-bound forward-flag added

## 2026-07-08 11:52 — reviewer (claude-fable-5)

owner closing thought (photon-energy scaling / maser cooling) recorded as findings addendum 5d + id:e552 extension; citations agent-verified (Albanese 2020 correction applied)

## 2026-07-10 17:30 — reviewer (claude-opus-4-8, fable-standin, relay-loop)

toesnail review: diff-window clean (gaming-scan OK, suite PASS); promoted id:318f lean-toolchain pointer [ROUTINE]+red spec, @container'd decomposed id:7306 [id:318f,7306]

## 2026-07-10 — executor (sonnet)

Worked id:318f — added the lean-toolchain provenance pointer to CLAUDE.md 'Related projects' section (cache/derived value, toesnail as rev-bump decider, mathematical-writing as fleet-value publisher); test_toolchain_pointer.sh green, full suite green.
Friction: none.

## 2026-07-10 18:21 — executor (sonnet, relay-loop)

Documented the lean-toolchain provenance pointer in CLAUDE.md (id:318f) — closes the routed:89d0 inbound item; full test suite green. [id:318f]

## 2026-07-10 19:16 — reviewer (claude-opus-4-8, fable-standin, relay-loop)

toesnail review: id:318f lean-toolchain pointer verified green (spec unchanged, gaming-scan clean, suite PASS); no reopens, 0 open ROUTINE [id:318f]

## 2026-07-11 — executor (sonnet, relay-loop)

Worked id:c7d6 — implemented the RUN half of the badge-colour split (owner-picked Option C,
REVIEW_ME 2026-07-11): added a hardcoded `\textcolor{<hex>}{...}` wrapper per verification-tier
badge macro in both `_includes/custom-head.html` and `.vscode/settings.json` (grey `\sorry`,
blue `\sympy`, amber `\numeric`, green `\lean`, deep-green `\sympylean`; the four `\<tier>c`
open-debt variants reuse their discharged tier's hue). Chose the plain-\textcolor route over
the CSS-\htmlClass route per the README's own "trust may be unavailable" fallback — no `trust`
config needed in either engine. Extended `tests/test_mathjax.cjs` with a dedicated "badge
colour" section asserting each tier's ratified hex actually appears in BOTH engines' rendered
output (not just "renders without error"), synced the `MJ_MACROS`/`KX_MACROS` mirrors, and
ticked TODO id:b7e5 (now that both author and run halves are done) alongside ROADMAP id:c7d6.
Full `bash tests/run.sh` SUITE: PASS (real Lean build, real Jekyll build, real npm-installed
mathjax-full/katex — no SKIPs this session).
Friction: two real gotchas surfaced and are now commented in the source at point of use —
(1) KaTeX's own macro-arity scanner misparses a literal hex starting `#1…` (e.g. `#15803d`,
`#14532d`) as an argument placeholder ("#1"), corrupting the render with "Unexpected end of
input in a macro argument"; fixed by dropping the leading `#` everywhere (both KaTeX and
MathJax accept a bare 6-digit hex — confirmed empirically, not just per KaTeX's own docs).
(2) `_includes/custom-head.html` is rendered through Jekyll's Liquid engine before it ever
reaches MathJax, so the `\sympyleanc` macro's `{{\checkmark...` (two adjacent literal braces
from wrapping an already-grouped TeX expression in `\textcolor{}{}`) was read as a Liquid
`{{ variable }}` tag and broke the site build (`test_render.sh`, silently truncated out of an
initial `tail -80` capture of the suite output — re-ran the full log to find it). Fixed with a
single space between the two braces (harmless in both TeX engines). Re-walking
`tests/HUMAN-integration.md` for the visual check is `[HUMAN]` — not done by this session.

## 2026-07-11 13:17 — executor (sonnet, relay-loop)

Implemented ROADMAP id:c7d6 (badge-colour RUN half, Option C) — hardcoded \textcolor per verification-tier badge macro in both engines, extended test_mathjax.cjs with colour assertions, ticked TODO id:b7e5 + ROADMAP id:c7d6; full suite PASS (real Lean/Jekyll/npm, no SKIPs). [id:c7d6,b7e5]

## 2026-07-11 13:42 — reviewer (claude-opus-4-8, fable-standin, relay-loop)

Reviewed toesnail: id:c7d6 badge-colour RUN half verified genuinely green (live under both engines); filed id:0030 drift-guard [ROUTINE] + colour visual re-walk REVIEW_ME box [id:c7d6,0030]

## 2026-07-11 — executor (sonnet, relay-loop)

Worked id:0030 — extended `tests/test_mathjax.cjs`'s source-guard block with a drift check for
the whole badge-macro family (`\sorry`/`\sympy`/`\numeric`/`\lean`/`\sympylean` +
`\<tier>c` open-debt variants): for each macro, extract its raw definition from BOTH
`_includes/custom-head.html` (MathJax) and `.vscode/settings.json` (KaTeX) and assert it is
byte-identical to this test's own `MJ_MACROS`/`KX_MACROS` mirror (colour hex included) — the
existing `\ltag` guard only covered one macro. Verified the guard actually catches drift by
temporarily dropping `\textcolor` from `leanc` in each config file in turn (both mutations
made `node tests/test_mathjax.cjs` FAIL as required by the done-check) then restoring the
originals; full `bash tests/run.sh` is green (real Lean/Jekyll/npm run, no SKIPs — symlinked
`node_modules` from the main checkout since the worktree started without it). Ticked ROADMAP
id:0030.
Friction: none.

## 2026-07-11 14:07 — executor (sonnet, relay-loop)

Closed ROADMAP id:0030 — extended test_mathjax.cjs's drift guard to the whole verification-tier badge macro family (custom-head.html + .vscode/settings.json vs mirror), verified it catches a dropped \textcolor in either file, full suite green. [id:0030]

## 2026-07-11 14:32 — reviewer (claude-opus-4-8, fable-standin, relay-loop)

Reviewed toesnail: id:0030 badge-macro drift guard verified genuinely green (gaming-scan clean, guard fires on dropped \textcolor, full suite PASS no SKIPs); ticked TODO twin, surfaced id:9d8c unmarked-gate advisory [id:0030]

## 2026-07-13 13:25 — reviewer (claude-opus-4-8, fable-standin, relay-loop)

review: toesnail green (9 shell + Lean tiers pass, node math tiers skip-recorded); gaming-scan clean; doctor+lint clean; 0 open ROUTINE

## 2026-07-16 13:20 — reviewer (claude-opus-4-8, relay-loop)

review: toesnail — diff window relay-ckpt-20260713-1325..HEAD held exactly ONE substantive commit (c1d980d, a
one-line inbox ingest of routed:b0c5 → TODO id:ff32); no executor code work to trust-but-verify, so no item was
verified-green and none reopened. gaming-scan clean (0 DELETED_TEST/ADDED_SKIP/REMOVED_ASSERT); relay-doctor
clean (0 issues); roadmap-lint + todo-conformance + cross-ledger all clean. ALL 12 declared tiers RAN GREEN, no
skips: test_verify, test_verify_entropy_routine, test_render, test_verify_hook, test_mw_mirror, test_lean (lake
build + no-sorry), test_page_coverage, test_crypto_exclude, test_conventions_ladder, test_toolchain_pointer,
test_mathjax.cjs, test_veqs_inline.cjs. The last two had been SKIP-recorded by the previous two reviews for a
missing node_modules — `npm ci` in the worktree un-skipped them (lock stayed clean, node_modules is gitignored)
and both pass, closing the isochrone-class silent-tier gap (review.md §3) rather than re-recording the skip.
Residual manual tier: tests/HUMAN-integration.md (irreducibly-visual MathJax checks) — human pass, unchanged.
spec-drift: CLAUDE.md `## Relay contract` pointer refreshed v6 → v9 (canonical marker in
dotclaude-skills/relay/references/executor-contract.md); pointer body already current, marker only. README +
ARCHITECTURE describe what shipped — no drift (window shipped no user-facing surface).
reverse-handoff §5b: id:ff32 (the one newly-added open item) qualified `[INPUT — meeting]`, NOT promoted to
ROADMAP and NOT executor work — it is an owner-direction physics research question (T-matrix ↔ Gaussian-splat ↔
WiRoHSH) with no observable done-state, and this repo's hard constraint reserves theory direction to the owner;
reused its existing id, no duplicate minted.
0 open [ROUTINE] after re-derivation (all 6 open ROADMAP items are gated/container/[INPUT]/[HARD — hands]).
refactor: none needed — this unit wrote only ledger/doc lines (no code surface to clean up).
[id:ff32]

## 2026-07-16 13:20 — reviewer (claude-opus-4-8, fable-standin, relay-loop)

Reviewed toesnail: window held only a 1-line inbox ingest (no executor work to verify); all 12 tiers ran green with ZERO skips (npm ci un-skipped the 2 node math tiers the prior 2 reviews skip-recorded); gaming-scan/doctor/lint clean; pointer v6→v9; qualified id:ff32 [INPUT — meeting]; 0 open ROUTINE [id:ff32]

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

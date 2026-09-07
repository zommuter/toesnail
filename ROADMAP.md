# Roadmap <!-- relay roadmap v1 -->

Executor-facing task spec. Each `[ROUTINE]` item is sized for ONE Sonnet session and is
the single source of truth (TODO.md carries only a summary line). Executors tick
checkboxes; only the reviewer adds, removes, or re-scopes items.

> **Scope guard (read `CLAUDE.md` → "Repo-specific scope guard" first).** This is
> owner-dictated theoretical-physics prose. `[ROUTINE]` work is **tooling only** (build,
> tests, CI, `verify/` plumbing). **No executor edits physics/maths/narrative content
> (`physics/*.md`, `essays/*.md`) or resolves a `verify:` finding** — that is human-only
> (see the bottom section). If a `[ROUTINE]` item seems to require editing prose math to
> pass a test, it was mis-tagged: STOP and hand it back.

## Items

### Verify commit-hook cluster (v1 HARD tier — TOOLING)

Design spec: `docs/meeting-notes/2026-06-16-0635-relay-aware-commit-hook.md` (D1–D6). Order is by
dependency: **0e63 (mirror) → 8757 (hook, depends on 0e63 + `.mw`) → d5f9 (config + doc)**. The shared
red suite is `tests/test_verify_hook.sh` (+ `tests/test_mw_mirror.sh` for the `.mw` DAG signal); both are
**id:211c's deliverable** — already AUTHORED by this handoff; the executor's job is to make them GREEN, not
to write them. Do NOT mint new ids; do NOT touch physics content.

### Lean `edot` cluster (SCOPED 2026-06-16, meeting `2026-06-16-0827-lean-edot-proof-mathlib-bringup.md` D1–D5)

The 2026-06-15 single Lean item was decomposed by the 2026-06-16-0827 `/meeting` into the cluster below.
Toolchain is now CONFIRMED present (`/usr/bin/{lake,lean,elan}`; elan toolchains `v4.30.0-rc2`+`v4.31.0`;
shared 415 MB `~/.cache/mathlib` download cache) — the HANDBACK-if-no-toolchain risk is moot. Order: **3317
(bring-up + proof) → 5776 (test wiring) → 1335 (marker) → 3275 (rigor-debt annotation)**. SCOPE GUARD still
binds: this is `verify/` plumbing + tests + attestation-marker bookkeeping ONLY — NO executor edits any
physics/maths/narrative prose. The proof is of an *owner-stated, SymPy-confirmed* claim (allowed).

### Recovered-pages infrastructure (recovery merge `c1e20b4`, 2026-06-16)

### Entropy + FHE SymPy verify-instrument bucket (/meeting id:3d2a D1/D3, promoted 2026-07-01)

Design spec: `docs/meeting-notes/2026-06-21-2129-lean-formalization-strategy.md` (D1/D3). The
owner has already PLACED the `\sympyc` open-debt badges in the source (id:8807); the executor's job
is the TOOLING half — build the SymPy instruments, write the sidecars, wire the test, and (badge-arg
carve-out D4) flip the discharged badges `\sympyc`→`\sympy`. **NO executor edits the physics/claims**
inside the `\veq{…}` — only the badge arg once its instrument is green. The `lambertw` marker
(`physics/entropy.md:59`, now `\leanc`) is OUT of scope — it belongs to the Lean bucket (id:37cc) and
its marker-split is an owner content decision, not this item.

- [ ] [INPUT — decision] Build the entropy + FHE-Stirling SymPy instruments + sidecars @container — 🚧 GATED (auto, id:3801; route:hard-split): DECOMPOSED into seams id:e9e9, id:76e5 — pick those, not this. fhe.md `stirling` claim's constant term (ln√(2π)) is a natural-log/log2 unit mismatch — Stirling's series requires log2√(2π); confirmed by SymPy asymptotic series + independent float check (offset doesn't shrink with n). Blocks 1 of 4 instruments; the other 3 (meanE/be/fd) verify cleanly and can ship as their own seam. <!-- id:7306 -->
  - **Why**: four owner-placed `\sympyc` (open-debt "desired SymPy, not yet verified") badges exist with
    no instrument behind them — `physics/entropy.md` `meanE` (l.22 mean-energy closed form),
    `be` (l.27 Bose–Einstein N→∞ limit), `fd` (l.35 Fermi–Dirac N=2), and `crypto/fhe.md` `stirling`
    (l.12 `\log_2(2^n)!` Stirling expansion with named correction terms + `O(2^{-n})` remainder). Mechanical
    SymPy plumbing over owner-marked claims = `[ROUTINE]` (scope guard, D4 carve-out).
  - **Scope**: create `verify/entropy_meanE.py`, `verify/entropy_be.py`, `verify/entropy_fd.py`,
    `verify/fhe_stirling.py` — each a `# /// script` uv-runnable SymPy instrument modelled on
    `verify/resogram_esol.py`: derive the claim symbolically, print exactly one `VERDICT: ✓`/`✗` line and a
    `CLAIM_HASH8`. `fhe_stirling.py` verifies the NAMED correction terms + the `O(2^{-n})` remainder
    symbolically (Stirling series), NOT eval-at-a-few-n. Create the sidecars `physics/entropy.toml` and
    `crypto/fhe.toml` (same shape as `physics/Resogram.toml`: `tier_floor`/`tiers`/`claim`/`by`, keyed by
    handle). Wire the new instruments + sidecars into `tests/test_verify.sh` (extend its instrument loop and
    its sidecar non-drift / handle-⊆-source check to cover `entropy.toml` + `fhe.toml`), or add a sibling
    `tests/test_verify_entropy.sh` wired into `tests/run.sh` — either way `make test` must cover them.
  - **Badge flip (D4 carve-out only)**: once an instrument is green and attested, flip its source badge
    `\sympyc`→`\sympy` (the four markers above). This is a badge-ARG edit only — do NOT touch the equation/claim.
  - **Tests**: `tests/test_verify_entropy.sh` (`# roadmap:7306`) — asserts each of the four instruments runs
    under `uv run` and prints `VERDICT: ✓`, and that `physics/entropy.toml` + `crypto/fhe.toml` attestations
    are drift-free with handles ⊆ source `\veq/\veqs` handles. Currently RED (instruments + sidecars absent).
  - **Done-check**: `bash tests/test_verify_entropy.sh` then full `bash tests/run.sh` (both exit 0).
  - **Context**: `verify/resogram_esol.py` + `physics/Resogram.toml` are the reference pattern; `\sympyc` =
    open-debt badge (id:feb8). Meeting `docs/meeting-notes/2026-06-21-2129-lean-formalization-strategy.md` D1/D3.

### Dreamed-batch tooling findings (filed 2026-09-01 by the owner-instructed ledger pass, batch id:8e64)

Three tooling defects located and coordinator-verified by the 2026-09-01 dreamed batch
(`docs/dreamed/`, TODO twin `id:2460`). All three are **tooling / inventory upkeep only** — no
physics, essays or `crypto/` prose, no `verify:` finding resolution, no marker moves. The scope
guard at the top of this file still binds.

> **Placement note (relay review 2026-09-07).** These three were filed under the
> `## Gated forward-flags — NOT yet executor work` heading with all three bodies stacked under
> `id:3381`, so `ac7b` and `17ee` carried no acceptance criteria at all and `roadmap-lint`
> rejected all three as `PARKED-POOL-LANE` — a pool-executable `[ROUTINE]` tag under a parked
> heading, i.e. dispatch-invisible (the `id:d35a` silent-no-op class). Same `md-merge`
> stacked-body damage that `584e93e` repaired in `TODO.md` for `id:2460`/`id:6646`. Moved here
> and re-attached to their own head lines; no text was changed, added or dropped.

- [ ] [ROUTINE] `docs/dependencies.md`: add the missing `dotclaude-skills` node <!-- id:3381 -->
  - **Why (located 2026-09-01, coordinator-verified: grep count for dotclaude-skills in `docs/dependencies.md` is 0)**: the file is the canonical three-node map (toesnail / `.mw` / collAIb), but the relay, the hooks, the ledger helpers and the commit-hook design all live in `~/src/dotclaude-skills`, which the map never mentions. `~/src/inflownistration`'s `instances.md` independently alleges the same gap. A dependency map missing a load-bearing dependency is the derived-doc-drift class `CLAUDE.md` warns about.
  - **Do**: add the node and its edges (which direction the dependency runs, and how strongly), matching the file's existing format. Documentation only, no code.
  - **Done-check**: the node exists with at least one typed edge; `bash tests/run.sh` exits 0.
  - **Context**: `docs/dreamed/inflownistration.md`; batch pointer TODO twin id:2460.

- [ ] [ROUTINE] `docs/se-corpus.md`: fix two misattributed rows (M-1 posts, P-C mechanism) <!-- id:17ee -->
  - **Why (located 2026-09-01, coordinator-verified)**: the corpus file is the inventory feeding the owner-only authoring item id:e552, so a wrong row sends the author down the wrong road. **Row M-1** lists posts `116633+a/116639, 337971, 186201` against the subject "generators: e^{a d/dx}, dilation alpha^{x d/dx} (self-answered), curl as skew so(3), curl eigenvectors", so positionally it attaches "(self-answered)" and the dilation to **337971**. Both belong to **116633/a-116639**. And 337971's actual subject, "Can the curl operator be generalized to non-3D?" (score 35, the owner's highest in the cluster), appears nowhere in the row; it also carries a live open question of the owner's own from 2013 (whether `A` can be `d_1^{-1}` and `d_{n-2}^{-1}` at once for `n != 3`), which the row hides entirely. **Row P-C** reads "Casimir eigenvalue eqs as field eqs", but q/27195's real title is "Can symmetry generators be used for quantization?" and its mechanism is **VARIATIONAL**, not an eigenvalue equation (`0 = delta <psi| p^2 - m0^2 |psi>` gives Klein-Gordon). Its accepted answer (Urs Schreiber, +22) gets Dirac from the **square root** via worldline supersymmetry, not from `W^2`, and neither answer appears in the row.
  - **Do**: correct both rows. Split 337971 into its own row with its real subject plus a note that it carries an open owner question. Restate P-C's mechanism as variational and record what its answers established. **Mechanical inventory upkeep only** (ROADMAP already calls `docs/se-corpus.md` maintenance ROUTINE-able): do NOT re-rank, re-promote, or change any row's **Status**, which is owner judgment.
  - **Done-check**: both rows name the right post for each claim; `bash tests/run.sh` exits 0 (unchanged).
  - **Context**: `docs/dreamed/generators-and-bch.md` and `docs/dreamed/casimir-field-equations.md`; batch pointer TODO twin id:2460. Suggested replacement text is in each essay's "Surfaced for the owner".

- [ ] [ROUTINE] Verify commit-hook: read the actual commit diff, and advance the note lifecycle <!-- id:ac7b -->
  - **Why (located 2026-09-01, coordinator-verified, `docs/dreamed/mw-collaib-triad.md`)**: `hooks/post-commit` runs a **CONSTANT PROBE**. It always simulates editing the same `e` definition in the mirror (`new_src = src.replace(e_def.content, e_def.content + " + 0  # probe")`) and **never reads the commit diff**, so every commit emits an identical, content-independent finding. Measured on this repo: **164 notes on `refs/notes/verify`, ALL `status:pending`, 0 triaged, 0 processed, and exactly ONE distinct findings string (`findings=stale`)**. The design's own observe-first log (`docs/meeting-notes/2026-06-16-0635-relay-aware-commit-hook.md`) therefore holds 164 copies of the same constant and has gathered zero evidence since installation. This is the silent-no-op class: a detector that fires correctly and resolves to nothing.
  - **Do**: (a) make the HARD tier read the committed diff and probe only the sections the commit actually touched, so the finding is a function of the commit; (b) either implement the pending/triaged/processed transition the design specifies, or delete the lifecycle field if no consumer is planned rather than emit a status nothing advances. Honour all four `CLAUDE.md` invariants (`.mw` optional and never a commit gate; no LLM in the hook; relay-skip; the mirror is a derived artifact). **Tooling only** -- no physics content, no marker moves.
  - **Tests**: extend `tests/test_verify_hook.sh` so that (1) two commits touching DIFFERENT sections produce DIFFERENT findings strings, and (2) a commit touching nothing relevant produces no finding or an explicit empty one. Currently RED: today every commit yields the same string.
  - **Done-check**: the two new assertions pass, then full `bash tests/run.sh` exits 0.
  - **Context**: surfaced by the 2026-09-01 dreamed batch (TODO twin id:2460). The existing 164 notes are local-only and lossy-on-rebase by design, so no migration is needed.

### Test-suite tier coverage (surfaced by the relay review 2026-09-07, §3 tier enumeration)

- [ ] [ROUTINE] Wire `tests/test_ci.sh` and `tests/test_make.sh` into `tests/run.sh` <!-- id:0183 -->
  - **Why (measured 2026-09-07)**: `tests/run.sh` runs 10 `.sh` tiers + 2 `.cjs` tiers. `test_ci.sh`
    (`# roadmap:9868`) and `test_make.sh` (`# roadmap:fca7`) are in `tests/` but in NO tier list, so
    `bash tests/run.sh` — this repo's stated definition-of-done — never runs them. Both items are CLOSED
    (`ROADMAP.archive.md:49` and `:40`), and both tests PASS when invoked by hand (verified: exit 0
    each), so their regression guards work and are simply not armed: deleting `.github/workflows/ci.yml`
    or the `Makefile`'s `test` target today leaves the suite green. A guard nothing runs is the
    `id:d35a` silent-no-op class.
  - **Do**: add `test_ci.sh` and `test_make.sh` to the `for t in …` list in `tests/run.sh`. Nothing else.
    `tests/test_verify_entropy.sh` is deliberately NOT included — it is the still-RED spec for the gated
    seam `id:76e5` (verified: exit 1 today), and its shipped half already runs as
    `test_verify_entropy_routine.sh`. `tests/probe_status_macros.cjs` is a probe, not a tier.
  - **Done-check**: `bash tests/run.sh` prints `RUN test_ci.sh` and `RUN test_make.sh` and exits 0.
  - **Context**: relay review 2026-09-07, review.md §3(a) tier enumeration. Tooling only.

## Gated forward-flags — NOT yet executor work

- [ ] (GATED — verify-pilot umbrella) verify-pilot instrument bucket @container — DECOMPOSED, no ungated executor work of its own. Seams: id:e9e9 (entropy meanE/be/fd instruments — SHIPPED, `ROADMAP.archive.md`), id:76e5 (fhe_stirling — GATED on owner content fix, below), id:5d31 (lambertw algebra — GATED on owner marker placement, below), id:37cc (five `\leanc` counts — decision-gate `/meeting`, below). Pick those seams, not this. TODO twin `id:8807` is the design-ledger parent (`[ROUTINE]`-tagged there historically, before the owner reshaped it into these seams); this ROADMAP line is its twin so `unpromoted-scan.sh` no longer misreads the parent as fresh un-promoted backlog. Stays open until every seam closes. <!-- id:8807 -->
- [ ] (FORWARD-FLAG, GATED — NOT yet executor work) CI Lean/Mathlib build <!-- owner-hold:local-lake-build-gate-suffices --> <!-- id:9d8c -->
  - **Gate**: a CI Mathlib build is ~60-min cold for one one-liner; warranted ONLY if local kernel-checking
    (id:5776's `lake build` gate) proves insufficient. Parked until that gate fires. Not dispatched.
  - **Marker corrected 2026-09-07 (relay review) — needs owner confirmation.** The 2026-07-19 `/relay
    human` pass wrote `<!-- gated-on: id5776-local-lake-build-gate -->` and ticked its REVIEW_ME box as
    DONE. That marker parsed to NOTHING: `lib-typed-edges.sh`'s extractor is
    `(?<=<!-- gated-on:)[0-9a-f,]+(?= -->)`, so both the space after the colon and the non-4-hex payload
    miss — the `id:d35a` silent-no-op class, and the tick was a false claim. `gated-on:5776` is also the
    WRONG edge: id:5776 is `[x]` closed (`ROADMAP.archive.md:137`), so a dependency edge on it would read
    as CLEARED and unpark an item the owner deliberately parked. The gate is a CONDITION ("only if the
    local gate proves insufficient"), which is exactly what `owner-hold:` (id:d119) expresses — an
    intentionally-unclearable hold. Owner: confirm `owner-hold` is the intent, or say what should clear it.

- [ ] (GATED — owner marker placement first) `lambertw` algebra-step SymPy instrument <!-- id:5d31 -->
  - **Gate**: /meeting id:3d2a D1 split the old `\veq{lambertw}\leanc` (`physics/entropy.md:59`): the ALGEBRA
    steps (l.53–57 inversion chain) are SymPy-provable → own handle + `\sympyc` open-debt badge; the closed-form
    W line (l.59) → `\definition` (its W-branch/domain caveat stays Lean-queued under id:37cc). Placing/moving
    `\veq` markers is OWNER-only content judgment (the D4 carve-out covers the badge ARG only), so the split is
    queued as a REVIEW_ME owner action. Once the split markers land, this becomes a `[ROUTINE]` instrument item:
    `verify/entropy_lambertw.py` + a `physics/entropy.toml` entry + a `tests/test_verify_entropy.sh` row (the
    id:7306 pattern). Split out of TODO id:7306's scope at the 2026-07-01 handoff (ROADMAP id:7306 deliberately
    excludes it); tracked here so closing id:7306 doesn't silently drop it. Not dispatched.

- [ ] (GATED — owner content fix first) `fhe_stirling.py` instrument + `crypto/fhe.toml` sidecar + badge flip <!-- id:76e5 -->
  - **Gate**: seam 2 of id:7306's hard-split (auto, id:3801). The instrument is blocked by a located finding
    in owner content: `crypto/fhe.md:12`'s `stirling` constant term is written `ln√(2π)` but the base-2
    Stirling expansion of `log₂((2^n)!)` requires `log₂√(2π)` = `ln√(2π)/ln 2` — a natural-log/log₂ unit
    mismatch (SymPy asymptotic series + independent float check; the ≈0.407-bit offset does not shrink with
    n; re-verified by the 2026-07-02 review). Resolving a located verify finding = editing owner math =
    HUMAN-ONLY (scope guard), so the fix is queued as a REVIEW_ME owner box (2026-07-02) — the id:5d31
    pattern. Once the owner fixes (or ratifies) the source line, this becomes a `[ROUTINE]` instrument item:
    `verify/fhe_stirling.py` (named correction terms + `O(2^{-n})` remainder, symbolic — NOT
    eval-at-a-few-n) + `crypto/fhe.toml` sidecar + the badge-ARG flip, after which the original
    `tests/test_verify_entropy.sh` (roadmap:7306) can go green and be wired. Not dispatched.
    (Re-laned from the auto-emitted `[HARD — strong model]` — not a recognized lane — by the 2026-07-02
    review; the blocking step is owner judgment, not model strength.)

- [ ] [INPUT — meeting] Lean claims — queued individually <!-- id:37cc -->
  - **Gate (decision-gate)**: NOT executor-ready. Each of the five `\leanc` claims — `ocount`
    (`Fintype.card_fun`), `bij24` (`Fintype.card_perm`), `semidestr`-count (`Nat.choose`),
    `semidestr`-identification (balanced⟺semi-destructive, owner modelling), `lambertw`-branch/domain —
    needs its OWN scoping `/meeting` (fidelity-consume + freeze the Lean signature, the `edot_deriv` pattern)
    BEFORE it can be sized `[ROUTINE]`. All stay `\leanc` open-debt until their meeting lands. Deliverables
    once scoped: `verify/Entropy.lean` + `verify/FHE.lean` (mirror `verify/Resogram.lean`), wired into
    `tests/test_lean.sh`; draft signatures go in the meeting note. Content/modelling judgment (esp. the
    balanced⟺semi-destructive identification) is owner-only.
  - **Context**: `docs/meeting-notes/2026-06-21-2129-lean-formalization-strategy.md` (D2). The `\leanc`
    markers are placed at `crypto/fhe.md:8,67,74` and `physics/entropy.md:59`.

### Meeting-gated backlog (surfaced by C2 reconciliation, 2026-07-20)

Un-promoted `[INPUT — meeting]` TODO.md items with no ROADMAP twin (`unpromoted-scan.sh`
disposition `laned`) — none are executor-ready; each needs a scoping `/meeting` first.
Promoted here (same id, TODO/design ledger stays the "why") purely so they stop being
invisible to `/relay human`'s gather, which reads ROADMAP.md + REVIEW_ME.md, not TODO.md.

- [ ] [INPUT — meeting] (MEETING candidate) Better workflow for math/Lean-formalization design sessions <!-- id:2f99 -->
  — e.g. meeting-rpg with in-session formula rendering (so equation-heavy decisions like
  id:b9bc's HasDerivAt signature are legible during discussion), or possibly a collAIb
  regime instead. To be scoped in a dedicated `/meeting`.

- [ ] [INPUT — meeting] Wishlist: automated subequation dot-numbering <!-- id:d2f4 -->
  — derive `(edot.1)…(edot.4)` handles from a parent handle so per-line tags render;
  also re-attaches the `[edot]` verify marker to an active `\ltag`. Relates to R2/R3
  (id:445e) + `.mw`. OPTION (owner obs 2026-06-18, entropy.md): let amsmath's native
  auto-enumeration number ephemeral steps for free instead of hand-inventing per-line
  subhandles; auto-numbers are NOT `\eqref`-able though. Needs scoping `/meeting`.

- [ ] [INPUT — meeting] Cross-project (triad): add the owner's Diplomarbeit `.git` repo <!-- id:6ab8 -->
  — a fully finished LaTeX project — as a second acceptance/test corpus for the
  `.mw`/toesnail/collAIb triad (N=2 beyond toesnail's north-star physics docs; exercises
  `.mw` ingest + verification on real finished LaTeX). **MIRRORED in
  `mathematical-writing/TODO.md` under the same id:6ab8** — keep both copies in sync
  MANUALLY (no automated cross-project sync); tick the twin wherever it's worked/closed.
  Likely resolved in a manual `/meeting`.

- [ ] [INPUT — meeting] Cross-project (triad): connecting dots between zkm infrastructure and the triad <!-- id:4159 -->
  — discuss embeddings/semantic-retrieval/knowledge-mgmt vs the `.mw`/toesnail/collAIb
  triad. toesnail is the documented hub (`docs/dependencies.md`); this would extend the
  dependency map with a zkm node. **MIRRORED in `zkm/TODO.md` under the same id:4159** —
  keep both copies in sync MANUALLY; tick the twin wherever closed. Likely a manual
  `/meeting`.

- [ ] [INPUT — meeting] Comment / annotation system for the GH Pages site <!-- id:d973 -->
  — idea salvaged from the archived `gtnsd` repo (see `gtnsd-archive` branch).
  Candidates: hypothes.is annotation overlay, staticman, `ghpages-ghcomments`, or a
  Jekyll static-comments recipe. Ties into collAIb's "live `verify:` assist UI"
  (annotation = surfacing rigor-debt in-page) and the `[edot]`-style handles (anchor
  targets). The gtnsd-era worry "how do annotations survive content changing over time?"
  is the inflownistration/staleness problem (`.mw` id:aae4). Design before wiring, low
  priority.

- [ ] [INPUT — meeting] [INBOUND routed:b0c5 from loderite] T-matrix ↔ Gaussian-splat ↔ WiRoHSH relationship <!-- id:ff32 -->
  — can a precomputed per-geometry response basis (T-matrix analogy) represent Gaussian
  splats compactly via WiRoHSH (Wick-rotated hyper-spherical harmonics)? loderite may
  become a showcase if applicable. **NB 2026-07-16 (relay review, reverse-handoff §5b):**
  qualified `[INPUT — meeting]`; NOT executor work and deliberately not promoted before
  now — an open physics-direction research question with no concrete change with an
  observable done-state; this repo's hard constraint reserves theory direction to the
  owner (`CLAUDE.md`: the AI never invents physics or decides narrative direction). Needs
  an owner scoping `/meeting` to rule on whether the correspondence is real and what (if
  anything) toesnail should author; only a tooling slice falling out of that ruling could
  later become `[ROUTINE]`. Existing surface: `physics/wirohsh.md`.

## Human-only — NOT in the executor queue

The research itself is the owner's. These are tracked in `TODO.md` (design ledger) and
`docs/rigor-debt.md` (triage menu), and the judgment calls surface in `REVIEW_ME.md` for
`/relay human` / `/meeting`. An executor never picks these up.

- **Resolve the Resogram pilot's located discrepancies** — `edot` (2nd equality wrong),
  `cval` (c≠0), `sol` (integrand paren). AI surfaced them; the owner decides each fix. See
  `REVIEW_ME.md`. (A `.mw`/collAIb tool may later *suggest* a fix, but a human ratifies it.)
- **Acoustics pilot #2** and all further `verify:`/`verified:` work — choosing which claims
  to mark and interpreting findings is owner judgment (the mechanical SymPy/handle plumbing
  for *owner-marked* claims can become `[ROUTINE]` once the claims are marked).
- **The toesnail spine's `verify:lean` targets** (Cauchy–Schwarz, inner-product axioms,
  zero-vector uniqueness) and any narrative/topic direction — `docs/rigor-debt.md`.
- [ ] [HARD — hands] Author the promoted SE subjects + ratified lasercool anchors (TODO id:e552 twin — tick both) <!-- id:e552 -->
  — Q13/Q14 ratified 2026-07-08 (`docs/meeting-notes/2026-07-08-1056-…` §5b): P-C Casimir→field-equations,
  P-A discrete-Noether, M-1+M-2 generators/matrix-exp, and the three lasercool.md section skeletons.
  Physics content = owner-only (scope guard); the mined inventory lives in `docs/se-corpus.md` (its
  mechanical upkeep can become `[ROUTINE]` later — nothing promotable now). The lone open Q16 (post the
  q/669175 self-answer, draft in `docs/drafts/`) is a REVIEW_ME owner box.
- The staleness-checker (TODO `id:04bb`) stays GATED on acoustics (N=2) before it becomes
  a `[ROUTINE]` tooling item.

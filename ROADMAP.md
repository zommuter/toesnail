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

- [x] Add a `Makefile` with `build`, `serve`, `test` targets [ROUTINE] <!-- id:fca7 -->
  - **Acceptance**: `make test` runs all three test layers (`tests/run.sh`) and exits 0;
    `make build` runs `bundle exec jekyll build`; `make serve` runs `bundle exec jekyll
    serve`. Targets are tooling wrappers only — they do not touch content.
  - **Tests**: `tests/test_make.sh` (`# roadmap:fca7`) — asserts the `Makefile` exists,
    `make test` exists and exits 0, and that it actually invokes `tests/run.sh` (currently RED).
  - **Done-check**: `bash tests/test_make.sh` then full `bash tests/run.sh`.
  - **Context**: wrap the existing `tests/run.sh`; the Ruby toolchain lives on the user
    gem path (see `CLAUDE.md` → Local build & tests). Pure convenience target; no new deps.

- [x] Add GitHub Actions CI running the test suite on push/PR [ROUTINE] <!-- id:9868 -->
  - **Acceptance**: `.github/workflows/ci.yml` installs `uv`, Ruby+`bundle`, and Node, then
    runs the three test layers (verify / render / mathjax). It is the safety net for the
    render regressions that bit us locally (headless pages, kramdown math, `\gdef`).
  - **Tests**: `tests/test_ci.sh` (`# roadmap:9868`) — asserts the workflow file exists,
    is valid YAML, and references each of the three test scripts (currently RED). The
    *actual CI run* is `# unverified — runs on GitHub Actions`; the local test only checks
    the workflow is well-formed and complete (a green local test is NOT a green CI run).
  - **Done-check**: `bash tests/test_ci.sh`; then confirm the run is green on GitHub after push.
  - **Context**: mirror the local toolchain setup in `CLAUDE.md`. Do not gate `main` on it
    without the owner's say-so; start as a reporting workflow.

### Verify commit-hook cluster (v1 HARD tier — TOOLING)

Design spec: `docs/meeting-notes/2026-06-16-0635-relay-aware-commit-hook.md` (D1–D6). Order is by
dependency: **0e63 (mirror) → 8757 (hook, depends on 0e63 + `.mw`) → d5f9 (config + doc)**. The shared
red suite is `tests/test_verify_hook.sh` (+ `tests/test_mw_mirror.sh` for the `.mw` DAG signal); both are
**id:211c's deliverable** — already AUTHORED by this handoff; the executor's job is to make them GREEN, not
to write them. Do NOT mint new ids; do NOT touch physics content.

- [x] Stand up a one-section Resogram `.mw` mirror the HARD tier reads [ROUTINE] <!-- id:0e63 -->
  - **Acceptance**: a checked-in `.mw` file (e.g. `verify/mirror/resogram_esol.mw`) FAITHFULLY transcribes
    ONE Resogram section's equations into `.mw` fragment syntax — the `esol` energy form (handle `e`), a
    sliding-average consumer of `e` (handle `ebar`), and the independent maintenance drive (handle `y`).
    It invents/alters NO physics (it mirrors `physics/Resogram.md` handles `esol`/`e`/`ymaint`). Editing the
    `e`/`esol` fragment flags its `$e$` citation + the `ebar` average STALE via `stale_after_edit`, while the
    unrelated `y` is untouched. Model it on `~/src/mathematical-writing/examples/resogram_cval.mw`.
  - **Tests**: `tests/test_mw_mirror.sh` (`# roadmap:0e63`) — runs `stale_after_edit` over the mirror via
    `uv run --project /home/tobias/src/mathematical-writing` and asserts the stale/not-stale split. (RED:
    `# unverified` until the mirror exists — see done-check; a SKIP is NOT a pass.)
  - **Done-check**: `bash tests/test_mw_mirror.sh` (must run the `.mw` DAG, not SKIP).
  - **Context**: `.mw` package import is `mathematical_writing` (NOT `mw`); `stale_after_edit(old, new)` is
    in `mathematical_writing.dag`; `parse()` in `mathematical_writing.parser`. FIDELITY is a judgment call —
    REVIEW_ME box (1) asks the owner to confirm the mirror matches the source section. N=2 guard: mirror ONE
    section only.
  - [x] **FIDELITY FIX follow-up [HARD — strong model] — RESOLVED 2026-06-16 (/meeting D3, owner-ratified): faithful four-block mirror (delta own fragment, ebar integral form); test green.** The
    DAG-mechanics test is green but the owner REJECTED the transcription fidelity (REVIEW_ME box 0e63). Two
    faithful-transcription corrections: (a) replace `ebar = Omega/pi * e` with the faithful half-period
    convolution `\bar e = (Ω/π)∫₀^{π/Ω} e(t-t')·e^{+2βt'} dt'` in `.mw` computation syntax (no scalar-multiply
    reduction); (b) add a SEPARATE `delta = atan2(Omega, beta)` fragment/cache item that the `e` block
    references (gives a `δ→e→ebar` DAG chain), not a dangling symbol.
    **Why HARD, not ROUTINE (reclassified 2026-06-16, grounded in `.mw` source):**
      (1) `test_mw_mirror.sh` gives ZERO fidelity signal — `mathematical_writing.dag` keys edges on REGEX
          symbol references (`_extract_defines_uses`/`_data_symbols`), so the `e→ebar` edge holds for ANY RHS
          merely containing `e`; the test is green for both the unfaithful `Omega/pi*e` AND a faithful
          integral (that's why the bug shipped green). An executor gated on "test passes" has no pressure
          toward faithfulness — owner-judged fidelity is the real gate and lives OUTSIDE the test.
      (2) Faithfully expressing `e(t-t')` is `.mw`-modeling judgment: the mirror defines `e` as a SymPy data
          symbol (`Expr`), but the convolution needs it evaluated at a SHIFTED argument. The eval/attestation
          core treats `e` as data, not callable — so the time-shift (`subs(t, t-tp)`? `Function`? `lambdify`?)
          needs `.mw` computation-semantics knowledge and may surface a `.mw` capability gap (cross-repo).
    The transcription TARGET is owner-settled; the IMPLEMENTATION needs strong-model sizing + the owner
    re-confirms fidelity (the test can't). Same id (single-id-two-views). <!-- id:0e63 -->.

- [x] Implement the v1 `post-commit` hook (deterministic HARD tier) [ROUTINE] <!-- id:8757 -->
  - **Acceptance**: a TRACKED `hooks/post-commit` (installed via `core.hooksPath hooks`, set in id:d5f9)
    that, on an OWNER commit, runs the HARD tier (`stale_after_edit` over the id:0e63 mirror) and appends a
    `git notes --ref=refs/notes/verify` note carrying `status:pending` + findings (append-only, never
    deletes). It **no-ops in a relay context** (`RELAY_SKIP=1` authoritative; `/worktrees/` substring in
    `git rev-parse --git-dir` fallback) — no note written, commit succeeds. It **degrades gracefully** when
    `.mw` is unavailable (HARD tier no-ops, logs "skipped: .mw unavailable", commit still succeeds). It
    **NEVER calls an LLM** and never raises/hangs.
  - **Tests**: `tests/test_verify_hook.sh` (`# roadmap:8757`) — pending-note-on-owner-commit,
    `RELAY_SKIP=1` no-op, `/worktrees/` path no-op, graceful-degrade-without-`.mw`, loose-note detection via
    `git merge-base --is-ancestor`. (currently RED)
  - **Done-check**: `bash tests/test_verify_hook.sh`.
  - **Context**: DEPENDS ON id:0e63 (the mirror) + `.mw` being importable. Invariants: never-an-LLM,
    `.mw`-optional, relay-skip — see `CLAUDE.md` → "Verify commit-hook". REVIEW_ME box (2) asks the owner to
    confirm the note schema/field set. Hook is the observe-first logger; SOFT/LLM tier is NOT here.

- [x] Set git config + document the hook install in `CLAUDE.md` [ROUTINE] <!-- id:d5f9 -->
  - **Acceptance**: repo git config sets `notes.rewriteRef = refs/notes/verify` and
    `notes.rewriteMode = concatenate` (default `overwrite` drops merged notes on squash) and
    `core.hooksPath = hooks` (tracked-hook install). A squash of two noted commits preserves BOTH findings.
    `CLAUDE.md` documents the exact install/config commands. Prefer a `make install-hooks` target (or a
    committed `tests/`-runnable setup script) so the config is reproducible, not hand-typed.
  - **Tests**: `tests/test_verify_hook.sh` (`# roadmap:d5f9`) — the `concatenate-on-squash` case asserts
    both findings survive a squash once `notes.rewriteMode=concatenate` is set. (currently RED)
  - **Done-check**: `bash tests/test_verify_hook.sh` (the squash case) + `git config --get notes.rewriteMode`.
  - **Context**: the `core.hooksPath` setup is folded in here (per the meeting note's hook-install
    decision). Config is local-repo, never global.

- [x] **Test suite for the hook cluster** — `tests/test_verify_hook.sh` + `tests/test_mw_mirror.sh` <!-- id:211c -->
  - This id is fulfilled by the C3 red suite this handoff already AUTHORED. The executor does NOT write these
    tests — its job across id:0e63/8757/d5f9 is to make them go GREEN. Recorded here for id-continuity only.

### Lean `edot` cluster (SCOPED 2026-06-16, meeting `2026-06-16-0827-lean-edot-proof-mathlib-bringup.md` D1–D5)

The 2026-06-15 single Lean item was decomposed by the 2026-06-16-0827 `/meeting` into the cluster below.
Toolchain is now CONFIRMED present (`/usr/bin/{lake,lean,elan}`; elan toolchains `v4.30.0-rc2`+`v4.31.0`;
shared 415 MB `~/.cache/mathlib` download cache) — the HANDBACK-if-no-toolchain risk is moot. Order: **3317
(bring-up + proof) → 5776 (test wiring) → 1335 (marker) → 3275 (rigor-debt annotation)**. SCOPE GUARD still
binds: this is `verify/` plumbing + tests + attestation-marker bookkeeping ONLY — NO executor edits any
physics/maths/narrative prose. The proof is of an *owner-stated, SymPy-confirmed* claim (allowed).

- [x] Stand up `verify/` lake project pinned `v4.30.0-rc2` + prove `edot_first_line` [HARD — strong model] [INTENSIVE — lean-build] <!-- id:3317 -->
  - **Why HARD + INTENSIVE**: first Mathlib extract is a heavy build (~6.6 GB, minutes even with the warm
    415 MB cache via `lake exe cache get`) — must run serially-alone (`--allow-intensive`), never inside a
    parallel wave (OOM risk, conventions §id:8d52). The proof itself is a one-liner (`subst; ring`); the cost
    is the bring-up, not the formalization.
  - **Acceptance** (D1/D2): tracked `verify/{lakefile.toml, lean-toolchain (→ v4.30.0-rc2),
    lake-manifest.json, Resogram.lean}`; `.gitignore += .lake/`; `verify/README.md` documents the canonical
    clean-clone build (`lake exe cache get && lake build`) plus the OPTIONAL btrfs `cp --reflink=auto` local
    space footnote (NOT a build step, NOT a symlink). `cd verify && lake build` exits 0 with NO `sorry`,
    discharging `theorem edot_first_line (x ẋ ẍ y β ω : ℝ) (eom : ẍ = -2*β*ẋ - ω^2*(x-y)) :
    ẋ*(ẍ + ω^2*x) = -2*β*ẋ^2 + ω^2*ẋ*y := by subst eom; ring`. This is the *algebraic* first-line identity
    (handle `edot`) — the derivative step is separate debt (id:b9bc), NOT in scope here.
  - **Done-check**: `cd verify && lake build` (exit 0) + `grep -L sorry verify/Resogram.lean`.
  - **Context**: `verify/resogram_edot.py` confirms the algebraic step symbolically; `docs/rigor-debt.md`.
    HANDBACK only if the warm-cache build fails for a reason no unattended fix covers (never `sudo`/`pamac`).

- [ ] Add `tests/test_lean.sh`, SKIP-without-lake, wired into `tests/run.sh` [ROUTINE] <!-- id:5776 -->
  - **Acceptance** (D4): `tests/test_lean.sh` mirrors the optional-tool SKIP pattern (`test_render.sh` w/o
    Ruby, `test_mathjax.cjs` w/o node) — `command -v lake` absent → SKIP (clean, never FAIL); present →
    `cd verify && lake build` + `grep -L sorry verify/Resogram.lean` (a `sorry`-green is a fake green and
    must FAIL). Wired into `tests/run.sh`. CI stays SKIP (no Lean toolchain there — id:9d8c is the gated CI
    item). DEPENDS ON id:3317 (the lake project must exist for the non-SKIP path).
  - **Tests**: this item *adds* the test; its own contract is the done-check below.
  - **Done-check**: `bash tests/run.sh` PASSes overall; on a lake-less host `test_lean.sh` SKIPs cleanly;
    on this host (lake present) it runs the real `lake build` + `grep`.
  - **Context**: optional-tool-SKIP is the ".mw optional, never a gate" invariant mirrored to Lean.

- [x] Escalate `edot` to the compressed multi-tier `verified:` marker + grammar doc [ROUTINE] <!-- id:1335 -->
  - **Acceptance** (D5): in `physics/Resogram.md:42`, rewrite the existing attestation **HTML comment** ONLY
    (NOT any prose/math) from `verified:sympy [edot] claim=b575864e by=resogram_edot.py@54710d91` to
    `verified:sympy+lean [edot] claim=b575864e by=resogram_edot.py@54710d91,Resogram.lean@<h8>` (same
    `srepr` claim-hash across tiers; `<h8>` = the new `Resogram.lean` filehash). Add the grammar
    `verified:<tiers> [handle] claim=<claimhash8> by=<inst1>@<h8>[,<inst2>@<h8>]`, `<tiers>` ∈
    {`sympy`,`lean`,`sympy+lean`}, to `CONVENTIONS.md` §2. SCOPE: this edits a `verified:` ATTESTATION
    marker (HTML comment for an owner-marked claim) — explicitly the allowed mechanical-plumbing carve-out
    (ROADMAP scope-guard bottom note). Touch NO equation, NO narrative. DEPENDS ON id:3317 (need the
    `Resogram.lean` filehash).
  - **Tests**: `tests/test_verify.sh` already parses `verified:` markers; the upgraded marker must still
    parse and the `edot` row must show the two-tier `by=` list.
  - **Done-check**: `bash tests/test_verify.sh` (marker parses, `edot` carries both instrument pointers).
  - **Context**: keep the `srepr` claim-hash byte-identical across tiers; only the per-instrument filehash
    differs. The automated staleness checker (id:04bb) stays N=2-gated — out of scope.

- [x] Annotate `docs/rigor-debt.md`: edot lean-attested + SymPy-as-gate datapoint [ROUTINE] <!-- id:3275 -->
  - **Acceptance** (D5): update the `[edot]` row in `docs/rigor-debt.md` to record that the algebraic
    first-line identity is now **lean-attested** (tier `sympy+lean`), with both instrument pointers
    (`resogram_edot.py`, `Resogram.lean`), AND record the per-tier outcome for the SymPy-as-gate dataset
    (did SymPy's `sympy ✓` correctly predict the lean-provable claim — a datapoint toward evaluating SymPy
    as a cheap pre-filter). This is triage-menu bookkeeping in a docs file — NO physics/math edits.
    DEPENDS ON id:3317 + id:1335.
  - **Done-check**: `grep -n 'edot' docs/rigor-debt.md` shows the `sympy+lean` row with both pointers.
  - **Context**: `docs/rigor-debt.md` is the triage menu, not a work order; this only annotates an already-
    resolved row.

- [ ] (DEBT, multi-day — NOT yet executor work) Derivative step `ė=ẋ(ẍ+ω²x)` via Mathlib `deriv` [HARD — strong model] <!-- id:b9bc -->
  - **Why deferred**: differentiating `e=½ẋ²+½ω²x²` and proving `ė=ẋ(ẍ+ω²x)` via Mathlib `deriv`/chain-rule
    is a multi-day formalization SymPy never checked (`resogram_edot.py` only does the *algebraic* step).
    Owner: "we can't have unverified maths dangling around" → tracked `verify:lean` debt, NOT discarded.
    Kept open and unsized as future strong-model work; not dispatched as a `[ROUTINE]` unit.
  - **Context**: gated behind id:3317 landing (needs the lake project + Mathlib in place first).

- [ ] (FORWARD-FLAG, GATED — NOT yet executor work) CI Lean/Mathlib build <!-- id:9d8c -->
  - **Gate**: a CI Mathlib build is ~60-min cold for one one-liner; warranted ONLY if local kernel-checking
    (id:5776's `lake build` gate) proves insufficient. Parked until that gate fires. Not dispatched.

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
- The staleness-checker (TODO `id:04bb`) stays GATED on acoustics (N=2) before it becomes
  a `[ROUTINE]` tooling item.

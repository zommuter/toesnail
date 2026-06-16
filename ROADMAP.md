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

- [ ] Stand up a one-section Resogram `.mw` mirror the HARD tier reads [ROUTINE] <!-- id:0e63 -->
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

- [ ] Implement the v1 `post-commit` hook (deterministic HARD tier) [ROUTINE] <!-- id:8757 -->
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

- [ ] Set git config + document the hook install in `CLAUDE.md` [ROUTINE] <!-- id:d5f9 -->
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

- [ ] **Test suite for the hook cluster** — `tests/test_verify_hook.sh` + `tests/test_mw_mirror.sh` <!-- id:211c -->
  - This id is fulfilled by the C3 red suite this handoff already AUTHORED. The executor does NOT write these
    tests — its job across id:0e63/8757/d5f9 is to make them go GREEN. Recorded here for id-continuity only.

- [ ] Lean proof of the `ė` first-line identity + stand up Lean4+Mathlib via `lake` [HARD — strong model] <!-- id:3317 -->
  - **Why HARD**: heavy toolchain bring-up (Lean4 + Mathlib via `lake`, large build) and a
    non-trivial formalization; reviewer-model + likely its own session. May HANDBACK if the
    relay host lacks the toolchain (never `sudo`/`pamac` unattended — record in RELAY_LOG).
  - **Acceptance**: `verify/Resogram.lean` + lakefile; `lake build` discharges
    `ė = ẋ(ẍ+ω²x) = −2βẋ² + ω²ẋy` (the SymPy-confirmed first-line identity, handle `edot`).
    This is a proof of an *owner-stated* claim (allowed); it does not invent or alter theory.
  - **Context**: `verify/resogram_edot.py` already confirms it symbolically; `docs/rigor-debt.md`.

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

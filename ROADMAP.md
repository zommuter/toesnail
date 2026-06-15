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

- [ ] Add GitHub Actions CI running the test suite on push/PR [ROUTINE] <!-- id:9868 -->
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

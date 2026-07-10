# toesnail

🦶 **TOE-SNAIL** — *Theory of Everything – Some Novel Approach Including Love ❤️ – Math on Demand Edition.*
A theoretical-physics / mathematics exploration written as a Jekyll/GitHub-Pages site, building physics
"math on demand" from first principles (QM from bra-ket up), plus topic explorations.

**This repo is the north-star use-case of [`mathematical-writing` (`.mw`)](../mathematical-writing/)** — a
future literate format that keeps prose, computation, and machine-checked proofs mutually consistent. toesnail
is authored now in plain markdown, prepared for `.mw` but not dependent on it.

## Hard constraint — direction is the owner's
The owner (Zommuter) dictates the physics direction. **The AI does not vibe-think the theory** — it does not
invent physics, choose topics, or decide narrative direction. The AI's license is narrow (see `CONVENTIONS.md`
"Working contract"): rigor-checking, structure/tooling, and Lean4-style formal proofs of *owner-stated*
claims. It **emits findings; it never edits the theory.** Discrepancies are located and surfaced; the owner
decides every resolution.

## Structure
- `README.md` (`permalink: /`) — project portal / site landing page: what toesnail is, the `.mw`
  relationship, and navigation into the content. **Not** the physics content itself.
- `physics/toesnail.md` (`permalink: /toesnail`) — the **TOESNAIL spine**: QM-from-scratch "math on demand"
  narrative; the flagship everything else branches off. (Was `README.md` until 2026-06-15.)
- `physics/` — topic explorations: `lasercool.md` (laser cooling), `acoustics.md` (Navier–Stokes/acoustics),
  `Resogram.md` (driven harmonic oscillator energy method).
- `essays/` — non-mathematical wing: `Narrativium.md`.
- **`gtnsd-archive` branch** (orphan, no common ancestor with `main`) — preserved full history of the
  retired `gtnsd` repo (the ~2017 "inflownistration" / information-flow-administration origin; the standalone
  repo was archived on GitHub + dropped 2026-06-16). Conceptually essays-wing material; its "Inflownistration"
  section is an owner-authored essay candidate. See `.mw` `id:aae4`.
- `img/`, `_includes/`, `_config.yml` — Jekyll site assets (theme: minima).
- `CONVENTIONS.md` — authoring conventions (equation handles, `verify:` markers, source-stays-plain) + the
  AI working contract.
- `docs/rigor-debt.md` — the tier-tagged inventory of hand-waved / unchecked claims (triage menu).
- `docs/dependencies.md` — how toesnail, `.mw`, and collAIb depend on each other and how strongly.
- `docs/meeting-notes/` — design-decision records.

## Authoring conventions (see `CONVENTIONS.md` for detail)
- **Equation handles:** stable content-meaningful ids via `\ltag{…}` / `\eqref{…}` (KaTeX macros in README).
- **Rigor-debt markers:** `\veq{h}\tier` badges on display equations — open debt = `\veq{h}\sorry`; tiers
  `\sympy`→∘ `\numeric`→△ `\lean`→✓ `\sympylean`→✓✓. Tiers match `.mw`'s verifier tiers (SymPy /
  CrossHair / Lean4+Mathlib). `grep -rn '\\veq' .` = live rigor-debt list (`\sorry` = open).
- **Source stays plain:** diff-friendly markdown, no inline computed outputs (source authoritative).

## Jekyll notes
- Permalinks are explicit per-file in front-matter → moving a source file does **not** change its public URL.
- Internal links (`](./)`, `](img/…)`) resolve against the rendered permalink, not the source path.
- **Layout default:** `_config.yml` applies `layout: page` site-wide via `defaults`. Pages declare only
  `title`+`permalink`; without the default they'd render headless (no `<head>` → no MathJax). Don't drop it.
- **Blank line after `$$`:** a `$$…$$` block must be separated by a blank line from anything that follows
  (incl. any following comment or text) — otherwise kramdown folds it into a paragraph and emits *inline*
  single-`$` math, which MathJax renders left-aligned with the `\tag` suppressed (the equation handle vanishes).
  `tests/test_render.sh` guards this (no `\ltag` in an inline `kdmath` span).
- **Math pipeline (MathJax 3):** `_config.yml` sets `kramdown: { math_engine: null }` so kramdown leaves
  `$`/`$$` delimiters for MathJax to typeset (its default rewrites them to MathJax-2 `math/tex` script tags
  MathJax 3 ignores). MathJax config (delimiters, `tags:'ams'`) lives in `_includes/custom-head.html`.
- **Equation handles:** `\ltag` is defined **centrally, per renderer** (MathJax rejects in-document `\gdef`):
  the site (MathJax) gets it from `_includes/custom-head.html` `macros`; the VS Code preview (KaTeX) from
  `.vscode/settings.json` `markdown.math.macros`. `\eqref` links on the site, is plain `(id)` in preview
  (KaTeX has no `\label`). Do **not** add an in-document `\gdef` block — it breaks the site. See `CONVENTIONS.md` §1.

## Local build & tests
- **Build:** Ruby + Jekyll (no sudo): `pamac install ruby`; `gem install --user-install bundler jekyll`;
  `bundle install` (Gemfile pins jekyll 4 + minima + plugins; `vendor/`, `_site/` gitignored). Then
  `bundle exec jekyll serve` → `http://localhost:4000/`. The live site builds remotely on GitHub Pages.
- **Tests (`tests/`):** relay-style TDD discipline (tests are the spec; never weaken a test to pass).
  `bash tests/run.sh` runs `test_verify.sh` (SymPy verdicts + `verified:` attestation
  non-drift, needs `uv`), `test_render.sh` (Jekyll build + HTML/MathJax invariants, SKIPs without Ruby), and
  `test_mathjax.cjs` (renders every equation through MathJax 3 **and** KaTeX — the client-side check HTML-grep
  can't do; needs `npm install`, SKIPs without it). `tests/HUMAN-integration.md` holds the residual `[HUMAN]`
  visual checks. **Lesson:** HTML-grep gave false confidence (the `\gdef` bug rendered fine in source) — test
  the actual render.

## Verify commit-hook (relay-aware, two-tier) — v1 HARD tier
Design: `docs/meeting-notes/2026-06-16-0635-relay-aware-commit-hook.md` (decisions D1–D6) and
`docs/dependencies.md` §"two-tier detection proposal". v1 ships the **deterministic HARD tier only** as a
non-blocking `post-commit` hook; the LLM/SOFT tier lives in `/relay review`, never in the hook.

- **Carrier — ephemeral `git notes` on `refs/notes/verify`.** The hook writes findings as notes
  (`status:pending` + findings), append-only, **never deletes** (the note is also the observe-first log).
  Notes are local-only, not pushed; lossy-on-rebase is acceptable (REVIEW_ME.md is the durable record).
- **Two git-config settings (id:d5f9).** Repo config MUST set
  `notes.rewriteRef = refs/notes/verify` (carry notes across rebase/amend) and
  `notes.rewriteMode = concatenate` (default `overwrite` silently drops merged notes on squash).
- **Hook install — TRACKED, never an untracked `.git/hooks/` file.** The hook lives at
  `hooks/post-commit` (tracked). Run `make install-hooks` (or the equivalent commands below)
  after a fresh clone to wire it in:
  ```
  make install-hooks
  # which runs:
  git config core.hooksPath hooks
  git config notes.rewriteRef refs/notes/verify
  git config notes.rewriteMode concatenate
  ```
  These are **local repo config** settings (never global). `core.hooksPath hooks` tells git
  to use the tracked `hooks/` directory instead of `.git/hooks/`.
- **Invariants (the executor must honour all four):**
  1. **`.mw` is OPTIONAL, never a commit gate (D6).** If `.mw` is unreachable/uninstalled/errors, the HARD
     tier no-ops (log "skipped: .mw unavailable") and the commit STILL SUCCEEDS. The hook must never
     raise/hang (post-commit's exit code is ignored by git anyway).
  2. **The hook NEVER calls an LLM (D3).** Deterministic only — no Ollama, no API. The SOFT/LLM tier is
     `/relay review`'s job, routed elsewhere.
  3. **Relay-skip (D2).** Detection runs on OWNER commits only; it no-ops in a relay context. `RELAY_SKIP=1`
     env is authoritative; a `/worktrees/` substring in `git rev-parse --git-dir` is the fallback.
  4. **HARD tier reads a one-section `.mw` mirror (id:0e63)** via `mathematical_writing.dag.stale_after_edit`
     over a faithful transcription of ONE Resogram section. The mirror is a DERIVED TOOLING ARTIFACT — it
     must NOT invent or alter physics (owner confirms fidelity; see REVIEW_ME.md).
- **`.mw` invocation:** package import name is `mathematical_writing` (NOT `mw`); run under
  `uv run --project /home/tobias/src/mathematical-writing`. Example: `examples/resogram_cval.mw` there.

## Related projects
- [`mathematical-writing`](../mathematical-writing/) — the `.mw` literate format/tool this repo is the
  north-star use-case for. toesnail's `physics/` docs are the eventual `.mw` migration target.
- `~/src/collaib` — local-LLM "calm co-author" observer PWA; a candidate live UI for the `verify:` rigor-debt
  assist role (three-repo relationship flagged for a dedicated scoping session).
- **`verify/lean-toolchain` provenance (routed:89d0 from `mathematical-writing`).** The pinned
  `leanprover/lean4:v4.30.0-rc2` value in `verify/lean-toolchain` is a CACHE/DERIVED value of the vendored
  Mathlib rev (`.lake/packages/mathlib/lean-toolchain`), not a hand-edited fact — never bump it directly.
  toesnail is the triad's rev-bump DECIDER, because it pays the ~7 GB Mathlib build cost that a rev bump
  triggers; a bump lands here first. `mathematical-writing` PUBLISHES the resulting derived fleet value at
  its own repo root, which is the value `relay-doctor`'s id:50c4 drift-check treats as canonical downstream.

## Relay contract <!-- relay-executor contract v6 -->

This repo is managed by a reviewer/executor relay. Load `/relay executor` before
working on any item, then follow its rules exactly.

### Repo-specific scope guard — executors NEVER touch the theory

This is owner-dictated theoretical-physics PROSE, not ordinary code. The hard constraint
(see top of this file + `CONVENTIONS.md` "Working contract") binds executors absolutely:

- **Executor-eligible (`[ROUTINE]`) = TOOLING ONLY:** the Jekyll build, `_config.yml`,
  `_includes/`, `tests/`, `Gemfile`/`package.json`, `Makefile`, CI, and the *mechanics* of
  the `verify/` harness (script plumbing, runners) — never the physics it checks.
- **Human-only — NEVER in the executor queue:** all physics/maths content and narrative
  (`physics/*.md`, `essays/*.md`), the *direction* of the theory, which claims to mark,
  and the **resolution of any `verify:` ✗ finding**. The AI emits findings; it never edits
  the theory. These live in `TODO.md` + `docs/rigor-debt.md` + `REVIEW_ME.md`, dispatched
  via `/relay human` or `/meeting`, ratified by the owner.
- A `verify:` finding (e.g. a located algebra discrepancy) is **surfaced**, never silently
  "fixed". Correcting owner math is the owner's call (a `.mw`/collAIb tool may later
  *suggest* a fix, but a human ratifies it).

If a ROADMAP item would require editing physics content to satisfy a test, STOP and treat
it as a HANDBACK / `REVIEW_ME` item — it was mis-tagged.

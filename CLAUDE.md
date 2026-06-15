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
- `img/`, `_includes/`, `_config.yml` — Jekyll site assets (theme: minima).
- `CONVENTIONS.md` — authoring conventions (equation handles, `verify:` markers, source-stays-plain) + the
  AI working contract.
- `docs/rigor-debt.md` — the tier-tagged inventory of hand-waved / unchecked claims (triage menu).
- `docs/dependencies.md` — how toesnail, `.mw`, and collAIb depend on each other and how strongly.
- `docs/meeting-notes/` — design-decision records.

## Authoring conventions (see `CONVENTIONS.md` for detail)
- **Equation handles:** stable content-meaningful ids via `\ltag{…}` / `\eqref{…}` (KaTeX macros in README).
- **Rigor-debt markers:** greppable HTML comments `<!-- verify:sympy|numeric|lean <claim> -->`. Tiers match
  `.mw`'s verifier tiers (SymPy / CrossHair / Lean4+Mathlib). `grep -rn 'verify:' .` = live rigor-debt list.
- **Source stays plain:** diff-friendly markdown, no inline computed outputs (source authoritative).

## Jekyll notes
- Permalinks are explicit per-file in front-matter → moving a source file does **not** change its public URL.
- Internal links (`](./)`, `](img/…)`) resolve against the rendered permalink, not the source path.
- **Layout default:** `_config.yml` applies `layout: page` site-wide via `defaults`. Pages declare only
  `title`+`permalink`; without the default they'd render headless (no `<head>` → no MathJax). Don't drop it.
- **Blank line after `$$`:** a `$$…$$` block must be separated by a blank line from anything that follows
  (incl. a `<!-- verify: -->` comment) — otherwise kramdown folds it into a paragraph and emits *inline*
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
- **Tests (`tests/`):** relay-style TDD discipline (tests are the spec; never weaken a test to pass), no
  `/relay` handoff. `bash tests/run.sh` runs `test_verify.sh` (SymPy verdicts + `verified:` attestation
  non-drift, needs `uv`), `test_render.sh` (Jekyll build + HTML/MathJax invariants, SKIPs without Ruby), and
  `test_mathjax.cjs` (renders every equation through MathJax 3 **and** KaTeX — the client-side check HTML-grep
  can't do; needs `npm install`, SKIPs without it). `tests/HUMAN-integration.md` holds the residual `[HUMAN]`
  visual checks. **Lesson:** HTML-grep gave false confidence (the `\gdef` bug rendered fine in source) — test
  the actual render.

## Related projects
- [`mathematical-writing`](../mathematical-writing/) — the `.mw` literate format/tool this repo is the
  north-star use-case for. toesnail's `physics/` docs are the eventual `.mw` migration target.
- `~/src/collaib` — local-LLM "calm co-author" observer PWA; a candidate live UI for the `verify:` rigor-debt
  assist role (three-repo relationship flagged for a dedicated scoping session).

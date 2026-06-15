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
- `README.md` (`permalink: /`) — the TOESNAIL spine (QM-from-scratch narrative; the site index).
- `physics/` — topic explorations: `lasercool.md` (laser cooling), `acoustics.md` (Navier–Stokes/acoustics),
  `Resogram.md` (driven harmonic oscillator energy method).
- `essays/` — non-mathematical wing: `Narrativium.md`.
- `img/`, `_includes/`, `_config.yml` — Jekyll site assets (theme: minima).
- `CONVENTIONS.md` — authoring conventions (equation handles, `verify:` markers, source-stays-plain) + the
  AI working contract.
- `docs/rigor-debt.md` — the tier-tagged inventory of hand-waved / unchecked claims (triage menu).
- `docs/meeting-notes/` — design-decision records.

## Authoring conventions (see `CONVENTIONS.md` for detail)
- **Equation handles:** stable content-meaningful ids via `\ltag{…}` / `\eqref{…}` (KaTeX macros in README).
- **Rigor-debt markers:** greppable HTML comments `<!-- verify:sympy|numeric|lean <claim> -->`. Tiers match
  `.mw`'s verifier tiers (SymPy / CrossHair / Lean4+Mathlib). `grep -rn 'verify:' .` = live rigor-debt list.
- **Source stays plain:** diff-friendly markdown, no inline computed outputs (source authoritative).

## Jekyll notes
- Permalinks are explicit per-file in front-matter → moving a source file does **not** change its public URL.
- Internal links (`](./)`, `](img/…)`) resolve against the rendered permalink, not the source path.

## Related projects
- [`mathematical-writing`](../mathematical-writing/) — the `.mw` literate format/tool this repo is the
  north-star use-case for. toesnail's `physics/` docs are the eventual `.mw` migration target.
- `~/src/collaib` — local-LLM "calm co-author" observer PWA; a candidate live UI for the `verify:` rigor-debt
  assist role (three-repo relationship flagged for a dedicated scoping session).

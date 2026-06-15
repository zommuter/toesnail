---
title: 🦶TOESNAIL-MODE🐌
permalink: /
author: Zommuter
---

**TOE-SNAIL** — *Theory of Everything · Some Novel Approach Including Love ❤️ · Math on Demand Edition.*

[![](img/cc-by-nc-sa-88x31.png)](http://creativecommons.org/licenses/by-nc-sa/4.0/)

A long-running theoretical-physics / mathematics exploration: building physics *math on demand*, from
first principles, with rigour you can actually check. Theory-heavy, no-income, pure fascination — and the
**north-star use-case** of [`mathematical-writing` (`.mw`)](../mathematical-writing/), a future literate
format that keeps prose, computation, and machine-checked proofs mutually consistent.

## Start here

- 📖 **[The TOESNAIL spine →](toesnail)** (`physics/toesnail.md`) — the main narrative: quantum mechanics
  from the bra-ket up, "math on demand". This is the flagship; everything else branches off it.

## Topic explorations — `physics/`

- **[Lasercold](Lasercold)** (`physics/lasercool.md`) — laser cooling, photon–matter interaction. The
  "maybe-save-the-planet-from-AI-training-heat" fascination.
- **[Acoustics](Accoustics)** (`physics/acoustics.md`) — Navier–Stokes / acoustics derivations.
- **[Resogramm](Resogramm)** (`physics/Resogram.md`) — driven harmonic oscillator energy methods.

## Essays — `essays/`

- **[Narrativium](Narrativium)** (`essays/Narrativium.md`) — the non-mathematical wing: storytelling as the
  "love" in the theory of everything. Zero math; out of scope for verification.

## How this repo works

- **[`CONVENTIONS.md`](CONVENTIONS.md)** — authoring conventions (stable equation handles, greppable
  tier-tagged `verify:` rigor markers, source-stays-plain) and the **AI working contract**: the owner
  dictates the physics; the AI rigor-checks, structures, and writes Lean4-style proofs of *owner-stated*
  claims — it **emits findings, never edits the theory.**
- **[`docs/rigor-debt.md`](docs/rigor-debt.md)** — the live triage menu of hand-waved / unchecked claims,
  tier-tagged (`sympy` / `numeric` / `lean`). `grep -rn 'verify:' .` is the running list.
- **[`docs/dependencies.md`](docs/dependencies.md)** — how toesnail, `.mw`, and collAIb progress depend on
  each other, and how strongly.
- **`docs/meeting-notes/`** — design-decision records.

## License

[CC BY-NC-SA 4.0](http://creativecommons.org/licenses/by-nc-sa/4.0/).

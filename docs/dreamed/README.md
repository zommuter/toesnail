---
title: Dreamed
permalink: /dreamed
---

# `docs/dreamed/` -- AI-generated exploration, NOT owner-authored, NOT reviewed

Everything under this directory was **dreamed by an AI agent**, not written by the owner
and not yet read by him. It is speculative exploration seeded from the owner's *own*
existing material (`physics/`, `essays/`, `docs/se-corpus.md`, his StackExchange corpus)
and nothing here has any authority.

**Status of every file in here: UNREVIEWED. Treat as a conversation starter, not content.**

## Hard rules for this directory

- Nothing here is theory. The repo's hard constraint (`CLAUDE.md`, `CONVENTIONS.md`
  "Working contract") reserves physics direction to the owner. These essays *propose*;
  the owner disposes.
- **Nothing here may be promoted into `physics/` or `essays/` without the owner
  explicitly authoring the move.** A copy-paste is not a promotion.
- `\veq` badges inside dreamed essays are **claims about the dreamed Lean file only**.
  They are NOT attestations against the repo's sidecar/verify machinery
  (`physics/*.toml`, `tests/test_verify.sh`) and are deliberately not wired into it.
- Lean files live in `docs/dreamed/lean/`. They are checked with
  `nice -n19 lake env lean docs/dreamed/lean/<file>.lean` run from `verify/`, so they
  are **not** part of the `verify` lake target and cannot break `make test`.

## Provenance

Session of 2026-09-01, owner-requested ("spawn some agents to be wildly creative on my
ideas"). Owner picked every seed; the AI picked none. Each essay states its seed and
which owner-authored file or SE post it grew from.

## Index

Each row: the essay, the owner-authored thing it grew from, and the single claim it
would most want ratified or rejected. Every "finding" below is an AI **recommendation**
awaiting the owner's ruling, never a settled decision.

| Essay | Lean | Seed | Headline claim (UNRATIFIED) |
|---|---|---|---|
| [`wirohsh-splats.md`](wirohsh-splats.md) | `lean/Wirohsh.lean` | `physics/wirohsh.md`, truncated mid-formula; ROADMAP `id:ff32` | The 3D reduction closes because the Wick rotation makes the direction **null** (`∇u·∇u = 0`), so `a_φ(x_φ+iz)` is harmonic for any twice-differentiable `a_φ`. The `b_φ` family is redundant (`x_φ̄ = -∂_φ x_φ`), leaving Whittaker's 1903 formula. Recommends **NO-GO on `id:ff32`** as framed, with one gated salvage. |
| [`wick-entropy.md`](wick-entropy.md) | `lean/WickEntropy.lean` | physics.SE q/143075 (corpus row P-I) + `physics/entropy.md` | The Laurent index `m` and the Matsubara index `n` are the **same basis** under `z = exp(2π(σ+iτ)/(ħβc))`. Reading the polar angle as the thermal circle forces `β = 2πr/(ħc)`, the Unruh temperature. `N=2` ↔ antiperiodic is an identity at the two limits used and a coincidence as a family. |
| [`omniscience.md`](omniscience.md) | `lean/Omniscience.lean` | the `#TODO: try and proof whether omniscience is impossible?` in `physics/toesnail.md`; corpus row M-5 | Omniscience is defeated by **arity, not physics**: a knower inside what it knows has the shape `φ : A → (A → B)`, and Lawvere forbids it. **Gödel I does not apply** to `|42⟩` (contra row M-5, which welds Gödel and Lawvere into one line); Cantor/Lawvere applies directly, Tarski nearly. |
| [`lambertw-statistics.md`](lambertw-statistics.md) | `lean/Statistics.lean` | the `\leanc` debt at `physics/entropy.md:59` (ROADMAP `id:37cc`, `id:5d31`) | The bosonic inversion is correct only on the **`W₋₁`** branch; on the principal branch (every CAS default) it collapses to `βE₁ = 0` identically. The fermionic case is genuinely two-valued. The `N` family is **Gentile** statistics, not anyons; the inversion stops closing in `W` at `N ≥ 3`. |
| [`spine.md`](spine.md) | `lean/Spine.lean` | `physics/toesnail.md` audited against its own "math on demand" rule | The rule fails **asymmetrically at l.126**: four pieces of mathematics arrive before their demand, two demands after it are never paid. `:79` says complex numbers cannot be ordered; `:89` then writes `⟪Ψ\|Ψ⟫ > 0` for one. `:105`'s "parallel or anti-parallel" is the **real** equality case; over ℂ it is the whole unit circle. |
| [`lasercool.md`](lasercool.md) | `lean/Lasercool.lean` | physics.SE q/669175 + row P-J (q/817764) + `docs/drafts/q669175-answer-draft.md` | The entropy inequality holds, but the margin is ~10³ (Rb87), not the ~10⁷ folklore implies, because **atoms are bad at shedding entropy**: `σ_atom ≤ k_B·T_rec/T_D = 4ω_rec/Γ`. Reabsorption is therefore a rate problem, not a second-law problem. |

### Findings surfaced, deliberately NOT filed

Each essay carries a "Surfaced for the owner" section. **Nothing from this batch was
written into `TODO.md`, `ROADMAP.md`, or `REVIEW_ME.md`** -- routing a dreamed finding
into a ledger is an owner decision, and a delegated agent's verdict is a recommendation,
never self-settling. The candidates awaiting that ruling are the `id:ff32` NO-GO, the
`lambertw` branch qualifier, the spine's ordering clash and Cauchy-Schwarz equality case,
the four notation snags in `physics/wirohsh.md`, and the critique of the q/669175 draft.

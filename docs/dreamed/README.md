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
- Runnable code lives in `docs/dreamed/<topic>/` (`resogram-lib/`, `fhe-search/`). It is
  dreamed too: unreviewed, not wired into `tests/`, and not part of `make test`. Where a
  search could be expensive it runs under a resource-capped wrapper.
- Lean files live in `docs/dreamed/lean/`. They are checked from `verify/` with
  `../docs/dreamed/capped.sh -m 6G -- lake env lean --threads=2 ../docs/dreamed/lean/<file>.lean`,
  so they are **not** part of the `verify` lake target and cannot break `make test`.
  `capped.sh` puts the run in a systemd user scope with a hard cgroup memory limit and
  no swap: a breach OOM-kills that scope alone. Do NOT substitute `ulimit -v` for Lean --
  it caps address space, and Mathlib mmaps its `.olean` files.

## Provenance

Session of 2026-09-01, owner-requested ("spawn some agents to be wildly creative on my
ideas"). Owner picked every seed; the AI picked none. Each essay states its seed and
which owner-authored file or SE post it grew from.

Second session, 2026-09-04: the FHE cluster below, owner-seeded on toy homomorphic
encryption, encrypted algorithms, and trustless distributed AI. Written directly rather
than by delegated agents, with prior-art research at the owner's explicit instruction
("don't not-invented-here", "don't blindly trust every publication").

## Index

38 essays, 38 Lean files, one runnable library, one runnable search suite. Every Lean
file was re-verified, not merely reported: `exit 0`, zero `sorry`. Every "finding" below
is an AI **recommendation** awaiting the owner's ruling, never a settled decision.

### FHE cluster (`crypto/fhe.md`) -- session of 2026-09-04

Companion code: [`fhe-search/`](fhe-search/) -- five stdlib Python scripts run under
[`fhe-search/run.sh`](fhe-search/run.sh) and [`capped.sh`](capped.sh), which impose a HARD cgroup
memory cap (`MemoryMax`, no swap) plus a CPU quota, so a runaway search is OOM-killed inside its
own scope and cannot take the machine down. `nice` alone does not do this and `ulimit -v` is wrong
for Lean (Mathlib mmaps its oleans). Every search is exhaustive over its stated space; the
Monte-Carlo experiments are seeded and labelled as such.

| Essay | Headline claim (UNRATIFIED) |
|---|---|
| [`fhe-toy-enumeration`](fhe-toy-enumeration.md) | A toy two-operation FHE exists trivially, and is trivially broken. Exhaustively: a strict scheme keeps only $\log_2 k$ key bits on a $k$-bit word (Frobenius) against the OTP's $k$; key entropy and functional completeness are **exactly** incompatible; randomising bought **zero** key ambiguity (mean 1.000). Confirms Boneh-Lipton 1996 rather than discovering it. |
| [`fhe-encrypted-algorithm`](fhe-encrypted-algorithm.md) | "Encrypted algorithm" names **three** problems with three answers, separated by who holds the key: private function evaluation (solved, $O(k\log k)$), obfuscation (VBB **impossible**), circuit privacy (a cost). The $2^n$ program-bit floor of `crypto/fhe.md:8` is a **lower bound over all encodings** and is attained. Obliviousness, not cryptography, is the structural tax. |
| [`fhe-llm`](fhe-llm.md) | State of the art, concretely: **BERT-base under non-interactive FHE in ~1 s on GPU** (NEXUS), but **~5 min/token for LLaMA-7B and only via MPC**. The gap is autoregression, not encryption. **The client should own the whole vocabulary boundary** -- saves >1 layer, $31\times$ bandwidth, deletes the vocabulary softmax exactly, removes the tokenizer side-channel class. OTRO/TDXRay is an argument **for** FHE over TEEs, not against. |
| [`model-attestation`](model-attestation.md) | The "LLM footprint" exists: **Activation-DiFR** detects a 4-bit swap at AUC>0.999 from **2 output tokens**, and Model Equality Testing found **11 of 31** commercial Llama endpoints deviating from Meta's weights. Derived: a sampled token carries **0.033 bits** of identity evidence, an activation fingerprint **4.98** -- a factor of 150, so text-based verification pays a huge avoidable tax. **Main claim:** under FHE a provider cannot recognise an audit, so encryption makes sampled integrity checking **unevadable** -- reversing "FHE gives no integrity" in the two siblings, which are corrected. Also retracts this batch's gap-gating as non-novel (DiFR got there first). |
| [`trustless-distributed-ai`](trustless-distributed-ai.md) | Owner's MP3-vs-bit-exact-codec analogy is the same problem, not an analogy: autoregressive decoding **is** predictive coding, so drift compounds (1e-3 per-token divergence reproduces a 4096-token answer 1.7% of the time), and codecs already fixed it by mandating integer transforms. Integer-only transformers exist (I-BERT, INT8 end-to-end, 3.1-3.6$\times$ faster). **Convergence claim:** an integer-only model is both bit-exactly verifiable AND natively evaluable by the *exact* FHE schemes (BFV/BGV) rather than approximate CKKS -- one substrate, both halves of trustlessness. |

### WiRoHSH cluster (`physics/wirohsh.md`)

| Essay | Headline claim (UNRATIFIED) |
|---|---|
| [`wirohsh-splats`](wirohsh-splats.md) | The truncated 3D reduction closes: the Wick rotation makes the direction **null**, so the `b_φ` family is redundant and the result is Whittaker 1903. Recommends **NO-GO on `id:ff32`**. |
| [`wirohsh-discontinuities`](wirohsh-discontinuities.md) | Nothing is lost to non-holomorphy: the data returns as a **Sato hyperfunction boundary value**. `wirohsh.md:82` is false as written -- the line is analytic vs non-analytic, and a `C^∞` bump is on the wrong side. |
| [`wirohsh-refraction`](wirohsh-refraction.md) | The 1+1 conformal-flatness hope is **half true**: rays, Fermat and Snell survive any profile, but a drift `(n'/n)∂_x` kills harmonicity except for `n = A/(x−x₀)²`. Snell/Fresnel **is** the Schwarz reflection principle. |
| [`wirohsh-ladder`](wirohsh-ladder.md) | The ladder's parity is **not** Huygens: `d=1` is the ladder's best floor and Huygens' exception. The descent buys nothing and returns `d−2` continuous parameters. |
| [`wirohsh-approximation`](wirohsh-approximation.md) | Completes the M-6 analogy as Laurent : two-sided Laplace. A **fifth** independent reason for the `id:ff32` NO-GO: analytic functions have no compact support, so the basis can never localize. |

### Spine and standing open questions

| Essay | Headline claim (UNRATIFIED) |
|---|---|
| [`spine`](spine.md) | "Math on demand" fails asymmetrically at l.126. `:79` says ℂ cannot be ordered, `:89` writes `⟪Ψ\|Ψ⟫ > 0`. `:105`'s equality case is the **real** one; over ℂ it is the unit circle. |
| [`time-and-operators`](time-and-operators.md) | Three obvious questions force a one-parameter unitary group; Stone then **derives** the Hamiltonian. `t1` at `:59` uses probabilities as coefficients, so it can come from a `U(t)` only if `p ∈ {0,1}`. |
| [`measurement-routes`](measurement-routes.md) | All four routes into `## Observe` drafted. Disagrees with `spine.md` on ordering: POVM first, decoherence second. |
| [`omniscience`](omniscience.md) | Omniscience fails by **arity**, not capacity (Lawvere). **Gödel I does not apply** to `\|42⟩`, contra corpus row M-5. |
| [`q2-galilei-vs-poincare`](q2-galilei-vs-poincare.md) | **Q2.** Decisive asymmetry proved: the Galilei cocycle is not a coboundary, the Poincaré one is. Caveat stated: that is 1+1, where `dim H²(Poincaré) = 1`. |
| [`information-wing`](information-wing.md) | **Q9.** Ratify with membership corrected: the wing coheres around `log W`, not "entropy". FHE is out; the one-time pad is in. |
| [`methodology-themes`](methodology-themes.md) | **Q10.** "Move the problem, solve, move back" has ~8 instances and was under-ranked by its own note. "Reversibility is sacred" is a slogan (`grep` returns zero hits). |
| [`love-wing`](love-wing.md) | **Q11.** The arc's invariant is a **Lyapunov quantity**, not the order parameter; Ott-Antonsen matches the Resogram's `ė` structurally. It breaks at Gottman. |
| [`photon-localizability`](photon-localizability.md) | **Q12.** The Gaussian ansatz does not solve the wave equation and a per-index `σ_α` breaks covariance. But NW constrains an *operator*, and `A_μ` is a field. |
| [`q6-q7-q8-apparatus`](q6-q7-q8-apparatus.md) | **Q6/Q7/Q8.** Status axis is orthogonal to the tier ladder (25 = 5×5). Q6 should extend `\definition`/`\assumption`. Cross-file `\eqref` renders `(???)` silently, which may settle Q8. |

### Thermodynamics, entropy, and the laser wing

| Essay | Headline claim (UNRATIFIED) |
|---|---|
| [`lasercool`](lasercool.md) | The entropy margin is ~10³, not the ~10⁷ folklore implies: `σ_atom ≤ k_B·T_rec/T_D`. Reabsorption is a rate problem, not a second-law problem. |
| [`five-level-laser`](five-level-laser.md) | **NO-GO at theorem strength.** Inversion and cooling are mutually exclusive at any pump strength; Scovil-Schulz-DuBois makes lasing-while-cooling require `T/T_p < 0`. |
| [`photon-energy-scaling`](photon-energy-scaling.md) | No COP optimum exists (Carnot is the supremum). But the **power** optimum is `hν − μ = [4 + W₀(−4e⁻⁴)]k_BT = 3.920690395 k_BT`, the **Wien law with exponent 4**. |
| [`wick-entropy`](wick-entropy.md) | The Laurent index `m` and the Matsubara index `n` are the same basis; reading the polar angle as the thermal circle forces the Unruh temperature. |
| [`lambertw-statistics`](lambertw-statistics.md) | The bosonic inversion needs the **`W₋₁`** branch; the principal branch gives `βE₁ = 0` identically. The `N` family is Gentile, not anyons. |
| [`acoustics`](acoustics.md) | A 12-row marking inventory proposed (not placed). Impedance matching **decouples** reflection from refraction, which optics cannot do. `acoustics.md` never states its adiabatic assumption. |

### Corpus items ratified for authoring (`id:e552`)

| Essay | Headline claim (UNRATIFIED) |
|---|---|
| [`casimir-field-equations`](casimir-field-equations.md) | Row **P-C is wrong about the mechanism**: q/27195 is variational, not an eigenvalue equation, and its accepted answer gets Dirac from the **square root**. `W² = 0` does not follow from masslessness. |
| [`generators-and-bch`](generators-and-bch.md) | Row **M-1 mislabels its posts**: 337971 is the curl-generalization question, not the self-answered dilation, and it holds a live 13-year-old gap of the owner's own. |
| [`discrete-noether`](discrete-noether.md) | Discrete symmetry gives a **multiplicative** charge against Noether's additive one; Bloch quasi-momentum is the best analogue. |

### Other repos, dreamed here at the owner's request

| Essay | Headline claim (UNRATIFIED) |
|---|---|
| [`mw-collaib-triad`](mw-collaib-triad.md) | `.mw` live at 0.12.0; **collAIb dormant 43 days**. A DAG catches propagation but **not origination**, which bounds what `.mw` can promise. Two bugs located in toesnail's own `hooks/post-commit`. |
| [`inflownistration`](inflownistration.md) | The universal thesis is an **arity error**: information is three-place, and `T` is the missing decoder argument. Friston himself calls the FEP "almost tautological". |
| [`essay-wing`](essay-wing.md) | The 2017 archive is one file, one evening; the concept is **thin**, and the sentence worth keeping is a task-list parenthesis about annotations rotting. |
| [`zelegator-helferli`](zelegator-helferli.md) | The eval set is **saturated** (`I = log₂10` exactly), so it cannot score a distilled student. **No shared contract artifact**, with `id:29e3` due at the 2026-09-10 demo gate. |
| [`loderite-lodelore`](loderite-lodelore.md) | Honest negative: cubic-26 **beats** BCC-14 on weighted path stretch. Greedy meshing is provably void on whole cells, contra `loderite/ARCHITECTURE.md:76`. |
| [`resogram-library`](resogram-library.md) + [`resogram-lib/`](resogram-lib/) | **A runnable library, 39 tests passing.** The resogram is exactly `\|CWT\|²` for a causal kernel, an order-1 gammatone. `Resogram.md:118`'s `e^{+2βt'}` sign leaves a residual the opposite sign cancels. |

### Speculation (owner-authorised 2026-09-01, results still required to be sound)

| Essay | Headline claim (UNRATIFIED) |
|---|---|
| [`why-three-plus-one`](why-three-plus-one.md) | `V_eff''(r₀) = (4−d)L²/(mr₀⁴)`, so stability needs `d < 4`. Tegmark disclaims deriving anything and never mentions Huygens tails. **The ladder adds nothing** to the question. |
| [`narrativium-formalized`](narrativium-formalized.md) | The simplicity prior **inverts** the myth: a million-to-one chance costs 19-20 bits. Formalisable only as a theorem about bounded describers, which is Pratchett's own reading. |
| [`fhe-counting`](fhe-counting.md) | Three counting debts closed with frozen signatures; the fourth is an **identification**, so a proof would only fix a stipulation. Independently **confirms** the `id:76e5` stirling finding. |

### Older index (kept for provenance)

Each row: the essay, the owner-authored thing it grew from, and the single claim it
would most want ratified or rejected.

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

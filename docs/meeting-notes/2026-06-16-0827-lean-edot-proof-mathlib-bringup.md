# 2026-06-16 — Lean proof of the `edot` first-line identity + stand up Lean4/Mathlib (id:3317)

**Started:** 2026-06-16 08:27
**Session:** 6174492c-9c7b-4560-a28b-bb867debb17c
**Attendees:** 🏗️ Archie (architect), 😈 Riku (devil's advocate), ✂️ Petra (productivity), 🔬 Lennart (formal-methods / Lean4+Mathlib), 🗄️ Cassi (derived-data / build-cache)
**Topic:** Scope the heaviest pilot deliverable (`id:3317`) — the first Lean proof (`edot` first-line identity) + `lake`/Mathlib bring-up — given the toolchain is already installed and the claim is SymPy-confirmed.

## Surfaced discoveries
(EMBED_ENDPOINT unset — `discoveries.md` not semantically retrieved; none surfaced. No GitHub prior art; no orphans.)

## Agenda
1. Toolchain reality — Lean/lake/elan are installed; does HANDBACK still apply, do we pin a version?
2. Mathlib or core-Lean? `ring` needs Mathlib (heavy build); a hand proof avoids it but is fragile.
3. What is "the first-line identity" formally — algebraic substitution vs the derivative step?
4. Test integration & DoD — how the Lean check joins `tests/run.sh`; what `lake build` discharges means.

## Facts established (read-only probing)
- **Toolchain present:** `/usr/bin/{lake,lean,elan}`; elan toolchains `v4.30.0-rc2` + `v4.31.0`; system `lean` = 4.31.0. → ROADMAP's HANDBACK-if-no-toolchain clause is moot; no `sudo`/`pamac`.
- **Mathlib already on the machine** but **per-repo, not shared:** `~/src/lean/research_lean/.lake/packages/mathlib` = **6.6 GB** (pinned Mathlib `v4.30.0-rc2`). Only `~/.cache/mathlib` (**415 MB**, compressed olean download cache) is shared; lake *extracts* from it per project.
- **Both repos on the same btrfs subvolume** (`/@home`, `/dev/nvme0n1p2`); `cp --reflink` supported.
- **Claim shape** (`verify/resogram_edot.py:25-34`): `e=½ẋ²+½ω²x²`; instrument verifies the *algebraic* step only — substitutes EOM `ẍ=−2βẋ−ω²(x−y)` into `ẋ(ẍ+ω²x)` to get `−2βẋ²+ω²ẋy`. It never differentiates `e`. Existing marker `physics/Resogram.md:42`: `verified:sympy [edot] claim=b575864e by=resogram_edot.py@54710d91`.
- **Test SKIP pattern:** `tests/run.sh` runs `test_render.sh` (SKIP w/o Ruby), `test_mathjax.cjs` (SKIP w/o node) — the ".mw optional, never a gate" invariant to mirror.

## Discussion

### Agenda 1 & 2 — toolchain + Mathlib
Archie: the ROADMAP acceptance says "Lean4+**Mathlib**"; the prior pilot (D1) framed Mathlib bring-up as the long pole that earns its keep at the spine's Cauchy–Schwarz. The probe removes the HANDBACK risk — `lake`/`lean`/`elan` are system-installed. Lennart drew the key distinction: the *toolchain* is present, but **Mathlib is a per-project dependency lake compiles from source on first build** — a cold build is ~20–60 min + a few GB, for one `ring` tactic. Riku pushed minimalism (core-Lean hand proof, 0 GB, seconds; SymPy already ✓), then reversed himself: a hand-rolled `CommRing` proof is *more* fragile code over owner math than `by ring`, undercutting "Lean = assurance floor" — conceding Mathlib **iff** the build is SKIP-gated. Petra applied N=2: consumer 1 = edot, consumer 2 = the spine's Cauchy–Schwarz (`inner_mul_le_norm_mul_norm` is literally a Mathlib lemma, on the roadmap) — N=2 holds. Archie: pin via `lean-toolchain` + `lake-manifest.json`.

### Agenda 2b — is Mathlib shared or duplicated? (owner question)
Cassi: **not disk-shared.** `research_lean/.lake/packages/mathlib` is 6.6 GB and per-project; only `~/.cache/mathlib` (415 MB compressed download cache) is shared, and lake *extracts* from it rather than hardlinking. Pinning toesnail to the *same* rev makes `lake exe cache get` fast (reuses the 415 MB cache) but still costs ~6.6 GB disk. Archie rejected path/symlink reuse — breaks clean-clone reproducibility (GitHub Pages / other machines / CI have no `research_lean` sibling).

### Agenda 2c — CoW resolves the disk cost (owner: btrfs? symlink?)
Both trees are on the **same btrfs subvolume** + `cp --reflink` supported. Cassi: this is the ideal CoW case — same FS + identical pinned rev → byte-identical oleans → `cp --reflink=auto` shares every extent, ~0 extra physical disk (oleans are write-once, never diverge). Strictly beats the owner's symlink idea (which the owner already smelled as "a recipe for disaster"): a symlink makes toesnail's build *the same files* as research_lean's (silent non-local breakage on rebuild/clean/bump); a reflink copy is **independent inodes sharing extents** — fully decoupled, same space saving. Archie fenced it: reflink is a **local optimization, not the build contract**; canonical tracked path stays `lake exe cache get && lake build`. Petra: "update to latest Mathlib later" is a one-line rev bump — defer (research_lean on hiatus).

### Agenda 3 — what the proof formalizes
Lennart: two readings differ by *days*. **(a) Algebraic** — exactly what `resogram_edot.py` checks: EOM as hypothesis, prove `ẋ(ẍ+ω²x)=−2βẋ²+ω²ẋy` by `subst; ring`. **(b) Derivative** — additionally prove `ė=ẋ(ẍ+ω²x)` by differentiating `e` via Mathlib `deriv`/chain-rule (multi-day; SymPy never checked it). Riku: matching the SymPy-confirmed claim means (a); (b) proves *more* than confirmed, on owner physics, for no assurance gain on the stated claim. Owner: **(a) now, but (b) is a must for later** — "we can't have unverified maths dangling around" → (b) becomes tracked `verify:lean` debt, not a discard.

### Agenda 4 — test integration + DoD + marker schema (owner extension)
Archie: lake project roots at `verify/` (tracked: `lakefile.toml`, `lean-toolchain`, `Resogram.lean`, `lake-manifest.json`; `.lake/` gitignored). Lennart: `tests/test_lean.sh` mirrors the optional-tool SKIP pattern — absent lake → SKIP (no fail); present → `lake build` + `grep -L sorry` (a `sorry`-green is a fake green). Riku: CI has no Lean → SKIPs like Ruby/node; we are *not* standing up Mathlib in CI for a one-liner. **Owner marker extension:** compress the dual `verified:sympy`/`verified:lean` lines into one marker carrying a tier-list (`sympy`/`lean`/`both`), AND track per-claim whether SymPy *could* verify, so SymPy can later be evaluated as a cheap "worth running Lean / quick-mistake detector" pre-filter gate.

## Decisions

- **D1 — Mathlib + `by ring`, pinned `v4.30.0-rc2`.** Real lakefile with Mathlib; prove via kernel-checked `ring`. Pin `lean-toolchain` + Mathlib rev to `v4.30.0-rc2` so `lake exe cache get` reuses the shared 415 MB cache (build in minutes, no source recompile). Rejected: core-Lean hand proof (fragile over owner math, throwaway), newest-rev (cold cache miss). *Out of scope:* the spine's Cauchy–Schwarz / `c=0` (future Mathlib consumers — they justify N=2). <!-- id:3317 -->
- **D2 — Disk: canonical build portable; reflink an optional local footnote.** Committed contract builds from a clean clone via `lake exe cache get && lake build` (no `research_lean` sibling assumed). On this btrfs machine, `cp --reflink=auto -r ~/src/lean/research_lean/.lake/packages/mathlib <verify>/.lake/packages/mathlib` (same FS + identical rev → shared extents → ~0 extra GB) documented in `verify/README.md` as optional. **Symlink rejected** (couples repos; reflink = independent inodes sharing extents). Bump Mathlib later. *Out of scope:* reflink as a build step; cross-repo path/symlink deps.
- **D3 — Algebraic step now; derivative step tracked.** `theorem edot_first_line (x ẋ ẍ y β ω : ℝ) (eom : ẍ = -2*β*ẋ - ω^2*(x-y)) : ẋ*(ẍ + ω^2*x) = -2*β*ẋ^2 + ω^2*ẋ*y := by subst eom; ring`. Bind handle `edot`. Derivative step `ė=ẋ(ẍ+ω²x)` (Mathlib `deriv`/chain-rule, multi-day) scoped out now but **tracked** as new `verify:lean` debt. *Out of scope this session:* the derivative formalization. <!-- id:b9bc -->
- **D4 — Local gate, CI SKIPs.** `tests/test_lean.sh`: no lake → SKIP (incl. CI); lake present → `lake build` + `grep -L sorry`. Wire into `tests/run.sh`. DoD = `lake build` discharges `edot_first_line` no-`sorry` locally; suite SKIPs cleanly elsewhere. *Out of scope (reconsider later):* CI Lean/Mathlib build (~60-min cold for one one-liner). <!-- id:5776 -->
- **D5 — Compressed multi-tier `verified:` marker + SymPy-as-gate tracking.** Evolve the prior-meeting D4 grammar into ONE marker: `verified:<tiers> [handle] claim=<claimhash8> by=<inst1>@<h8>[,<inst2>@<h8>]`, `<tiers>` ∈ {`sympy`,`lean`,`sympy+lean`}. edot becomes `verified:sympy+lean [edot] claim=b575864e by=resogram_edot.py@54710d91,Resogram.lean@<h8>` (same `srepr` claim-hash across tiers; per-instrument filehash for staleness). SymPy-as-gate data: per-tier outcomes recorded — successes in the tier-list, SymPy ✗/inconclusive in `docs/rigor-debt.md` — so SymPy's value as a cheap pre-filter can be evaluated later. *Out of scope:* the automated staleness checker (id:04bb, N=2-gated); a negative-attestation grammar. <!-- id:1335 -->

## Action items
- [ ] Stand up `verify/` lake project pinned `v4.30.0-rc2` (lakefile.toml + lean-toolchain + lake-manifest.json committed; `.gitignore` += `.lake/`; `verify/README.md` lake-build + optional btrfs-reflink footnote) and prove `edot_first_line` in `verify/Resogram.lean` via `subst; ring`. Contract: `cd verify && lake build` exits 0, no `sorry`. <!-- id:3317 -->
- [ ] Add `tests/test_lean.sh` (SKIP w/o lake; else `lake build` + `grep -L sorry`) wired into `tests/run.sh`. Contract: `bash tests/run.sh` PASSes; SKIPs cleanly where lake absent. <!-- id:5776 -->
- [ ] Escalate `edot` to compressed `verified:sympy+lean` marker in `physics/Resogram.md`; add multi-tier marker grammar to `CONVENTIONS.md` (D5). Contract: marker parses as `verified:<tiers> claim=<h8> by=<inst>@<h8>[,…]`. <!-- id:1335 -->
- [ ] Annotate `docs/rigor-debt.md`: edot lean-attested; record per-tier outcome for the SymPy-as-gate dataset. Contract: edot row shows sympy+lean ✓ with both instrument pointers. <!-- id:3275 -->
- [ ] NEW tracked debt: derivative step `ė=ẋ(ẍ+ω²x)` as a `verify:lean` item (Mathlib `deriv`/chain-rule). Contract: tracked in TODO + rigor-debt, not silently dropped. <!-- id:b9bc -->
- [ ] (Forward-flag, GATED — reconsider later) CI Lean/Mathlib build; gate: warranted only if local kernel-checking proves insufficient. <!-- id:9d8c -->
- → routed to zomni inbox: periodic btrfs filesystem dedup (duperemove/bees) housekeeping <!-- routed:bf8a -->

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

### Verify commit-hook cluster (v1 HARD tier — TOOLING)

Design spec: `docs/meeting-notes/2026-06-16-0635-relay-aware-commit-hook.md` (D1–D6). Order is by
dependency: **0e63 (mirror) → 8757 (hook, depends on 0e63 + `.mw`) → d5f9 (config + doc)**. The shared
red suite is `tests/test_verify_hook.sh` (+ `tests/test_mw_mirror.sh` for the `.mw` DAG signal); both are
**id:211c's deliverable** — already AUTHORED by this handoff; the executor's job is to make them GREEN, not
to write them. Do NOT mint new ids; do NOT touch physics content.

### Lean `edot` cluster (SCOPED 2026-06-16, meeting `2026-06-16-0827-lean-edot-proof-mathlib-bringup.md` D1–D5)

The 2026-06-15 single Lean item was decomposed by the 2026-06-16-0827 `/meeting` into the cluster below.
Toolchain is now CONFIRMED present (`/usr/bin/{lake,lean,elan}`; elan toolchains `v4.30.0-rc2`+`v4.31.0`;
shared 415 MB `~/.cache/mathlib` download cache) — the HANDBACK-if-no-toolchain risk is moot. Order: **3317
(bring-up + proof) → 5776 (test wiring) → 1335 (marker) → 3275 (rigor-debt annotation)**. SCOPE GUARD still
binds: this is `verify/` plumbing + tests + attestation-marker bookkeeping ONLY — NO executor edits any
physics/maths/narrative prose. The proof is of an *owner-stated, SymPy-confirmed* claim (allowed).

### Recovered-pages infrastructure (recovery merge `c1e20b4`, 2026-06-16)

### Entropy + FHE SymPy verify-instrument bucket (/meeting id:3d2a D1/D3, promoted 2026-07-01)

Design spec: `docs/meeting-notes/2026-06-21-2129-lean-formalization-strategy.md` (D1/D3). The
owner has already PLACED the `\sympyc` open-debt badges in the source (id:8807); the executor's job
is the TOOLING half — build the SymPy instruments, write the sidecars, wire the test, and (badge-arg
carve-out D4) flip the discharged badges `\sympyc`→`\sympy`. **NO executor edits the physics/claims**
inside the `\veq{…}` — only the badge arg once its instrument is green. The `lambertw` marker
(`physics/entropy.md:59`, now `\leanc`) is OUT of scope — it belongs to the Lean bucket (id:37cc) and
its marker-split is an owner content decision, not this item.

- [ ] [INPUT — decision] Build the entropy + FHE-Stirling SymPy instruments + sidecars @container — 🚧 GATED (auto, id:3801; route:hard-split): DECOMPOSED into seams id:e9e9, id:76e5 — pick those, not this. fhe.md `stirling` claim's constant term (ln√(2π)) is a natural-log/log2 unit mismatch — Stirling's series requires log2√(2π); confirmed by SymPy asymptotic series + independent float check (offset doesn't shrink with n). Blocks 1 of 4 instruments; the other 3 (meanE/be/fd) verify cleanly and can ship as their own seam. <!-- id:7306 -->
  - **Why**: four owner-placed `\sympyc` (open-debt "desired SymPy, not yet verified") badges exist with
    no instrument behind them — `physics/entropy.md` `meanE` (l.22 mean-energy closed form),
    `be` (l.27 Bose–Einstein N→∞ limit), `fd` (l.35 Fermi–Dirac N=2), and `crypto/fhe.md` `stirling`
    (l.12 `\log_2(2^n)!` Stirling expansion with named correction terms + `O(2^{-n})` remainder). Mechanical
    SymPy plumbing over owner-marked claims = `[ROUTINE]` (scope guard, D4 carve-out).
  - **Scope**: create `verify/entropy_meanE.py`, `verify/entropy_be.py`, `verify/entropy_fd.py`,
    `verify/fhe_stirling.py` — each a `# /// script` uv-runnable SymPy instrument modelled on
    `verify/resogram_esol.py`: derive the claim symbolically, print exactly one `VERDICT: ✓`/`✗` line and a
    `CLAIM_HASH8`. `fhe_stirling.py` verifies the NAMED correction terms + the `O(2^{-n})` remainder
    symbolically (Stirling series), NOT eval-at-a-few-n. Create the sidecars `physics/entropy.toml` and
    `crypto/fhe.toml` (same shape as `physics/Resogram.toml`: `tier_floor`/`tiers`/`claim`/`by`, keyed by
    handle). Wire the new instruments + sidecars into `tests/test_verify.sh` (extend its instrument loop and
    its sidecar non-drift / handle-⊆-source check to cover `entropy.toml` + `fhe.toml`), or add a sibling
    `tests/test_verify_entropy.sh` wired into `tests/run.sh` — either way `make test` must cover them.
  - **Badge flip (D4 carve-out only)**: once an instrument is green and attested, flip its source badge
    `\sympyc`→`\sympy` (the four markers above). This is a badge-ARG edit only — do NOT touch the equation/claim.
  - **Tests**: `tests/test_verify_entropy.sh` (`# roadmap:7306`) — asserts each of the four instruments runs
    under `uv run` and prints `VERDICT: ✓`, and that `physics/entropy.toml` + `crypto/fhe.toml` attestations
    are drift-free with handles ⊆ source `\veq/\veqs` handles. Currently RED (instruments + sidecars absent).
  - **Done-check**: `bash tests/test_verify_entropy.sh` then full `bash tests/run.sh` (both exit 0).
  - **Context**: `verify/resogram_esol.py` + `physics/Resogram.toml` are the reference pattern; `\sympyc` =
    open-debt badge (id:feb8). Meeting `docs/meeting-notes/2026-06-21-2129-lean-formalization-strategy.md` D1/D3.

### Inline-render polish (owner directives 2026-06-18; laned 2026-07-02 apex/human batch, promoted same-id by the 2026-07-02 review)

- [x] [HARD] Colour-code the verification-tier badges — AUTHOR half only (author-then-run) <!-- id:b7e5 -->
  - **AUTHOR HALF DONE 2026-07-04** (relay HARD child): three accessibility-checked palette options
    (`docs/palette-preview/README.md`) mapping the whole badge family + open-debt `\<tier>c` variants to
    colour, each with measured WCAG contrast on the minima light bg (`#fdfdfd`, all ≥4.75:1) and Machado-2009
    deuteranopia/protanopia separation numbers; a self-contained per-option preview render
    (`docs/palette-preview/index.html`, light + future-proof dark strip); and per-engine (KaTeX `\htmlClass`/
    `\textcolor` + trust caveat, MathJax `\class`/`\color`) implementation notes for the run half. Owner-pick
    box filed to `REVIEW_ME.md`. **NO engine config changed** — `git diff` touches only `docs/palette-preview/`,
    `REVIEW_ME.md`, `RELAY_LOG.md`, `ROADMAP.md` (author-then-run split honored). The RUN half re-queues as
    `[ROUTINE]` once the owner ratifies a palette (see the gated sub-note below).
  - **Why**: owner render directive 2026-06-18; laned `[HARD — pool]` with an explicit
    author-then-run split by the 2026-07-02 human-answer batch (TODO id:b7e5, same token). The pool
    AUTHORS the proposal; the owner RATIFIES the pick; only then is the run half implemented. The
    relay never auto-implements a palette the owner hasn't picked.
  - **Author-half deliverable**: 2–3 accessibility-checked palette options (contrast against the
    site background, colour-blind-safe check) mapping the whole badge family (`\sorry`/`\sympy`/
    `\numeric`/`\lean`/`\sympylean` + the `\<tier>c` open-debt variants) to colours (strawman:
    `\sorry` red, `\sympy`/`\sympyc` amber, `\numeric` blue, `\lean` green, `\sympylean`
    deep-green), plus a PREVIEW render per option (a static HTML page rendering sample badges under
    each palette), and per-engine implementation notes: KaTeX prefers `\htmlClass` + CSS over raw
    `\color` (metric warnings; check the `trust` option requirement), MathJax CSS class/`\color`.
    Lands as a REVIEW_ME owner-pick box + preview files (e.g. `docs/palette-preview/`) — NO engine
    config is changed in the author half.
  - **Run half (GATED on the owner's pick)**: implement the ratified palette in both engines +
    `test_mathjax.cjs` coverage; re-queue as `[ROUTINE]` once the pick exists.
  - **Done-check (author half)**: the REVIEW_ME owner-pick box with option + preview paths exists;
    `git diff` shows NO change to `_includes/custom-head.html` / `.vscode/settings.json`.
  - **Context**: TODO id:b7e5; relates to R2/R3 (id:445e); REVIEW_ME id:e0b7 history.

- [x] [ROUTINE] Colour-code the verification-tier badges — RUN half (implement Option C) <!-- id:c7d6 -->
  - **Owner pick 2026-07-11 (relay human)**: Option C — assurance-ramp + amber accent
    (grey→blue→green→deep-green ordinal over the CONVENTIONS.md §2 assurance ladder; `\numeric` an
    off-ramp amber counter-indicator). Best colour-blind separation (deut 50.4). RUN half of the
    author-then-run split; author half shipped as id:b7e5 (`docs/palette-preview/`).
  - **Do**: implement the Option C hexes (from `docs/palette-preview/README.md`) in
    `_includes/custom-head.html` + `.vscode/settings.json` + `tests/test_mathjax.cjs`, per the README's
    per-engine notes (KaTeX `\htmlClass`/`\textcolor` + `trust` caveat; MathJax `\class`/`\color`).
    Colour is REINFORCEMENT — the glyph `? ∘ △ ✓ ✓✓` stays the primary channel; the open-debt `\<tier>c`
    variants reuse the SAME hue as their discharged tier (distinguished by the superscript `?` glyph).
    Then re-walk `tests/HUMAN-integration.md`.
  - **Context**: TODO id:b7e5 (same directive, run half); REVIEW_ME palette-pick box (ticked 2026-07-11).

- [x] [ROUTINE] Badge-macro drift guard: assert `_includes/custom-head.html` matches `test_mathjax.cjs`'s mirror <!-- id:0030 -->
  - **Why**: `test_mathjax.cjs` defines `MJ_MACROS`/`KX_MACROS` as a HARDCODED MIRROR of the badge macros
    in `_includes/custom-head.html` (line 34 "MJ_MACROS mirrors _includes/custom-head.html macros"). Only the
    `\ltag` macro has a drift guard (l.128 reads custom-head.html and asserts it). The badge family
    (`\sorry`/`\sympy`/`\numeric`/`\lean`/`\sympylean` + `\<tier>c`) has NONE — so the id:c7d6 colour
    assertions verify the test's OWN copy carries each `\textcolor{hex}`, NOT that custom-head.html does. A
    future edit that drops `\textcolor` from custom-head.html would render badges colourless yet leave the
    suite green (false-green). Surfaced by the id:c7d6 review 2026-07-11 (colour DID land correctly this
    turn — verified live under both engines; this guards against future silent drift).
  - **Do**: extend the existing l.128 drift-guard pattern to the badge family — for each badge macro, read
    `_includes/custom-head.html`, extract its macro string, and assert it equals the `MJ_MACROS` mirror entry
    (hex included). Mirror the same guard for `.vscode/settings.json`'s KaTeX macro block if it also carries
    the colours.
  - **Done-check**: a deliberately-mutated custom-head.html badge macro (drop one `\textcolor`) makes
    `node tests/test_mathjax.cjs` FAIL; unmutated ⇒ full `bash tests/run.sh` exits 0. (Spec is red until the
    guard exists: today dropping `\textcolor` in custom-head.html does NOT fail the suite.)
  - **Context**: latent pre-existing mirror pattern (predates c7d6; c7d6 merely added colour to the mirror).

## Gated forward-flags — NOT yet executor work

- [ ] (GATED — verify-pilot umbrella) verify-pilot instrument bucket @container — DECOMPOSED, no ungated executor work of its own. Seams: id:e9e9 (entropy meanE/be/fd instruments — SHIPPED, `ROADMAP.archive.md`), id:76e5 (fhe_stirling — GATED on owner content fix, below), id:5d31 (lambertw algebra — GATED on owner marker placement, below), id:37cc (five `\leanc` counts — decision-gate `/meeting`, below). Pick those seams, not this. TODO twin `id:8807` is the design-ledger parent (`[ROUTINE]`-tagged there historically, before the owner reshaped it into these seams); this ROADMAP line is its twin so `unpromoted-scan.sh` no longer misreads the parent as fresh un-promoted backlog. Stays open until every seam closes. <!-- id:8807 -->
- [ ] (FORWARD-FLAG, GATED — NOT yet executor work) CI Lean/Mathlib build <!-- gated-on: id5776-local-lake-build-gate --> <!-- id:9d8c -->
  - **Gate**: a CI Mathlib build is ~60-min cold for one one-liner; warranted ONLY if local kernel-checking
    (id:5776's `lake build` gate) proves insufficient. Parked until that gate fires. Not dispatched.

- [ ] (GATED — owner marker placement first) `lambertw` algebra-step SymPy instrument <!-- id:5d31 -->
  - **Gate**: /meeting id:3d2a D1 split the old `\veq{lambertw}\leanc` (`physics/entropy.md:59`): the ALGEBRA
    steps (l.53–57 inversion chain) are SymPy-provable → own handle + `\sympyc` open-debt badge; the closed-form
    W line (l.59) → `\definition` (its W-branch/domain caveat stays Lean-queued under id:37cc). Placing/moving
    `\veq` markers is OWNER-only content judgment (the D4 carve-out covers the badge ARG only), so the split is
    queued as a REVIEW_ME owner action. Once the split markers land, this becomes a `[ROUTINE]` instrument item:
    `verify/entropy_lambertw.py` + a `physics/entropy.toml` entry + a `tests/test_verify_entropy.sh` row (the
    id:7306 pattern). Split out of TODO id:7306's scope at the 2026-07-01 handoff (ROADMAP id:7306 deliberately
    excludes it); tracked here so closing id:7306 doesn't silently drop it. Not dispatched.

- [ ] (GATED — owner content fix first) `fhe_stirling.py` instrument + `crypto/fhe.toml` sidecar + badge flip <!-- id:76e5 -->
  - **Gate**: seam 2 of id:7306's hard-split (auto, id:3801). The instrument is blocked by a located finding
    in owner content: `crypto/fhe.md:12`'s `stirling` constant term is written `ln√(2π)` but the base-2
    Stirling expansion of `log₂((2^n)!)` requires `log₂√(2π)` = `ln√(2π)/ln 2` — a natural-log/log₂ unit
    mismatch (SymPy asymptotic series + independent float check; the ≈0.407-bit offset does not shrink with
    n; re-verified by the 2026-07-02 review). Resolving a located verify finding = editing owner math =
    HUMAN-ONLY (scope guard), so the fix is queued as a REVIEW_ME owner box (2026-07-02) — the id:5d31
    pattern. Once the owner fixes (or ratifies) the source line, this becomes a `[ROUTINE]` instrument item:
    `verify/fhe_stirling.py` (named correction terms + `O(2^{-n})` remainder, symbolic — NOT
    eval-at-a-few-n) + `crypto/fhe.toml` sidecar + the badge-ARG flip, after which the original
    `tests/test_verify_entropy.sh` (roadmap:7306) can go green and be wired. Not dispatched.
    (Re-laned from the auto-emitted `[HARD — strong model]` — not a recognized lane — by the 2026-07-02
    review; the blocking step is owner judgment, not model strength.)

- [ ] [INPUT — meeting] Lean claims — queued individually <!-- id:37cc -->
  - **Gate (decision-gate)**: NOT executor-ready. Each of the five `\leanc` claims — `ocount`
    (`Fintype.card_fun`), `bij24` (`Fintype.card_perm`), `semidestr`-count (`Nat.choose`),
    `semidestr`-identification (balanced⟺semi-destructive, owner modelling), `lambertw`-branch/domain —
    needs its OWN scoping `/meeting` (fidelity-consume + freeze the Lean signature, the `edot_deriv` pattern)
    BEFORE it can be sized `[ROUTINE]`. All stay `\leanc` open-debt until their meeting lands. Deliverables
    once scoped: `verify/Entropy.lean` + `verify/FHE.lean` (mirror `verify/Resogram.lean`), wired into
    `tests/test_lean.sh`; draft signatures go in the meeting note. Content/modelling judgment (esp. the
    balanced⟺semi-destructive identification) is owner-only.
  - **Context**: `docs/meeting-notes/2026-06-21-2129-lean-formalization-strategy.md` (D2). The `\leanc`
    markers are placed at `crypto/fhe.md:8,67,74` and `physics/entropy.md:59`.

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
- [ ] [HARD — hands] Author the promoted SE subjects + ratified lasercool anchors (TODO id:e552 twin — tick both) <!-- id:e552 -->
  — Q13/Q14 ratified 2026-07-08 (`docs/meeting-notes/2026-07-08-1056-…` §5b): P-C Casimir→field-equations,
  P-A discrete-Noether, M-1+M-2 generators/matrix-exp, and the three lasercool.md section skeletons.
  Physics content = owner-only (scope guard); the mined inventory lives in `docs/se-corpus.md` (its
  mechanical upkeep can become `[ROUTINE]` later — nothing promotable now). The lone open Q16 (post the
  q/669175 self-answer, draft in `docs/drafts/`) is a REVIEW_ME owner box.
- The staleness-checker (TODO `id:04bb`) stays GATED on acoustics (N=2) before it becomes
  a `[ROUTINE]` tooling item.

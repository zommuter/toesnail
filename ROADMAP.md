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

- [x] Document the `lean-toolchain` provenance pointer in `CLAUDE.md` [ROUTINE] <!-- id:318f -->
  - **Why**: inbound `routed:89d0` from `mathematical-writing` (TODO id:318f twin). A reader who
    opens `verify/lean-toolchain` (`leanprover/lean4:v4.30.0-rc2`) can't tell it is a DERIVED cache of
    the vendored Mathlib rev, nor which repo decides a rev bump. Pure docs sync (no theory), executor-eligible.
  - **Scope**: add ONE short pointer to `CLAUDE.md` — natural home is `## Related projects` (l.110) or the
    `## Local build & tests` / Lean material. State the three facts from the routed item, verbatim in intent:
    (a) `verify/lean-toolchain` is a CACHE of the vendored Mathlib rev (`.lake/packages/mathlib/lean-toolchain`),
    NOT a hand-edited fact; (b) toesnail is the triad's rev-bump DECIDER because it pays the ~7 GB Mathlib
    build; (c) `mathematical-writing` PUBLISHES the derived fleet value at its repo root (the value
    `relay-doctor`'s id:50c4 drift-check treats as canonical). Docs/prose only — touch NO `physics/*.md`,
    `essays/*.md`, `verify/*.py`, or engine config; the scope-guard forbids theory edits.
  - **Acceptance**: `bash tests/test_toolchain_pointer.sh` green (the three facts co-occur near a
    `lean-toolchain` mention in `CLAUDE.md`); `bash tests/run.sh` green; `git diff` touches only `CLAUDE.md`
    (+ this ROADMAP/TODO tick).
  - **Spec test**: `tests/test_toolchain_pointer.sh` (RED until the pointer lands), wired into `tests/run.sh`.
  - **Context**: inbound routing breadcrumb `routed:89d0` (from `mathematical-writing`); triad toolchain-pin
    facts live in `verify/README.md` §"Lean tier" and are cross-checked by `relay-doctor`'s id:50c4 gate.

- [x] Sync authoring docs to the `\veq{h}\tier` form — retire the HTML-comment `verify:` syntax [ROUTINE] <!-- id:9fdc -->
  - **Why**: the 2026-06-18 migration (`a9d2`/`dce9`) moved the corpus + KaTeX/MathJax macros to
    `\veq{h}\tier`, but `CONVENTIONS.md`/`CLAUDE.md`/`ARCHITECTURE.md` still teach the retired
    `<!-- verify:tier -->` HTML comment — so a `/relay human` pilot-marker instruction wrongly told the
    owner to author HTML comments. Pure docs/convention sync (no theory), executor-eligible.
  - **Scope**: `CONVENTIONS.md` §2 marker table (l.50-63), `CLAUDE.md` rigor-debt-markers (l.39-49),
    `ARCHITECTURE.md` (l.20), `README.md` §"How this repo works" (l.46-51 — the `verify:` rigor-marker
    description + the `grep -rn 'verify:' .` running-list pointer, both now stale post-migration), and the
    `REVIEW_ME.md` `verify:`-pilot owner instruction. Document the
    implemented form: `\veq{h}\tier` badges `\sorry`→? `\sympy`→∘ `\numeric`→△ `\lean`→✓ `\sympylean`→✓✓;
    open-debt is `\veq{h}\sorry` (NOT `\sympy*` — `id:feb8` `\tier*` notation is still unresolved).
    KEEP the D4 carve-out: tooling MAY write the badge arg, but the equation/claim inside `\veq{…}` stays
    human-only theory.
  - **Acceptance**: `grep -rnE '<!--[[:space:]]*verify:' CONVENTIONS.md CLAUDE.md ARCHITECTURE.md` returns
    nothing; `README.md` no longer describes the marker as a `verify:` HTML comment and its running-list
    pointer reflects the `\veq` form (e.g. `grep -rn '\veq' .` or the sidecar attestations, not
    `grep -rn 'verify:'`); each doc describes `\veq{h}\tier`; `bash tests/run.sh` green.
  - **Not gated**: macros (`_includes/custom-head.html`, `.vscode/settings.json`) + corpus migration
    (`a9d2`/`dce9`, `id:e0b7` pilot) already landed 2026-06-18. NB the residual content-bearing finding
    comment at `physics/Resogram.md:21` is owner-only (theory notes), out of this item's scope.
  - **Context**: meeting `docs/meeting-notes/2026-06-18-0729-veq-macro-verify-carrier.md` (D2-D4).

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

- [x] Stand up a one-section Resogram `.mw` mirror the HARD tier reads [ROUTINE] <!-- id:0e63 -->
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
  - [x] **FIDELITY FIX follow-up [HARD — strong model] — RESOLVED 2026-06-16 (/meeting D3, owner-ratified): faithful four-block mirror (delta own fragment, ebar integral form); test green.** The
    DAG-mechanics test is green but the owner REJECTED the transcription fidelity (REVIEW_ME box 0e63). Two
    faithful-transcription corrections: (a) replace `ebar = Omega/pi * e` with the faithful half-period
    convolution `\bar e = (Ω/π)∫₀^{π/Ω} e(t-t')·e^{+2βt'} dt'` in `.mw` computation syntax (no scalar-multiply
    reduction); (b) add a SEPARATE `delta = atan2(Omega, beta)` fragment/cache item that the `e` block
    references (gives a `δ→e→ebar` DAG chain), not a dangling symbol.
    **Why HARD, not ROUTINE (reclassified 2026-06-16, grounded in `.mw` source):**
      (1) `test_mw_mirror.sh` gives ZERO fidelity signal — `mathematical_writing.dag` keys edges on REGEX
          symbol references (`_extract_defines_uses`/`_data_symbols`), so the `e→ebar` edge holds for ANY RHS
          merely containing `e`; the test is green for both the unfaithful `Omega/pi*e` AND a faithful
          integral (that's why the bug shipped green). An executor gated on "test passes" has no pressure
          toward faithfulness — owner-judged fidelity is the real gate and lives OUTSIDE the test.
      (2) Faithfully expressing `e(t-t')` is `.mw`-modeling judgment: the mirror defines `e` as a SymPy data
          symbol (`Expr`), but the convolution needs it evaluated at a SHIFTED argument. The eval/attestation
          core treats `e` as data, not callable — so the time-shift (`subs(t, t-tp)`? `Function`? `lambdify`?)
          needs `.mw` computation-semantics knowledge and may surface a `.mw` capability gap (cross-repo).
    The transcription TARGET is owner-settled; the IMPLEMENTATION needs strong-model sizing + the owner
    re-confirms fidelity (the test can't). Same id (single-id-two-views). <!-- id:0e63 -->.

- [x] Implement the v1 `post-commit` hook (deterministic HARD tier) [ROUTINE] <!-- id:8757 -->
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

- [x] Set git config + document the hook install in `CLAUDE.md` [ROUTINE] <!-- id:d5f9 -->
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

- [x] **Test suite for the hook cluster** — `tests/test_verify_hook.sh` + `tests/test_mw_mirror.sh` <!-- id:211c -->
  - This id is fulfilled by the C3 red suite this handoff already AUTHORED. The executor does NOT write these
    tests — its job across id:0e63/8757/d5f9 is to make them go GREEN. Recorded here for id-continuity only.

### Lean `edot` cluster (SCOPED 2026-06-16, meeting `2026-06-16-0827-lean-edot-proof-mathlib-bringup.md` D1–D5)

The 2026-06-15 single Lean item was decomposed by the 2026-06-16-0827 `/meeting` into the cluster below.
Toolchain is now CONFIRMED present (`/usr/bin/{lake,lean,elan}`; elan toolchains `v4.30.0-rc2`+`v4.31.0`;
shared 415 MB `~/.cache/mathlib` download cache) — the HANDBACK-if-no-toolchain risk is moot. Order: **3317
(bring-up + proof) → 5776 (test wiring) → 1335 (marker) → 3275 (rigor-debt annotation)**. SCOPE GUARD still
binds: this is `verify/` plumbing + tests + attestation-marker bookkeeping ONLY — NO executor edits any
physics/maths/narrative prose. The proof is of an *owner-stated, SymPy-confirmed* claim (allowed).

- [x] Stand up `verify/` lake project pinned `v4.30.0-rc2` + prove `edot_first_line` [HARD — strong model] [INTENSIVE — lean-build] <!-- id:3317 -->
  - **Why HARD + INTENSIVE**: first Mathlib extract is a heavy build (~6.6 GB, minutes even with the warm
    415 MB cache via `lake exe cache get`) — must run serially-alone (`--allow-intensive`), never inside a
    parallel wave (OOM risk, conventions §id:8d52). The proof itself is a one-liner (`subst; ring`); the cost
    is the bring-up, not the formalization.
  - **Acceptance** (D1/D2): tracked `verify/{lakefile.toml, lean-toolchain (→ v4.30.0-rc2),
    lake-manifest.json, Resogram.lean}`; `.gitignore += .lake/`; `verify/README.md` documents the canonical
    clean-clone build (`lake exe cache get && lake build`) plus the OPTIONAL btrfs `cp --reflink=auto` local
    space footnote (NOT a build step, NOT a symlink). `cd verify && lake build` exits 0 with NO `sorry`,
    discharging `theorem edot_first_line (x ẋ ẍ y β ω : ℝ) (eom : ẍ = -2*β*ẋ - ω^2*(x-y)) :
    ẋ*(ẍ + ω^2*x) = -2*β*ẋ^2 + ω^2*ẋ*y := by subst eom; ring`. This is the *algebraic* first-line identity
    (handle `edot`) — the derivative step is separate debt (id:b9bc), NOT in scope here.
  - **Done-check**: `cd verify && lake build` (exit 0) + `grep -L sorry verify/Resogram.lean`.
  - **Context**: `verify/resogram_edot.py` confirms the algebraic step symbolically; `docs/rigor-debt.md`.
    HANDBACK only if the warm-cache build fails for a reason no unattended fix covers (never `sudo`/`pamac`).

- [x] Add `tests/test_lean.sh`, SKIP-without-lake, wired into `tests/run.sh` [ROUTINE] <!-- id:5776 -->
  - **Acceptance** (D4): `tests/test_lean.sh` mirrors the optional-tool SKIP pattern (`test_render.sh` w/o
    Ruby, `test_mathjax.cjs` w/o node) — `command -v lake` absent → SKIP (clean, never FAIL); present →
    `cd verify && lake build` + `grep -L sorry verify/Resogram.lean` (a `sorry`-green is a fake green and
    must FAIL). Wired into `tests/run.sh`. CI stays SKIP (no Lean toolchain there — id:9d8c is the gated CI
    item). DEPENDS ON id:3317 (the lake project must exist for the non-SKIP path).
  - **Tests**: this item *adds* the test; its own contract is the done-check below.
  - **Done-check**: `bash tests/run.sh` PASSes overall; on a lake-less host `test_lean.sh` SKIPs cleanly;
    on this host (lake present) it runs the real `lake build` + `grep`.
  - **Context**: optional-tool-SKIP is the ".mw optional, never a gate" invariant mirrored to Lean.

- [x] Escalate `edot` to the compressed multi-tier `verified:` marker + grammar doc [ROUTINE] <!-- id:1335 -->
  - **Acceptance** (D5): in `physics/Resogram.md:42`, rewrite the existing attestation **HTML comment** ONLY
    (NOT any prose/math) from `verified:sympy [edot] claim=b575864e by=resogram_edot.py@54710d91` to
    `verified:sympy+lean [edot] claim=b575864e by=resogram_edot.py@54710d91,Resogram.lean@<h8>` (same
    `srepr` claim-hash across tiers; `<h8>` = the new `Resogram.lean` filehash). Add the grammar
    `verified:<tiers> [handle] claim=<claimhash8> by=<inst1>@<h8>[,<inst2>@<h8>]`, `<tiers>` ∈
    {`sympy`,`lean`,`sympy+lean`}, to `CONVENTIONS.md` §2. SCOPE: this edits a `verified:` ATTESTATION
    marker (HTML comment for an owner-marked claim) — explicitly the allowed mechanical-plumbing carve-out
    (ROADMAP scope-guard bottom note). Touch NO equation, NO narrative. DEPENDS ON id:3317 (need the
    `Resogram.lean` filehash).
  - **Tests**: `tests/test_verify.sh` already parses `verified:` markers; the upgraded marker must still
    parse and the `edot` row must show the two-tier `by=` list.
  - **Done-check**: `bash tests/test_verify.sh` (marker parses, `edot` carries both instrument pointers).
  - **Context**: keep the `srepr` claim-hash byte-identical across tiers; only the per-instrument filehash
    differs. The automated staleness checker (id:04bb) stays N=2-gated — out of scope.

- [x] Annotate `docs/rigor-debt.md`: edot lean-attested + SymPy-as-gate datapoint [ROUTINE] <!-- id:3275 -->
  - **Acceptance** (D5): update the `[edot]` row in `docs/rigor-debt.md` to record that the algebraic
    first-line identity is now **lean-attested** (tier `sympy+lean`), with both instrument pointers
    (`resogram_edot.py`, `Resogram.lean`), AND record the per-tier outcome for the SymPy-as-gate dataset
    (did SymPy's `sympy ✓` correctly predict the lean-provable claim — a datapoint toward evaluating SymPy
    as a cheap pre-filter). This is triage-menu bookkeeping in a docs file — NO physics/math edits.
    DEPENDS ON id:3317 + id:1335.
  - **Done-check**: `grep -n 'edot' docs/rigor-debt.md` shows the `sympy+lean` row with both pointers.
  - **Context**: `docs/rigor-debt.md` is the triage menu, not a work order; this only annotates an already-
    resolved row.

- [x] Prove `edot_deriv` (derivative step `ė=ẋ(ẍ+ω²x)`) via Mathlib `HasDerivAt` [ROUTINE] [PILOT — Sonnet-on-Lean4] <!-- id:b9bc -->
  - **Re-scoped 2026-06-16** (/meeting `2026-06-16-2257-edot-deriv-lean-formalization.md`): the fidelity
    judgment is consumed in the meeting; what remains is filling one proof body against a FROZEN signature,
    which is mechanical + testable → `[ROUTINE]`. The 0827 "multi-day" estimate priced the *unscoped*
    problem; EOM-free + `HasDerivAt.pow` reduces it to ~1 session. id:3317 (lake + Mathlib) HAS LANDED.
  - **FROZEN signature** (D1 — owner-ratified; do NOT alter name, hypotheses, or conclusion; do NOT add
    hypotheses). Add as a second theorem in `verify/Resogram.lean`:
    ```
    theorem edot_deriv (x v a : ℝ → ℝ) (ω : ℝ) (t : ℝ)
        (hx : HasDerivAt x (v t) t)          -- ẋ = v
        (hv : HasDerivAt v (a t) t)          -- ẍ = a
        : HasDerivAt (fun s => (1/2)*(v s)^2 + (1/2)*ω^2*(x s)^2)
                     (v t * (a t + ω^2 * x t)) t := by
      sorry  -- ← fill ONLY this; see proof sketch
    ```
  - **Proof sketch** (~5 lines, standard Mathlib analysis): combine `hv.pow 2` (rate `2·v·a`) scaled by ½
    with `hx.pow 2` scaled by `ω²/2`, then reconcile to `v(a+ω²x)`:
    `(((hv.pow 2).const_mul (1/2)).add ((hx.pow 2).const_mul (ω^2/2))).congr_deriv (by ring)` — if
    `congr_deriv` is fussy, `convert (((hv.pow 2)…).add …) using 1; ring`. Exact lemma names may need a
    `exact?`/`apply?` nudge; the shape is fixed.
  - **Why `HasDerivAt` not `deriv`** (D1): Mathlib `deriv` is total junk-on-failure (returns `0` off-domain),
    a latent fidelity hole; `HasDerivAt` witnesses carry differentiability in named hyps. Do NOT switch to a
    `deriv`-based statement.
  - **Attestation** (D3/D4 — the allowed mechanical-plumbing carve-out, NO prose/math edits): add a
    `<!-- verify:lean [edot_deriv] -->` HTML-comment marker near edot.1 in `physics/Resogram.md`, escalate to
    `<!-- verified:lean [edot_deriv] claim=<h8> by=Resogram.lean@<h8> -->` once proven (lean-only tier; the
    grammar already admits it — NO CONVENTIONS change). Add a `[edot_deriv]` row to `docs/rigor-debt.md`:
    lean-attested + **SymPy-blind** (record as the contrast datapoint for the SymPy-as-gate eval). Interim
    HTML-comment carrier is deliberate (corpus consistency); the brace-grammar migration is id:a9d2 (gated).
  - **Done-check**: `cd verify && lake build` exit 0; `verify/Resogram.lean` contains `edot_deriv` with the
    EXACT frozen signature, no added/weakened hyps; `grep -L sorry verify/Resogram.lean` clean; `bash
    tests/run.sh` PASSes (`test_lean.sh` unchanged — second theorem in the same file is already covered).
  - **PILOT (owner)**: this run is an n=1 measurement of how well a Sonnet executor handles a simple Lean4
    proof. The `RELAY_LOG.md` self-report MUST record the experience honestly: clean-close / flailed /
    needed handback / slipped a `sorry` the grep caught — feeds the question of whether simple Lean4 work
    can be ROUTINE-dispatched to Sonnet generally. HANDBACK is a VALID outcome — if the proof resists, say
    so in the log rather than weakening the signature or `sorry`-ing.

### Recovered-pages infrastructure (recovery merge `c1e20b4`, 2026-06-16)

- [x] Extend render-test coverage to ALL recovered pages [ROUTINE] <!-- id:7fd7 -->
  - **DONE 2026-06-16** (strong turn): all five recovered pages — `physics/entropy.md`,
    `physics/wirohsh.md`, `physics/photon.md`, `crypto/fhe.md`, `essays/supertool.md` — added to the
    `DOCS` array in `tests/test_mathjax.cjs`; `tests/test_page_coverage.sh` wired into `tests/run.sh`;
    full suite green. TOOLING/coverage only — no content edited.
  - **CORRECTION**: an earlier handoff note claimed `wirohsh.md`/`photon.md` "fail to render" and
    scope-guarded them out. That was an UNVERIFIED claim — it was wrong. Running them through
    `tests/test_mathjax.cjs` shows ALL 32 + 2 display blocks render clean under both MathJax 3 and KaTeX.
    "Incomplete derivation" (empty `align` blocks, unfinished sections) is valid LaTeX and renders fine;
    whether to FINISH the math is an owner content question (REVIEW_ME id:8807), orthogonal to render
    coverage. The scope guard was removed — there was nothing to hand back.
  - **Tests**: `tests/test_page_coverage.sh` (`# roadmap:7fd7`) — asserts all five pages are in `DOCS`.
  - **Done-check**: `bash tests/test_page_coverage.sh` then full `bash tests/run.sh` (both exit 0).
  - **Note (owner content, untouched)**: KaTeX emits a non-fatal `newLineInDisplayMode` *warning* for a
    `\\` in a non-`align` display block in `entropy.md` — a style nit in owner math, not a render error;
    left as-is.

- [x] Exclude `crypto/` non-page companions from the Jekyll build [ROUTINE] <!-- id:fed0 -->
  - **Acceptance**: `_config.yml` gains an `exclude:` entry covering `crypto/fhe.ipynb`, `crypto/fhe.py`,
    `crypto/fhe.ods` so they are NOT copied into `_site`; the FHE page (`crypto/fhe.md` → `/FHE`) still
    renders; `tests/test_crypto_exclude.sh` is wired into `tests/run.sh`. Do NOT delete the companions
    from the repo (the `.ods` holds unique 368-cell enumeration work).
  - **Tests**: `tests/test_crypto_exclude.sh` (`# roadmap:fed0`) — builds and asserts the companions are
    absent from `_site/` while `_site/FHE.html` exists (SKIPs without Ruby; currently RED).
  - **Done-check**: `bash tests/test_crypto_exclude.sh` then full `bash tests/run.sh`.
  - **Owner-flag**: default keeps these source-only (source-stays-plain). If the owner wants the `.ods`
    downloadable from the site, that's a one-line re-include — tracked under the verify-pilot box (id:8807).

### Entropy + FHE SymPy verify-instrument bucket (/meeting id:3d2a D1/D3, promoted 2026-07-01)

Design spec: `docs/meeting-notes/2026-06-21-2129-lean-formalization-strategy.md` (D1/D3). The
owner has already PLACED the `\sympyc` open-debt badges in the source (id:8807); the executor's job
is the TOOLING half — build the SymPy instruments, write the sidecars, wire the test, and (badge-arg
carve-out D4) flip the discharged badges `\sympyc`→`\sympy`. **NO executor edits the physics/claims**
inside the `\veq{…}` — only the badge arg once its instrument is green. The `lambertw` marker
(`physics/entropy.md:59`, now `\leanc`) is OUT of scope — it belongs to the Lean bucket (id:37cc) and
its marker-split is an owner content decision, not this item.

- [ ] Build the entropy + FHE-Stirling SymPy instruments + sidecars [HARD — decision gate] @container — 🚧 GATED (auto, id:3801; route:hard-split): DECOMPOSED into seams id:e9e9, id:76e5 — pick those, not this. fhe.md `stirling` claim's constant term (ln√(2π)) is a natural-log/log2 unit mismatch — Stirling's series requires log2√(2π); confirmed by SymPy asymptotic series + independent float check (offset doesn't shrink with n). Blocks 1 of 4 instruments; the other 3 (meanE/be/fd) verify cleanly and can ship as their own seam. <!-- id:7306 -->
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

- [x] Build entropy meanE/be/fd SymPy instruments + `physics/entropy.toml` sidecar + badge flips (`\sympyc`→`\sympy`) [ROUTINE] — seam 1 of id:7306's hard-split (auto, id:3801) <!-- id:e9e9 -->
  - **DONE 2026-07-02** (executor; verified genuine by the 2026-07-02 review): `verify/entropy_{meanE,be,fd}.py`
    first-principles SymPy instruments (finite-N sum / N→∞ limit / N=2 case, each derived independently of the
    doc's own algebra chain), `physics/entropy.toml` attestation sidecar, badge-ARG-only flips in
    `physics/entropy.md` (equations untouched — D4 carve-out honored). New narrower spec
    `tests/test_verify_entropy_routine.sh` (`# roadmap:e9e9`) wired into `tests/run.sh`; the original
    `tests/test_verify_entropy.sh` (`# roadmap:7306`, all FOUR instruments) was deliberately kept RED +
    unwired — NOT weakened — pending the id:76e5 stirling seam. (Relocated here from the misplaced
    auto-append at the file bottom, 2026-07-02 review.)

- [x] Document the tier-escalation ladder in `CONVENTIONS.md` [ROUTINE] <!-- id:2709 -->
  - **Why**: `CONVENTIONS.md` §2 teaches the badge glyphs and "tier = assurance floor" but never states the
    DECISION LADDER an author/tool follows when picking a tier (the id:3d2a D3 outcome). Pure docs/convention
    text, executor-eligible.
  - **Scope**: extend `CONVENTIONS.md` §2 (verify-marker section) with the escalation ladder: **SymPy-if-it-
    closes → else Lean → else an honest open-debt badge naming the DESIRED tier** (`\sympyc`/`\numericc`/
    `\leanc`). State explicitly that `\definition` is never a dodge for a real claim (a claim that needs
    discharge must carry a discharge tier, not be relabelled a definition), and that numeric is a
    complementary COUNTER-indicator, never the assurance badge. No content/theory edits.
  - **Tests**: `tests/test_conventions_ladder.sh` (`# roadmap:2709`) — greps `CONVENTIONS.md` for the ladder
    (the ordered SymPy→Lean→open-debt escalation, the `\definition`-is-not-a-dodge clause, and the
    numeric-is-counter-indicator clause). Currently RED (ladder not yet documented).
  - **Wiring**: when the test goes green, ALSO wire `test_conventions_ladder.sh` into `tests/run.sh`'s
    test loop (the runner has no expected-red lane, so red specs stay unwired until green — but an unwired
    green test is orphaned; `make test` must cover it from then on).
  - **Done-check**: `bash tests/test_conventions_ladder.sh` then full `bash tests/run.sh` (both exit 0),
    with the ladder test wired into `tests/run.sh`.
  - **Context**: meeting `docs/meeting-notes/2026-06-21-2129-lean-formalization-strategy.md` D3.

### Inline-render polish (owner directives 2026-06-18; laned 2026-07-02 apex/human batch, promoted same-id by the 2026-07-02 review)

- [x] Inline `\veqs`: hide the handle, parenthesize the tier badge [ROUTINE] <!-- id:9c41 -->
  - **Why**: owner render directive 2026-06-18 — inline `\veqs{h}\tier` (the FHE counts
    `\veqs{ocount}\leanc` etc.) currently shows the handle (KaTeX `#1\quad #2`; the residual id:a138
    cosmetic) and a bare badge; the owner wants NO label shown and the tier badge in parens:
    `… 2^{m2^n} (✓?)`, not `… ocount ✓?`. Laned `[ROUTINE]` by the 2026-07-02 apex DQ triage
    (TODO id:9c41 — same token, single-id-two-views).
  - **Scope**: `_includes/custom-head.html` (MathJax `veqs` macro), `.vscode/settings.json` (KaTeX
    `\veqs`), then sync the MJ_MACROS/KX_MACROS mirrors in `tests/test_mathjax.cjs`. Display `\veq`
    is OUT of scope (unchanged). CONSTRAINT (verified while authoring the spec): a KaTeX string
    macro MUST reference `#1` — a body without it is a parse error — so hiding needs an invisible
    carrier (`\hphantom`-family; zero-width e.g. `\rlap{\hphantom{#1}}`) or a restructure. If the
    fix would require changing the CALL-SITE syntax in owner content (`crypto/fhe.md` inline
    markers), STOP and hand back — owner-placed markers are not tooling-editable beyond the badge
    arg (D4 carve-out).
  - **Tests**: `tests/test_veqs_inline.cjs` (`roadmap:9c41` — authored RED by the 2026-07-02 review,
    deliberately UNWIRED from `tests/run.sh` until green; the runner has no expected-red lane). It
    reads the REAL engine configs, not the test mirrors — do not weaken it.
  - **Done-check**: `node tests/test_veqs_inline.cjs` green → add it to the `tests/run.sh` list;
    full `bash tests/run.sh` green (incl. `test_mathjax.cjs` with the synced mirrors). A config
    change here re-triggers the `tests/HUMAN-integration.md` visual re-walk (note it in the log).
  - **Context**: REVIEW_ME id:e0b7 rounds 4–5 (the `\veqs` design history); TODO id:9c41.

- [x] Colour-code the verification-tier badges — AUTHOR half only (author-then-run) [HARD — pool] <!-- id:b7e5 -->
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

- [ ] Colour-code the verification-tier badges — RUN half (implement Option C) [ROUTINE] <!-- id:c7d6 -->
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

## Gated forward-flags — NOT yet executor work

- [ ] (FORWARD-FLAG, GATED — NOT yet executor work) CI Lean/Mathlib build <!-- id:9d8c -->
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

- [ ] Lean claims — queued individually [HARD — meeting] <!-- id:37cc -->
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

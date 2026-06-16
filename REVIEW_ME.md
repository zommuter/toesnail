# Human review queue <!-- budget: 15 min -->

Judgment calls for the owner — **theory decisions the AI surfaced but must never make.**
A ticked box = "owner confirms this interpretation/correction"; to correct one, edit the
cited source (or leave a note under the item) and the next review re-derives. Resolved via
`/relay human` or `/meeting`. Max ~10 open boxes.

> These are owner-ratified by design (the no-AI-vibe-thinking-the-theory constraint). A
> `.mw`/collAIb tool may later *pre-fill a suggested fix* for a sufficiently-clear item,
> but a human still accepts it — the suggestion is a draft, not a merge.

## Divergent-main recovery merge — portal surfacing (merge `c1e20b4`, 2026-06-16)

- [ ] **Recovered owner pages — confirm portal surfacing + crypto-wing topology.** The
  cartmanjaro divergent-main recovery merge `c1e20b4` refiled owner-authored pages into the
  post-restructure dirs: `physics/entropy.md`, `physics/wirohsh.md`, `physics/photon.md`,
  `crypto/fhe.md` (NEW top-level wing), `essays/supertool.md`. This
  /relay review added them to the `README.md` portal index and recorded the new `crypto/` wing in
  `ARCHITECTURE.md §4` (navigation/topology bookkeeping only — NO content edited). **Owner:**
  (a) confirm these belong on the portal now — `physics/photon.md` is a self-described "rough stub"
  (currently listed as such); pull it from the portal if it isn't ready; (b) confirm `crypto/` is the
  intended home for FHE (vs `physics/` or an essay). The 3 `img/craiyon_*.png` AI-art assets are
  recovered but unwired (no page references them) — confirm intended target page or leave orphaned.
  - **UPDATE 2026-06-16 (later same session — supersedes the original (c) + the productivity entry):**
    (i) `essays/productivity.md` was a **dated personal journal**; it has been **scrubbed from git
    history** (owner privacy call) into gitignored `private/productivity.md`, and its `README` portal
    link removed (forward commit, no force-push) — it is no longer a recovered/portal page.
    (ii) the `fhe.{ipynb,py,ods}` companions **were restored** into `crypto/` (a comparison found
    `crypto/fhe.ods` holds the unique 368-cell enumeration the `.md` only abbreviates); the open
    question is now only whether they should be **published on the site** — default is source-only
    (excluded via `_config.yml`, ROADMAP id:fed0); say if you want the `.ods` downloadable.

- [ ] **`verify:` pilot candidates in the recovered pages — owner picks which claims to mark.**
  The recovered derivations carry clean, self-contained results that are natural `verify:` pilots.
  Per the working contract the AI does **not** choose which claims to mark — surfacing candidates only;
  once the owner marks a claim with a `verify:sympy|numeric|lean` comment, the mechanical instrument
  plumbing becomes `[ROUTINE]` (cf. the Human-only note in `ROADMAP.md`). Candidates by tier:
  - **`verify:sympy` — `physics/entropy.md`** (cleanest pilot): the `N→∞` limit collapsing to
    Bose–Einstein `⟨k⟩ = 1/(e^{βE₁}−1)` and the `N=2` case to Fermi–Dirac `1/(e^{βE₁}+1)`; and the
    Lambert-W inversion `E₁ = −(1/β)·W(−βE·e^{∓βE})`. All are symbolic identities SymPy can re-derive.
  - **`verify:numeric` — `crypto/fhe.md` + `crypto/fhe.ods`**: the enumeration closure — `Πₙ = log₂((2ⁿ)!)`
    Stirling expansion, the `binom(2ⁿ, 2^{n−1})` semi-destructive count, and the 24-row `n=2` bijective
    table. A numeric instrument can regenerate the tables and cross-check the `.ods` (the dogfood here is
    that the spreadsheet IS the worked computation — a perfect attestation target).
  - **`verify:sympy`/`lean` — `physics/wirohsh.md`** (PARTIAL — mark only the complete identities): the
    tangential-Laplacian reduction `Δ_φ = (∂_x sinφ − ∂_y cosφ)² = ∂_{φ̄}²` and the 1D back-rotation
    `f = f⁺(x−ct) + f⁺(x+ct)`. NOTE the page has unfinished sections (empty `align` blocks) — those are
    not yet markable as `verify:` claims (no closed result). They render fine, though — the page IS in the
    render-test coverage (id:7fd7); "unfinished derivation" is a separate, owner content question.
  - **`physics/photon.md`** carries no closed result yet (Ansatz only) — no pilot until the owner develops it.

- [x] `verify/resogram_edot.py` (handle `edot`, `docs/rigor-debt.md`) — **located algebra
  discrepancy.** The doc's 2nd equality `ė = −4βe − ω²(2βx² − ẋy)` is wrong (off by
  `−4βω²x²`); SymPy confirms the correct closed form is `ė = −4βe + ω²(2βx² + ẋy)` (sign on
  the ω²-bracket). **Owner:** confirm the correction (then fix `physics/Resogram.md`) or
  re-derive. AI will not edit the math.
  **RESOLVED 2026-06-15 (owner-ratified, /relay human):** owner confirmed the sign correction;
  source `edot` block now reads `−4βe + ω²(2βx² + ẋy)`. Re-check: `git show` on `physics/Resogram.md`
  handle `edot`; `verify/resogram_edot.py` derives this end-to-end. **Instrument re-pinned 2026-06-15
  (/relay review):** `resogram_edot.py` verdict ✗→✓, `test_verify.sh` pins edot=✓, `verified:sympy [edot]
  claim=b575864e by=resogram_edot.py@54710d91` attestation added.
- [x] `verify/resogram_cval.py` (handle `cval`) — **"is c=0?" answered: c ≠ 0.** The free
  oscillator's energy is phase-shifted: `e = (A²ω/2)e^{−2βt}(ω + β cos(2(Ωt+φ) − δ))`,
  `δ=atan2(Ω,β)`; the stated `(c+cos²(Ωt+φ))e^{−2βt}` form omits a `sin(2θ)` term, and
  forcing a cos(2θ) match gives `c = Ω²/(2β²) ≠ 0`. **Owner:** confirm the finding and the
  preferred framing (keep the approximate form with a note, or adopt the exact one).
  **RESOLVED 2026-06-15 (owner-ratified, /relay human): ADOPT THE EXACT FORM.** Source `cval`
  equation now states `e = (A²ω/2)e^{−2βt}(ω + β cos(2(Ωt+φ)−δ))`, `δ=atan2(Ω,β)`. Re-check:
  `physics/Resogram.md` handle `cval`; `verify/resogram_cval.py` derives this exact form.
  **Instrument re-pinned 2026-06-15 (/relay review):** `resogram_cval.py` verdict ✗→✓, `test_verify.sh`
  pins cval=✓, `verified:numeric [cval] claim=18d3f7a7 by=resogram_cval.py@a64cfdc0` attestation added.
  **ONE follow-up STILL OPEN (box below):** the surrounding c-narrative reconciliation (owner-only prose).
- [x] `physics/Resogram.md` (handle `sol`) — **integrand typo.** The rendered solution has
  an unbalanced paren `\sin(\Omega (t-t')e^{-\beta(t-t')}` (missing `)` after `(t-t')`); the
  SymPy-verified kernel is `sin(Ω(t−t'))·e^{−β(t−t')}`. **Owner:** confirm the one-char fix.
  **RESOLVED 2026-06-15 (owner-ratified, /relay human):** one-char fix applied; integrand now reads
  `\sin(\Omega (t-t'))e^{-\beta(t-t')}`. Pure render fix — no verdict/instrument change (sol stays ✓).

## Resogram energy-method chain — located discrepancies (`/meeting` 2026-06-15)

> The c-narrative reconciliation (routed here via `/relay human`) opened into a small **cluster**: the
> `edot` sign fix propagates through the energy-method section, and a late-night averaging window looks
> suspect. Per the owner's call (`/meeting` 2026-06-15) each discrepancy was **flagged in place** with a
> visible `🚧 located rigor-debt` callout in `physics/Resogram.md`. **AI flags only — the owner authors
> every physics/prose fix (the vibe-veto holds).** Canonical `.mw` motivating example.
>
> **Owner resolved the cluster in-document (commit `236fa1b` "re: resogram", reconciled here 2026-06-15):**
> responses given as inline `**re**` notes against the callouts; boxes ticked below from those edits. Ticks
> are CLAIMs the next `/relay review` re-derives. **Two NEW items spun out of the owner's edits** (render
> regression + subequation numbering — see bottom).

- [x] `verify/resogram_cval.py` → `resogram_esol.py`, handle `cval`→`esol` — **rename DONE (`/meeting` 2026-06-15).**
  The old `cval` ("find the constant c") name was answered and obsolete; `esol` = the analytical energy
  SOLUTION. Mechanical sweep across `\ltag`, the `[esol]` verify/verified markers, the instrument file,
  `test_verify.sh`, and `verify/README.md`; attestation re-pinned `by=resogram_esol.py@e6722a73`
  (claim hash unchanged `18d3f7a7`). `tests/test_verify.sh` green (5✓/0✗, esol pinned ✓). <!-- id:adfc -->

- [x] `physics/Resogram.md` (¶ before `ymaint`) — **energy-loss claim — RESOLVED by owner (`236fa1b`).** The
  ¶ now reads "it would be clear **from (edot.3)** that a free oscillator … would permanently loose energy",
  citing the manifestly-≤0 first form `ė = −2βẋ²`. Owner `**re**`: "okay, explicitly mentioned (edot.3)".
  ⚠️ The `(edot.3)` reference depends on the subequation tags that don't yet render — see id:3b4c / id:d2f4. <!-- id:559c -->

- [x] `physics/Resogram.md` (handles `ymaint`/`yfree`) — **terse derivation — ACKNOWLEDGED by owner (`236fa1b`).**
  Owner `**re** same`: accepted as an exposition gap (results machine-verified ✓ by `resogram_drive.py`,
  unaffected by the `edot` sign fix). Fuller step-by-step exposition is deferred to the subequation
  auto-numbering wishlist (id:d2f4). <!-- id:0cb5 -->

- [x] `physics/Resogram.md` (`esol` prose) — **c-narrative — RESOLVED by owner (`236fa1b`).** The dangling
  "I'm too lazy to check whether $c=0$, doesn't matter anyway" sentence was removed (now just "This hints at
  a sensible sliding average:"); the pre-solution handwaving ¶ ($-2\beta e$ averaging) was kept as framed.
  Successor to id:9135; summary id:e27e. <!-- id:f9fe -->

- [x] `physics/Resogram.md` (sliding average $\bar e$) — **window — RESOLVED by owner (`236fa1b`).** Corrected
  from $2\Omega\int_0^{1/2\Omega}$ to $\frac{\Omega}{\pi}\int_0^{\pi/\Omega}$ — a proper full-period average
  over the `β cos` term's period $\pi/\Omega$. The late-night `1/(2Ω)` (blame: `0249a41` 2021-01-31 00:56)
  is fixed. <!-- id:3999 -->

## Spun out of the owner's `236fa1b` edits (tooling / render — AI-eligible)

- [x] `physics/Resogram.md` energy block — **render regression — FIXED (owner-confirmed, 2026-06-15).** The
  `\ltag{e}`-inside-`aligned` → MathJax `merror` was un-broken by splitting into two `$$` blocks (`e` tagged
  `\ltag{e}`; the ė-chain `aligned` tagged `\ltag{edot}` on the outer block). No math changed. `tests/run.sh`
  green again (MathJax + KaTeX both render); CI green on the fix commit. Owner picked the split over an
  interim single tag. <!-- id:3b4c -->

- [ ] **Wishlist: automated subequation dot-numbering** — derive `(edot.1)…(edot.4)` handles from a parent
  handle so per-line tags render (amsmath `subequations`/`align` style), letting the owner cite individual
  derivation steps. The owner currently has them commented out (`%\ltag{edot.N}`). Nice-to-have (owner, sugar):
  re-align the `=` signs of `(e)` and `(edot)` across the now-split blocks — the two-`$$` split (render fix
  id:3b4c) aligns each block independently; owner notes `.mw` may make this moot. (Handle drift is RESOLVED by
  the split: `\ltag{e}` on the energy block, `\ltag{edot}` on the ė-chain's outer block re-attaches the
  `[edot]` marker.) Relates to ROADMAP R2/R3 (id:445e) and `.mw`. <!-- id:d2f4 -->
  — **DEFERRED pending `.mw` (owner, /relay human 2026-06-16).** Disposition decided: do NOT
    schedule pool work now; the `.mw` motivating example may make per-line subequation numbering
    moot. Box stays OPEN as a tracked wishlist; revisit only after `.mw` lands (then either build
    or drop). Not "build now", not dropped.

## Verify commit-hook cluster — judgment calls (`/meeting` 2026-06-16, id:d8bf)

> The hook itself is TOOLING (executor-eligible). These two boxes are the genuine
> JUDGMENT CALLS the executor cannot decide: a theory-adjacent fidelity check and a
> contract-shape check. Resolved via `/relay human` / `/meeting`; the executor proceeds
> against the red tests meanwhile.

- [x] `tests/test_mw_mirror.sh` (roadmap:0e63) — **does the one-section `.mw` mirror
  faithfully match the Resogram source section?** The mirror (`verify/mirror/resogram_esol.mw`)
  is a DERIVED artifact transcribing `physics/Resogram.md` handles `esol`/`e`/`ymaint` into
  `.mw` fragment syntax. Faithful transcription is theory-adjacent — the AI must NOT alter
  physics. **Owner:** confirm the mirror's equations match the source section (energy form,
  sliding-average consumer, maintenance drive), or correct the transcription. The DAG
  staleness *mechanics* are machine-tested; this box is about FIDELITY to the owner's math.
  **FINDINGS surfaced 2026-06-16 (/relay human) — owner REJECTED, box STAYS OPEN.** Side-by-side
  of mirror ↔ `physics/Resogram.md`: `esol` (`e=…`) and `ymaint` (`y=…`) transcribe EXACTLY, but
  two infidelities remain — the DAG-mechanics test (`test_mw_mirror.sh`, green) cannot see either,
  which is why this is a human box:
    1. **Sliding average is reduced — UNACCEPTABLE (owner).** Mirror has `ebar = Omega/pi * e`;
       source `Resogram.md:107` is the half-period convolution
       `\bar e(t) := (Ω/π)∫₀^{π/Ω} e(t-t')·e^{+2βt'} dt'`. The mirror drops the integral and the
       `e^{+2βt'}` growth kernel — collapses a convolution to a scalar multiply. Owner: "absolutely
       inacceptable." **FIX: transcribe the integral form faithfully** (keep the `e`→`ebar`
       staleness edge so `test_mw_mirror.sh` stays green; `ebar`'s RHS must still reference `e`).
    2. **`δ=atan2(Ω,β)` is part of the RESULT, not a free definition (owner).** Source `esol:85`
       carries `δ=atan2(Ω,β)` as the derived phase shift; the mirror leaves `delta` a dangling free
       symbol. **FIX (owner 2026-06-16): model `δ` as its OWN `.mw` fragment / cache item** — a
       separate `delta = atan2(Omega, beta)` computation block that the `e` block then references —
       rather than inlining it. This gives a `δ → e → ebar` dependency chain in the DAG (editing `δ`
       stales `e`, transitively `ebar`), which the mirror should exercise faithfully.
  Tracked as a re-transcription under the SAME id:0e63 (ROADMAP follow-up bullet), tagged
  **[HARD — strong model]** (reclassified 2026-06-16): `test_mw_mirror.sh` gives no fidelity signal
  (`.mw` keys DAG edges on regex symbol refs — green for faithful AND unfaithful RHS alike), and
  expressing `e(t-t')` faithfully needs `.mw` computation-semantics judgment (`e` is a data `Expr`, not
  callable) that may spill cross-repo. Owner re-confirms fidelity once the integral form + δ-fragment land. <!-- id:0e63 -->.

- [x] `tests/test_verify_hook.sh` (roadmap:8757/d5f9) — **is the chosen `git notes` schema
  the right contract?** v1 writes `status:pending findings:…` on `refs/notes/verify`
  (append-only, never deleted). The meeting (D4) envisions later transitions
  `pending → triaged → processed verdict:valid|noise review_me:id:XXXX` (the latter added by
  `/relay review` + `/relay human`, not the hook). **Owner:** confirm `status` + `findings`
  is the right v1 field set and that the `triaged`/`processed`/`verdict`/`review_me` fields are
  the right forward-compatible extension, before executors freeze the note format.
  **RESOLVED 2026-06-16 (owner-ratified, /relay human): CONFIRM BOTH v1 + extension.** Owner
  confirmed the two-field v1 set `{status, findings}` is the right minimal contract AND that the
  forward-compat extension `{triaged, processed, verdict:valid|noise, review_me:id:XXXX}` (added
  by `/relay review` + `/relay human`, never the hook) is the right shape. Executors may freeze
  the note format. Re-check: `hooks/post-commit:97-103` writes `status:pending` + `findings:…`;
  `tests/test_verify_hook.sh` cases 1+5 pin pending-note + concatenate-on-squash. No code change
  (this is a contract ratification, not an implementation edit). <!-- id:8757 -->
  <!-- relay:human auto-flow: ROADMAP id:8757/d5f9 implementation already [x]; this box was the
       separate schema-CONTRACT judgment, now owner-ratified. No new pool work unblocked. -->.

## Visual / manual (run these — never auto-ticked)

- [ ] `@manual` Walk `tests/HUMAN-integration.md` (TODO `id:6501`): equations render in a
  real browser + VS Code preview applies `.vscode/settings.json`. Render *correctness* is
  machine-checked (`test_mathjax.cjs`); this is the visual/editor-integration last mile.

# Human review queue <!-- budget: 15 min -->

Judgment calls for the owner — **theory decisions the AI surfaced but must never make.**
A ticked box = "owner confirms this interpretation/correction"; to correct one, edit the
cited source (or leave a note under the item) and the next review re-derives. Resolved via
`/relay human` or `/meeting`. Max ~10 open boxes.

> These are owner-ratified by design (the no-AI-vibe-thinking-the-theory constraint). A
> `.mw`/collAIb tool may later *pre-fill a suggested fix* for a sufficiently-clear item,
> but a human still accepts it — the suggestion is a draft, not a merge.

## `\veq` carrier syntax — feasibility-gate result (`id:e0b7` pilot, 2026-06-18)

- [x] **PICK the `\veq` in-prose syntax — RATIFIED (d) by owner 2026-06-18** (the meeting's preferred `\veq[tier]{h}` was INFEASIBLE; owner chose form (d), see decision note below).
  The `id:e0b7` KaTeX/MathJax feasibility spike (run 2026-06-18, this `/relay --afk` turn) settled the
  D7 gate empirically. Matrix (KaTeX 0.16.47 + MathJax 3, both engines this repo renders through):

  | in-prose form | KaTeX 0.16.47 | MathJax 3 | note |
  |---|---|---|---|
  | `\veq[tier]{h}` (optional-arg — meeting D3/D7 **preferred**) | ❌ FAIL | ✅ | KaTeX has **no** optional-argument macro support (`\newcommand{\veq}[2][sorry]{…}` → `Expected '}', got '#'`). |
  | `\veq{h:tier}` (colon, 1 brace arg — D7's pre-named fallback) | ⚠️ renders but **can't split** | ✅ | the whole `h:tier` becomes the `\tag`/`\label` (so `\eqref` must target `h:tier`, tier leaks into the handle). See round-2 below — KaTeX cannot split a *braced* colon arg. |
  | `\veq{h}{tier-badge}` (2 brace args) | ✅ | ✅ | `#1`=handle stays the clean `\tag{#1}\label{#1}` (`\eqref{h}` clean, **immune to a colon in the handle** — verified `\veq{e:dot}{…}` → tag `(e:dot)`); `#2`=a per-tier badge **macro** drives the emoji. Open-debt = a `sorry`-sentinel badge; always 2 args (no bare `\veq{h}`). |

  **Round-2 pilot (2026-06-18, follow-up): can a macro SPLIT the colon to render only the real label, and
  can it map tier→emoji? — both piloted now in both engines:**
  - **Colon split:** MathJax can (delimited `\def`, `\ifx`). KaTeX can split *only* via a delimited
    `\def\veq#1:#2;{…}` called **bare as `\veq edot:lean;`** (terminator required) — the **brace form
    `\veq{edot:lean}` does NOT split** (braces hide the `:` → parse error "expected ':'"). So "keep the
    `\veq{h:tier}` braces AND render a clean label" is **impossible in KaTeX**.
  - **Colon-in-a-real-handle risk (your concern): real and inherent** — any delimited split takes the *first*
    colon, so a future handle containing `:` mis-splits. Today's handles are colon-free, but it's a latent
    landmine. The 2-arg form sidesteps it entirely (handle is its own braced arg).
  - **tier→emoji badge:** mapping a tier *string* to an emoji needs `\ifx` (string conditional) — **KaTeX has
    no `\ifx`** (MathJax does), so cross-engine string→emoji is out. The portable path is **per-tier badge
    macros** (`\leanbadge`→`\checkmark`, `\sorrybadge`→…), which work in BOTH engines — but they need the badge
    to be a **macro token**, i.e. the `\veq{h}{\tierbadge}` 2-arg form, not a colon substring. (Also: raw
    unicode emoji ✓✅ render in KaTeX only with metric *warnings* `unknownSymbol` — badges should use LaTeX
    symbols `\checkmark`/`\bullet`/`\dagger` or `\htmlClass`, not literal emoji.)

  **Round-3 pilot (2026-06-18, owner asked: is a delimited `\def` like `\veq edot;lean;` acceptable, is the
  trailing `;` needed, does `\veq edot;`+whitespace terminate, is `\veq*` an issue?):**
  - Delimited `\def\veq#1;#2;{…}` parses `\veq edot;lean;` in BOTH engines (tag `edot`, tier `lean`).
  - **Trailing `;` IS required** — `\veq edot;lean` (no closing `;`) is a parse error ("expected ';' at end of
    input"). A delimited arg ends only on its literal delimiter token, NOT on whitespace or a non-latin char.
    (Exception: a SPACE-delimited final arg `\def\veq#1 {…}` ends on whitespace — single trailing arg only,
    eats one space.) So an optional tier can't auto-terminate; use a MANDATORY tier with a `sorry` sentinel
    (`\veq h;tier;`). `\@ifnextchar` optionality was fragile.
  - **`\veq*` is NOT an issue** — `\@ifstar` works in BOTH engines (`\veq*…` → no number, `\veq …` → numbered).
  - **BUT deployment blocker (decisive):** the project forbids in-document `\def` (the `\gdef` lesson) → macros
    must live in central config. A delimited `\def` CANNOT be expressed in `.vscode/settings.json`
    `markdown.math.macros` (JSON, strings only): a `\def`-string expands to garbage, a simple `#1`-string can't
    carry the delimiter signature, and a JS FUNCTION (which DOES work in KaTeX) can't live in JSON. So the
    delimited grammar **cannot reach the VS Code KaTeX preview** without a custom KaTeX build/extension or
    dropping preview parity (MathJax's JS config could take a custom CommandMap; KaTeX/VS-Code is the blocker).
    The 2-brace `\veq{h}{\tierB}` form, by contrast, DEPLOYS via plain string macros in BOTH central configs
    (verified): `.vscode` `"\\veq":"\\tag{#1}\\,{\\scriptstyle #2}"`, `custom-head.html` `veq:['\\tag{#1}\\,#2',2]`,
    with per-tier badge string macros `\sorryB`→`{?}`, `\leanB`→`\checkmark` (LaTeX symbols, no metric warning).

  **Round-4 pilot (2026-06-18, owner idea): `\veq{h}` as a 1-arg `\ltag` drop-in FOLLOWED BY a standalone
  badge macro** — `\veq{edot}\lean`, where `\lean`/`\sympy`/`\sorry` are their own simple string macros and
  ABSENCE of a trailing badge = implicit open-debt ("to be updated by `.mw`"). Piloted in both engines:
  - `\veq{edot}` alone → clean `(edot)` tag; `\veq{edot}\lean` → `✓(edot)` (✓ adjacent to the number) in BOTH
    engines; `\eqref{edot}` resolves cleanly after `\veq{edot}\lean` (no tier leak).
  - BOTH `\veq` AND the badge macros are SIMPLE STRING macros → JSON-deployable in `.vscode/settings.json` and
    `custom-head.html`, ZERO per-`.md` line (same central-def model as `\ltag` today — note: a global central def
    is needed either way; it is ONE site/editor def, NOT a per-document init line).
  - **Advantages over the 2-brace form:** migration is a pure rename (`\ltag{h}`→`\veq{h}`, 1-arg→1-arg; badges
    added separately, not retrofitted onto every handle); the badge is a SEPARATE token the tool inserts/updates
    without touching the equation/handle (badge=tooling, equation=human, D4); maps closely to D6's
    `{#h}{@verify tier}` brace (trailing badge ≈ the annotation fragment adjacent to the handle fragment).
  - **Open sub-points:** the badge renders adjacent to, not welded onto, the number (owner judges visual); the
    `.mw` lowering + tool must associate the trailing badge token with the preceding `\veq{h}` (manageable).

  **Round-5 pilot (2026-06-18, owner requirement): annotations are NOT only verification — also definition
  (e.g. the Resogram `\delta`), assumption, and other kinds; owner prefers (d) PLUS `\@ifstar`, with a family
  of trailing macros (`\definition`, `\assumption`, … alongside `\sorry`/`\sympy`/`\lean`).** Piloted both engines:
  - **`\veq*` IS JSON-deployable after all** — `\@ifstar` is invocable from a STRING macros option value
    (`"\\veq":"\\@ifstar\\veqStar\\veqNum"`, with `\veqNum`/`\veqStar` also string macros), so `\veq{edot}`
    numbers and `\veq*{x}` is unnumbered, both via the simple-string central config (no `\def` needed). (Refine:
    `\veqStar` should consume the handle arg so it doesn't leak into the body — trivial.)
  - **Open annotation-kind vocabulary works**: `\veq{delta}\definition` → "def (delta)", `\veq{a1}\assumption`
    → "assume (a1)"; all simple string macros. **Composition works**: `\veq{edot}\definition\lean` → "def ✓(edot)"
    — kind + verification-tier chain as adjacent trailing macros.
  - So (d) generalizes: `\veq{h}` (+`\@ifstar` for unnumbered) followed by an OPEN family of annotation macros
    — semantic kinds (`\definition`/`\assumption`/…) AND verification states (`\sorry`/`\sympy`/`\lean`),
    composable, absence = unannotated/implicit-sorry. All deployable via the simple-string central config.
  - **Owner/theory decisions this raises (likely a `/meeting`):** (1) the TAXONOMY of annotation kinds (what
    exists beyond definition/assumption/verify — theory-adjacent, owner enumerates); (2) the BASE MACRO NAME —
    `\veq` reads as "verified equation" but now tags definitions/assumptions too (neutral name? meeting fallback
    was `\vtag`); (3) name-collision check for EACH annotation macro (`\definition`/`\assumption`/`\lean`/… vs
    KaTeX/MathJax builtins + siunitx/physics/mathtools — extend the D7 `\veq`-name check to the whole family);
    (4) the `.mw` link-types generalize from `{@verify}`/`{@verified}` to an open-enum over KINDS — see
    `mathematical-writing` `id:358f` (updated).

  **Net:** the colon form can't give clean-label-plus-badge in KaTeX; the delimited `\def`, though it answers
  every raw-engine sub-question, can't deploy through this repo's JSON/no-in-doc-def config on the KaTeX/VS-Code
  side. The two forms that DO deploy through the existing simple-string central config in both engines are
  **(a) 2-brace `\veq{h}{\tierbadge}`** and **(d) `\veq{h}` + trailing annotation macro(s)** (owner's idea).
  **OWNER RATIFIED 2026-06-18 (this conversation): form (d) — `\veq[*]{label}[\tier]`-style** = `\veq{h}` (1-arg
  `\ltag` drop-in) + `\@ifstar` for the unnumbered `\veq*{h}` + optional trailing annotation macro(s), absence =
  implicit/unannotated. This REVISES meeting D7's colon default. **Name check (round-6):** `\veq` and the tier
  macros `\sorry`/`\sympy`/`\numeric`/`\lean`/`\sympylean` are all FREE (undefined) in BOTH KaTeX and MathJax —
  no builtin collision (real-LaTeX-package collision only matters if the corpus is ever `latex`-compiled; none of
  siunitx/physics/mathtools/unicode-math defines `\veq` — low-priority caveat). **Deferred as a bonus (owner):**
  a custom active-char shorthand `@{edot}`/`@{edot}@lean` instead of `\veq` — infeasible via the central config
  anyway (active chars need catcode/`\def`, not a JSON string-map). **NOT a blocker (owner):** the annotation
  *taxonomy* (definition/assumption/… beyond verify) + final macro NAME + per-glyph choices are a SEPARATE
  `/meeting`, not gating this. Implementation proceeds with the verify tiers now, extensibly.
  Remaining gates for the `id:a9d2`/`id:dce9` corpus migration: the `.mw` side (`mathematical-writing` `id:358f`).
  Reproducer: KaTeX `renderToString(expr,{macros})` / MathJax `TeX({macros})` — see this turn's diary entries.
  (toesnail `id:e0b7`; meeting `docs/meeting-notes/2026-06-18-0729-veq-macro-verify-carrier.md` D3/D7) <!-- id:e0b7 -->

## Divergent-main recovery merge — portal surfacing (merge `c1e20b4`, 2026-06-16)

- [x] **Recovered owner pages — confirm portal surfacing + crypto-wing topology.** The
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
  - **RESOLVED 2026-06-16 (owner-ratified, /relay human):** all three topology/portal calls confirmed —
    (a) **keep `physics/photon.md` on the portal, labelled *Rough stub*** (no change; already listed as
    such at `README.md:30`); (b) **`crypto/` is the confirmed home for FHE** (keep the top-level wing +
    `ARCHITECTURE.md §4` entry — no change); (c) **`crypto/fhe.ods` stays source-only** (default — `_config.yml`
    exclude / ROADMAP id:fed0 stand, NOT published downloadable). The 3 `img/craiyon_*.png` assets remain
    **orphaned by default** (no page references them; owner left no target page — safe default, surface again
    if one wants them wired). Re-check: `README.md:30` (photon stub line), `README.md:33-35` (crypto wing),
    `_config.yml` exclude list (fhe.ods). No source content edited — bookkeeping confirmation only.

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
  - **OWNER SELECTION 2026-06-16 (/relay human) — box STAYS OPEN (owner places the markers).** Owner picked
    **two pilots to mark: `physics/entropy.md` (`verify:sympy`)** and **`crypto/fhe.md` + `crypto/fhe.ods`
    (`verify:numeric`)**; **`physics/wirohsh.md` DEFERRED** (not selected this round). Per the working contract +
    the relay scope guard (`physics/*.md` and the FHE content source are Human-only — the AI never edits the
    theory), **the owner adds the `<!-- verify:sympy -->` / `<!-- verify:numeric -->` comment to the chosen
    claim(s)** — that placement is the owner's act. **Once the markers land, the instrument plumbing becomes
    `[ROUTINE]`** (build `verify/entropy_*.py` sympy instruments + a `verify/fhe_*.py` numeric instrument that
    cross-checks `crypto/fhe.ods`; pin verdicts + `verified:` attestations in `tests/test_verify.sh`, mirroring
    the existing `resogram_*` pilots). Surfaced as a "you do these" owner action below; the box closes once the
    markers are in and the next `/relay review` re-derives them.

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

- [x] `@manual` Walk `tests/HUMAN-integration.md` (TODO `id:6501`): equations render in a
  real browser + VS Code preview applies `.vscode/settings.json`. Render *correctness* is
  machine-checked (`test_mathjax.cjs`); this is the visual/editor-integration last mile.
  **DONE 2026-06-16 (owner-walked, /relay human):** all 3 `[HUMAN]` boxes in
  `tests/HUMAN-integration.md` ticked by the owner (live-site visual sanity, VS Code macro
  pickup, cross-browser glance). Re-run after any change to `_includes/custom-head.html`,
  `_config.yml`, `.vscode/settings.json`, or equation markup.

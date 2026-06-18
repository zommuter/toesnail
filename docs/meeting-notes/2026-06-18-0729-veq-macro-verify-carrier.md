# 2026-06-18 — `\veq[…]{…}` macro: replacing HTML-comment verify: markers (cross-.mw)

**Started:** 2026-06-18 07:29
**Session:** bbb589de-63b1-41da-a9e9-c4e0b8d8bc47
**Attendees:** 🏗️ Archie (architect), 😈 Riku (devil's advocate), ✂️ Petra (productivity), 🔬 Greta (proof-engineering / .mw provenance + fidelity), 🔎 Dex (.mw parser / brace-attribute grammar) *(new)*
**Topic:** Un-park the `e4df` gate: design the full cross-`.mw` rich-payload carrier that replaces toesnail's HTML-comment `verify:`/`verified:` markers.

## Surfaced discoveries
- Prior ratified decision D4 (`2026-06-16-2257-edot-deriv-lean-formalization.md`): keep interim HTML comments for corpus consistency; route rich-payload→brace design to `.mw` (`routed:e4df`); toesnail migration GATED on that. `e4df` still open/unstarted in `.mw` inbox.
- Owner verbatim ×2 (`2026-06-16-2257` :65, `.mw` `2026-06-16-1313`): *"I am strongly against HTML comments in markdown, and neither should .mw use that."*
- `.mw` shipped `{#anchor}` + `{@type target}` + `{@lean}` routing; rich `verified:` payload (tier-list + `claim=<h8>` + `by=<inst>@<h8>`) undesigned. `ROADMAP.md:98`: "NO HTML comments in `.mw` — anchor + annotation are visible brace-attributes."

## Agenda
1. Meeting scope — re-open the `e4df` gate, partial-migrate only, or re-confirm D4 defer?
2. Carrier shape — which of three shapes carries open-debt + attestation hash?
3. Scope unit, in-prose footprint, sidecar granularity
4. Unified macro design + badge semantics
5. Macro name + who-labels + renderer split

## Discussion

### Agenda 1 — meeting scope
Archie decomposed "replace HTML comments" into the near-expressible `verify:` open-debt marker vs the undesigned `verified:` attestation (the `e4df` gap). Riku: no new *evidence* since D4 — only owner preference — but conceded preference is a legitimate trigger. Petra's N=2: rich brace surface has one consumer (toesnail's 5 markers); owner-legibility is the warrant. Greta split it: open-debt link vs provenance hash are two different tiers of design. Dex pinned the grammar limit: `{@type target}` holds one type + one whitespace-free target, can't carry `claim=… by=…,…`.

**DP1 (owner): option A — design `e4df` here, cross-`.mw`.** Produce the full rich-payload carrier spec (open-debt AND attestation) that unblocks both `id:a9d2` and `routed:e4df`.

### Agenda 2 — carrier shape
Dex laid out three shapes:

- Shape 1 (split): legible brace in prose + hash to sidecar
- Shape 2 (multi-attr brace): extend grammar to key=val, hashes stay in prose
- Shape 3 (fenced block): `.mw`-native `verification` fences; restructures prose

Greta/Archie argued Shape 1 is principled provenance hygiene (hashes are cache; toesnail already has 3 sidecar channels) and the cheapest `.mw` change (one open-enum link-type, no grammar extension). Riku flagged the new two-file drift surface (mitigated: join key = `{#handle}` anchor). Petra fenced it: Shape 1 deliberately avoids generic multi-attr braces.

**DP2 (owner): Shape 1 (split), with riders.** (a) prefer per-file sidecar for mergeability; (b) Shape 3 **rejected** — equation-rendering → code-rendering; (c) forward-flag: spec any richer future grammar **formally** (EBNF / Python/Lean4-style), not ad-hoc regex; (d) open crux: which block does an annotation bind to? → Agenda 3.

### Agenda 3 — scope unit, footprint, sidecar granularity
Archie/Dex: bind scope to a **named equation handle** (reuse `\ltag`); finer scope = new handle, not a range operator; multi-step = list handles. Riku's spectrum: fully-sidecar kills the greppable rigor-debt list; full-payload-in-prose is what owner rejects → **minimal badge** is the only defensible middle. Per-file sidecar is merge-local under relay (Archie). Riku: new guard needed — sidecar handles must be ⊆ source handles (dangling-attestation).

**DP3 (owner):** 3a → bind to handle; 3b → minimal badge; 3c → per-file, **drop the `.verify` infix** (don't bloat filenames). **Major refinement:** rather than a separate `{#anchor}` brace, **extend+rename `\ltag` to `\mw[verify]{edot}` macro** — unifies KaTeX/MathJax tag/label/`\eqref` combo AND `.mw` annotation in one token. Better than the brace for `\eqref` compatibility; `.md`/`.mw` could make them equivalent. Ties to subequation-labelling question (`id:d2f4`).

### Agenda 4 — unified macro + badge semantics
Archie: one token = `\eqref` target + verify anchor + sidecar join-key → zero drift. Dex: `.mw` lowers `\mw[t]{h}`-in-math and `{#h}{@verify t}`-brace to the SAME Fragment (pluggable-frontend, `parser.py:9`). Petra: coupling is real; subequation labelling (`id:d2f4`) explicitly OUT OF SCOPE. Riku risks: (1) KaTeX optional-arg support is partial → feasibility GATE via `test_mathjax.cjs` in both engines; (2) rename is the (now larger) `a9d2` migration.

**DP4 (owner):** adopt unified macro with riders: reconsider name (`\mw` collides with milliwatt/megawatt in a physics doc); add `\mw*` unnumbered variant (`align*` analogue); pilot KaTeX/MathJax `[...]` first, fallback colon form `\mw{edot:tier}`; optional arg is **just the tier** (`\mw[lean]{edot}` — "verify" keyword redundant). **Badge semantics — owner overrides "stable floor only" → live achieved-state IS in source:** proof strength visible to author + drives rendering (✓-emoji variations). `.md` on honor system; `.mw` validates against sidecar (stales a lie/drift). Hashes stay sidecar. Ties to `id:445e`.

### Agenda 5 — name + who-labels + renderer
Greta tightened DP4: asserted proof-strength = authored claim owner stands behind; machine proof = cache. `.mw` validates the authored assertion against sidecar, stales mismatch (`dag.py` `LINK_SEVERITY` edge). Riku: `\mw` is a milliwatt/megawatt collision in a physics/energy doc + leaks tool name. Dex: name is authoring-ergonomics only; parser lowering name-agnostic; ONE name, no aliases.

**DP5 (owner):** name = **`\veq`** pending package-collision check (siunitx/physics/mathtools/unicode-math), fallback **`\vtag`** same check. Open-vs-attested **grep-separable** (exact sentinel finalized in pilot). **The TOOL labels, not the owner:** `\veq{edot}` ≡ `\veq[sorry]{edot}` (`sorry` = Lean's "to-be-checked" sentinel, grep-distinct); owner authors only handle+location; tool runs instruments, attests, syncs badge arg (`sorry`→`sympy`→`sympy+lean`) — badge arg is tooling; equation/claim stays human-only. **Renderer:** `.md` → KaTeX/MathJax expand `\veq` to tag+`\label`+✓-emoji (asserted/trust); `.mw` → own render model, badge gated on sidecar validation.

## Decisions
- **D1 — Un-park `e4df`: this meeting IS the cross-`.mw` rich-payload carrier design.** Unblocks toesnail `id:a9d2` (migration) and `.mw` `routed:e4df` (grammar). *Out of scope:* implementing the migration; subequation labelling (`id:d2f4`); ✓-emoji render variants (`id:445e`).
- **D2 — Carrier = SPLIT (Shape 1).** Legible in-prose badge + machine hashes in a per-file sidecar. HTML comments retired. Shape 3 (fenced verification block) **rejected** — turns equation-rendering into code-rendering. Shape 2 (multi-attr brace) deferred — spec formally (EBNF / Python/Lean4-style) only if a future consumer needs it.
- **D3 — In-prose surface = unified macro `\veq[…]{…}` (rename of `\ltag`).** `\veq{h}` = plain tag/label (`\eqref{h}` works); `\veq[tier]{h}` adds verify badge. ONE token = `\eqref` target + verify anchor + sidecar join-key → zero drift. `\veq*` = unnumbered variant. Name pending package-collision check; fallback `\vtag`. *Out of scope:* aliases.
- **D4 — Badge carries LIVE achieved-state, tool-maintained.** Optional arg = achieved tier(s) (`sympy`/`numeric`/`lean`/`sympy+lean`); default `\veq{h}` ≡ `\veq[sorry]{h}` = open debt. Open vs attested MUST be grep-separable (sentinel `sorry`, exact spelling finalized in KaTeX pilot). **The tool** (never the owner) syncs the badge arg from sidecar results. Badge arg = tooling; equation/claim = human-only.
- **D5 — Sidecar = per-file `<stem>.toml` (e.g. `physics/Resogram.toml`), keyed by handle.** Holds `tier_floor`, `tiers`, `claim=<srepr-h8>`, `by=[<inst>@<filehash8>,…]`. Composite-key semantics unchanged, just relocated. *New guard:* sidecar handles ⊆ source `\veq` handles (dangling-attestation = error).
- **D6 — `.md`/`.mw` equivalence + validation split.** `.mw` lowers `\veq[t]{h}`-in-math and `{#h}{@verify t}`-brace to the SAME Fragment (`parser.py:9`). `.md` renders asserted badge on trust; `.mw` validates against sidecar, stales/errors on mismatch (`dag.py` `LINK_SEVERITY` edge).
- **D7 — KaTeX/MathJax optional-arg feasibility is a GATE.** Prove `\veq[lean]{edot}` renders in BOTH engines via `tests/test_mathjax.cjs` before the rename commits. If `[…]` infeasible in KaTeX, fall back to colon form `\veq{edot:lean}`. `a9d2` migration stays gated until pilot passes.

## Action items
- [ ] **(toesnail) KaTeX/MathJax `\veq[…]{…}` feasibility pilot.** Define trial `\veq`/`\veq*` macro (tag+`\label`+✓-emoji by tier) in `_includes/custom-head.html` (MathJax) and `.vscode/settings.json` (KaTeX); assert `\veq[lean]{edot}`, `\veq[sorry]{edot}`, `\veq*{x}` render in BOTH via `tests/test_mathjax.cjs`. Check name against siunitx/physics/mathtools/unicode-math; if `\veq` collides use `\vtag`; if `[…]` infeasible use `\veq{edot:lean}`. **Gate on `id:a9d2`.** <!-- id:e0b7 -->
- [ ] **(toesnail, GATED on id:e0b7) Execute `a9d2` migration.** Rename `\ltag`→`\veq` corpus-wide; convert 5 Resogram HTML comments to `\veq[…]{…}` badges + `physics/Resogram.toml` sidecar; rewrite `tests/test_verify.sh` (join badge↔sidecar by handle, replacing the `grep -oE "verified:…"` regex) and assert sidecar-handles ⊆ source-handles; update `test_render.sh` `\ltag` guard. (closes `id:a9d2`) <!-- id:dce9 -->
- [ ] → routed to `mathematical-writing` inbox: design the `.mw` side of the carrier — add open-enum `{@verify <tier>}`/`{@verified <tier>}` link-types; lower `\veq[t]{h}`-in-math AND `{#h}{@verify t}`-brace to the same Fragment; read per-file `<stem>.toml` sidecar; validate asserted badge-state vs sidecar as a `LINK_SEVERITY` staleness edge; spec the future richer grammar formally (EBNF / Python/Lean4-style). (fulfils `routed:e4df`) <!-- routed:8587 -->
- [ ] **(toesnail, relay-contract note)** Clarify in `CONVENTIONS.md` and relay scope that tooling MAY write the `\veq` **badge arg** (derived attestation), but the equation/claim inside `\veq{…}` stays human-only theory. <!-- id:9fdc -->
- [ ] **(forward-flag)** `\veq{}` is the natural vehicle for subequation labelling (`id:d2f4`) and ✓-emoji render variants (`id:445e`); design separately, after the pilot. <!-- id:7b2b -->

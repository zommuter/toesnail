# Architecture & decisions

Decision records with rationale and rejected alternatives. The blow-by-blow design
discussions live in `docs/meeting-notes/`; this file is the durable "why" an executor or
new contributor needs before touching anything. Authoring rules: `CONVENTIONS.md`.

## 0. What this repo is (and the prime constraint)

toesnail is **owner-dictated theoretical-physics prose** authored as a Jekyll/GitHub-Pages
site — the north-star use-case of `mathematical-writing` (`.mw`). The owner dictates the
physics; **the AI never invents, redirects, or edits the theory.** Its license is narrow:
rigor-checking, tooling, and Lean4-style proofs of *owner-stated* claims. It emits
findings; it never resolves them. This is not a style preference — it is the architectural
boundary that determines what is automatable (tooling) vs human-only (everything physics).
See `CONVENTIONS.md` "Working contract" and the relay scope guard in `CLAUDE.md`.

## 1. The verify-marker rigor-debt scheme

**Decision.** Hand-waved/asserted claims carry greppable HTML-comment markers
`<!-- verify:<tier> [handle] <claim> inst=verify/… -->`; discharged claims gain a
`<!-- verified:<tier> claim=<h8> by=<inst>@<h8> -->` attestation. Instruments live in
`verify/` (re-runnable `uv` scripts); verdicts are cache, never pasted into prose.

- **Tier = assurance *floor*, not a claim-type label** — `verify:sympy` means "discharge
  with **at least** SymPy," escalatable to Lean. Rejected: tier-as-category (would forbid
  proving an algebra claim in Lean).
- **`verified:` is a signature, not a result** — composite hash (`srepr` of the sympified
  claim × instrument file hash, Nix-derivation style). Either changing invalidates it.
  Rejected: pasting the verdict inline (violates "source authoritative, cache disposable").
- **✗ is a valid outcome.** A located discrepancy is surfaced (in `docs/rigor-debt.md` +
  `REVIEW_ME.md`), the prose math left untouched. The Resogram pilot ran 5 claims → 3 ✓,
  2 ✗; the loop surviving real errors *was the point*. Rejected: all-green gating.
- The automated staleness checker is **deferred** until a 2nd consumer (acoustics) exists
  (N=2 rule). Format is fixed now so the checker is mechanical to add later.

Pilot scope + contract: `docs/meeting-notes/2026-06-15-1409-resogram-verify-pilot-scope.md`.

## 2. Rendering pipeline (Jekyll + MathJax 3)

Three bugs were latent until the site was actually built/served locally; each is now
fixed and pinned by a test. They are the cautionary tale for why `tests/` builds for real.

- **Site-wide `layout: page` default** (`_config.yml`). Pages declared only
  `title`+`permalink`; without a layout Jekyll emitted **headless fragments** → no
  `<head>` → MathJax never loaded → no math rendered, ever. Rejected: per-file `layout:`
  front matter (easy to forget on the next page).
- **`kramdown: { math_engine: null }`.** kramdown's default rewrites `$$…$$` into
  MathJax-2 `<script type="math/tex">` tags that **MathJax 3 ignores**; null leaves the
  delimiters as text for MathJax 3 to scan.
- **Equation-handle macros are per-renderer, not in-document.** MathJax **rejects**
  in-document `\gdef` ("macro parameter character #"); KaTeX accepts it; `\def` doesn't
  persist across `$$` blocks in either. So `\ltag` is defined in the MathJax config
  (`_includes/custom-head.html`, with `\label` → clickable `\eqref`) AND in
  `.vscode/settings.json` (`markdown.math.macros`, for the KaTeX preview, plain `(id)`).
  Verified empirically with `mathjax-full` + `katex` (`tests/test_mathjax.cjs`). Rejected:
  one in-document `\gdef` block (breaks the live site); MathJax-config-only (breaks the
  VS Code preview).
- **Blank line after every `$$` block.** A comment glued to a closing `$$` makes kramdown
  fold the block into a paragraph and emit *inline* single-`$` math → left-aligned, `\tag`
  suppressed (handle vanishes). Guarded by `test_render.sh`.

## 3. Test layers (relay-style TDD, no theory in the loop)

`tests/run.sh` = three layers, each a `[ROUTINE]` spec an executor may extend — none of
which assert anything about the *correctness of the physics* (that's human-only):

| layer | engine | pins |
|---|---|---|
| `test_verify.sh` | `uv`/SymPy | instrument verdicts (5 ✓ — edot/esol [handle renamed from `cval` 2026-06-15] re-pinned ✗→✓ after the 2026-06-15 owner-ratified corrections) + `verified:` attestation non-drift |
| `test_render.sh` | Ruby/Jekyll | build succeeds, head/MathJax present, kramdown left delimiters, handles in block math |
| `test_mathjax.cjs` | Node/MathJax+KaTeX | every `$$` block renders in both engines, `\eqref` resolves |

`tests/HUMAN-integration.md` holds the residual `[HUMAN]` visual checks (a browser renders
client-side; a grep can't see it). **Lesson:** HTML-grep gave false confidence — the
`\gdef` bug rendered fine in source. Test the actual render.

## 4. Repo topology

`README.md` (`/`) = portal; `physics/toesnail.md` (`/toesnail`) = the QM spine; `physics/`
= topic explorations; `essays/` = non-mathematical wing; `crypto/` = maths-not-physics wing
(FHE; added by the 2026-06-16 cartmanjaro divergent-main recovery merge `c1e20b4`).
Permalinks are explicit per file, so moving a source file does not change its URL.
Cross-project dependency map: `docs/dependencies.md`. Topology rationale:
`docs/meeting-notes/2026-06-15-1257-repo-topology-and-mw-aligned-authoring.md`.

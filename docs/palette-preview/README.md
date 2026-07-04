# Verification-tier badge colour — palette options (ROADMAP id:b7e5, AUTHOR half)

Author-half deliverable for the owner render directive of 2026-06-18, laned `[HARD — pool]` with an
explicit **author-then-run** split (the pool authors the proposal; the owner ratifies the pick; only then
is the run half implemented). **No engine config is changed here** — `git diff` for this item touches only
`docs/palette-preview/`, `REVIEW_ME.md`, `RELAY_LOG.md`, and `ROADMAP.md`. Visual preview:
[`index.html`](index.html) (open in a browser; it is self-contained, no network).

The five verification tiers (CONVENTIONS.md §2) and their shape-distinct glyphs:

| tier macro | glyph | meaning |
|---|---|---|
| `\sorry` | `?` | open debt — to be checked |
| `\sympy` | `∘` | algebraic identity discharged by SymPy |
| `\numeric` | `△` | a claimed evaluation (integral / limit / constant) — a *counter-indicator*, never the assurance badge |
| `\lean` | `✓` | theorem / structural statement, kernel-checked in Lean4 |
| `\sympylean` | `✓✓` | attested by both SymPy and Lean |

The five **open-debt `\<tier>c` variants** (`\sympyc` `\numericc` `\leanc` `\sympyleanc` — "this verifier is
*desired* but not yet run") carry a superscript `?` on the same glyph.

## Design decision baked into every option: colour is *reinforcement*, glyph is *primary*

The glyphs `? ∘ △ ✓ ✓✓` are already shape-distinct, so **WCAG 1.4.1 (never colour alone)** is satisfied under
any palette — a colour-blind or monochrome reader still reads the tier from the glyph. Colour is a redundant
second channel. Two consequences the owner should confirm:

1. **Open-debt `\<tier>c` variants reuse the *same hue* as their discharged tier** (same verifier, only
   pending) and are told apart by the existing superscript `?` glyph — **not** by a separate colour. This keeps
   every palette to **five** colours instead of ten. (Alternative sub-choices if you want the pending state to
   also read differently *at a glance*: a dashed underline, or reduced weight — **not** reduced opacity, which
   can drop the badge below the 4.5:1 contrast floor. Recommendation: superscript-only, as today.)
2. Because five saturated categorical hues, each dark enough to clear 4.5:1 on the white page, **cannot all
   remain separable under dichromacy**, a colour-blind reader will sometimes see two badges as the same colour.
   That is acceptable *only* because the glyph disambiguates. If the owner wants colour to also survive
   colour-blindness, Option C (an ordinal luminance ramp) is the one to pick.

## The three options (all measured, not asserted)

Contrast is WCAG 2.1 against the minima **light** skin background `#fdfdfd` (the live site; the repo does not
enable minima's dark skin). "min deut/prot" is the smallest pairwise separation among the five badges under
simulated deuteranopia / protanopia (Machado 2009 matrices, severity 1.0) — computed by
`scratchpad/contrast.py` in the authoring session; reproduce with the same sRGB→linear + WCAG formula.

### Option A — Semantic traffic-light (most intuitive)

| tier | hex | contrast vs #fdfdfd |
|---|---|---|
| `\sorry` | `#b12a1b` | 6.42 |
| `\sympy` | `#8a5a00` | 5.83 |
| `\numeric` | `#2563eb` | 5.08 |
| `\lean` | `#15803d` | 4.93 |
| `\sympylean` | `#0f766e` | 5.38 |

- Intuition: red = debt → amber = partial → green = proven. Matches the strawman in the ROADMAP item.
- min deuteranopia separation **42.5** (`sorry`↔`lean`, the classic red/green pair) — the weakest colour-blind
  option of the three, but every badge still clears 4.5:1. Relies on the glyph for CB readers.

### Option B — Okabe-Ito categorical (five distinct hues from a colour-blind-tuned source)

| tier | hex | contrast vs #fdfdfd |
|---|---|---|
| `\sorry` | `#b34d00` | 5.19 |
| `\sympy` | `#9d3d75` | 6.15 |
| `\numeric` | `#0072b2` | 5.10 |
| `\lean` | `#007a59` | 5.26 |
| `\sympylean` | `#004a38` | 10.14 |

- Hues drawn from the Okabe-Ito qualitative palette, darkened to reach 4.5:1 on white.
- min deuteranopia separation **23.1** (`sympy`↔`lean`), min protanopia **62.2**. Note the darkening needed for
  white-background contrast *erodes* Okabe-Ito's native CB-separation, so on *this* background B is not actually
  the colour-blind champion — C is. Offered as the familiar 5-distinct-hue middle option.

### Option C — Assurance-ramp + counter-indicator accent (colour-blind recommendation)

| tier | hex | contrast vs #fdfdfd | role |
|---|---|---|---|
| `\sorry` | `#6b7280` | 4.75 | neutral grey — no assurance |
| `\sympy` | `#2563eb` | 5.08 | CAS assurance (ladder step 1) |
| `\numeric` | `#b45309` | 4.94 | amber accent — *off* the ladder (counter-indicator) |
| `\lean` | `#15803d` | 4.93 | kernel assurance (ladder step 2) |
| `\sympylean` | `#14532d` | 8.96 | both (ladder top) |

- Colour encodes the **assurance ladder** (CONVENTIONS.md §2) as an ordinal — grey → blue → green → deep-green —
  so hue/luminance *means* "how strong is the assurance", reinforcing the doc's own tier semantics.
  `\numeric` is deliberately amber and *off* the ramp, matching its stated role as a counter-indicator that
  never attests assurance.
- min deuteranopia separation **50.4** (`lean`↔`sympylean`, an intentionally nested same-hue pair; every other
  pair is farther apart) — the best colour-blind separation of the three. Recommended if CB readability is the
  deciding factor.

## Implementation notes for the RUN half (do NOT act on these until the owner picks)

Both engines can colour a badge macro without touching the equation body. The colour lives on the **badge
macro** only (`\sorry`/`\sympy`/…), so the D4 carve-out holds — tooling colours the badge arg, the claim is
untouched.

- **KaTeX** (VS Code preview, `.vscode/settings.json` string macros): prefer `\htmlClass{veq-lean}{\checkmark}`
  + a CSS rule `.veq-lean{color:#15803d}` over a raw `\color{#15803d}{\checkmark}`. KaTeX's `\htmlClass`/`\htmlStyle`
  require the renderer to be built with `trust: true` (and `strict` not rejecting HTML extensions) — VS Code's
  Markdown-preview KaTeX **may not enable `trust`**, in which case `\htmlClass` is silently dropped. Verify in
  the run half; if `trust` is unavailable, fall back to `\textcolor{#15803d}{\checkmark}` (KaTeX supports
  `\textcolor`/`\color` natively, no trust needed) — hardcoding the hex in the macro string. The CSS-class route
  is preferred *only if* `trust` is on, because it centralises the palette and supports a dark-skin `@media`.
- **MathJax 3** (live site, `_includes/custom-head.html` macros): use `\class{veq-lean}{\checkmark}` (the
  `mathtools`/`html` extension `\class` is on by default in tex-mml-chtml) + a site CSS rule, OR
  `\color{#15803d}{\checkmark}` inline. The CSS-class route lets a future minima dark-skin restyle badges via a
  `@media (prefers-color-scheme: dark)` block without re-touching the macros.
- **Keep the `$...$` wrap.** `\veq` already wraps the badge as `$#2$` inside the tag's text mode; the colour
  macro goes *inside* that math wrap (`\class{…}{\checkmark}` is math-mode). Do not move the colour to the tag
  text.
- **Test coverage** (`tests/test_mathjax.cjs`): the run half must sync the `MJ_MACROS`/`KX_MACROS` mirrors and
  add an assertion that each badge macro renders the chosen colour (e.g. the output contains the class name or
  the hex). Re-run the full `tests/run.sh`; a config change re-triggers the `tests/HUMAN-integration.md` visual
  re-walk.
- **Where the palette lives.** If the CSS-class route is taken, the five hexes from the ratified option become five
  CSS custom properties (`--veq-sorry` …) in the site stylesheet + the VS Code preview — one edit point, and the
  open-debt `\<tier>c` variants reference the same property as their base tier.

## Reproducing the accessibility numbers

`scratchpad/contrast.py` (authoring session) computes WCAG 2.1 relative-luminance contrast and the Machado-2009
deuteranopia/protanopia simulated pairwise distances. Any WCAG contrast calculator agrees on the contrast
column; the CB distances are a first-order screen (simulate → Euclidean in simulated sRGB), enough to rank the
options — not a substitute for a colour-blind reader's judgment, which is exactly why this is a REVIEW_ME
owner pick.

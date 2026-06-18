# Human integration checks `[HUMAN]`

The automated suite (`tests/run.sh`) now proves a lot: the HTML is correct **and** every
equation actually renders under MathJax 3 and KaTeX with `\eqref` resolving
(`test_mathjax.cjs`). What it still can't prove is that the page *looks right in a real
browser/editor* — final typography, layout, and that VS Code actually picks up
`.vscode/settings.json`. Those are `[HUMAN]` by nature. Re-run after any change to
`_includes/custom-head.html`, `_config.yml`, `.vscode/settings.json`, or equation markup.

To serve locally:

```sh
bundle exec jekyll serve   # then open http://localhost:4000/Resogram
```

## Checklist

- [x] `[HUMAN]` **Live site — visual sanity.** Open `/Resogram` and `/toesnail`. Equations
  typeset cleanly (no red error boxes), tags like `(edot)` sit on the right, the inline
  `\eqref{eom}` is a clickable `(eom)`, and the `verify:`/`verified:` comments are invisible
  in the body. (Render *correctness* is already machine-checked; this is the eyeball pass.)
- [x] `[HUMAN]` **VS Code preview actually applies the macros.** Open `physics/Resogram.md`
  preview in VS Code itself (not raw KaTeX): no "Undefined control sequence: \ltag" errors,
  `(id)` refs render. This confirms VS Code reads `.vscode/settings.json` →
  `markdown.math.macros` (the test exercises KaTeX directly, not the VS Code integration).
- [x] `[HUMAN]` **Cross-browser glance (optional).** One Chromium + one Firefox render the
  heaviest page (`/toesnail`) without layout breakage.
- [ ] `[HUMAN]` **`\veq` tier-badge glyphs read correctly (id:e0b7).** The new `\veq{h}\tier`
  badges render with adequate, distinguishable glyphs next to the equation number — chosen
  by tooling, pending owner eyeball: `\sorry`→`?`, `\sympy`→`○`, `\numeric`→`△`, `\lean`→`✓`,
  `\sympylean`→`✓✓`. Confirm the glyphs/placement are acceptable (or pick replacements); the
  test only asserts they RENDER, not that they look right. Add a `\veq{...}\lean` to a scratch
  display equation to view, or wait for the a9d2 migration (id:dce9) to surface real ones.

## Why these aren't automated

`test_mathjax.cjs` already renders every equation through MathJax 3 and KaTeX headlessly —
so "do the equations render / does `\eqref` resolve" *is* automated now. What's left is
genuinely visual (typography, layout) or an editor-integration detail (VS Code reading its
settings). A full headless-browser screenshot test (Playwright) could close even that, but
it's deferred until a second consumer justifies the browser toolchain (the project's N=2
rule). Until then: a human glances.

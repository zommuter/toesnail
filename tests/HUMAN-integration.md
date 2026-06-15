# Human integration checks `[HUMAN]`

The automated suite (`tests/run.sh`) proves the **HTML is correct**: the page has a
head, MathJax loads, kramdown left the delimiters alone, handles/markers survived.
It **cannot** prove the page *looks right* — MathJax and KaTeX typeset client-side in
a browser, so a machine grep can't "see" a rendered equation. These checks are
`[HUMAN]` by nature: a person looks and confirms. Re-run after any change to
`_includes/custom-head.html`, `_config.yml`, the `\gdef` macro block, or equation markup.

To serve locally:

```sh
bundle exec jekyll serve   # then open http://localhost:4000/Resogramm
```

## Checklist

- [ ] `[HUMAN]` **Live site — equations render.** Open `/Resogramm`. The six display
  equations (`eom`, `sol`, `edot`, `ymaint`, `yfree`, `cval`) typeset as math, not raw
  LaTeX source. No red MathJax error boxes.
- [ ] `[HUMAN]` **Live site — handles + cross-ref.** Each marked equation shows its tag
  on the right, e.g. `(edot)`. The inline `\eqref{eom}` in the first paragraph renders
  as `(eom)` (plain text — clickable linking is a known TODO, not a regression).
- [ ] `[HUMAN]` **Live site — no leaked markers.** The `verify:`/`verified:` comments are
  invisible in the page body (they live only in the HTML source).
- [ ] `[HUMAN]` **VS Code preview parity.** Open `physics/Resogram.md` preview. No
  "Undefined control sequence: \ltag / \eqref" errors; equations and `(id)` refs render.
  (This is the regression the in-document `\gdef` block fixed — keep it covered.)
- [ ] `[HUMAN]` **Spine page sanity.** Open `/toesnail` — its math still renders (the
  site-wide `layout: page` default and MathJax config did not regress it).
- [ ] `[HUMAN]` **Cross-browser glance (optional).** Confirm one Chromium + one Firefox
  render the heaviest page (`/toesnail`) without layout breakage.

## Why these aren't automated

A headless-browser render test (Playwright + screenshot/DOM-after-MathJax assertion)
*could* automate most of the "render" rows — but that pulls a Node/browser dependency
into a Ruby+Python repo for a site that builds remotely on GitHub Pages. Deferred until
there's a second consumer that justifies the toolchain (cf. the N=2 rule the project
already uses for the verify-marker staleness checker). Until then: a human looks.

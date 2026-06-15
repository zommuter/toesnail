# `tests/` — relay-style TDD for toesnail

This repo is **not** under `/relay` handoff (no executor sessions, no `ROADMAP.md`/
`RELAY_LOG.md`, no executor `CLAUDE.md`). It borrows only relay's **TDD discipline**:

> **Tests are the spec. Definition of done = the suite is green. Never weaken, skip, or
> rewrite a test to make it pass** — fix the code (or, if the contract genuinely changed,
> change the test deliberately and say so).

Two layers, mirroring how relay separates machine-checkable `[ROUTINE]` work from
`[HUMAN]` judgement:

| file | tag | what it pins |
|---|---|---|
| `test_verify.sh` | `[ROUTINE]` | the SymPy instruments' verdicts (3 ✓ / 2 ✗) and `verified:` attestation non-drift (claim-hash × file-hash) |
| `test_render.sh` | `[ROUTINE]` | the Jekyll→HTML pipeline: pages have a head, MathJax loads, kramdown leaves delimiters alone, the `\ltag` config macro is present, handles/markers survive |
| `test_mathjax.cjs` | `[ROUTINE]` | the **client-side render** — every `$$…$$` block in the physics docs actually renders under **MathJax 3** (site) *and* **KaTeX** (VS Code preview) with no error, and `\eqref` cross-refs resolve |
| `HUMAN-integration.md` | `[HUMAN]` | the last visual mile — typography/layout looks right in a real browser; a sanity glance that the headless renders match what a human sees |

## Run

```sh
bash tests/run.sh            # full automated suite (exit 0 = done)
bash tests/test_verify.sh    # SymPy + attestation layer (needs uv)
bash tests/test_render.sh    # Jekyll build + HTML asserts (needs the Ruby toolchain; SKIPs without it)
node tests/test_mathjax.cjs  # MathJax + KaTeX render (needs `npm install`; SKIPs without it)
```

Then walk `HUMAN-integration.md` after any rendering-related change.

## Toolchains

- **SymPy layer:** `uv` (PEP 723 inline deps in each `verify/*.py` — auto-provisioned).
- **Math-render layer:** Node + `npm install` (test-only `mathjax-full` + `katex` from `package.json`;
  `node_modules/` gitignored). `test_mathjax.cjs` SKIPs (exit 0) if not installed.
- **Render layer:** Ruby + Jekyll. One-time local setup (no sudo):
  ```sh
  pamac install ruby                              # system Ruby (polkit, not sudo)
  gem install --user-install bundler jekyll       # user gems
  export PATH="$HOME/.local/share/gem/ruby/3.4.0/bin:$PATH"
  bundle config set --local path vendor/bundle
  bundle install                                  # Gemfile pins jekyll + minima + plugins
  ```
  `test_render.sh` SKIPs (exit 0) if `bundle` isn't on `PATH`, so the SymPy layer stays
  runnable on machines without the Ruby toolchain. The live site builds remotely on
  GitHub Pages; this toolchain is for local build + these tests only.

## What real local builds already caught

Writing tests against an actual build + render surfaced three latent bugs that no amount
of source-reading had: (1) **no page declared a `layout`**, so Jekyll emitted headless
fragments and MathJax never loaded; (2) kramdown's default math engine would have rewritten
`$$…$$` into MathJax-2 `<script type="math/tex">` tags MathJax 3 ignores; (3) the
in-document `\gdef\ltag` macro block — which KaTeX (VS Code preview) accepts — **MathJax
rejects** ("macro parameter character #"), so on the live site `\ltag` was undefined and
`\eqref` rendered `(???)`. Bug 3 passed every HTML-grep check and was caught only by
rendering the real equations through MathJax (`test_mathjax.cjs`) — that's why a
client-side render test exists, not just HTML asserts. All three are fixed and pinned.

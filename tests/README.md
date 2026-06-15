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
| `test_render.sh` | `[ROUTINE]` | the Jekyll→MathJax pipeline: pages have a head, MathJax loads, kramdown leaves delimiters alone, handles/markers survive |
| `HUMAN-integration.md` | `[HUMAN]` | the irreducibly-visual checks — equations actually *display* in a browser / VS Code preview (MathJax runs client-side; a grep can't see it) |

## Run

```sh
bash tests/run.sh          # full automated suite (exit 0 = done)
bash tests/test_verify.sh  # SymPy + attestation layer only (needs uv)
bash tests/test_render.sh  # Jekyll build + HTML asserts only (needs the Ruby toolchain)
```

Then walk `HUMAN-integration.md` after any rendering-related change.

## Toolchains

- **SymPy layer:** `uv` (PEP 723 inline deps in each `verify/*.py` — auto-provisioned).
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

Writing `test_render.sh` against an actual `jekyll build` surfaced two latent bugs that
no amount of source-reading had: (1) **no page declared a `layout`**, so Jekyll emitted
headless fragments and MathJax never loaded; (2) kramdown's default math engine would
have rewritten `$$…$$` into MathJax-2 `<script type="math/tex">` tags MathJax 3 ignores.
Both are now fixed and pinned. That's the case for the toolchain.

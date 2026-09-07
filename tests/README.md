# `tests/` — relay-style TDD for toesnail

This repo **is** under `/relay` handoff — `ROADMAP.md`, `RELAY_LOG.md` and the
`## Relay contract` pointer in `CLAUDE.md` are all live, and 28 executor sessions are on
the log (corrected 2026-09-07 review; the original sentence claimed the opposite and had
been false since the repo was onboarded). The **TDD discipline** below is the part that
has always governed here, and it still does:

> **Tests are the spec. Definition of done = the suite is green. Never weaken, skip, or
> rewrite a test to make it pass** — fix the code (or, if the contract genuinely changed,
> change the test deliberately and say so).

**The authoritative tier list is `tests/run.sh`'s own loop, not this table** — it stands at
**14 automated tiers** as of 2026-09-07 (`test_verify`, `test_verify_entropy_routine`,
`test_render`, `test_verify_hook`, `test_mw_mirror`, `test_lean`, `test_page_coverage`,
`test_crypto_exclude`, `test_conventions_ladder`, `test_toolchain_pointer`, `test_ci`,
`test_make`, `test_mathjax.cjs`, `test_veqs_inline.cjs`). `tests/test_verify_entropy.sh` is
deliberately **outside** the loop: it is the still-RED spec for the gated seam `id:76e5`.
`tests/test_dreamed_render.cjs` runs in the loop but is **advisory, not blocking** (see below).
The table below details only the original layers, which mirror how relay separates
machine-checkable `[ROUTINE]` work from `[HUMAN]` judgement:

| file | tag | what it pins |
|---|---|---|
| `test_verify.sh` | `[ROUTINE]` | the SymPy instruments' verdicts (3 ✓ / 2 ✗) and `verified:` attestation non-drift (claim-hash × file-hash) |
| `test_render.sh` | `[ROUTINE]` | the Jekyll→HTML pipeline: pages have a head, MathJax loads, kramdown leaves delimiters alone, the `\ltag` config macro is present, handles/markers survive |
| `test_mathjax.cjs` | `[ROUTINE]` | the **client-side render** — every `$$…$$` block in the physics docs actually renders under **MathJax 3** (site) *and* **KaTeX** (VS Code preview) with no error, and `\eqref` cross-refs resolve |
| `HUMAN-integration.md` | `[HUMAN]` | the last visual mile — typography/layout looks right in a real browser; a sanity glance that the headless renders match what a human sees |

## The advisory tier: `test_dreamed_render.cjs` (`id:8b1c`)

`docs/dreamed/` holds 57 published pages (`permalink: /dreamed/<slug>`, excluded from the
site by nothing) that are **unratified AI exploration by design**. They are also the
math-heaviest prose in the repo, so a kramdown or MathJax break there was silent *and*
public. The owner's ruling (`REVIEW_ME` `id:8b1c`, option (c)) is **visibility without
blocking**:

- `tests/test_dreamed_render.cjs` renders every dreamed page through MathJax 3 and KaTeX,
  checks that every `$$` block is followed by a blank line (the kramdown fold that silently
  drops the `\ltag` handle), flags unresolved `\eqref`, and, when `_site/` was already built
  earlier in the run, greps the built HTML for a handle that landed in an inline `kdmath`
  span. It prints a loud, boxed `ADVISORY` block naming each page and line.
- It **always exits 0**, and `tests/run.sh` calls it with `|| true`, so an unratified essay
  can never break the owner's `make test`. Do not "fix" a dreamed finding to silence it:
  that content is the owner's, and a finding is surfaced, never edited away.
- Always on, not opt-in: it is source-level plus one optional grep (no Jekyll build of its
  own), so it costs about 2 s on 57 pages.

**Blocking versus advisory scope split** (stated in both files' headers):

| directory | tier | blocks the suite? |
|---|---|---|
| `physics/`, `essays/`, `crypto/`, root `README.md` | `test_page_coverage.sh` + `test_mathjax.cjs` | yes |
| `docs/dreamed/` | `test_dreamed_render.cjs` | no, advisory only |
| `docs/meeting-notes/` | none | out of scope (a decision record, not site content) |

`tests/test_page_coverage.sh` is now a **directory scan**, not a name list. It enumerates
every page under the blocking directories that carries a `permalink:` and asserts it appears
in `test_mathjax.cjs`'s `DOCS` array. Before `id:8b1c` it compared 5 hardcoded names against
that hand-maintained array, so the guard checked an allowlist against itself and adding a page
tripped nothing. A new ratified page now turns it RED until it is covered.

## Run

```sh
bash tests/run.sh            # full automated suite (exit 0 = done)
bash tests/test_verify.sh    # SymPy + attestation layer (needs uv)
bash tests/test_render.sh    # Jekyll build + HTML asserts (needs the Ruby toolchain; SKIPs without it)
node tests/test_mathjax.cjs  # MathJax + KaTeX render (needs `npm install`; SKIPs without it)
node tests/test_dreamed_render.cjs  # ADVISORY docs/dreamed/ render report (always exits 0)
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

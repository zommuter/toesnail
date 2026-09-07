#!/usr/bin/env node
// roadmap: id:8b1c  (owner ruling 2026-09-07, option (c))
//
// ADVISORY render tier for docs/dreamed/ -- REPORTS, NEVER BLOCKS.
//
// Why this tier exists and why it does not fail the suite
// -------------------------------------------------------
// docs/dreamed/ is UNRATIFIED AI exploration by design (see docs/dreamed/README.md
// and the dreamed-path convention). It is also PUBLISHED: every dreamed page carries
// a `permalink: /dreamed/<slug>` and _config.yml excludes none of them, so a kramdown
// or MathJax break there is silent AND public. Those two facts pull opposite ways:
//   * the dreamed pages are the math-heaviest prose in the repo, so they want coverage;
//   * an unratified essay must never be able to break the owner's `make test`.
// The owner's ruling (option (c) of REVIEW_ME id:8b1c) is VISIBILITY WITHOUT BLOCKING:
// this tier renders every dreamed page, prints a loud ADVISORY block naming each page
// and line that breaks, and then exits 0 regardless. `tests/run.sh` stays green.
//
// Nothing here ever edits content. A finding is SURFACED for the owner; the fix (if any)
// is a content decision, never an executor's -- the repo scope guard binds absolutely.
//
// Scope split (the substance of id:8b1c; the blocking half lives in
// tests/test_page_coverage.sh, whose header states the same split):
//   BLOCKING  -> ratified content: physics/, essays/, crypto/, root README.md
//   ADVISORY  -> docs/dreamed/            <-- this file
//
// What it checks (the failure modes that actually bite this repo):
//   1. a $$...$$ block not separated by a blank line from what follows -- kramdown folds
//      it into the paragraph and emits INLINE single-$ math, which MathJax renders
//      left-aligned with the \tag suppressed, silently dropping the equation handle
//      (CLAUDE.md "Jekyll notes"; tests/test_render.sh asserts the same thing on the
//      built HTML for Resogram);
//   2. any display block that errors under MathJax 3 (the live site) or KaTeX (the
//      VS Code preview);
//   3. an \eqref that resolves to (???).
//   4. when _site/ already exists (test_render.sh / test_crypto_exclude.sh built it
//      earlier in the run), the built-HTML confirmation of (1): a \ltag/\veq handle
//      that landed inside a `class="kdmath">$` inline span. No extra Jekyll build is
//      done here -- this tier is source-level plus one optional grep, so it adds
//      ~1s to the suite and needs no Ruby.
//
// SKIPs cleanly (exit 0) when the test-only Node deps are absent, same idiom as
// test_mathjax.cjs.
'use strict';
const fs = require('fs');
const path = require('path');
const ROOT = path.join(__dirname, '..');
const DREAMED = path.join(ROOT, 'docs/dreamed');

try { require.resolve('mathjax-full/js/mathjax.js'); require.resolve('katex'); }
catch { console.log('[test_dreamed_render] SKIP: run `npm install` first (mathjax-full + katex)'); process.exit(0); }

if (!fs.existsSync(DREAMED)) { console.log('[test_dreamed_render] SKIP: no docs/dreamed/'); process.exit(0); }

const { MJ_MACROS, KX_MACROS } = require('./lib/macros.cjs');
const { mathjax } = require('mathjax-full/js/mathjax.js');
const { TeX } = require('mathjax-full/js/input/tex.js');
const { SVG } = require('mathjax-full/js/output/svg.js');
const { liteAdaptor } = require('mathjax-full/js/adaptors/liteAdaptor.js');
const { RegisterHTMLHandler } = require('mathjax-full/js/handlers/html.js');
const { AllPackages } = require('mathjax-full/js/input/tex/AllPackages.js');
const katex = require('katex');
const adaptor = liteAdaptor(); RegisterHTMLHandler(adaptor);

// findings: { page, line, kind, detail }
const findings = [];
const note = (page, line, kind, detail) => findings.push({ page, line, kind, detail });

const lineOf = (src, idx) => src.slice(0, idx).split('\n').length;

// Mask fenced code blocks so ``` ... $$ ... ``` samples are not read as math.
function maskFences(src) {
  const lines = src.split('\n');
  let inFence = false;
  return lines.map((l) => {
    if (/^\s*(```|~~~)/.test(l)) { inFence = !inFence; return ''.padEnd(l.length); }
    return inFence ? ''.padEnd(l.length) : l;
  }).join('\n');
}

// $$ ... $$ display blocks, with the source offset of the opening delimiter.
function displayBlocks(masked) {
  const out = []; const re = /\$\$([\s\S]*?)\$\$/g; let m;
  while ((m = re.exec(masked))) out.push({ tex: m[1].trim(), start: m.index, end: re.lastIndex });
  return out;
}

// Check 1: the closing $$ must be followed by a blank line (or EOF). Anything else --
// a comment, a sentence, a list item glued to it -- makes kramdown fold the block into
// the paragraph and emit inline single-$ math, dropping the \tag/handle.
function checkBlankLineAfter(src, masked, page) {
  for (const b of displayBlocks(masked)) {
    const rest = src.slice(b.end);
    // Remainder of the closing $$'s own line.
    const nl = rest.indexOf('\n');
    const tail = nl === -1 ? rest : rest.slice(0, nl);
    if (tail.trim() !== '') {
      note(page, lineOf(src, b.end), 'kramdown-fold',
        `text on the same line as the closing $$: « ${tail.trim().slice(0, 60)} »`);
      continue;
    }
    if (nl === -1) continue; // EOF right after the block is fine
    const after = rest.slice(nl + 1);
    const nl2 = after.indexOf('\n');
    const nextLine = nl2 === -1 ? after : after.slice(0, nl2);
    if (after !== '' && nextLine.trim() !== '') {
      note(page, lineOf(src, b.end) + 1, 'kramdown-fold',
        `no blank line after the closing $$ (next line: « ${nextLine.trim().slice(0, 60)} »)`);
    }
  }
}

const pages = fs.readdirSync(DREAMED).filter((f) => f.endsWith('.md')).sort();
console.log(`[test_dreamed_render] advisory scan of ${pages.length} docs/dreamed/*.md pages`);

for (const f of pages) {
  const rel = path.join('docs/dreamed', f);
  const src = fs.readFileSync(path.join(DREAMED, f), 'utf8');
  const masked = maskFences(src);

  checkBlankLineAfter(src, masked, rel);

  const blocks = displayBlocks(masked);
  if (blocks.length === 0) continue;

  // MathJax: one doc per page so \label registrations are page-scoped, exactly as
  // test_mathjax.cjs does for the ratified pages.
  const tex = new TeX({ packages: AllPackages, tags: 'ams', macros: MJ_MACROS });
  const doc = mathjax.document('', { InputJax: tex, OutputJax: new SVG() });
  for (const b of blocks) {
    let html;
    try { html = adaptor.innerHTML(doc.convert(b.tex, { display: true })); }
    catch (e) { note(rel, lineOf(src, b.start), 'mathjax', `threw: ${String(e.message).split('\n')[0]}`); continue; }
    if (html.includes('merror'))
      note(rel, lineOf(src, b.start), 'mathjax', `merror in « ${b.tex.slice(0, 50).replace(/\n/g, ' ')} … »`);
  }
  const refRe = /\\eqref\{([^}]*)\}/g; let m;
  while ((m = refRe.exec(masked))) {
    let html;
    try { html = adaptor.innerHTML(doc.convert(`\\eqref{${m[1]}}`, { display: false })); } catch { continue; }
    if (html.includes('???')) note(rel, lineOf(src, m.index), 'eqref', `\\eqref{${m[1]}} unresolved (???)`);
  }

  // KaTeX (VS Code preview).
  for (const b of blocks) {
    try { katex.renderToString(b.tex, { macros: { ...KX_MACROS }, displayMode: true, throwOnError: true }); }
    catch (e) { note(rel, lineOf(src, b.start), 'katex', String(e.message).split('\n')[0]); }
  }
}

// Check 4 (only when a build already happened earlier in the suite): the built-HTML
// confirmation of the kramdown fold, the same assertion test_render.sh makes.
const siteDreamed = path.join(ROOT, '_site/dreamed');
if (fs.existsSync(siteDreamed)) {
  for (const h of fs.readdirSync(siteDreamed).filter((f) => f.endsWith('.html')).sort()) {
    const html = fs.readFileSync(path.join(siteDreamed, h), 'utf8');
    const hits = html.match(/class="kdmath">\$[^$]*(ltag|veq)/g);
    if (hits) note(`_site/dreamed/${h}`, 0, 'kramdown-fold-built',
      `${hits.length} handle(s) landed in INLINE math (blank line missing after $$)`);
  }
} else {
  console.log('  note  _site/dreamed not built (Ruby/Jekyll absent or build skipped): built-HTML check skipped');
}

if (findings.length === 0) {
  console.log(`[test_dreamed_render] PASS (advisory): ${pages.length} pages, no render breaks found`);
  process.exit(0);
}

// LOUD. A detector whose report is a quiet line in the scroll is the anti-pattern.
const byPage = new Map();
for (const f of findings) { if (!byPage.has(f.page)) byPage.set(f.page, []); byPage.get(f.page).push(f); }
const bar = '#'.repeat(76);
console.log('');
console.log(bar);
console.log(`###  ADVISORY: ${findings.length} render break(s) in ${byPage.size} docs/dreamed/ page(s)`);
console.log('###  These pages ARE published (permalink /dreamed/<slug>) but are UNRATIFIED,');
console.log('###  so this does NOT fail the suite (REVIEW_ME id:8b1c, owner ruling option (c)).');
console.log('###  Surface to the owner. Do NOT edit dreamed content to silence this.');
console.log(bar);
for (const [page, fs_] of byPage) {
  console.log(`  ${page}`);
  for (const f of fs_) console.log(`      line ${String(f.line).padStart(5)}  [${f.kind}] ${f.detail}`);
}
console.log(bar);
console.log('[test_dreamed_render] ADVISORY: findings above; exiting 0 by design (non-blocking)');
process.exit(0);

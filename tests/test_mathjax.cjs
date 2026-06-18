#!/usr/bin/env node
// roadmap: math-render
// Renders the ACTUAL equations from the physics docs through both engines that
// render this project — MathJax 3 (the live site) and KaTeX (VS Code preview) —
// and fails on any render error or unresolved cross-reference.
//
// Why this exists: test_render.sh greps the built HTML, so it cannot see a
// CLIENT-SIDE failure. The in-document \gdef block passed every HTML check yet
// MathJax rejected it at render time ("macro parameter character #"), leaving
// \ltag undefined and \eqref showing (???). This test renders for real.
//
// Contract (relay-TDD: never weaken a test to make it pass):
//   • every $$…$$ display block in the physics docs renders with no <merror>;
//   • \eqref cross-refs resolve (no "???") under MathJax;
//   • the same handles render under KaTeX with the .vscode macros;
//   • no in-document \gdef macro block sneaks back in (MathJax rejects it);
//   • custom-head.html still carries the canonical \ltag macro (drift guard).
'use strict';
const fs = require('fs');
const path = require('path');
const ROOT = path.join(__dirname, '..');

// SKIP cleanly when the test-only Node deps aren't installed.
try { require.resolve('mathjax-full/js/mathjax.js'); require.resolve('katex'); }
catch { console.log('[test_mathjax] SKIP — run `npm install` first (mathjax-full + katex)'); process.exit(0); }

const DOCS = [
  'physics/Resogram.md', 'physics/toesnail.md',
  // recovered pages (merge c1e20b4) — all render clean under MathJax 3 + KaTeX (id:7fd7)
  'physics/entropy.md', 'physics/wirohsh.md', 'physics/photon.md',
  'crypto/fhe.md', 'essays/supertool.md',
];
// Mirrors of the central per-renderer macro configs.
// MJ_MACROS mirrors _includes/custom-head.html macros:{…}
// KX_MACROS mirrors .vscode/settings.json markdown.math.macros:{…}
// Keep these in sync with the source configs whenever macros are added or changed.
const MJ_MACROS = {
  ltag:     ['\\tag{#1}\\label{#1}', 1],
  // \veq{h}\tier — handle + verification badge together in the (tag); 2nd arg is a
  // single-token tier macro, $...$-wrapped inside the text-mode tag (renders in both engines).
  veq:      ['\\tag{#1\\,$#2$}\\label{#1}', 2],
  // Verification-tier badge macros (LaTeX symbols, not raw emoji — no metric warnings).
  //   \sorry    → \mathbf{?}           (open debt)
  //   \sympy    → \circ                (SymPy / CAS check)
  //   \numeric  → \triangle            (numeric / evaluation)
  //   \lean     → \checkmark           (Lean4 proof)
  //   \sympylean → \checkmark\!\checkmark  (SymPy + Lean)
  sorry:    '\\mathbf{?}',
  sympy:    '\\circ',
  numeric:  '\\triangle',
  lean:     '\\checkmark',
  sympylean: '\\checkmark\\!\\checkmark',
};
const KX_MACROS = {
  '\\ltag':     '\\tag{#1}',
  '\\eqref':    '(\\text{#1})',
  // \veq{h}\tier — KaTeX has no \label; handle is the visible (tag), badge $...$-wrapped.
  '\\veq':      '\\tag{#1\\,$#2$}',
  // Verification-tier badge macros.
  '\\sorry':    '\\mathbf{?}',
  '\\sympy':    '\\circ',
  '\\numeric':  '\\triangle',
  '\\lean':     '\\checkmark',
  '\\sympylean': '\\checkmark\\!\\checkmark',
};

let fail = 0;
const pass = (m) => console.log('  ok   ' + m);
const bad  = (m) => { console.log('  FAIL ' + m); fail = 1; };

function read(p) { return fs.readFileSync(path.join(ROOT, p), 'utf8'); }
function displayBlocks(src) {
  // $$ … $$ blocks (multiline), excluding the inline single-$ math.
  const out = []; const re = /\$\$([\s\S]*?)\$\$/g; let m;
  while ((m = re.exec(src))) out.push(m[1].trim());
  return out;
}
function eqrefs(src) {
  const out = []; const re = /\\eqref\{([^}]*)\}/g; let m;
  while ((m = re.exec(src))) out.push(m[1]);
  return out;
}

// ---- regression / drift guards (no engine needed) ----
console.log('[test_mathjax] source guards');
for (const d of DOCS) {
  // Match an actual in-document (re)definition of our handle macros — \gdef\ltag,
  // \def\eqref, … — not the word "\gdef" appearing in an explanatory comment.
  if (/\\g?def\s*\\(ltag|eqref|label)\b/.test(read(d)))
    bad(`${d}: in-document macro definition present (MathJax rejects \\gdef)`);
  else pass(`${d}: no in-document handle-macro definition`);
}
if (/ltag:\s*\['\\\\tag\{#1\}\\\\label\{#1\}'/.test(read('_includes/custom-head.html')))
  pass('custom-head.html carries the canonical \\ltag macro');
else bad('custom-head.html \\ltag macro missing/changed (drift)');

// ---- MathJax: render every display block + resolve \eqref in one document ----
console.log('[test_mathjax] MathJax 3 render');
const { mathjax } = require('mathjax-full/js/mathjax.js');
const { TeX } = require('mathjax-full/js/input/tex.js');
const { SVG } = require('mathjax-full/js/output/svg.js');
const { liteAdaptor } = require('mathjax-full/js/adaptors/liteAdaptor.js');
const { RegisterHTMLHandler } = require('mathjax-full/js/handlers/html.js');
const { AllPackages } = require('mathjax-full/js/input/tex/AllPackages.js');
const adaptor = liteAdaptor(); RegisterHTMLHandler(adaptor);

// ---- \veq family: dedicated assertions in both engines ----
// Tests that \veq{h}\tier (handle + badge-in-tag) renders without errors in both engines,
// and that \eqref{h} resolves cleanly (no tier leaks into the handle) under MathJax.
// (\veq* unnumbered/sub-step variant is deferred — id:a138.)
console.log('[test_mathjax] \\veq macro family');

const VEQ_CASES = [
  { name: '\\veq{edot}\\sorry (open debt)',    expr: '\\veq{edot}\\sorry' },
  { name: '\\veq{edot}\\sympy',                expr: '\\veq{edot}\\sympy' },
  { name: '\\veq{esol}\\numeric',              expr: '\\veq{esol}\\numeric' },
  { name: '\\veq{edot}\\lean',                 expr: '\\veq{edot}\\lean' },
  { name: '\\veq{edot}\\sympylean (combined)', expr: '\\veq{edot}\\sympylean' },
];

// MathJax \veq assertions — fresh doc per case to avoid "label multiply defined" errors
// (each equation is a self-contained assertion; labels accumulate across doc.convert calls,
//  so shared-doc renders of the same handle id would fail on the second call).
for (const { name, expr } of VEQ_CASES) {
  const tex = new TeX({ packages: AllPackages, tags: 'ams', macros: MJ_MACROS });
  const doc = mathjax.document('', { InputJax: tex, OutputJax: new SVG() });
  const html = adaptor.innerHTML(doc.convert(expr, { display: true }));
  if (html.includes('merror')) bad(`MathJax \\veq: merror in ${name}`);
  else pass(`MathJax \\veq: ${name}`);
}
// \eqref{edot} must resolve cleanly — no tier leak into the handle.
// A shared doc is intentional here: render \veq{edot}\lean first to register the label,
// then resolve the cross-ref in the same doc.
{
  const tex = new TeX({ packages: AllPackages, tags: 'ams', macros: MJ_MACROS });
  const doc = mathjax.document('', { InputJax: tex, OutputJax: new SVG() });
  doc.convert('\\veq{edot}\\lean', { display: true });
  const refHtml = adaptor.innerHTML(doc.convert('\\eqref{edot}', { display: false }));
  if (refHtml.includes('???')) bad('MathJax \\veq: \\eqref{edot} unresolved (???) after \\veq{edot}\\lean');
  else pass('MathJax \\veq: \\eqref{edot} resolves cleanly (no tier leak) after \\veq{edot}\\lean');
}

// KaTeX \veq assertions — require katex (also used for the per-doc renders below).
const katex = require('katex');
{
  for (const { name, expr } of VEQ_CASES) {
    try {
      katex.renderToString(expr, { macros: { ...KX_MACROS }, displayMode: true, throwOnError: true });
      pass(`KaTeX \\veq: ${name}`);
    } catch (e) {
      bad(`KaTeX \\veq: ${name} → ${e.message.split('\n')[0]}`);
    }
  }
}

for (const d of DOCS) {
  const src = read(d);
  const tex = new TeX({ packages: AllPackages, tags: 'ams', macros: MJ_MACROS });
  const doc = mathjax.document('', { InputJax: tex, OutputJax: new SVG() });
  let errs = 0, unresolved = 0;
  for (const blk of displayBlocks(src)) {
    const html = adaptor.innerHTML(doc.convert(blk, { display: true }));
    if (html.includes('merror')) { errs++; if (errs <= 2) bad(`${d}: merror in « ${blk.slice(0, 40).replace(/\n/g, ' ')} … »`); }
  }
  for (const ref of eqrefs(src)) {
    const html = adaptor.innerHTML(doc.convert(`\\eqref{${ref}}`, { display: false }));
    if (html.includes('???')) { unresolved++; bad(`${d}: \\eqref{${ref}} unresolved (???)`); }
  }
  if (!errs && !unresolved) pass(`${d}: all display blocks render, all \\eqref resolve`);
}

// ---- KaTeX: render the handles with the .vscode preview macros ----
console.log('[test_mathjax] KaTeX (VS Code preview) render');
for (const d of DOCS) {
  const src = read(d);
  let errs = 0;
  for (const blk of displayBlocks(src)) {
    try { katex.renderToString(blk, { macros: { ...KX_MACROS }, displayMode: true, throwOnError: true }); }
    catch (e) { errs++; if (errs <= 2) bad(`${d}: KaTeX « ${blk.slice(0, 30).replace(/\n/g, ' ')} » → ${e.message.split('\n')[0]}`); }
  }
  if (!errs) pass(`${d}: all display blocks render under KaTeX`);
}

console.log(fail ? '[test_mathjax] FAIL' : '[test_mathjax] PASS');
process.exit(fail);

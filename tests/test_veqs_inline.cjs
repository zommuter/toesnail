#!/usr/bin/env node
// roadmap:9c41 — RED spec for the inline-\veqs render polish (owner directive 2026-06-18):
//   inline `\veqs{h}\tier` must HIDE the handle/label entirely and show the tier badge
//   wrapped in PARENTHESES — e.g. `… 2^{m2^n} (✓?)`, NOT `… ocount ✓?`.
//
// DELIBERATELY UNWIRED from tests/run.sh until green (the runner has no expected-red
// lane — repo convention, cf. ROADMAP id:2709 wiring note). When this goes green:
// wire it into tests/run.sh AND sync the MJ_MACROS/KX_MACROS mirrors in test_mathjax.cjs.
//
// This spec reads the REAL central configs (.vscode/settings.json markdown.math.macros
// for KaTeX; _includes/custom-head.html macros:{} for MathJax) — never the test-local
// mirrors — so it cannot be satisfied by editing a test fixture.
//
// Contract (relay-TDD: never weaken this test to make it pass):
//   KaTeX (functional, real .vscode macros):
//     • `\veqs{<handle>}\leanc` renders inline without throwing;
//     • the VISIBLE output (katex-html portion, MathML annotation excluded) does NOT
//       contain the handle text;
//     • the visible output DOES contain the badge wrapped in parens: `(` … `)`.
//   MathJax (real custom-head.html `veqs` body — string-level, since SVG output is
//   glyph-refs and cannot be text-grepped):
//     • `#1` (the handle) appears ONLY inside invisible carriers (\label{…}, \hphantom{…},
//       \phantom{…}, or a zero-width \rlap/\llap wrapper) — never bare/visible;
//     • the badge reference `#2` is wrapped in parens (`(`/`\left(` before, `)`/`\right)` after);
//     • the body still renders without <merror> for `\veqs{h}\leanc`.
//   NOTE (implementation freedom, not asserted): KaTeX string macros MUST reference #1
//   (a body without it is a parse error — verified), so hiding likely needs a phantom/lap
//   construct or a restructure. If a solution would require changing the CALL-SITE syntax
//   (`\veqs{h}\tier` in owner content, e.g. crypto/fhe.md), STOP and surface instead —
//   owner-placed markers are not tooling-editable beyond the badge arg (D4 carve-out).
'use strict';
const fs = require('fs');
const path = require('path');
const ROOT = path.join(__dirname, '..');

// SKIP cleanly when the test-only Node deps aren't installed (same pattern as test_mathjax.cjs).
try { require.resolve('mathjax-full/js/mathjax.js'); require.resolve('katex'); }
catch { console.log('[test_veqs_inline] SKIP — run `npm install` first (mathjax-full + katex)'); process.exit(0); }

let fail = 0;
const pass = (m) => console.log('  ok   ' + m);
const bad  = (m) => { console.log('  FAIL ' + m); fail = 1; };
const read = (p) => fs.readFileSync(path.join(ROOT, p), 'utf8');

// A handle that cannot appear by accident and whose chars concatenate detectably.
const HANDLE = 'zzqhandle';

// ---- extract the REAL macro definitions ----------------------------------------------

// .vscode/settings.json is JSONC (has // comments) — regex-extract the macro map entries.
function vscodeMacros() {
  const src = read('.vscode/settings.json');
  const out = {};
  const re = /"(\\\\[a-zA-Z]+)"\s*:\s*("(?:[^"\\]|\\.)*")/g;
  let m;
  while ((m = re.exec(src))) out[m[1].replace(/\\\\/g, '\\')] = JSON.parse(m[2]);
  return out;
}

// _includes/custom-head.html carries `veqs: ['<js-string>', 2]` inside macros:{…}.
function mathjaxVeqsBody() {
  const src = read('_includes/custom-head.html');
  const m = src.match(/veqs:\s*\[\s*'((?:[^'\\]|\\.)*)'\s*,\s*(\d+)\s*\]/);
  if (!m) return null;
  return { body: m[1].replace(/\\\\/g, '\\'), nargs: Number(m[2]) };
}

// ---- KaTeX: functional assertions on the real .vscode macros --------------------------

console.log('[test_veqs_inline] KaTeX (real .vscode/settings.json macros)');
{
  const katex = require('katex');
  const macros = vscodeMacros();
  if (!macros['\\veqs']) {
    bad('.vscode/settings.json: no \\veqs macro found');
  } else {
    let html = null;
    try {
      html = katex.renderToString(`\\veqs{${HANDLE}}\\leanc`, {
        macros: { ...macros }, displayMode: false, throwOnError: true,
      });
      pass(`\\veqs{${HANDLE}}\\leanc renders inline without error`);
    } catch (e) {
      bad(`\\veqs{${HANDLE}}\\leanc throws → ${e.message.split('\n')[0]}`);
    }
    if (html !== null) {
      // Visible portion only: the katex-html span (aria-hidden render); the MathML
      // annotation carries the raw TeX source and would false-positive on the handle.
      const start = html.indexOf('katex-html');
      const vis = start < 0 ? '' :
        html.slice(html.indexOf('>', start) + 1).replace(/<[^>]*>/g, '').replace(/\s+/g, '');
      if (vis.includes(HANDLE)) bad(`handle "${HANDLE}" is VISIBLE in the inline render (must be hidden)`);
      else pass('handle is hidden in the visible output');
      if (vis.includes('(') && vis.includes(')')) pass('tier badge is wrapped in parens');
      else bad(`tier badge is not parenthesized (visible text: "${vis.slice(0, 60)}")`);
    }
  }
}

// ---- MathJax: string-level assertions on the real custom-head.html body ---------------

console.log('[test_veqs_inline] MathJax (real _includes/custom-head.html veqs body)');
{
  const def = mathjaxVeqsBody();
  if (!def) {
    bad('_includes/custom-head.html: no veqs macro entry found');
  } else {
    // Strip invisible #1 carriers, then no bare #1 may remain.
    const carriers = /\\(?:label|hphantom|phantom)\{[^{}]*#1[^{}]*\}|\\[rl]lap\{(?:\\hphantom\{[^{}]*#1[^{}]*\}|[^{}]*#1[^{}]*)\}/g;
    const residue = def.body.replace(carriers, '');
    if (residue.includes('#1')) bad(`veqs body renders #1 (handle) visibly: '${def.body}'`);
    else pass('veqs body carries #1 only in invisible form');
    // Badge parenthesization: a `(`/`\left(` before the #2 reference and `)`/`\right)` after.
    if (/(?:\(|\\left\()[^)]*#2/.test(def.body) && /#2.*(?:\)|\\right\))/.test(def.body))
      pass('veqs body parenthesizes the #2 badge');
    else bad(`veqs body does not parenthesize the badge: '${def.body}'`);
    // Functional sanity: the real body must still render error-free.
    const { mathjax } = require('mathjax-full/js/mathjax.js');
    const { TeX } = require('mathjax-full/js/input/tex.js');
    const { SVG } = require('mathjax-full/js/output/svg.js');
    const { liteAdaptor } = require('mathjax-full/js/adaptors/liteAdaptor.js');
    const { RegisterHTMLHandler } = require('mathjax-full/js/handlers/html.js');
    const { AllPackages } = require('mathjax-full/js/input/tex/AllPackages.js');
    const adaptor = liteAdaptor(); RegisterHTMLHandler(adaptor);
    const tex = new TeX({
      packages: AllPackages, tags: 'ams',
      macros: { veqs: [def.body, def.nargs], leanc: '\\checkmark^{?}' },
    });
    const doc = mathjax.document('', { InputJax: tex, OutputJax: new SVG() });
    const out = adaptor.innerHTML(doc.convert(`\\veqs{${HANDLE}}\\leanc`, { display: false }));
    if (out.includes('merror')) bad('real veqs body produces <merror> under MathJax');
    else pass('real veqs body renders without merror under MathJax');
  }
}

console.log(fail ? '[test_veqs_inline] FAIL (expected-red until ROADMAP id:9c41 ships)' : '[test_veqs_inline] PASS');
process.exit(fail);

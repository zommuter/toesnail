#!/usr/bin/env node
// Q6 feasibility probe (TOE roadmap, docs/meeting-notes/2026-07-07-1240-mw-collaib-toe-needs.md):
// can the epistemic-status candidates \derived / \empirical / \hypothesis work as
// zero-arg trailing badge macros STACKED with the verify tiers (`\veq{h}\derived\sorry`)
// in BOTH engines?
//
// DELIBERATELY UNWIRED from tests/run.sh — this is a feasibility PROBE, not a spec.
// It defines candidate bodies locally; the real macros land in .vscode/settings.json +
// _includes/custom-head.html only after the owner ratifies names (TODO id:57e2 Q6).
// On ratification: promote this into a proper red spec (assert the REAL configs define
// the ratified names, test_veqs_inline.cjs pattern) and wire it into tests/run.sh.
//
// Result 2026-07-07: PASS — all three names free in both engines, stacking renders clean.
// NB: MathJax's `noundefined` package (in AllPackages) renders undefined macros as red
// text, NOT <merror> — collision checks must exclude it, or they false-negative.
'use strict';
const fs = require('fs');
const path = require('path');
const ROOT = path.join(__dirname, '..');
try { require.resolve('mathjax-full/js/mathjax.js'); require.resolve('katex'); }
catch { console.log('[probe_status_macros] SKIP — run `npm install` first (mathjax-full + katex)'); process.exit(0); }
const katex = require('katex');

const read = (p) => fs.readFileSync(path.join(ROOT, p), 'utf8');
function vscodeMacros() {
  const src = read('.vscode/settings.json');
  const out = {}; const re = /"(\\\\[a-zA-Z]+)"\s*:\s*("(?:[^"\\]|\\.)*")/g;
  let m; while ((m = re.exec(src))) out[m[1].replace(/\\\\/g, '\\')] = JSON.parse(m[2]);
  return out;
}
const CANDIDATES = ['derived', 'empirical', 'hypothesis'];
const BODIES = { derived: '\\;{\\scriptsize\\text{[der.]}}',
                 empirical: '\\;{\\scriptsize\\text{[emp.]}}',
                 hypothesis: '\\;{\\scriptsize\\text{[hyp.]}}' };
const real = vscodeMacros();
let fail = 0;
const ok = (m) => console.log('  ok   ' + m);
const bad = (m) => { console.log('  FAIL ' + m); fail = 1; };

console.log('[probe_status_macros] KaTeX ' + katex.version + ' (real .vscode macros as base)');
for (const c of CANDIDATES) {
  let collided = false;
  try { katex.renderToString(`x \\${c}`, { macros: { ...real }, throwOnError: true }); collided = true; }
  catch { /* expected: undefined control sequence */ }
  collided ? bad(`\\${c} already renders undefined — NAME COLLISION`)
           : ok(`\\${c} is free (undefined ⇒ error, no builtin collision)`);
  const macros = { ...real, ['\\' + c]: BODIES[c] };
  for (const expr of [`\\veq{probe}\\${c}`, `\\veq{probe}\\${c}\\sorry`, `\\veqs{probe}\\${c}\\leanc`]) {
    try { katex.renderToString(expr, { macros, displayMode: !expr.includes('veqs'), throwOnError: true }); ok(`${expr} renders`); }
    catch (e) { bad(`${expr} throws → ${e.message.split('\n')[0]}`); }
  }
}

console.log('[probe_status_macros] MathJax (real custom-head.html macros as base)');
{
  const src = read('_includes/custom-head.html');
  const macros = {};
  const re = /([a-zA-Z]+):\s*(?:'((?:[^'\\]|\\.)*)'|\[\s*'((?:[^'\\]|\\.)*)'\s*,\s*(\d+)\s*\])/g;
  let m;
  while ((m = re.exec(src))) {
    if (m[2] !== undefined) macros[m[1]] = m[2].replace(/\\\\/g, '\\');
    else macros[m[1]] = [m[3].replace(/\\\\/g, '\\'), Number(m[4])];
  }
  if (!macros.veq) bad('could not extract veq from custom-head.html');
  const mj = require('mathjax-full/js/mathjax.js').mathjax;
  const { TeX } = require('mathjax-full/js/input/tex.js');
  const { SVG } = require('mathjax-full/js/output/svg.js');
  const { liteAdaptor } = require('mathjax-full/js/adaptors/liteAdaptor.js');
  const { RegisterHTMLHandler } = require('mathjax-full/js/handlers/html.js');
  const { AllPackages } = require('mathjax-full/js/input/tex/AllPackages.js');
  const adaptor = liteAdaptor(); RegisterHTMLHandler(adaptor);
  // collision check WITHOUT noundefined (it masks undefined macros as red text, no merror)
  const strictPkgs = AllPackages.filter((p) => p !== 'noundefined');
  for (const c of CANDIDATES) {
    const texBare = new TeX({ packages: strictPkgs, tags: 'ams', macros: { ...macros } });
    const docBare = mj.document('', { InputJax: texBare, OutputJax: new SVG() });
    const outBare = adaptor.innerHTML(docBare.convert(`x \\${c}`, { display: false }));
    outBare.includes('merror') ? ok(`\\${c} is free under MathJax (undefined ⇒ merror, strict)`)
                               : bad(`\\${c} renders undefined under MathJax — COLLISION`);
    const tex = new TeX({ packages: AllPackages, tags: 'ams',
                          macros: { ...macros, [c]: BODIES[c] } });
    const doc = mj.document('', { InputJax: tex, OutputJax: new SVG() });
    const out = adaptor.innerHTML(doc.convert(`\\veq{probe${c}}\\${c}\\sorry`, { display: true }));
    out.includes('merror') ? bad(`\\veq{h}\\${c}\\sorry → merror under MathJax`)
                           : ok(`\\veq{h}\\${c}\\sorry renders clean under MathJax (stacked)`);
  }
}
console.log(fail ? '[probe_status_macros] FAIL' : '[probe_status_macros] PASS');
process.exit(fail);

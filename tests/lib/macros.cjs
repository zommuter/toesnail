// Shared per-renderer macro mirrors, used by BOTH render tiers:
//   tests/test_mathjax.cjs        (blocking, ratified content)
//   tests/test_dreamed_render.cjs (advisory, docs/dreamed/)
//
// These were inline in test_mathjax.cjs until the advisory tier needed the same
// values (id:8b1c). They live here so there is exactly ONE mirror to keep in sync
// with the real configs -- a second hand-copied table would be the drift bug the
// drift guard in test_mathjax.cjs exists to catch.
//
// MJ_MACROS mirrors _includes/custom-head.html macros:{...}
// KX_MACROS mirrors .vscode/settings.json markdown.math.macros:{...}
// Keep these in sync with the source configs whenever macros are added or changed;
// test_mathjax.cjs asserts byte-identity against both config files.
'use strict';

const MJ_MACROS = {
  ltag:     ['\\tag{#1}\\label{#1}', 1],
  // \veq{h}\tier -- numbered: handle + verification badge in the (tag); 2nd arg is a
  //   single-token tier macro, $...$-wrapped inside the text-mode tag (both engines).
  // \veqs{h}\tier -- unnumbered sub-step/inline: \label (invisible), badge in parens, no \tag
  //   (id:9c41 owner render directive 2026-06-18 -- no bare handle shown).
  //   Both are DIRECT macros (NO \@ifstar): a \veq* star variant is infeasible because MathJax's
  //   \@ifstar registers a spurious \label keyed on the branch-macro name, so the 2nd non-star
  //   \veq in one document fails "Label '\veqNum' multiply defined" (id:a138).
  veq:      ['\\tag{#1\\,$#2$}\\label{#1}', 2],
  veqs:     ['\\label{#1}(#2)', 2],
  // Verification-tier badge macros (LaTeX symbols, not raw emoji -- no metric warnings).
  //   \sorry    -> \mathbf{?}           (open debt)
  //   \sympy    -> \circ                (SymPy / CAS check)
  //   \numeric  -> \triangle            (numeric / evaluation)
  //   \lean     -> \checkmark           (Lean4 proof)
  //   \sympylean -> \checkmark\!\checkmark  (SymPy + Lean)
  // Colour (id:c7d6, Option C -- assurance-ramp + amber accent, docs/palette-preview/README.md).
  // GOTCHA: hexes are written WITHOUT the leading '#' (both engines accept a bare 6-digit hex,
  // e.g. \textcolor{15803d}{...}) -- a leading '#1' (only when the digit right after '#' is '1')
  // is misparsed by KaTeX's own macro-arity scan as an argument placeholder ("#1"), which then
  // tries to consume the next token as an argument and corrupts the render ("Unexpected end of
  // input in a macro argument"). #2563eb/#b45309/#6b7280 happen not to trigger it (no leading
  // "#1"), but #15803d and #14532d do -- so ALL hexes here drop the '#' for consistency, never
  // re-add it to a macro string.
  sorry:    '\\textcolor{6b7280}{\\mathbf{?}}',
  sympy:    '\\textcolor{2563eb}{\\circ}',
  numeric:  '\\textcolor{b45309}{\\triangle}',
  lean:     '\\textcolor{15803d}{\\checkmark}',
  sympylean: '\\textcolor{14532d}{\\checkmark\\!\\checkmark}',
  // open-debt-naming-desired-tier badges (id:feb8) -- tier glyph + superscript ?, same hue as
  // the discharged tier (Option C sub-decision 1).
  sympyc:    '\\textcolor{2563eb}{\\circ^{?}}',
  numericc:  '\\textcolor{b45309}{\\triangle^{?}}',
  leanc:     '\\textcolor{15803d}{\\checkmark^{?}}',
  sympyleanc: '\\textcolor{14532d}{ {\\checkmark\\!\\checkmark}^{?}}',
  // annotation-KIND pilot macros (id:8ddc) -- not verification tiers
  definition: '\\mathrm{def}',
  assumption: '\\mathrm{ass}',
};

const KX_MACROS = {
  '\\ltag':     '\\tag{#1}',
  '\\eqref':    '(\\text{#1})',
  // \veq{h}\tier -- numbered (tag); \veqs{h}\tier -- unnumbered (no \tag). Both DIRECT (no \@ifstar).
  //   KaTeX has no \label, so \veqs stores the handle via \def (never rendered) and shows
  //   only the parenthesized badge -- matches the MathJax site's \label-hidden handle (id:9c41).
  '\\veq':      '\\tag{#1\\,$#2$}',
  '\\veqs':     '\\def\\veqsHandle{#1}(#2)',
  // Verification-tier badge macros.
  // Colour (id:c7d6, Option C -- assurance-ramp + amber accent).
  '\\sorry':    '\\textcolor{6b7280}{\\mathbf{?}}',
  '\\sympy':    '\\textcolor{2563eb}{\\circ}',
  '\\numeric':  '\\textcolor{b45309}{\\triangle}',
  '\\lean':     '\\textcolor{15803d}{\\checkmark}',
  '\\sympylean': '\\textcolor{14532d}{\\checkmark\\!\\checkmark}',
  // open-debt-naming-desired-tier badges (id:feb8), same hue as the discharged tier
  '\\sympyc':    '\\textcolor{2563eb}{\\circ^{?}}',
  '\\numericc':  '\\textcolor{b45309}{\\triangle^{?}}',
  '\\leanc':     '\\textcolor{15803d}{\\checkmark^{?}}',
  '\\sympyleanc': '\\textcolor{14532d}{ {\\checkmark\\!\\checkmark}^{?}}',
  // annotation-KIND pilot macros (id:8ddc)
  '\\definition': '\\mathrm{def}',
  '\\assumption': '\\mathrm{ass}',
};

module.exports = { MJ_MACROS, KX_MACROS };

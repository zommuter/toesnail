#!/usr/bin/env bash
# roadmap:2709
# RED spec for documenting the tier-escalation ladder in CONVENTIONS.md (/meeting id:3d2a D3).
# §2 already teaches the badge glyphs and "tier = assurance floor", but never states the
# DECISION LADDER an author/tool follows when picking a tier. This asserts CONVENTIONS.md §2
# gains the ladder:
#   • the ordered escalation SymPy-if-it-closes -> else Lean -> else honest open-debt badge
#     naming the DESIRED tier (\sympyc/\numericc/\leanc);
#   • the "\definition is never a dodge for a real claim" clause;
#   • the "numeric is a complementary counter-indicator, never the assurance badge" clause.
# Pure docs; no theory. Currently RED: the ladder text is not present yet.
set -u
cd "$(dirname "$0")/.." || exit 2
f="CONVENTIONS.md"
fail=0
need() {  # need <grep-ERE> <description>
  if grep -qiE "$1" "$f"; then printf '  ok   %s\n' "$2"
  else printf '  FAIL %s\n' "$2"; fail=1; fi
}

echo "[test_conventions_ladder] $f verify-marker tier ladder"
# The ordered escalation ladder: SymPy first, else Lean, else honest open-debt badge.
need 'sympy.*(else|then|->|→|otherwise).*lean'   "ladder: SymPy-if-closes -> else Lean"
need '(open.debt|honest).*(desired|intended|\\\\?(sympyc|numericc|leanc))' \
                                                 "ladder: else honest open-debt badge naming desired tier"
# \definition is not an escape hatch for a claim that needs discharge.
need '\\\\?definition.*(never|not).*(dodge|escape|downgrade|relabel)' \
                                                 "clause: \\definition is never a dodge for a real claim"
# numeric is a counter-indicator, not an assurance tier.
need 'numeric.*(counter.indicator|complementary|never.*assurance)' \
                                                 "clause: numeric is a counter-indicator, not the assurance badge"

[ "$fail" -eq 0 ] && echo "[test_conventions_ladder] PASS" || echo "[test_conventions_ladder] FAIL"
exit "$fail"

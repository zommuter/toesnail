#!/usr/bin/env bash
# ADVISORY tier -- carry-back promise coverage for docs/dreamed/pascalized.md
#
# Why this tier exists
# ---------------------
# pascalized.md ends with a "## Carry-back list": numbered items naming a sharper
# formulation and the essay it was meant to be written back into. Nothing checked
# whether that write-back ever happened -- a promise with no enforcement. 9 of the
# first 10 items were found unapplied by inspection, with no test catching it.
#
# ADVISORY, never blocking (same precedent as test_dreamed_render.cjs, id:8b1c owner
# ruling option (c)): docs/dreamed/ is UNRATIFIED AI exploration. An unapplied
# carry-back is information for the owner, not a build break -- applying one is a
# content edit, which is human-only per this repo's scope guard (CLAUDE.md "Relay
# contract"). This script therefore ALWAYS exits 0. tests/run.sh must call it the
# same way it calls test_dreamed_render.cjs: report, never gate.
#
# What it does
# ------------
# Parses the "## Carry-back list" section of docs/dreamed/pascalized.md. Each item
# looks like:
#   1. **`lasercool.md` §4 and §9:** the two-threshold sentence becomes "A laser
#      cannot be the exhaust: ..."
# It extracts, per numbered item:
#   - the TARGET FILE: the first `...md` backtick-quoted token on the line, resolved
#     relative to docs/dreamed/ (the carried-back essays live there too, per the
#     task's own instruction -- do not resolve against physics/ or essays/).
#   - the REPLACEMENT SENTENCE: the double-quoted string at the end of the line.
# Then it checks whether that sentence (whitespace-normalised, since a target file
# may reflow it across lines) appears anywhere in the target file's text.
#
# Robust parsing beats clever parsing: an item that does not match the expected shape
# is reported UNPARSEABLE and the script keeps going -- it is never silently dropped
# (a silent no-op is the exact anti-pattern this repo bans; see CLAUDE.md "Mechanize-
# first").  The list itself is the source of truth: this script does not hardcode the
# current item count or text, so it stays correct as items are added, removed, or
# resolved.
set -u
here="$(dirname "$0")"
root="$here/.."
src="$root/docs/dreamed/pascalized.md"

if [ ! -f "$src" ]; then
  echo "[test_carryback] SKIP: $src not found"
  exit 0
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "[test_carryback] SKIP: python3 not installed"
  exit 0
fi

python3 - "$root" "$src" <<'PYEOF'
import os
import re
import sys

root, src_path = sys.argv[1], sys.argv[2]
dreamed = os.path.join(root, "docs", "dreamed")

with open(src_path, "r", encoding="utf-8") as f:
    text = f.read()

# Isolate the "## Carry-back list" section: from its heading to the next "## " heading
# (or EOF). Robust to whatever comes after -- currently a "Not carried back" paragraph.
m = re.search(r"^##\s*Carry-back list\s*$", text, re.MULTILINE)
if not m:
    print("[test_carryback] SKIP: no '## Carry-back list' section in "
          + os.path.relpath(src_path, root))
    sys.exit(0)

rest = text[m.end():]
next_heading = re.search(r"^##\s", rest, re.MULTILINE)
section = rest[:next_heading.start()] if next_heading else rest

# Numbered list items: a line starting "N. " begins an item; the item's text runs
# until the next "N. " line (or end of section). This tolerates an item's own text
# wrapping onto following lines (none currently do, but nothing here assumes they
# won't).
item_starts = list(re.finditer(r"^\d+\.\s", section, re.MULTILINE))
if not item_starts:
    print("[test_carryback] SKIP: '## Carry-back list' section has no numbered items")
    sys.exit(0)

items = []
for i, mm in enumerate(item_starts):
    end = item_starts[i + 1].start() if i + 1 < len(item_starts) else len(section)
    items.append(section[mm.start():end].strip())


def normalize_ws(s):
    """Whitespace-normalise AND strip presentation-only markup.

    The list states its sentences in plain prose; a target file legitimately
    renders the same sentence with LaTeX math delimiters, bold/italic markers or
    code ticks around parts of it ("because $Z = Z_0/n$ ties ..." vs "because
    Z = Z_0/n ties ..."), and often re-cases the first word when the sentence is
    spliced after a lead-in ("**Third, sound can bend ...**"). Matching raw would
    report those as MISSING when the carry-back is in fact applied -- a false
    negative that would train a reader to ignore this tier. Comparison is
    therefore case-insensitive over markup-stripped text.
    """
    s = re.sub(r"[$*`_]", "", s)
    return re.sub(r"\s+", " ", s).strip().lower()


def squash(s):
    """Whitespace-only normalisation, for HUMAN-READ output (keeps case)."""
    return re.sub(r"\s+", " ", s).strip()


def parse_item(raw):
    """Return (target_file, sentence) or (None, None) if unparseable."""
    num_m = re.match(r"^(\d+)\.", raw)
    if not num_m:
        return None, None
    # Target file: first backtick-quoted token ending in .md
    target_m = re.search(r"`([^`]*?\.md)`", raw)
    if not target_m:
        return None, None
    target = target_m.group(1)
    # Replacement sentence: the LAST double-quoted span on the item (tolerates
    # nested/earlier quoted fragments such as an "it" quote mid-item, since the
    # carry-back sentence is always the trailing one).
    quotes = re.findall(r'"([^"]+)"', raw)
    if not quotes:
        return None, None
    sentence = quotes[-1]
    return target, sentence


results = []  # (item_no, status, detail)
present = 0
missing = 0
unparseable = 0
refused = 0

for raw in items:
    num_m = re.match(r"^(\d+)\.", raw)
    num = num_m.group(1) if num_m else "?"

    # An item may be closed as REFUSED: the spot-check found the distilled sentence
    # dropped something load-bearing, so NOT applying it is the correct outcome and
    # the item is discharged, not outstanding. The reason is required to live in the
    # list next to the marker, so a reader sees why without leaving the file.
    refusal = re.search(r"\[REFUSED:\s*(.+?)\]", raw, re.DOTALL)
    if refusal:
        refused += 1
        results.append((num, "REFUSED", squash(refusal.group(1))[:110]))
        continue

    target, sentence = parse_item(raw)
    if target is None or sentence is None:
        unparseable += 1
        preview = normalize_ws(raw)[:80]
        results.append((num, "UNPARSEABLE", f"could not extract target file + quoted sentence from: {preview}"))
        continue

    target_path = os.path.join(dreamed, target)
    if not os.path.isfile(target_path):
        missing += 1
        results.append((num, "MISSING", f"target file not found: docs/dreamed/{target}"))
        continue

    with open(target_path, "r", encoding="utf-8") as tf:
        target_text = tf.read()

    needle = normalize_ws(sentence)
    haystack = normalize_ws(target_text)

    if needle and needle in haystack:
        present += 1
        results.append((num, "PRESENT", f"docs/dreamed/{target}"))
    else:
        missing += 1
        short = needle[:70] + ("..." if len(needle) > 70 else "")
        results.append((num, "MISSING", f"docs/dreamed/{target} -- \"{short}\""))

print(f"[test_carryback] advisory scan of {os.path.relpath(src_path, root)}: "
      f"{len(items)} carry-back item(s)")
print("")
for num, status, detail in results:
    print(f"  item {num:>2}  {status:<12}  {detail}")
print("")
print(f"[test_carryback] {present} present, {missing} missing, {refused} refused, "
      f"{unparseable} unparseable out of {len(items)} items")
print("[test_carryback] ADVISORY: this is information for the owner, not a build gate "
      "(applying a carry-back is a content edit, human-only per this repo's scope guard). "
      "Exiting 0 by design (non-blocking).")
PYEOF

# Always succeed -- advisory tier, must never fail `make test` (docs/dreamed/ is
# unratified content; see header).
exit 0

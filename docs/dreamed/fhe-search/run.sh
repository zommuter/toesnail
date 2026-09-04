#!/usr/bin/env bash
# Resource-capped runner for the dreamed FHE search scripts.
#
# The searches are exhaustive and one of them (experiment B, max clique) can
# recurse; the caps below are deliberately tight so a mistake here cannot
# affect the machine. Address space is capped at 2 GiB and the process runs at
# the lowest priority, matching the docs/dreamed/ convention for Lean runs.
#
# Usage: ./run.sh [script.py ...]   (default: all three)
set -euo pipefail
cd "$(dirname "$0")"

MEM_KIB=$((2 * 1024 * 1024))   # 2 GiB address space
CPU_SEC=1800                   # 30 min hard CPU cap per script

scripts=("$@")
if [ ${#scripts[@]} -eq 0 ]; then
  scripts=(fhe_search.py circuit_search.py llm_cost.py)
fi

for s in "${scripts[@]}"; do
  echo "### running $s (ulimit -v ${MEM_KIB} KiB, -t ${CPU_SEC}s, nice 19)"
  ( ulimit -v "$MEM_KIB"; ulimit -t "$CPU_SEC"; exec nice -n 19 python3 "$s" )
  echo
done

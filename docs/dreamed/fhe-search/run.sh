#!/usr/bin/env bash
# Resource-capped runner for the dreamed FHE search scripts.
#
# The searches are exhaustive and some of them recurse. Everything runs inside a
# systemd user scope with a HARD cgroup memory limit and no swap, so a mistake
# here gets the scope OOM-killed and leaves the machine alone. See
# ../capped.sh for why `nice` and `ulimit -v` are both inadequate on their own.
#
# Usage: ./run.sh [script.py ...]   (default: all five)
set -euo pipefail
cd "$(dirname "$0")"

CAP=../capped.sh
MEM=2G          # generous for these; none has been observed above ~100 MB
CPU=200         # two cores
TIMEOUT=1800

scripts=("$@")
if [ ${#scripts[@]} -eq 0 ]; then
  scripts=(fhe_search.py circuit_search.py llm_cost.py trustless_verify.py model_attestation.py)
fi

for s in "${scripts[@]}"; do
  echo "### running $s (MemoryMax=$MEM, no swap, CPUQuota=${CPU}%, nice 19)"
  # belt and braces: the cgroup cap is the real guard, ulimit -v catches a
  # runaway allocation slightly earlier and with a clearer Python traceback.
  "$CAP" -m "$MEM" -c "$CPU" -t "$TIMEOUT" -- \
    bash -c 'ulimit -v $((3 * 1024 * 1024)); exec python3 -u "$0"' "$s"
  echo
done

#!/usr/bin/env bash
# Resource-capped runner for the dreamed D3 scheduler prototype.
#
# The experiment is a seeded Monte Carlo over a synthetic corpus. It is small by
# design, but it runs inside a systemd user scope with a HARD cgroup memory
# limit and no swap anyway, so a mistake here gets the scope OOM-killed and
# leaves the machine alone. See ../capped.sh for why `nice` and `ulimit -v` are
# both inadequate on their own.
#
# Usage: ./run.sh [script.py ...]   (default: audit.py then experiment.py)
#        ./run.sh experiment.py e3  (a single experiment block)
set -euo pipefail
cd "$(dirname "$0")"

CAP=../capped.sh
MEM=2G          # generous for these; none has been observed above ~40 MB
CPU=100         # one core: three sibling agents share this box
TIMEOUT=300

if [ $# -gt 0 ]; then
  script=$1
  shift
  echo "### running $script $* (MemoryMax=$MEM, no swap, CPUQuota=${CPU}%, nice 19)"
  "$CAP" -m "$MEM" -c "$CPU" -t "$TIMEOUT" -- \
    bash -c 'ulimit -v $((3 * 1024 * 1024)); s=$1; shift; exec python3 -u "$s" "$@"' \
    _ "$script" "$@"
  exit 0
fi

for s in audit.py experiment.py; do
  echo "### running $s (MemoryMax=$MEM, no swap, CPUQuota=${CPU}%, nice 19)"
  # belt and braces: the cgroup cap is the real guard, ulimit -v catches a
  # runaway allocation slightly earlier and with a clearer Python traceback.
  "$CAP" -m "$MEM" -c "$CPU" -t "$TIMEOUT" -- \
    bash -c 'ulimit -v $((3 * 1024 * 1024)); exec python3 -u "$0"' "$s"
  echo
done

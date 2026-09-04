#!/usr/bin/env bash
# Run a command under a HARD memory cap, so a runaway dreamed search or a Lean
# elaboration cannot take the machine down.
#
# Why not `nice`:      nice is CPU priority only. It does nothing about memory,
#                      and a process that eats all RAM makes the machine
#                      unusable no matter how politely it is scheduled.
# Why not `ulimit -v`: that caps ADDRESS SPACE. Mathlib mmaps its .olean files,
#                      so a virtual-memory cap large enough for Lean to start is
#                      too large to bound real usage, and one tight enough to
#                      bound it makes Lean fail spuriously.
# What this does:      a systemd user scope with MemoryMax (a cgroup v2 RSS
#                      limit) and MemorySwapMax=0. On breach the kernel OOM-kills
#                      the processes INSIDE the scope and nothing else -- the
#                      system stays responsive. CPUQuota bounds CPU as well, and
#                      nice keeps it out of the way of interactive work.
#
# Usage:  ./capped.sh [-m MEM] [-c CPU%] [-t SECONDS] -- <command> [args...]
#   -m  memory cap, systemd syntax (default 4G)
#   -c  CPU quota percent, 100 = one core (default 200)
#   -t  wall-clock timeout in seconds (default 1800)
#
# Exit code 137 (or a "Killed" message) means the cap was hit -- that is the
# guard working, not a bug in the command.
set -euo pipefail

MEM=4G
CPU=200
TIMEOUT=1800

while getopts "m:c:t:" opt; do
  case "$opt" in
    m) MEM=$OPTARG ;;
    c) CPU=$OPTARG ;;
    t) TIMEOUT=$OPTARG ;;
    *) echo "usage: $0 [-m MEM] [-c CPU%] [-t SECONDS] -- <command>" >&2; exit 2 ;;
  esac
done
shift $((OPTIND - 1))
[ "${1:-}" = "--" ] && shift
[ $# -eq 0 ] && { echo "$0: no command given" >&2; exit 2; }

if ! command -v systemd-run >/dev/null 2>&1; then
  echo "$0: systemd-run not available; refusing to run uncapped" >&2
  exit 3
fi

exec systemd-run --user --scope -q \
  --slice=dreamed.slice \
  -p MemoryMax="$MEM" \
  -p MemorySwapMax=0 \
  -p CPUQuota="${CPU}%" \
  -- nice -n 19 timeout "$TIMEOUT" "$@"

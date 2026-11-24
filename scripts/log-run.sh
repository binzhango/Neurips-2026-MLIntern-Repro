#!/usr/bin/env bash
set -euo pipefail

if (( $# == 0 )); then
    echo "Usage: bash log-run.sh COMMAND [ARG ...]" >&2
    exit 2
fi

mkdir -p .local-runs
run_dir=$(mktemp -d ".local-runs/$(date -u +%Y%m%dT%H%M%SZ)-XXXXXX")
printf 'Saving run output in %s\n' "$run_dir" >&2

status=0
"$@" 2>&1 | tee "$run_dir/output.log" || status=$?
printf '%s\n' "$status" > "$run_dir/exit-code"
exit "$status"

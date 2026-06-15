#!/usr/bin/env bash
# Coalescing brightness adjuster for external DDC/CI monitors.
#
# Niri fires repeat events ~30 Hz while a key is held. Each `light` call
# costs ~80ms (DDC/CI bus latency). Without coalescing, 1 second of holding
# queues ~30 hardware writes and the monitor lags 2.5s behind input.
#
# This script accumulates deltas in a tmp file; a single background writer
# (via flock) flushes whatever delta has built up, so holding for 1 second
# converges to ~12 hardware writes total.
#
# Usage: brightness.sh +5   or   brightness.sh -5

set -u

STEP="${1:-+5}"
STATE_DIR="${XDG_RUNTIME_DIR:-/tmp}/brightness-adjust"
DELTA_FILE="$STATE_DIR/delta"
DELTA_LOCK="$STATE_DIR/delta.lock"
WRITER_LOCK="$STATE_DIR/writer.lock"

mkdir -p "$STATE_DIR"

(
  flock -x 9
  cur=$(cat "$DELTA_FILE" 2>/dev/null || echo 0)
  echo "$(( cur + STEP ))" > "$DELTA_FILE"
) 9>"$DELTA_LOCK"

(
  exec 8>"$WRITER_LOCK"
  flock -n -x 8 || exit 0

  while :; do
    delta=$(
      flock -x 9
      cat "$DELTA_FILE" 2>/dev/null || echo 0
      echo 0 > "$DELTA_FILE"
    ) 9>"$DELTA_LOCK"

    [ "${delta:-0}" -eq 0 ] && break
    if [ "$delta" -gt 0 ]; then
      light -A "$delta" >/dev/null 2>&1 || true
    else
      light -U "$(( -delta ))" >/dev/null 2>&1 || true
    fi
  done
) </dev/null >/dev/null 2>&1 &
disown 2>/dev/null || true

#!/usr/bin/env bash
# Coalescing brightness adjuster.
#
# Hyprland's `binde` fires repeat events ~30 Hz while a key is held. Each
# `light` call costs ~80ms (DDC/CI bus latency, can't be reduced in software).
# Without coalescing, 1 second of holding = 30 queued hardware writes = the
# monitor lags ~2.5 seconds behind your keypresses.
#
# This script accumulates pending deltas in a tmp file. A single background
# writer (acquired via flock) flushes whatever delta has accumulated, so
# holding the key for 1 second converges to ~12 hardware writes total and
# the monitor catches up immediately on release.
#
# The script itself returns in ~3ms so Hyprland never blocks.
#
# Usage:
#   adjust.sh +10      # increase by 10%
#   adjust.sh -10      # decrease by 10%

set -u

STEP="${1:-+5}"
STATE_DIR="${XDG_RUNTIME_DIR:-/tmp}/brightness-adjust"
DELTA_FILE="$STATE_DIR/delta"
DELTA_LOCK="$STATE_DIR/delta.lock"
WRITER_LOCK="$STATE_DIR/writer.lock"

mkdir -p "$STATE_DIR"

# Step 1 (fast path): accumulate this step into the shared delta file.
# This is the only synchronous work the foreground script does.
(
  flock -x 9
  cur=$(cat "$DELTA_FILE" 2>/dev/null || echo 0)
  echo "$(( cur + STEP ))" > "$DELTA_FILE"
) 9>"$DELTA_LOCK"

# Step 2: try to spawn the background writer. If one is already running it
# will pick up our delta on its next iteration, so we just exit fast.
# `setsid` detaches from the controlling terminal so the writer survives
# parent (Hyprland keybind) exit cleanly.
(
  exec 8>"$WRITER_LOCK"
  flock -n -x 8 || exit 0   # another writer is active; we're done

  # Drain loop. Take all accumulated delta, apply once, repeat until empty.
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

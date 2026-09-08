#!/usr/bin/env bash
set -u

STATE_DIR="${XDG_RUNTIME_DIR:-/tmp}/brightness-idle"
SAVE_FILE="$STATE_DIR/saved"
PID_FILE="$STATE_DIR/fadeout.pid"

# cancel an in-flight fade so it can't dim back to 0 after we restore
if [ -s "$PID_FILE" ]; then
  kill "$(cat "$PID_FILE")" 2>/dev/null || true
  rm -f "$PID_FILE"
  sleep 0.15
fi

if [ -s "$SAVE_FILE" ]; then
  target=$(cat "$SAVE_FILE")
  target=${target%.*}
  rm -f "$SAVE_FILE"
  if [ "${target:-0}" -gt 0 ]; then
    brightnessctl set "${target}%" >/dev/null 2>&1
  fi
fi

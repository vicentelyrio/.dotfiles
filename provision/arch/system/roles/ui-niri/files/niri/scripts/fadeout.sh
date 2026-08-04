#!/usr/bin/env bash
set -u

STATE_DIR="${XDG_RUNTIME_DIR:-/tmp}/brightness-idle"
SAVE_FILE="$STATE_DIR/saved"
PID_FILE="$STATE_DIR/fadeout.pid"

mkdir -p "$STATE_DIR"
echo $$ > "$PID_FILE"

start=$(brightnessctl -m i | cut -d, -f4 | tr -d '%')
start=${start%.*}
start=${start:-0}

# only persist the real pre-fade value, never a mid-fade/zero one
if [ ! -s "$SAVE_FILE" ] && [ "$start" -gt 0 ]; then
  echo "$start" > "$SAVE_FILE"
fi

if [ "$start" -le 0 ]; then
  rm -f "$PID_FILE"
  exit 0
fi

steps=10
sleep_step=$(awk "BEGIN { print 1 / $steps }")
for (( i=1; i<=steps; i++ )); do
  nb=$(awk "BEGIN { print int($start - ($start / $steps) * $i) }")
  [ "$nb" -lt 0 ] && nb=0
  brightnessctl set "${nb}%" >/dev/null 2>&1
  sleep "$sleep_step"
done

brightnessctl set 0% >/dev/null 2>&1
rm -f "$PID_FILE"

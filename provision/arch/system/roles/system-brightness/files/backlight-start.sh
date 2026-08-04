#!/usr/bin/env bash
# Binds the ddcci kernel driver to every i2c bus that has a real DDC/CI-capable
# monitor on it. Once bound, the kernel creates /sys/class/backlight/ddcci<N>
# which userspace tools like `brightnessctl` can drive.
#
# Idempotent: re-binding an already-bound device is a no-op (writes silently
# fail with EEXIST). Safe to run multiple times.

set -u

LOG_TAG="backlight-start"

log() {
  logger -t "$LOG_TAG" -- "$*"
  echo "$LOG_TAG: $*"
}

# Make sure the kernel modules we depend on are present.
modprobe i2c-dev 2>/dev/null || true
if ! modprobe ddcci 2>/dev/null; then
  log "ERROR: ddcci module not loadable. Is ddcci-driver-linux-dkms-git installed and built for kernel $(uname -r)?"
  exit 1
fi

# Wait briefly for ddcutil to see displays. On boot, DRM/i2c can take a moment
# to fully expose monitors, especially after a cold start.
for attempt in 1 2 3 4 5 6; do
  mapfile -t BUSES < <(ddcutil --terse --sleep-multiplier 0 detect 2>/dev/null \
                        | awk '/^[[:space:]]*I2C bus:/ { sub("/dev/", "", $NF); print $NF }')
  if [ "${#BUSES[@]}" -gt 0 ]; then
    break
  fi
  log "No DDC/CI monitors detected (attempt ${attempt}/6); retrying in 2s..."
  sleep 2
done

if [ "${#BUSES[@]}" -eq 0 ]; then
  log "No DDC/CI monitors found after retries. Nothing to bind."
  exit 0
fi

rc=0
for bus in "${BUSES[@]}"; do
  target="/sys/bus/i2c/devices/${bus}/new_device"
  if [ ! -w "$target" ]; then
    log "WARN: ${target} not writable, skipping (this script must run as root)"
    rc=1
    continue
  fi
  # Already bound? /sys/bus/i2c/devices/${bus}/<bus#>-0037 will exist.
  busnum="${bus#i2c-}"
  if [ -e "/sys/bus/i2c/devices/${busnum}-0037" ]; then
    log "${bus} already has ddcci bound at address 0x37; skipping"
    continue
  fi
  if echo 'ddcci 0x37' > "$target" 2>/dev/null; then
    log "bound ddcci 0x37 on ${bus}"
  else
    # EEXIST or similar; treat as informational
    log "could not bind ddcci on ${bus} (already bound or unsupported)"
  fi
done

exit "$rc"

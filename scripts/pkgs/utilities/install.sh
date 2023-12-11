#!/usr/bin/env bash

set -e

# shellcheck source=/scripts/pkgs/utilities/dash/install.sh
source "$(require "pkgs/utilities/dash/install.sh")"

# shellcheck source=/scripts/pkgs/utilities/obsidian/install.sh
source "$(require "pkgs/utilities/obsidian/install.sh")"

# shellcheck source=/scripts/pkgs/utilities/origin/install.sh
source "$(require "pkgs/utilities/origin/install.sh")"

# shellcheck source=/scripts/pkgs/utilities/qmk/install.sh
source "$(require "pkgs/utilities/qmk/install.sh")"

# shellcheck source=/scripts/pkgs/utilities/spotify/install.sh
source "$(require "pkgs/utilities/spotify/install.sh")"

# shellcheck source=/scripts/pkgs/utilities/steam/install.sh
source "$(require "pkgs/utilities/steam/install.sh")"

# shellcheck source=/scripts/pkgs/utilities/transmission/install.sh
source "$(require "pkgs/utilities/transmission/install.sh")"

# shellcheck source=/scripts/pkgs/utilities/via/install.sh
source "$(require "pkgs/utilities/via/install.sh")"

# shellcheck source=/scripts/pkgs/utilities/vlc/install.sh
source "$(require "pkgs/utilities/vlc/install.sh")"

installUtilitiesExec () {
  local NAME="Utilities"

  printSection "Installing $NAME"

  install_dash
  install_obsidian
  install_origin
  install_qmk
  install_spotify
  install_steam
  install_transmission
  install_via
  install_vlc

  printSection "✓ $NAME successfully installed"
}

installUtilities () {
  local NAME="Utilities"
  printQuestion "Choose what $NAME you want to install"

  local ACTIONS

  local OBSIDIAN="Dash (offline docs)"
  local OBSIDIAN="Obsidian"
  local ORIGIN="EA Origin"
  local QMK="QMK Keyboard Toolbox"
  local SPOTIFY="Spotify"
  local STEAM="Steam"
  local TRANSMISSION="Transmission (torrent)"
  local VIA="VIA Keyboard"
  local VLC="VLC"

  ACTIONS=$(
    gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " --no-limit \
    "$DASH" \
    "$OBSIDIAN" \
    "$ORIGIN" \
    "$QMK" \
    "$SPOTIFY" \
    "$STEAM" \
    "$TRANSMISSION" \
    "$VIA" \
    "$VLC" \
  )

  case "$ACTIONS" in
    "$DASH") install_dash ;;
    "$OBSIDIAN") install_obsidian ;;
    "$ORIGIN") install_origin ;;
    "$QMK") install_qmk ;;
    "$SPOTIFY") install_spotify ;;
    "$STEAM") install_steam ;;
    "$TRANSMISSION") install_transmission ;;
    "$VIA") install_via ;;
    "$VLC") install_vlc ;;
  esac
}


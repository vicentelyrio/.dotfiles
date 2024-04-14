#!/usr/bin/env bash

set -e

install_spotify () {
  local NAME="Spotify"
  local FOLDER="pkgs/utilities/spotify"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "brew list spotify"

  printSectionEnd "$NAME successfully configured"
}


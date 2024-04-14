#!/usr/bin/env bash

set -e

install_vlc () {
  local NAME="VLC"
  local FOLDER="pkgs/utilities/vlc"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "brew list vlc"

  printSectionEnd "$NAME successfully configured"
}


#!/usr/bin/env bash

set -e

install_firefox () {
  local NAME="Firefox"
  local FOLDER="pkgs/browsers/firefox"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "brew list firefox"

  printSectionEnd "$NAME successfully configured"
}


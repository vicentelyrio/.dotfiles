#!/usr/bin/env bash

set -e

install_caffeine () {
  local NAME="Caffeine"
  local FOLDER="pkgs/osx/caffeine"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "brew list caffeine"

  printSectionEnd "$NAME successfully configured"
}


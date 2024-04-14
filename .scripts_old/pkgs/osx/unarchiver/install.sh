#!/usr/bin/env bash

set -e

install_unarchiver () {
  local NAME="The Unarchiver"
  local FOLDER="pkgs/osx/unarchiver"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "brew list the-unarchiver"

  printSectionEnd "$NAME successfully configured"
}


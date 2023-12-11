#!/usr/bin/env bash

set -e

install_obsidian () {
  local NAME="Obsidian"
  local FOLDER="pkgs/utilities/obsidian"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "brew list obsidian"

  printSectionEnd "$NAME successfully configured"
}


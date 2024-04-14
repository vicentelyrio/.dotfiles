#!/usr/bin/env bash

set -e

install_tree () {
  local NAME="TREE"
  local FOLDER="pkgs/terminal/tree"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "tree --version"

  printSectionEnd "$NAME successfully configured"
}


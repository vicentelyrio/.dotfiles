#!/usr/bin/env bash

set -e

install_bat () {
  local NAME="GITUI"
  local FOLDER="pkgs/terminal/gtiui"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "gitui --version"
  install_on_zshaliases "[#gitui]" "$FOLDER"

  printSectionEnd "$NAME successfully configured"
}


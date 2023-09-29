#!/usr/bin/env bash

set -e

install_gitui () {
  local NAME="GITUI"
  local FOLDER="pkgs/terminal/gitui"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "gitui --version"
  install_on_zshaliases "#gitui" "$FOLDER"

  printSectionEnd "$NAME successfully configured"
}


#!/usr/bin/env bash

set -e

install_helix () {
  local NAME="Helix"
  local FOLDER="pkgs/ide/helix"
  local FILE="config.toml"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "hx --version"
  install_config_bkp "$FILE" "$FOLDER" ".config/helix/" "$FILE"

  printSectionEnd "$NAME successfully configured"
}


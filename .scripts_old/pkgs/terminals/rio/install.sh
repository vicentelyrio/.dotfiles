#!/usr/bin/env bash

set -e

install_rio () {
  local NAME="RIO"
  local FOLDER="pkgs/terminals/rio"
  local FILE="config.toml"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "rio --version"
  install_config_bkp "$FILE" "$FOLDER" ".config/rio/$FILE"
  install_config_bkp "theme/catppuccin.toml" "$FOLDER" ".config/rio/theme/catppuccin.toml"

  printSectionEnd "$NAME successfully configured"
}


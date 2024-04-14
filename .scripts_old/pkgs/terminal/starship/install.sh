#!/usr/bin/env bash

set -e

install_starship () {
  local NAME="STARSHIP"
  local FOLDER="pkgs/terminal/starship"
  local FILE="starship.toml"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "starship --version"
  install_config_bkp "$FILE" "$FOLDER" ".config/$FILE"
  install_on_zshrc "#starship" "$FOLDER"

  printSectionEnd "$NAME successfully configured"
}


#!/usr/bin/env bash

set -e

install_starship () {
  local NAME="STARSHIP"
  local FOLDER="pkgs/terminal/starship"
  local FILE="starship.toml"
  local CODE="\$(starship init zsh)"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "starship --version"
  write_on_zshrc "$CODE"
  install_config_bkp "$FILE" "$FOLDER" "/.config/$FILE"

  printSectionEnd "$NAME successfully configured"
}


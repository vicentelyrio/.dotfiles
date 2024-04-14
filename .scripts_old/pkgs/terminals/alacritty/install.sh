#!/usr/bin/env bash

set -e

install_alacritty () {
  local NAME="ALACRITY"
  local FOLDER="pkgs/terminals/alacritty"
  local FILE="alacritty.yml"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "alacritty --version"
  install_config_bkp "$FILE" "$FOLDER" ".config/alacritty/$FILE"
  install_config_bkp "catppuccin/catppuccin-frappe.yml" "$FOLDER" ".config/alacritty/catppuccin/catppuccin-frappe.yml"
  install_config_bkp "catppuccin/catppuccin-latte.yml" "$FOLDER" ".config/alacritty/catppuccin/catppuccin-latte.yml"
  install_config_bkp "catppuccin/catppuccin-macchiato.yml" "$FOLDER" ".config/alacritty/catppuccin/catppuccin-macchiato.yml"
  install_config_bkp "catppuccin/catppuccin-mocha.yml" "$FOLDER" ".config/alacritty/catppuccin/catppuccin-mocha.yml"

  printSectionEnd "$NAME successfully configured"
}


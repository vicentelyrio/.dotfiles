#!/usr/bin/env bash

set -e

install_wezterm () {
  local NAME="WEZTERM"
  local FOLDER="pkgs/terminals/wezterm"
  local FILE="wezterm.lua"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "wezterm --version"
  install_config_bkp "$FILE" "$FOLDER" ".config/wezterm/$FILE"

  printSectionEnd "$NAME successfully configured"
}


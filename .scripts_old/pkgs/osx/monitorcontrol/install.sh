#!/usr/bin/env bash

set -e

install_monitorcontrol () {
  local NAME="Monitor Control"
  local FOLDER="pkgs/osx/monitorcontrol"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "brew list monitorcontrol"

  printSectionEnd "$NAME successfully configured"
}


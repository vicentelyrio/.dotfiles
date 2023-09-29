#!/usr/bin/env bash

set -e

install_ack () {
  local NAME="ACK"
  local FOLDER="pkgs/terminal/ack"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "ack --version"
  install_on_zshaliases "#ack" "$FOLDER"

  printSectionEnd "$NAME successfully configured"
}


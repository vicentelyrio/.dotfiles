#!/usr/bin/env bash

set -e

install_slack () {
  local NAME="Slack"
  local FOLDER="pkgs/utilities/slack"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "brew list slack"

  printSectionEnd "$NAME successfully configured"
}


#!/usr/bin/env bash

set -e

install_postgres () {
  local NAME="Postgres"
  local FOLDER="pkgs/code/postgres"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "brew list postgres-unofficial"

  printSectionEnd "$NAME successfully configured"
}


#!/usr/bin/env bash

set -e

# BASEPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

require() {
  local DIR="${BASH_SOURCE%/*}"
  if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
  local FILE="$DIR/$1"
  chmod +x "$FILE"
  echo "$FILE"
}

# Source dependencies

# shellcheck source=/interface.sh
source "$(require "interface.sh")"

# shellcheck source=/validateOs.sh
source "$(require "validateOs.sh")"

# shellcheck source=/dependencies.sh
source "$(require "dependencies.sh")"

# shellcheck source=/packages.sh
source "$(require "packages.sh")"

main() {
  clear

  welcome

  validateOs

  installDependencies

  installPackages
}

main

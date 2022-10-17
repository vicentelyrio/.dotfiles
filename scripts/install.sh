#!/usr/bin/env bash

require() {
  local DIR="${BASH_SOURCE%/*}"
  if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
  chmod +x "$DIR/$1"
  source "$DIR/$1"
}

# Source dependencies
require "interface.sh"
require "dependencies.sh"
require "configs.sh"
require "bundles.sh"

onStart() {
  printMessage "booting..."

  untestedOsWarning
  onCheckDependencies
  onInstallCorePkg
  onWelcome
  onGitConfig
  onInstallMethod
}

onStart

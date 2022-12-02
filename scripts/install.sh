#!/usr/bin/env bash

set -e

require() {
  local DIR="${BASH_SOURCE%/*}"
  if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
  local FILE="$DIR/$1"
  chmod +x $FILE 
  echo $FILE
}

# Source dependencies
source $(require "interface.sh")
source $(require "deps/dependencies.sh")
source $(require "core/core.sh")
source $(require "git/git.sh")
source $(require "pkgs/terminal/install.sh")
source $(require "pkgs/ide/install.sh")
# source $(require "bundles.sh")

main() {
  # untestedOsWarning

  # installDependencies
  # installCorePackages

  # welcome

  # startGitConfig

  installTerminalPackages
  installIDEs

  # onInstallMethod
}

main


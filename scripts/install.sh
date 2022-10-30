#!/usr/bin/env bash

require() {
  local DIR="${BASH_SOURCE%/*}"
  if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
  local FILE="$DIR/$1"
  chmod +x $FILE 
  echo $FILE
}

# Source dependencies
source $(require "interface.sh")
source $(require "dependencies.sh")
source $(require "git.sh")
source $(require "bundles.sh")

onStart() {
  printMessage "booting..."

  untestedOsWarning
  checkAndInstallDependencies
  installCorePackages

  onWelcome

  startGitConfig

  onInstallMethod
}

onStart

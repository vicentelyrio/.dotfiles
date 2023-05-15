#!/usr/bin/env bash

set -e

DATENOW="$(date +%Y-%m-%d-%H.%M.%S)"

OS="unkown"

case "$OSTYPE" in
  solaris*) OS="SOLARIS" ;;
  darwin*)  OS="OSX" ;;
  linux*)   OS="LINUX" ;;
  bsd*)     OS="BSD" ;;
  msys*)    OS="WINDOWS" ;;
  cygwin*)  OS="WINDOWS" ;;
  *)        OS="unknown" ;;
esac

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
source $(require "bundles.sh")

main() {
  untestedOsWarning

  # installDependencies
  # installCorePackages

  welcome

  # startGitConfig

  onInstallMethod
}

main


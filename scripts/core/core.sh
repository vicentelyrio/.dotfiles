#!/usr/bin/env bash

installCorePackages () {
  printSection "Core packages install"
  brew bundle --file "$(require "core/Brewfile")"
  printSuccess "Core Packages successfully installed"
}


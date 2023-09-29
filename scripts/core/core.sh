#!/usr/bin/env bash

installCorePackages () {
  printSection "Core packages install"
  gum spin --spinner minidot --title "Installing core packages..." -- brew bundle --file "$(require "core/Brewfile")"
  printSuccess "Core Packages successfully installed"
}


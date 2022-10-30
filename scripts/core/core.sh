#!/usr/bin/env bash

installCorePackages () {
  printLine
  printMessage "Installing core packages"

  brew bundle --file $(require "core/Brewfile")

  printLine
  printSuccess "Core Packages successfully installed"
}


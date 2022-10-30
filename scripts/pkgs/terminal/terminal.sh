#!/usr/bin/env bash

installTerminalPackages () {
  printLine
  printMessage "Installing core packages"

  brew bundle --file $(require "pkgs/terminal/Brewfile")

  printLine
  printSuccess "Core Packages successfully installed"
}


#!/usr/bin/env bash

NAME="Terminal Utilities"

installTerminalPackages () {
  printLine
  printMessage "Installing $NAME"

  brew bundle --file $(require "pkgs/terminal/Brewfile")

  printLine
  printSuccess "$NAME successfully installed"
}


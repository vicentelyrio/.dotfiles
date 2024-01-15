#!/usr/bin/env bash

installLinuxPackages() {

}

installMacosPackages() {
}

installPackages() {
  printSection "Install packages and apps"

  case "$OS" in
    "LINUX") installLinuxPackages ;;
    "MACOS") installMacosPackages ;;
  esac

  printSectionEnd
}

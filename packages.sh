#!/usr/bin/env bash

# shellcheck source=/packages.sh
installLinuxPackages() {
  printStep "Pacdef setup"
  rm -rf ~/.config/pacdef
  mkdir ~/.config/pacdef
  cp "$BASEPATH/install/linux/pacdef/pacdef.yml" ~/.config/pacdef/pacdef.yaml
  pacdef group import "$BASEPATH/install/linux/pacdef/groups/base"

  printStep "Pacdef install"
  pacdef package sync --noconfirm
}

installMacosPackages() {
  printSection "TBI"
}

installPackages() {
  printSection "Install packages and apps"

  case "$OS" in
    "LINUX") installLinuxPackages ;;
    "MACOS") installMacosPackages ;;
  esac

  printSectionEnd
}

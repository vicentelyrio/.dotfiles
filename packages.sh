#!/usr/bin/env bash

# shellcheck source=/packages.sh
installLinuxPackages() {
  printStep "Pacdef setup"
  rm -rf ~/.config/pacdef
  mkdir ~/.config/pacdef
  cp "$BASEPATH/install/linux/pacdef/pacdef.yml" ~/.config/pacdef/pacdef.yaml
  pacdef g i "$BASEPATH/install/linux/pacdef/groups"

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

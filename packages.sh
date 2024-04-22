#!/usr/bin/env bash

# shellcheck source=/packages.sh
installLinuxPackages() {
  ansible-playbook --ask-become-pass -i ./provision/hosts.yml ./provision/arch/main.yml
  printSection "Arch playbook completed"
}

installMacosPackages() {
  ansible-playbook --ask-become-pass -i ./provision/hosts.yml ./provision/macos/main.yml
  printSection "MacOS playbook completed"
}

installPackages() {
  printSection "Install packages and apps"

  case "$OS" in
    "LINUX") installLinuxPackages ;;
    "MACOS") installMacosPackages ;;
  esac

  printSectionEnd
}

#!/usr/bin/env bash

# shellcheck source=/packages.sh
installLinuxPackages() {
  ansible-playbook --ask-become-pass -i hosts ./provision/roles/arch/main.yml
  printSection "ansible stuff"
}

installMacosPackages() {
  ansible-playbook --ask-become-pass -i hosts ./provision/roles/macos/main.yml
  printSection "ansible stuff"
}

installPackages() {
  printSection "Install packages and apps"

  case "$OS" in
    "LINUX") installLinuxPackages ;;
    "MACOS") installMacosPackages ;;
  esac

  printSectionEnd
}

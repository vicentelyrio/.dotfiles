#!/usr/bin/env bash

# LINUX
installLinuxDeps() {
  printMessage "updating pacman"
  sudo pacman -Syyu --noconfirm
  sudo pacman -S --needed base base-devel linux-headers git rsync python-pip python-pexpect --noconfirm
  printSuccess "done"

  # ANSIBLE
  if ! command -v ansible &> /dev/null; then
    printMessage "installing ansible..."
    sudo pacman -S ansible --needed --noconfirm
  fi
  printSuccess "ansible"
}

# MACOS
installMacosDeps() {
  # XCODE
  if ! command -v xcode-select --version &> /dev/null; then
    printMessage "installing xcode-select..."
    xcode-select --install
  fi
  printSuccess "xcode-select"

  # BREW
  if ! command -v brew &> /dev/null; then
    printMessage "installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> "$HOME/.zprofile"
    eval "$("$(brew --prefix)"/bin/brew shellenv)"
  fi
  printSuccess "homebrew"

  # ANSIBLE
  if ! command -v ansible &> /dev/null; then
    printMessage "installing ansible..."
    brew install ansible
  fi
  printSuccess "ansible"
}

# INSTALL
installDependencies() {
  printSection "$OS Dependencies check"

  case "$OS" in
    "LINUX") installLinuxDeps ;;
    "MACOS") installMacosDeps ;;
  esac

  printSectionEnd
}

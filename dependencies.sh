#!/usr/bin/env bash

# LINUX
installLinuxDeps() {
  printMessage "updating pacman"
  sudo pacman -Syyu
  sudo pacman -S --needed base-devel git
  printSuccess "done"

  # CURL
  if ! command -v curl &> /dev/null; then
    sudo pacman -S curl
  fi
  printSuccess "curl"

  # SSH
  if ! command -v ssh-agent &> /dev/null; then
    sudo pacman -S openssh
  fi
  printSuccess "openssh"

  # YAY
  if ! command -v yay &> /dev/null; then
    printMessage "installing yay..."
    git clone https://aur.archlinux.org/yay.git
    chmod 777 yay || return
    cd yay || return
    makepkg -si
  fi
  printSuccess "yay"

  # ANSIBLE
  if ! command -v ansible &> /dev/null; then
    printMessage "installing ansible..."
    sudo pacman -S ansible
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

  # CURL
  if ! command -v curl &> /dev/null; then
    printMessage "installing curl..."
    brew install curl
    echo "export PATH=$(brew --prefix)/opt/curl/bin:$PATH" >> ~/.zshrc
    source "$HOME/.zshrc"
  fi
  printSuccess "curl"

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

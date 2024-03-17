#!/usr/bin/env bash

installRust() {
  if ! command -v rustc &> /dev/null; then
    printMessage "installing rust and cargo..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME/.cargo/env"
  fi
  printSuccess "cargo"
}

installBombadil() {
  if ! command -v bombadil &> /dev/null; then
    printMessage "installing toml-bombadil..."
    eval "$(ssh-agent -s)"
    ssh-add
    cargo install --git  https://github.com/oknozor/toml-bombadil
  fi
  printSuccess "toml bombadil"
}

# LINUX
installOn() {
  printMessage "installing $1..."
  packagesNeeded="$1"

  if  [ -x "$(command -v pacman)" ];  then sudo pacman -Sy "$packagesNeeded"
  else
    printError "Package manager not found. You must manually install: $packagesNeeded">&2
    return
  fi
}

installDeps() {
  printMessage "updating pacman"
  sudo pacman -Syyu
  sudo pacman -S --needed base-devel git
  printSuccess "done"

  # CURL
  if ! command -v curl &> /dev/null; then
    installOn "curl"
  fi
  printSuccess "curl"

  # SSH
  if ! command -v ssh-agent &> /dev/null; then
    installOn "openssh"
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

  # PACDEF
  if ! command -v pacdef &> /dev/null; then
    yay -S pacdef
  fi
  printSuccess "pacdef"

  # RUST
  installRust

  # BOMBADIL
  installBombadil
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
    echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zprofile
    eval "$("$(brew --prefix)"/bin/brew shellenv)"
  fi
  printSuccess "homebrew"

  # CURL
  if ! command -v curl &> /dev/null; then
    printMessage "installing curl..."
    brew install curl
    echo "export PATH=$(brew --prefix)/opt/curl/bin:$PATH" >> ~/.zshrc
    source ~/.zshrc
  fi
  printSuccess "curl"

  # RUST
  installRust

  # BOMBADIL
  installBombadil
}

# INSTALL
installDependencies() {
  printSection "$OS Dependencies check"

  case "$OS" in
    "LINUX") installDeps ;;
    "MACOS") installMacosDeps ;;
  esac

  printSectionEnd
}

#!/usr/bin/env bash

installOnLinux() {
  printMessage "installing $1..."
  packagesNeeded="$1"

  if    [ -x "$(command -v apk)" ];     then sudo apk add --no-cache "$packagesNeeded"
  elif  [ -x "$(command -v apt-get)" ]; then sudo apt-get install "$packagesNeeded"
  elif  [ -x "$(command -v dnf)" ];     then sudo dnf install "$packagesNeeded"
  elif  [ -x "$(command -v zypper)" ];  then sudo zypper install "$packagesNeeded"
  elif  [ -x "$(command -v pacman)" ];  then sudo pacman -Sy "$packagesNeeded"
  else
    printError "Package manager not found. You must manually install: $packagesNeeded">&2
    return
  fi
}

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
    eval `ssh-agent -s`
    ssh-add
    cargo install --git  https://github.com/oknozor/toml-bombadil
  fi
  printSuccess "toml bombadil"
}

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

installLinuxDeps() {
  # CURL
  if ! command -v curl &> /dev/null; then
    installOnLinux "curl"
  fi
  printSuccess "curl"

  # SSH
  if ! command -v ssh-agent &> /dev/null; then
    installOnLinux "openssh"
  fi
  printSuccess "openssh"

  # RUST
  installRust

  # BOMBADIL
  installBombadil

  # PACDEF
  if ! command -v pacdef &> /dev/null; then
    printMessage "installing pacdef..."
    cargo install -F arch pacdef
  fi
  printSuccess "pacdef"
}

installDependencies() {
  printSection "$OS Dependencies check"

  case "$OS" in
    "LINUX") installLinuxDeps ;;
    "MACOS") installMacosDeps ;;
  esac

  printSectionEnd
}

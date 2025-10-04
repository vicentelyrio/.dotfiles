# Source aliases
source ${ZDOTDIR:-${HOME}}/.config/.zsh/.zshaliases

# zsh highlight theme
if [[ ! -f ${ZDOTDIR:-${HOME}}/.config/.zsh/zsh-sh-theme/.catppuccin.yaml ]]; then
  command git clone https://github.com/catppuccin/zsh-syntax-highlighting.git ${ZDOTDIR:-${HOME}}/.config/.zsh/zsh-sh-theme
fi

source ${ZDOTDIR:-${HOME}}/.config/.zsh/zsh-sh-theme/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh

# ZCOMET - plugin manager
if [[ ! -f ${ZDOTDIR:-${HOME}}/.config/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.config/.zcomet/bin
fi

source ${ZDOTDIR:-${HOME}}/.config/.zcomet/bin/zcomet.zsh

# Snipts
zcomet snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh   # git completion

# Plugins
zcomet load zsh-users/zsh-completions                                           # tab completion
zcomet load zsh-users/zsh-history-substring-search                              # history (with up arrow)
zcomet load zsh-users/zsh-autosuggestions                                       # suggestions
zcomet load zsh-users/zsh-syntax-highlighting                                   # syntax highlight

# Compile zcomet
zcomet compinit

# FZF
source <(fzf --zsh)

# Zoxide
eval "$(zoxide init zsh)"

# Starship
eval "$(starship init zsh)"

# TMUX

# TPM - TMUX PACKAGE MANAGER
TMUXFOLDER=${ZDOTDIR:-${HOME}}/.config/.tmux/plugins
TPM=${TMUXFOLDER}/tpm/tpm

if [[ ! -f ${TPM} ]]; then
  git clone https://github.com/tmux-plugins/tpm ${TMUXFOLDER}/tpm
fi

# History
HISTFILE=~/.zsh_histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

function asdf_update_versions() {
  local nvmrc_path=".nvmrc"
  local yarnrc_path=".yarnrc"
  local toolversions_path=".tool-versions"

  # Don't do anything if .tool-versions exists
  if [ -f "$toolversions_path" ]; then
    return
  fi  # This was the problem - had a } instead of fi

  # Handle Node version from .nvmrc
  if [ -f "$nvmrc_path" ]; then
    local node_version
    node_version=$(<"$nvmrc_path")
    # Clean up the version string (remove 'v' prefix if present)
    node_version=${node_version#v}

    # Install the version if it's not already installed
    asdf install nodejs $node_version 2>/dev/null || true
    # Set the version for the current shell
    asdf local nodejs $node_version
  fi

  # Handle Yarn version from .yarnrc
  if [ -f "$yarnrc_path" ]; then
    local yarn_version
    # Extract version from .yarnrc (assuming format like 'version "X.X.X"')
    yarn_version=$(grep "version" "$yarnrc_path" | cut -d '"' -f2)

    if [ ! -z "$yarn_version" ]; then
      # Install the version if it's not already installed
      asdf install yarn $yarn_version 2>/dev/null || true
      # Set the version for the current shell
      asdf local yarn $yarn_version
    fi
  fi
}

# Auto-switch versions when entering a directory
autoload -U add-zsh-hook
add-zsh-hook chpwd asdf_update_versions

# BEGIN ANSIBLE MANAGED BLOCK - asdf
. "$HOME/.asdf/asdf.sh"
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit
# END ANSIBLE MANAGED BLOCK - asdf

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/google-cloud-sdk/completion.zsh.inc'; fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

. "$HOME/.cargo/env"
export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)"

export PATH="$HOME/.asdf/shims:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

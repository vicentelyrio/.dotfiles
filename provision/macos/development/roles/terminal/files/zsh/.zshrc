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

# ASDF
. "$HOME/.asdf/asdf.sh"

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)

# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# Function to find and read .nvmrc files
function asdf_update_nodejs_version() {
  local nvmrc_path
  nvmrc_path="$(pwd)/.nvmrc"
  if [ -f "$nvmrc_path" ]; then
    local node_version
    node_version=$(<"$nvmrc_path")
    # Install the version if it's not already installed
    asdf install nodejs $node_version 2>/dev/null || true
    # Set the version for the current shell
    asdf local nodejs $node_version
  fi
}

# Auto-switch Node.js version when entering a directory
autoload -U add-zsh-hook

add-zsh-hook chpwd asdf_update_nodejs_version
# BEGIN ANSIBLE MANAGED BLOCK - asdf
. "$HOME/.asdf/asdf.sh"
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit
# END ANSIBLE MANAGED BLOCK - asdf

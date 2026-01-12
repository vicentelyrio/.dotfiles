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

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

autoload -U +X bashcompinit && bashcompinit
# BEGIN ANSIBLE MANAGED BLOCK - node/nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"
# END ANSIBLE MANAGED BLOCK - node/nvm
<<<<<<< Updated upstream
ssh-add --apple-use-keychain ~/.ssh/id_ssh_default 2>/dev/null
=======

# opencode
export PATH=/Users/vicentelyrio/.opencode/bin:$PATH
>>>>>>> Stashed changes

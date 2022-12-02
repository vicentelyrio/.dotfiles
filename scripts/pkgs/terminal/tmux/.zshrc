
# TPM - TMUX PACKAGE MANAGER 
TMUXFOLDER=${ZDOTDIR:-${HOME}}/.tmux/plugins
TPM=${TMUXFOLDER}/tpm/tpm

if [[ ! -f ${TPM} ]]; then
  git clone https://github.com/tmux-plugins/tpm ${TMUXFOLDER}/tpm
fi


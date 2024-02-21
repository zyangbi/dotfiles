# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source $HOME/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh
#
# # Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle command-not-found
antigen bundle docker
antigen bundle sudo
antigen bundle z
antigen bundle aliases
antigen bundle web-search
antigen bundle dirhistory
antigen bundle history
antigen bundle jsontools
antigen bundle vi-mode
antigen bundle ripgrep
antigen bundle fd
antigen bundle man
antigen bundle zsh-interactive-cd
#
# # Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
#
# # Load the theme.
# antigen theme robbyrussell
antigen theme romkatv/powerlevel10k
#
# # Tell Antigen that you're done.
antigen apply

alias l='ls -lh'
alias ll='ls -lah'

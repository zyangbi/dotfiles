# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# Homebrew
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"

# Proxy
function proxy() {
	case $1 in
		start)
			export http_proxy=http://127.0.0.1:7890
			export HTTP_PROXY=$http_proxy
			export https_proxy=$http_proxy
			export HTTPS_PROXY=$http_proxy
			export all_proxy=$http_proxy
			export no_proxy=localhost,192.168.*,127.0.*
			export NO_PROXY=localhost,192.168.*,127.0.*
			;;
		stop)
			unset http_proxy
			unset HTTP_PROXY
			unset https_proxy
			unset HTTPS_PROXY
			unset all_proxy
			unset no_proxy
			unset NO_PROXY
			;;
		status)
			echo "http_proxy=$http_proxy"
			echo "HTTP_PROXY=$HTTP_PROXY"
			echo "https_proxy=$https_proxy"
			echo "HTTPS_PROXY=$HTTPS_PROXY"
			echo "all_proxy=$all_proxy"
			echo "no_proxy=$no_proxy"
			echo "NO_PROXY=$NO_PROXY"
			;;
	esac
}
proxy start

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


DOTFILES=$HOME/code/dotfiles

# antigen
if [ ! -d $HOME/.antigen ]; then
	mkdir $HOME/.antigen
fi
if [ ! -f $HOME/.antigen/antigen.zsh ]; then
	echo "Install Antigen"
	curl -L git.io/antigen >$HOME/.antigen/antigen.zsh
fi

# zsh
ln -sf "$DOTFILES/zsh/.zshrc" "$HOME"
ln -sf "$DOTFILES/zsh/.p10k.zsh" "$HOME"

# tmux
ln -sf "$DOTFILES/tmux/tmux.conf" "$HOME/.tmux.conf"
#git clone https://github.com/tmux-plugins/tpm "$DOTFILES/vendor/tpm"

# vim
ln -sf "$DOTFILES/vim/.vimrc" "$HOME"

# nvim (lazyvim)
if [ ! -f "$HOME/.config/nvim/lua/config/lazy.lua" ]; then
  echo "Install LazyVim"
	git clone https://github.com/LazyVim/starter $HOME/.config/nvim
	rm -rf $HOME/.config/nvim/.git
fi
rm -rf $HOME/.config/nvim/lua
ln -sfT "$DOTFILES/nvim/lua" "$HOME/.config/nvim/lua"

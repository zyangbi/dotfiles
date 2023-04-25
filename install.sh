DOTFILES=$HOME/code/dotfiles

# Install Antigen
if [ ! -d $HOME/.antigen ] ; then
    mkdir $HOME/.antigen
fi
if [ ! -f $HOME/.antigen/antigen.zsh ] ; then
    curl -L git.io/antigen > $HOME/.antigen/antigen.zsh
fi

ln -sf "$DOTFILES/zsh/.zshrc" "$HOME"
ln -sf "$DOTFILES/zsh/.p10k.zsh" "$HOME"

ln -sf "$DOTFILES/tmux/tmux.conf" "$HOME/.tmux.conf"
#git clone https://github.com/tmux-plugins/tpm "$DOTFILES/vendor/tpm"

ln -sf "$DOTFILES/vim/.vimrc" "$HOME"

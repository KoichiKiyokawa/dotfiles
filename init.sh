#!/bin/sh

mkdir -p ~/.config
rm -rf ~/.config/fish
ln -fs ~/dotfiles/fish ~/.config
ln -fs ~/dotfiles/nvim ~/.config
ln -fs ~/dotfiles/karabiner.json ~/.config/karabiner
ln -fs ~/dotfiles/vscode/.vimrc ~/.vimrc
ln -fs ~/dotfiles/.gitconfig ~/.gitconfig
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
nvim -c "PlugInstall | :qa"
sh coc-extensions.sh


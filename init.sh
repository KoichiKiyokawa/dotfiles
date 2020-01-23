#!/bin/sh

mkdir -p ~/.config
ln -fs ~/dotfiles/fish ~/.config
ln -fs ~/dotfiles/nvim ~/.config
ln -fs ~/dotfiles/.tigrc ~
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

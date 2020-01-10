#!/bin/sh

mkdir -p ~/.config
ln -fs ~/dotfiles/fish ~/.config
ln -fs ~/dotfiles/nvim ~/.config
ln -fs ~/dotfiles/.tigrc ~
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fisher

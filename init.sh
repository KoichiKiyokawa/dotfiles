#!/bin/sh

mkdir -p ~/.config

ln -fs ~/dotfiles/nvim ~/.config

ln -fs ~/dotfiles/karabiner ~/.config

ln -fs ~/dotfiles/zsh/.zshrc ~/.zshrc
touch ~/dotfiles/zsh/local.zsh
mkdir -p ~/.config/sheldon
ln -fs ~/dotfiles/zsh/plugins.toml ~/.config/sheldon/plugins.toml
ln -fs ~/dotfiles/zsh/starship.toml ~/.config/starship.toml

ln -fs ~/dotfiles/lazygit/config.yml ~/.config/lazygit/

ln -fs ~/dotfiles/vscode/.vimrc ~/.vimrc
ln -fs ~/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

ln -fs ~/dotfiles/.gitconfig ~/.gitconfig

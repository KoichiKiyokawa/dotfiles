#!/bin/sh

mkdir -p ~/.config
rm -rf ~/.config/fish
ln -fs ~/dotfiles/fish ~/.config
ln -fs ~/dotfiles/nvim ~/.config
ln -fs ~/dotfiles/karabiner ~/.config
ln -fs ~/dotfiles/lazygit/config.yml ~/.config/lazygit/
ln -fs ~/dotfiles/vscode/.vimrc ~/.vimrc
ln -fs ~/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -fs ~/dotfiles/.gitconfig ~/.gitconfig
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
nvim -c "PackerInstall | :qa"
sh coc-extensions.sh


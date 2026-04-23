#!/bin/sh

set -eu

repo_dir=$(cd "$(dirname "$0")" && pwd)

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/sheldon"
mkdir -p "$HOME/.config/lazygit"
mkdir -p "$HOME/Library/Application Support/Code/User"

ln -fs "$repo_dir/nvim" "$HOME/.config/nvim"
ln -fs "$repo_dir/karabiner" "$HOME/.config/karabiner"

ln -fs "$repo_dir/zsh/.zshrc" "$HOME/.zshrc"
touch "$repo_dir/zsh/local.zsh"
ln -fs "$repo_dir/zsh/plugins.toml" "$HOME/.config/sheldon/plugins.toml"
ln -fs "$repo_dir/zsh/starship.toml" "$HOME/.config/starship.toml"

ln -fs "$repo_dir/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"

ln -fs "$repo_dir/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"

ln -fs "$repo_dir/.gitconfig" "$HOME/.gitconfig"

devbox install -c "$repo_dir"

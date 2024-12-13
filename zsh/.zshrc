eval "$(starship init zsh)"
eval "$(sheldon source)"
eval "$(fnm env --use-on-cd --shell zsh)"
zsh-defer source ~/dotfiles/zsh/alias.zsh
zsh-defer source ~/dotfiles/zsh/local.zsh

eval "$(sheldon source)"
source ~/dotfiles/zsh/alias.zsh

fpath=(~/.zsh/completion $fpath)
autoload -U compinit
compinit -u

eval "$(starship init zsh)"
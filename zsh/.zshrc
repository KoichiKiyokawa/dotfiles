eval "$(starship init zsh)"
eval "$(sheldon source)"
eval "$(/opt/homebrew/bin/mise activate zsh)"

zsh-defer source ~/dotfiles/zsh/alias.zsh
zsh-defer source ~/dotfiles/zsh/local.zsh

zsh-defer zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[-_./]=**' 'l:|=* r:|=*' # fuzzy matching

# Ctrl + F to edit the current command line in $EDITOR
export EDITOR="code --wait"
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^F' edit-command-line

# Ctrl + R to search history with peco
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
alias distinct='awk '\''!a[$0]++'\'
function peco-select-history() {
    BUFFER=$(\history -n -r 1 | distinct | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-select-history
bindkey '^r' peco-select-history

export XDG_CONFIG_HOME="$HOME/.config"
# for M1 Mac
export PATH="/opt/homebrew/bin:$PATH"

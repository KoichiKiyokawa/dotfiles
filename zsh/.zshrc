export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export PATH="$HOME/.local/bin:$PATH"
for prefix in /opt/homebrew /home/linuxbrew/.linuxbrew; do
  if [[ -d "$prefix/bin" ]]; then
    export PATH="$prefix/opt/curl/bin:$prefix/bin:$prefix/sbin:$PATH"
  fi
done
# Resolve the managed link so any checkout location works.
export DOTFILES_ROOT="${${(%):-%x}:A:h:h}"
if [[ "$OSTYPE" == darwin* ]]; then
  export PNPM_HOME="$HOME/Library/pnpm"
else
  export PNPM_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/pnpm"
fi
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

eval "$(mise activate zsh)"

# for cursor (https://scrapbox.io/ygkn/gh_cliをCursor_Agentに実行させると動かない)
export GH_PAGER=""

eval "$(starship init zsh)"
eval "$(sheldon source)"

zsh-defer source "${DOTFILES_ROOT:-$HOME/dotfiles}/zsh/alias.zsh"
zsh-defer source "${DOTFILES_ROOT:-$HOME/dotfiles}/zsh/local.zsh"

zsh-defer zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[-_./]=**' 'l:|=* r:|=*' # fuzzy matching

# Ctrl + F to edit the current command line in $EDITOR
export EDITOR="nvim"
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

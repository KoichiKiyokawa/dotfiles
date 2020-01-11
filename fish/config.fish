# ------------------------------------------------------------------------------
# 環境変数
# ------------------------------------------------------------------------------
source ~/.config/fish/env.fish

# ------------------------------------------------------------------------------
# エイリアス
# ------------------------------------------------------------------------------
# ll
alias ll='ls -al'

# use nvim instead of vim
alias v='nvim'

alias x='exit'

# Docker関連
alias dc='docker-compose'
alias dpa='docker ps -a'

# Maven関連
alias mcc='mvn clean compile'
alias mcct='mvn clean compile test'

# Postgres関連
alias pgc='pg_ctl -D /usr/local/var/postgres'

# Rails関連
alias be='bundle exec'
alias br='bin/rails'
alias rs='bundle exec rails s'
alias rc='bin/rails c'
alias rami='bundle exec rake db:migrate'

# git関連
alias gb='git branch'
alias gc='git checkout'
alias gf='git fetch'
alias gl='git log --oneline'
alias gll='git log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s"'
alias gs='git status'
alias gp='git push -u origin HEAD'
alias ga='git add'
alias gm='git commit'
alias gr='git rebase'
alias gac='git add -A; git commit -m'
alias gst='git stash'
alias t='tig'
alias gn='git-now --all'

function gd
	git diff origin/{$argv}..HEAD
end

function gri
	git rebase -i HEAD~{$argv}
end

# ------------------------------------------------------------------------------
# カラー設定
# ------------------------------------------------------------------------------
# ls のファイル名を青色から緑色に変更
set -x LSCOLORS  cxfxcxdxbxegedabagacad

# ------------------------------------------------------------------------------
# pecoの設定
# ------------------------------------------------------------------------------
function fish_user_key_bindings
  bind \cr peco_select_history # Ctrl + R
end

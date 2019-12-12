# ----------------------------------------------------
# 環境変数
# ----------------------------------------------------

# Python
# set -x  PYENV_ROOT $HOME/.pyenv
# set -x  PATH $PYENV_ROOT/shims $PATH
# eval (pyenv init - | source)

# Ruby
status --is-interactive; and source (rbenv init -|psub)

# Java
set -x JAVA_HOME (/usr/libexec/java_home  -v 1.8)
set -x PATH $JAVA_HOME/bin $PATH

# Go
set -x GOPATH $HOME/prg/go

# Flutter
set -x PATH $HOME/flutter/bin $PATH

# ----------------------------------------------------
# エイリアス
# ----------------------------------------------------

# ll
alias ll='ls -al'

# use nvim instead of vim
alias v='nvim'

alias x='exit'

# fzf
alias f='history | fzf'

# robee関連
alias cr='cd ~/robee'
alias crs='cd ~/robee-setting'

# kolony関連
alias kolony='code ~/prg/macbee/kolony-frontend; code ~/prg/macbee/kolony-backend'

# Docker関連
alias dc='docker-compose'
alias dpa='docker ps -a'
alias dcb='docker-compose run --rm robee bash'
alias dct='docker-compose run --rm robee env RAILS_ENV=test bash'

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

function gd
	git diff origin/{$argv}..HEAD
end


function gri
	git rebase -i HEAD~{$argv}
end


# -------------------
# カラー設定
# -------------------
# ls のファイル名を青色から緑色に変更
set -x LSCOLORS  cxfxcxdxbxegedabagacad


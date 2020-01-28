# ------------------------------------------------------------------------------
# 環境変数
# ------------------------------------------------------------------------------
source ~/.config/fish/env.fish

# ------------------------------------------------------------------------------
# エイリアス
# ------------------------------------------------------------------------------
# ll
abbr -a ll ls -al

# use nvim instead of vim
abbr -a v nvim

abbr -a x exit

# Docker関連
abbr -a dc docker-compose
abbr -a dpa docker ps -a

# Postgres関連
abbr -a pgc pg_ctl -D /usr/local/var/postgres

# Rails関連
abbr -a be bundle exec
abbr -a br bin/rails
abbr -a rs bundle exec rails s
abbr -a rc bin/rails c
abbr -a rami bundle exec rake db:migrate

# git関連
abbr -a g git
abbr -a gb git branch
abbr -a gc git checkout
abbr -a gf git fetch
abbr -a gl git log --oneline
abbr -a gll "git log --graph --all --format='%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s'"
abbr -a gs git status
abbr -a gp git push -u origin HEAD
abbr -a ga git add
abbr -a gm git commit
abbr -a gr git rebase
abbr -a gac "git add -A; git commit -m"
abbr -a gst git stash
abbr -a t tig
abbr -a gn git-now --all
abbr -a gnr git-now rebase
abbr -a gri git rebase -i HEAD~

function gd
	git diff origin/{$argv}..HEAD
end

# function gri
# 	git rebase -i HEAD~{$argv}
# end

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

# ------------------------------------------------------------------------------
# Ctrl + Fで入力中のコマンドをneovimで編集する
# ------------------------------------------------------------------------------
bind \cf edit_command_buffer
set EDITOR nvim

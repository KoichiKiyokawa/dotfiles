abbr -a ll ls -alh
abbr -a op open .
abbr -a rf rm -rf
abbr -a w cd ~/workspace

# cd
alias ...="cd ../.."

# gcp cli
abbr -a gci gcloud compute instances

# use nvim instead of vim
abbr -a v nvim

abbr -a x exit

# Docker関連
abbr -a dc docker compose
abbr -a dpa docker ps -a

# Postgres関連
abbr -a pgc pg_ctl -D /usr/local/var/postgres

# Rails関連
abbr -a be bundle exec
abbr -a br bin/rails
abbr -a rs bundle exec rails s
abbr -a rc bin/rails c
abbr -a rami bundle exec rake db:migrate
abbr -a ramis bundle exec rake db:migrate:status

# git関連
abbr -a g git
abbr -a gb git branch
abbr -a gbD "git branch | xargs git branch -D"
abbr -a gc git checkout
abbr -a gcb git checkout -b
# delete local branch if remote is deleted
abbr -a gf git fetch -p
abbr -a gl git log --oneline
abbr -a gll "git log --graph --all --format='%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s'"
abbr -a gs git status
abbr -a gp git push -u origin HEAD
abbr -a gpf git push -u origin HEAD --force-with-lease
abbr -a ga git add
abbr -a gm git commit
abbr -a gr git rebase
abbr -a gac "git add -A; git commit -m"
abbr -a gt "git add -A; git commit -m 'temporary commit'"
abbr -a gst git stash -u
abbr -a gstl git stash list
abbr -a gstp git stash pop
abbr -a gme git merge -Xignore-all-space

# gh
abbr -a repo gh repo view --web
abbr -a pr gh pr view --web
abbr -a prc gh pr checkout
abbr -a prcr gh pr create -w
abbr -a pra gh pr review -a

# lazy関連
abbr -a lg lazygit
abbr -a ld lazydocker

# node
abbr -a nr npm run
abbr -a ni npm install
abbr -a nrl npm run lint

abbr -a y yarn
abbr -a ya yarn add
abbr -a yd yarn dev
abbr -a yl yarn lint

abbr -a pn pnpm
abbr -a pni pnpm i

# golang
abbr -a gg go generate ./...

# editor
abbr -a co code .

# aws
abbr -a aws-mfa source ~/dotfiles/scripts/aws-mfa.fish

# scripts
abbr -a gho sh ~/dotfiles/scripts/gh-extra.sh open
abbr -a gha sh ~/dotfiles/scripts/gh-extra.sh approve

function gd
  git diff origin/{$argv}..HEAD
end

# incremental search for `git checkout`
function gco
  git branch -a --sort=-authordate | grep -v -e '->' -e '*' | perl -pe 's/^\h+//g' | perl -pe 's#^remotes/origin/###' | perl -nle 'print if !$c{$_}++' | peco | xargs git checkout
end

# incremental search for `gh pr checkout`
function pro
  gh pr list | peco | awk '{print $1}' | xargs gh pr checkout
end

# mkdirしたディレクトリにそのまま移動する https://qiita.com/piruty/items/20780a17c8a9fd04ba41
function mkcd
  if test (count $argv) -eq 0
    echo "Pass dir name"
    return 1
  end

  set dirname $argv[1]
  mkdir -p $dirname
  eval "cd" $dirname
end

# 指定した port のプロセスを kill する
function killport
  set port $argv[1]
  set pid (lsof -ti:$port)
  if test -n "$pid"
    kill $pid
  else
    echo "port $port has already opened."
  end
end

abbr add ll="ls -alh"
abbr add op="open ."
abbr add rf="rm -rf"
alias w="cd ~/workspace"

# cd
alias ..="cd .."
alias ...="cd ../.."

# use nvim instead of vim
abbr add v="nvim"

abbr add x="exit"

# Docker関連
abbr add dc="docker compose"
abbr add dpa="docker ps -a"

# git関連
abbr add g="git"
abbr add gb="git branch"
abbr add gbD="git branch | xargs git branch -D"
abbr add gc="git checkout"
abbr add gcb="git checkout -b"
# delete local branch if remote is deleted
abbr add gf="git fetch -p"
abbr add gl="git log --oneline"
abbr add gll="git log --graph --all --format='%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s'"
abbr add gs="git status"
abbr add gp="git push -u origin HEAD"
abbr add gpn="git push -u origin HEAD --no-verify"
abbr add gpu="git pull"
abbr add gpf="git push -u origin HEAD --force-with-lease"
abbr add gpfn="git push -u origin HEAD --force-with-lease --no-verify"
abbr add ga="git add"
abbr add gm="git commit"
abbr add gr="git rebase"
abbr add gac="git add -A; git commit -m"
abbr add gt="git add -A; git commit -m 'temporary commit'"
abbr add gst="git stash -u"
abbr add gstl="git stash list"
abbr add gstp="git stash pop"
abbr add gme="git merge -Xignore-all-space"

abbr add m="make"

# gh
abbr add repo="gh repo view --web"
abbr add pr="gh pr view --web"
abbr add prc="gh pr checkout"
abbr add prcr="gh pr create -w"
abbr add pra="gh pr review -a"

# lazy関連
abbr add lg="lazygit"
abbr add ld="lazydocker"

# Node.js
abbr add pn="pnpm"
abbr add nr="ni run"

# golang
abbr add gg="go generate ./..."

# editor
abbr add co="code ."

# incremental search for `git checkout`
gco() {
  git branch -a --sort=-authordate | grep -v -e '->' -e '*' | perl -pe 's/^\h+//g' | perl -pe 's#^remotes/origin/###' | perl -nle 'print if !$c{$_}++' | peco | xargs git checkout
}

# incremental search for `gh pr checkout`
pro() {
  gh pr list | peco | awk '{print $1}' | xargs gh pr checkout
}

# mkdirしたディレクトリにそのまま移動する https://qiita.com/piruty/items/20780a17c8a9fd04ba41
mkcd() {
  if [ $# -eq 0 ]; then
    echo "Pass dir name"
    return 1
  fi

  dirname="$1"
  mkdir -p "$dirname"
  cd "$dirname"
}

# 指定した port のプロセスを kill する
killport() {
  port="$1"
  pid=$(lsof -ti:$port)
  if [ -n "$pid" ]; then
    kill "$pid"
  else
    echo "Port $port is not being used."
  fi
}

abbr --quiet ll="ls -alh"
abbr --quiet op="open ."
abbr --quiet rf="rm -rf"
alias w="cd ~/workspace"

# cd
alias ..="cd .."
alias ...="cd ../.."

# use nvim instead of vim
abbr --quiet v="nvim"

abbr --quiet x="exit"

# Docker関連
abbr --quiet dc="docker compose"
abbr --quiet dpa="docker ps -a"

# git関連
abbr --quiet g="git"
abbr --quiet gb="git branch"
abbr --quiet gbD="git branch | xargs git branch -D"
abbr --quiet gc="git checkout"
abbr --quiet gcb="git checkout -b"
# delete local branch if remote is deleted
abbr --quiet gf="git fetch -p"
abbr --quiet gl="git log --oneline"
abbr --quiet gll="git log --graph --all --format='%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s'"
abbr --quiet gs="git status"
abbr --quiet gp="git push -u origin HEAD"
abbr --quiet gpn="git push -u origin HEAD --no-verify"
abbr --quiet gpu="git pull"
abbr --quiet gpf="git push -u origin HEAD --force-with-lease"
abbr --quiet gpfn="git push -u origin HEAD --force-with-lease --no-verify"
abbr --quiet ga="git add"
abbr --quiet gm="git commit"
abbr --quiet gr="git rebase"
abbr --quiet gac="git add -A; git commit -m"
abbr --quiet gt="git add -A; git commit -m 'temporary commit'"
abbr --quiet gst="git stash -u"
abbr --quiet gstl="git stash list"
abbr --quiet gstp="git stash pop"
abbr --quiet gme="git merge -Xignore-all-space"

abbr --quiet m="make"

# gh
abbr --quiet repo="gh repo view --web"
abbr --quiet pr="gh pr view --web"
abbr --quiet prc="gh pr checkout"
abbr --quiet prcr="gh pr create -w"
abbr --quiet pra="gh pr review -a"

# lazy関連
abbr --quiet lg="lazygit"
abbr --quiet ld="lazydocker"

abbr --quiet pn="pnpm"

# golang
abbr --quiet gg="go generate ./..."

# editor
abbr --quiet co="code ."

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

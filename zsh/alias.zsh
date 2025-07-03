abbr --session ll="ls -alh"
abbr --session rf="rm -rf"
alias w="cd ~/workspace"

# cd
alias ..="cd .."
alias ...="cd ../.."

# use nvim instead of vim
abbr --session v="nvim"

abbr --session x="exit"

alias cleanup="curl -s https://raw.githubusercontent.com/mac-cleanup/mac-cleanup-sh/53b2c24/mac-cleanup | bash"

# Docker関連
abbr --session --force dc="docker compose"
abbr --session dpa="docker ps -a"

# git関連
abbr --session g="git"
abbr --session gb="git branch"
abbr --session gbD="git branch | xargs git branch -D"
abbr --session gc="git checkout"
abbr --session gcb="git checkout -b"
# delete local branch if remote is deleted
abbr --session gf="git fetch -p"
abbr --session gl="git log --oneline"
abbr --session gll="git log --graph --all --format='%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s'"
abbr --session gs="git status"
abbr --session gp="git push -u origin HEAD"
abbr --session gpn="git push -u origin HEAD --no-verify"
abbr --session gpu="git pull"
abbr --session gpf="git push -u origin HEAD --force-with-lease"
abbr --session gpfn="git push -u origin HEAD --force-with-lease --no-verify"
abbr --session ga="git add"
abbr --session gm="git commit"
abbr --session gr="git rebase"
abbr --session gac="git add -A; git commit -m"
abbr --session gt="git add -A; git commit -m 'temporary commit'"
abbr --session gw="git worktree"
abbr --session gst="git stash -u"
abbr --session gstl="git stash list"
abbr --session gstp="git stash pop"
abbr --session gme="git merge -Xignore-all-space"

abbr --session m="make"

# gh
abbr --session repo="gh repo view --web"
abbr --session --force pr="gh pr view --web"
abbr --session prc="gh pr checkout"
abbr --session prcr="gh pr create -w"
abbr --session pra="gh pr review -a"

# lazy関連
abbr --session lg="lazygit"
abbr --session ld="lazydocker"

# Node.js
abbr --session pn="pnpm"

# golang
abbr --session gg="go generate ./..."

# editor
abbr --session co="code ."
abbr --session e="cursor ."

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

# 与えられた命名でworktreeを追加し、cursorで開く
ew() {
  task_name="$1"
  if [ -z "$task_name" ]; then
    echo "Usage: ew <task-name>"
    return 1
  fi

  local worktree_dir="../${PWD##*/}-$task_name"
  mkdir -p "$worktree_dir"

  # 同名のタスクのworktreeがすでに存在していたら再利用
  local existing_worktree=$(git worktree list | grep $(realpath "$worktree_dir") | awk '{print $1}')
  if [ -n "$existing_worktree" ]; then
    echo "Worktree for task '$task_name' already exists at $existing_worktree"
    cursor "$existing_worktree"
    return 0
  fi

  git worktree add --detach "$worktree_dir"
  cursor "$worktree_dir"
}

# GitHub PRをGit Worktreeとしてチェックアウトする
prw() {
  if [ -z "$1" ]; then
    echo "Usage: prw <PR number or GitHub PR URL>"
    return 1
  fi

  local branch_name=$(gh pr view $1 --json headRefName -q .headRefName)
  local worktree_dir="../${PWD##*/}-${branch_name//\//-}"
  mkdir -p "$worktree_dir"

  # 同名のブランチのworktreeがすでに存在していたら再利用
  local existing_worktree=$(git worktree list | grep "\[$branch_name\]" | awk '{print $1}')
  if [ -n "$existing_worktree" ]; then
    echo "Worktree for branch '$branch_name' already exists at $existing_worktree"
    cursor "$existing_worktree"
    return 0
  fi

  echo "Creating worktree at $worktree_dir..."
  git fetch origin "$branch_name"
  git worktree add "$worktree_dir" "$branch_name" || return 1

  cursor "$worktree_dir"
}

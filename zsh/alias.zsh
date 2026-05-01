alias w="cd ~/workspace"

# cd
alias ..="cd .."
alias ...="cd ../.."

alias cleanup="curl -s https://raw.githubusercontent.com/mac-cleanup/mac-cleanup-sh/53b2c24/mac-cleanup | bash"

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
  pids=("${(@f)$(lsof -ti:$port)}")  # 改行区切りを配列化

  if (( ${#pids[@]} > 0 )); then
    kill $pids    # 配列を展開して複数 PID を kill
    echo "Killed PIDs: ${pids[@]}"
  else
    echo "Port $port is not being used."
  fi
}


#----------------------------
# git worktreeの操作

# 与えられた命名でworktreeを追加する
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
    cd "$existing_worktree"
    return 0
  fi

  git worktree add --detach "$worktree_dir"
  cd "$worktree_dir"
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
    cd "$existing_worktree"
    return 0
  fi

  echo "Creating worktree at $worktree_dir..."
  git fetch origin "$branch_name"
  git worktree add "$worktree_dir" "$branch_name" || return 1

  cd "$worktree_dir"
}

# git worktree remove + directory delete
gwr() {
  if [[ -z $1 ]]; then
    echo "Usage: gwr <worktree-path>"
    return 1
  fi

  local wt=$1

  if [[ ! -d $wt ]]; then
    echo "Error: '$wt' does not exist or is not a directory."
    return 1
  fi

  # ワークツリー解除
  echo "Removing worktree metadata for: $wt"
  if git worktree remove --force "$wt"; then
    # ディレクトリ削除
    echo "Deleting directory: $wt"
    rm -rf -- "$wt"
    echo "Done."
  else
    echo "Failed to remove worktree. Directory not deleted."
    return 1
  fi
}

#----------------------------

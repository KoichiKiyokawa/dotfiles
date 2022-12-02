cd "$(dirname "$0")"
. ./env.sh

action=$1
targetPullRequestURL=$2
parsed=($(echo $targetPullRequestURL | perl -pe 's|.+?com/.+?/(.+?)/pull/(\d+).*|$1 $2|'))
repo=${parsed[0]}
prNo=${parsed[1]}

cdToRepoPath $repo

if ! git diff --exit-code --quiet; then
  echo "\n[ERROR] There are uncommitted changes in the repo. Please stash or commit them first.\n"
  exit 1
fi

case $action in
  "open") gh pr checkout $prNo && code . ;;
  "approve") gh pr review -a $prNo ;;
esac
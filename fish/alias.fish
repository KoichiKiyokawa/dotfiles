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
abbr -a ramis bundle exec rake db:migrate:status

# git関連
abbr -a g git
abbr -a gb git branch
abbr -a gc git checkout
# delete local branch if remote is deleted
abbr -a gf git fetch -p
abbr -a gl git log --oneline
abbr -a gll "git log --graph --all --format='%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s'"
abbr -a gs git status
abbr -a gp git push -u origin HEAD
abbr -a ga git add
abbr -a gm git commit
abbr -a gr git rebase
abbr -a gac "git add -A; git commit -m"
abbr -a gt "git add -A; git commit -m 'temporary commit'"
abbr -a gst git stash -u
abbr -a gstl git stash list
abbr -a gstp git stash pop

# lazy関連
abbr -a lg lazygit
abbr -a ld lazydocker

# node
abbr -a nr npm run

# ffmpeg
abbr -a ff 'ffmpeg -filter_complex "[0:v] fps=60,scale=640:-1,split [a][b];[a] palettegen [p];[b][p] paletteuse=dither=none, setpts=PTS/2" -i'

function gd
  git diff origin/{$argv}..HEAD
end

# run a slide tool
function rev
  docker run --rm -itp "10000:10000" -p "35729:35729" -v (pwd):/app qwerty3141/reveal-ck
end

# incremental search for `git checkout`
function gco
  git branch -a --sort=-authordate | grep -v -e '->' -e '*' | perl -pe 's/^\h+//g' | perl -pe 's#^remotes/origin/###' | perl -nle 'print if !$c{$_}++' | peco | xargs git checkout
end

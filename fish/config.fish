# ------------------------------------------------------------------------------
# 環境変数
# ------------------------------------------------------------------------------
source ~/.config/fish/env.fish

# ------------------------------------------------------------------------------
# エイリアス
# ------------------------------------------------------------------------------
source ~/.config/fish/alias.fish

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

fnm env --use-on-cd --corepack-enabled | source

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

# local
if test -e ~/.config/fish/local.fish
  source ~/.config/fish/local.fish
end
# pnpm
set -gx PNPM_HOME "/Users/koichi/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
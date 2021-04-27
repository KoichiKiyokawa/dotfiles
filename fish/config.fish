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

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

# ------------------------------------------------------------------------------
# 環境変数
# ------------------------------------------------------------------------------

# Python
# set -x  PYENV_ROOT $HOME/.pyenv
# set -x  PATH $PYENV_ROOT/shims $PATH
# eval (pyenv init - | source)

# Ruby
status --is-interactive; and source (rbenv init -|psub)
set -x OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES

# Java
set -x JAVA_HOME (/usr/libexec/java_home  -v 1.8)
set -x PATH $JAVA_HOME/bin $PATH

# Go
set -x GOPATH $HOME/prg/go

# Flutter
set -x PATH $HOME/flutter/bin $PATH

# nodebrew
set -x PATH $HOME/.nodebrew/current/bin $PATH

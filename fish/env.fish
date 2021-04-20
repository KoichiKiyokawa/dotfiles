# ------------------------------------------------------------------------------
# 環境変数
# ------------------------------------------------------------------------------

# M1
eval (/opt/homebrew/bin/brew shellenv)

# Python
# set -x  PYENV_ROOT $HOME/.pyenv
# set -x  PATH $PYENV_ROOT/shims $PATH
# status --is-interactive; and source (pyenv init -|psub)

# Ruby
# status --is-interactive; and source (rbenv init -|psub)
# set -x OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES

# Java
set -x JAVA_HOME (/usr/libexec/java_home)
set -x PATH $JAVA_HOME/bin $PATH

# Go
# set -x GOENV_ROOT $HOME/.goenv
# set -x PATH $GOENV_ROOT/bin $PATH
# eval (goenv init - | source)
set -x PATH $GOPATH/bin $PATH

# Flutter
set -x PATH $HOME/flutter/bin $PATH

# android
# set -x ANDROID_HOME /usr/local/share/android-sdk
# set -x ANDROID_SDK_ROOT /usr/local/share/android-sdk
# set -x ANDROID_HOME /usr/local/share/android-sdk
# set -x ANDROID_SDK_ROOT /usr/local/share/android-sdk

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/koichi/google-cloud-sdk/path.fish.inc' ]; . '/Users/koichi/google-cloud-sdk/path.fish.inc'; end

# volta: node version tool
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH


# ------------------------------------------------------------------------------
# 環境変数
# ------------------------------------------------------------------------------

# M1
eval (/opt/homebrew/bin/brew shellenv)

# Python
set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
status is-login; and pyenv init --path | source
pyenv init - | source

# Ruby
status --is-interactive; and source (rbenv init -|psub)
# set -x OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES
set -x PATH /opt/homebrew/lib/ruby/gems/2.7.0/bin $PATH

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


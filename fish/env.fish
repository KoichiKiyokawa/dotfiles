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
rvm default

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

# Rust
source $HOME/.cargo/env

# android
# set -x ANDROID_HOME /usr/local/share/android-sdk
# set -x ANDROID_SDK_ROOT /usr/local/share/android-sdk
# set -x ANDROID_HOME /usr/local/share/android-sdk
# set -x ANDROID_SDK_ROOT /usr/local/share/android-sdk

source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"


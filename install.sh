#!/usr/bin/env bash

# 未定義な変数があったら途中で終了する
set -u

# 今のディレクトリ
# dotfilesディレクトリに移動する
BASEDIR=$(dirname $0)
cd $BASEDIR

# シンボリックリンクを貼る
ln -snfv ${PWD}/.zshrc ~/
ln -snfv ${PWD}/.gitconfig ~/
ln -snfv ${PWD}/.zsh ~/
ln -snfv ${PWD}/.config/kitty ~/.config
ln -snfv ${PWD}/.hammerspoon ~/
ln -snfv ${PWD}/.hyper.js ~/

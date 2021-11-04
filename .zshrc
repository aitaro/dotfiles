# alias
alias ll="ls -alF"
alias relogin='exec $SHELL -l'
alias dc="docker-compose"

# pathの設定
export PATH="$PATH:`pwd`/flutter/bin"

# zplug
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

## ここにpluginを追加
zplug "b4b4r07/enhancd", use:init.sh

## 未インストール項目をインストールする
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

## コマンドをリンクして、PATH に追加し、プラグインは読み込む
zplug load --verbose



# 　各種インストール用
eval "$(/opt/homebrew/bin/brew shellenv)"
. /opt/homebrew/opt/asdf/libexec/asdf.sh
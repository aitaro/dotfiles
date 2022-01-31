# alias
alias ll="ls -alF"
alias relogin='exec $SHELL -l'
alias dc="docker-compose"
alias dce="docker-compose exec"
alias emulator="/Users/aitaro/Library/Android/sdk/emulator/emulator"

# state保存したままだとバグるのでデータリセットして起動する
alias android="emulator @Pixel_4_API_32 -wipe-data"

# 環境変数の設定
export PATH="$PATH:/Users/aitaro/development/flutter/bin:$HOME/.pub-cache/bin"
export GOPRIVATE=github.com/uzuPJ/protos

# zplug
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

## ここにpluginを追加
zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "zsh-users/zsh-syntax-highlighting", defer:2

## 未インストール項目をインストールする
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

## コマンドをリンクして、PATH に追加し、プラグインは読み込む
zplug load # --verbose

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# 補完
autoload -U compinit
compinit

# kubectl の補完
source <(kubectl completion zsh)

# 　各種インストール用
eval "$(/opt/homebrew/bin/brew shellenv)"
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# GCloud
export CLOUDSDK_PYTHON="/usr/bin/python"
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/aitaro/development/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/aitaro/development/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/aitaro/development/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/aitaro/development/google-cloud-sdk/completion.zsh.inc'; fi

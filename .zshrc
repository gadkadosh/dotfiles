#!/usr/bin/env zsh
export CLICOLOR=true            # Enable colors for 'ls' (macOS)
export HISTSIZE=10000
export SAVEHIST=10000

bindkey '^[[Z' reverse-menu-complete    # Shift-tab
bindkey -v
bindkey jj vi-cmd-mode

# Arrows search history
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^P' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search

# setopt appendhistory
setopt incappendhistory
setopt autocd
setopt extendedhistory
setopt histexpiredupsfirst
setopt histfindnodups
setopt histignoredups
setopt histignorespace
setopt histverify

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors 'di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

if type brew &>/dev/null
then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

autoload -Uz compinit
compinit

# Frecency based directory switching
# [ -f /usr/local/etc/profile.d/z.sh ] && source /usr/local/etc/profile.d/z.sh
export _ZO_FZF_OPTS="--height 40% --reverse --no-sort"
eval "$(zoxide init zsh)"

# Load fzf tab completion and key bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $HOME/.env
source $HOME/.aliases

# Starship
eval "$(starship init zsh)"

# zsh autosuggestions (brew install zsh-autosuggestions)
[ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh syntax highlighting (brew install zsh-syntax-highlighting)
[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

#!/usr/bin/env zsh
# If tmux is available start a session or attach to an existing one
if  [[ $(command -v tmux) ]] &&
  [[ "$SSH_CONNECTION" == "" ]] &&
  [[ -z "$TMUX" ]]; then
  exec tmux new -A -s base
fi

# Antigen
if [[ -f /usr/local/share/antigen/antigen.zsh ]]; then
  source /usr/local/share/antigen/antigen.zsh

  antigen bundle mafredri/zsh-async               # async support for pure
  antigen bundle sindresorhus/pure                # A minimal theme
  antigen bundle zsh-users/zsh-autosuggestions    # Autosuggestions
  antigen bundle zdharma/fast-syntax-highlighting # Syntax highlighting
  antigen apply
fi

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

bindkey -e                              # Emacs style bindings
bindkey '^[[Z' reverse-menu-complete    # Shift-tab for moving backwards in menus

# Arrows search history
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^P' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search

setopt appendhistory
setopt autocd
setopt extendedhistory
setopt histexpiredupsfirst
setopt histfindnodups
setopt histignoredups
setopt histignorespace
setopt histverify
setopt incappendhistory
setopt interactivecomments
setopt sharehistory

# Show a menu for completions
zstyle ":completion:*" menu select
# Case insensitive autocomplete
zstyle ":completion:*" matcher-list "" "m:{a-zA-Z}={A-Za-z}"
# Completion colors: empty string ("") would use the shell's defaults ($LSCOLORS), but ZSH doesn't support BSD style $LSCOLORS so here is the equivalent in Linux style $LS_COLORS
zstyle ":completion:*" list-colors "di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# Frecency based directory switching
[ -f /usr/local/etc/profile.d/z.sh ] && source /usr/local/etc/profile.d/z.sh

# Load fzf tab completion and key bindings
[ $(command -v fzf) ] && [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $HOME/.env
source $HOME/.aliases

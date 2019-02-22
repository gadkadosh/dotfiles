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

# History
export HISTFILE=$HOME/.zsh_history      # History file
export HISTSIZE=10000                   # Maximum number of events stored internally
export SAVEHIST=10000                   # Maximum number of events stored in the file

# Bindkey
bindkey -e                              # Emacs style bindings
bindkey ' ' magic-space                 # Magic space for history expansion
bindkey ^r history-incremental-search-backward # History search
bindkey "^[[3~" delete-char             # Delete key
bindkey ^u backward-kill-line           # Delete from cursor to beginning
bindkey '^[[Z' reverse-menu-complete    # Shift-tab for moving backwards in menus

# Up/Down arrows history search
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^[[A' history-beginning-search-backward-end
bindkey '^[[B' history-beginning-search-forward-end

# Options
setopt appendhistory
setopt autocd
setopt autopushd
setopt extendedhistory
setopt histexpiredupsfirst
setopt histfindnodups
setopt histignoredups
setopt histignorespace
setopt histverify
setopt incappendhistory
setopt interactivecomments
setopt pushdignoredups
setopt sharehistory

# Show a menu for completions
zstyle ":completion:*" menu select
# Case insensitive autocomplete
zstyle ":completion:*" matcher-list "" "m:{a-zA-Z}={A-Za-z}"
# Completion colors: empty string ("") would use the shell's defaults ($LSCOLORS),
# but zsh doesn't support BSD style $LSCOLORS so here is the equivalent in Linux style $LS_COLORS
zstyle ":completion:*" list-colors "di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# Frecency based directory switching
[ -f /usr/local/etc/profile.d/z.sh ] && source /usr/local/etc/profile.d/z.sh

# Load fzf tab completion and key bindings
[ $(command -v fzf) ] && [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $HOME/.shell/env
source $HOME/.shell/aliases
source $HOME/.shell/functions
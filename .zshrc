export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=50000

export EDITOR=nvim
# i: case-insensitive searches, unless uppercase characters in search string
# R: raw output, to allow ANSI colors
# M: verbose prompt, line numbers/percentage
export LESS='-iRM'
export PSQL_PAGER="pspg -X -b"
export MANPAGER='nvim +Man!' # Man pages with vim

export CLICOLOR=1            # Enable colors for 'ls' (macOS)

# Shift-tab
bindkey '^[[Z' reverse-menu-complete

# Arrows search history
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search edit-command-line
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N edit-command-line

bindkey '^X^E' edit-command-line
bindkey '^[[A' up-line-or-beginning-search
bindkey '^P' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search
bindkey -M viins '^[b' backward-word
bindkey -M viins '^[f' forward-word

# setopt appendhistory
setopt incappendhistory
setopt extendedhistory
setopt histexpiredupsfirst
setopt histfindnodups
setopt histignoredups
setopt histignorespace
setopt histverify
setopt sharehistory

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors 'di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

autoload -Uz compinit; compinit

# Load fzf tab completion and key bindings
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
source /opt/homebrew/opt/fzf/shell/completion.zsh
# FZF using fd instead of find (respects .gitignore)
export FZF_DEFAULT_COMMAND='fd --type f'

source $HOME/.aliases

# Starship
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# zsh autosuggestions (brew install zsh-autosuggestions)
[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh syntax highlighting (brew install zsh-syntax-highlighting)
[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#compdef opencode
###-begin-opencode-completions-###
#
# yargs command completion script
#
# Installation: opencode completion >> ~/.zshrc
#    or opencode completion >> ~/.zprofile on OSX.
#
_opencode_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" opencode --get-yargs-completions "${words[@]}"))
  IFS=$si
  if [[ ${#reply} -gt 0 ]]; then
    _describe 'values' reply
  else
    _default
  fi
}
if [[ "'${zsh_eval_context[-1]}" == "loadautofunc" ]]; then
  _opencode_yargs_completions "$@"
else
  compdef _opencode_yargs_completions opencode
fi
###-end-opencode-completions-###

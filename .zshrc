export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=50000

export PATH="$PATH:$HOME/go/bin:$HOME/Code/scripts"

export EDITOR=nvim
# i: case-insensitive searches, unless uppercase characters in search string
# R: raw output, to allow ANSI colors
# M: verbose prompt, line numbers/percentage
export LESS='-iRM'
export PSQL_PAGER="pspg -X -b"
export MANPAGER='nvim +Man!' # Man pages with vim

export CLICOLOR=1            # Enable colors for 'ls' (macOS)

# Use Emacs-style shell shortcuts, regardless of $EDITOR.
bindkey -e

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

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors 'di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

autoload -Uz compinit; compinit

# Load fzf tab completion and key bindings
source <(fzf --zsh)
# FZF using fd instead of find (respects .gitignore)
export FZF_DEFAULT_COMMAND='fd --type f'

source $HOME/.aliases

wt() {
  local dir
  dir=$(git worktree list --porcelain |
    awk '
      /^worktree / { dir = substr($0, 10); branch = "(detached HEAD)" }
      /^branch / { branch = substr($0, 8); sub(/^refs\/heads\//, "", branch) }
      /^bare$/ { branch = "(bare)" }
      /^$/ {
        dirs[++count] = dir
        branches[count] = branch
        if (length(dir) > width) width = length(dir)
      }
      END {
        for (i = 1; i <= count; i++)
          printf "%s\t%-*s  %s\n", dirs[i], width, dirs[i], branches[i]
      }
    ' |
    fzf --delimiter=$'\t' --with-nth=2 --height=40% --reverse --border) || return
  cd "${dir%%$'\t'*}"
}

# Starship
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

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

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# History
export HISTFILE=~/.bash_history
export HISTSIZE=100000
export HISTFILESIZE=100000

# bash completion
if [[ -f /usr/local/etc/bash_completion ]]; then
  source /usr/local/etc/bash_completion
fi

# git branch
parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo '*'
}

parse_git_branch() {
  git branch 2> /dev/null | sed -e "/^[^*]/ d" -e "s/* \(.*\)/${violet}${bold}\1$(parse_git_dirty)/"
}

bold=$(tput bold)
reset=$(tput sgr0)

# Solarized colors
black=$(tput setaf 0)
blue=$(tput setaf 33)
cyan=$(tput setaf 37)
green=$(tput setaf 64)
orange=$(tput setaf 166)
purple=$(tput setaf 125)
red=$(tput setaf 124)
violet=$(tput setaf 61)
white=$(tput setaf 15)
yellow=$(tput setaf 136)

# Prompt
PS1="\n\[${bold}\]\[${blue}\]\w \$(parse_git_branch)\n\[${reset}\]\[${purple}\]❯ \[${reset}\]"
export PS1

# Frecency based directory switching
[ -n /usr/local/etc/profile.d/z.sh ] && source /usr/local/etc/profile.d/z.sh

# Load fzf tab completion and key bindings
[ $(command -v fzf) ] && [ -f ~/.fzf.bash ] && source ~/.fzf.bash

source $HOME/.env
source $HOME/.aliases

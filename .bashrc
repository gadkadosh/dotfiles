export HISTSIZE=10000
export HISTFILESIZE=10000

if [[ -f /usr/local/etc/bash_completion ]]; then
  source /usr/local/etc/bash_completion
fi

git_prompt() {
  BRANCH=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ $(git status --short 2> /dev/null) ]]; then
    echo $BRANCH*
  else
    echo $BRANCH
  fi
}

bold=$(tput bold)
reset=$(tput sgr0)
blue=$(tput setaf 12)
grey=$(tput setaf 242)
magenta=$(tput setaf 13)

PS1="
\[${bold}\]\[${blue}\]\w \[${grey}\]\$(git_prompt)
\[${magenta}\]❯ \[${reset}\]"

[ -n /usr/local/etc/profile.d/z.sh ] && source /usr/local/etc/profile.d/z.sh

[ $(command -v fzf) ] && [ -f ~/.fzf.bash ] && source ~/.fzf.bash

source $HOME/.env
source $HOME/.aliases

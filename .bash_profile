eval "$(rbenv init -)"

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
export EDITOR="/usr/local/bin/code"

# bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# git branch
parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo [!]
}

parse_git_branch() {
    git branch 2> /dev/null | sed -e "/^[^*]/ d" -e "s/* \(.*\)/${reset}on ${bold}${violet}\1 $(parse_git_dirty)/"
}

get_git_info() {
    status=$(git status -sb 2> /dev/null)
    branch=$(echo $status | sed "s/## \([[:alnum:]][[:alnum:]]*\).*/${reset}on ${bold}${violet}\1/")
    echo $branch
}

# battery
battery() {
    battstat=$(pmset -g batt)
    
    time_left=$(echo $battstat | tail -n1 | cut -f2 | awk -F"; " '{print $3}' | cut -d' ' -f1)
    percentage=$(echo $battstat | tail -n1 | cut -f2 | awk -F"; " '{print $1}' | cut -d' ' -f8)

    if [[ $(pmset -g ac) == "No adapter attached." ]]
    then
        emoji='🔋'
    else
        emoji='🔌'
    fi

    if [[ $time_left == "(no" || $time_left == "not" ]]
    then
        time_left='⌛️'
    fi

    if [[ $time_left == *"0:00"* ]]
    then
        time_left='⚡️'
    fi

    echo "$emoji  $percentage  $time_left"
}

bold=$(tput bold)
reset=$(tput sgr0)

# Colors
# red=$(tput setaf 160)
# green=$(tput setaf 28) #28,64
# light_green=$(tput setaf 34) #40
# yellow=$(tput setaf 178) #3
# blue=$(tput setaf 12) #33
# orange=$(tput setaf 166)
# cyan=$(tput setaf 37)
# purple=$(tput setaf 135) #125
# violet=$(tput setaf 141) #61

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

# customizations
# PS1="\n$PROMPT_BOLD$PROMPT_GREEN\u@\h:$PROMPT_BLUE\W$ $PROMPT_RESET"
# PS1="$PROMPT_BOLD$PROMPT_GREEN\u@\h:$PROMPT_BLUE\W$ $PROMPT_RESET"
# PS1="\[${green}\]\u@\h: $PROMPT_BOLD$PROMPT_BLUE\w$PROMPT_LIGHT_GREEN\$(parse_git_branch)\n$PROMPT_BLUE$ $PROMPT_RESET"
# PS1="\[${bold}\]\[${green}\]\u\[${reset}\] in \[${bold}\]\[${blue}\]\W\[${light_green}\] \$(parse_git_branch)\n\[${reset}\]$ "
# PS1="\[${bold}\]\[${light_green}\]\u\[${reset}\] at \[${bold}\]\[${purple}\]\h\[${reset}\] in \[${bold}\]\[${blue}\]\W \$(parse_git_branch)\n\[${reset}\]$ "
PS1="\[${bold}\]\[${green}\]\u\[${reset}\] at \[${bold}\]\[${purple}\]\h\[${reset}\] in \[${bold}\]\[${blue}\]\W \$(parse_git_branch)\n\[${reset}\]$ "

export PS1
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad
# export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'
export GREP_OPTIONS='--color=always'

alias c="clear"
alias h="history"
alias j="jobs -l"
alias o="open ."

alias ..="cd .."
alias ...="cd ../.."
alias la="ls -a"
alias ll="ls -lh"
alias lla="ls -lha"
alias mkdir="mkdir -pv"
alias du="du -h"
alias less="less -r"

alias gs="git status -sb"

alias desktop="cd ~/Desktop"
alias downloads="cd ~/Downloads"
alias dropbox="cd ~/Dropbox"
alias programming="cd ~/Programming"
alias website="cd ~/Website/gadkadosh-jekyll"

alias showfiles="defaults write com.apple.finder AppleShowAllFiles YES && killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO && killall Finder"
alias emptytrash="rm -rf ~/.Trash/*"
alias ecbash="$EDITOR ~/.bash_profile"
alias reload="source ~/.bash_profile"
# alias battery="pmset -g batt"

#!/usr/bin/env zsh

export CLICOLOR=1
export EDITOR=code

if [[ ! -f ~/.antigen/antigen.zsh ]]; then
    mkdir -v ~/.antigen
    curl -L git.io/antigen > ~/.antigen/antigen.zsh
fi
source ~/.antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle colored-man-pages
# antigen bundle git
antigen bundle command-not-found
antigen bundle z
# antigen bundle zsh-users/zsh-history-substring-search
# antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

# antigen theme lambda
# antigen theme steeef

antigen apply

alias c="clear"
alias h="history"
alias hg="history | grep"
alias j="jobs -l"
alias u="users"
alias o="open ."

alias la="ls -a"
alias ll="ls -lh"
alias lla="ls -lha"
alias mkdir="mkdir -pv"
alias du="du -h"
alias less="less -r"

alias gs="git status -sb"

alias dotfiles="cd ~/dotfiles"
alias desktop="cd ~/Desktop"
alias downloads="cd ~/Downloads"
alias dropbox="cd ~/Dropbox"
alias programming="cd ~/Programming"
alias website="cd ~/Website/gadkadosh-jekyll"

alias showfiles="defaults write com.apple.finder AppleShowAllFiles YES && killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO && killall Finder"
alias emptytrash="rm -rf ~/.Trash/*"
alias zshrc="$EDITOR ~/.zshrc"
# alias ecbash="$EDITOR ~/.bash_profile"
# alias reload="source ~/.bash_profile"
alias reload="source ~/.zshrc"
# alias battery="pmset -g batt"

# dotfiles

These are my dotfiles and config files. Currently using MacOS, Homebrew, Vim/Neovim, tmux and ZSH with Antigen.

## Installation

```
alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
git clone --bare https://github.com/gadkadosh/dotfiles.git $HOME/.dotfiles
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```

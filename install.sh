#! /bin/sh

bluetext() { echo "$(tput bold)$(tput setaf 33)$*$(tput sgr 0)"; }

read -n 1 -p "Symlinking into home directory, this overwrites files. Proceed? " yn

[[ $yn != [Yy] ]] && echo "\n\nExiting..." && exit

echo "\ninstalling..."

dotfiles_dir=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
dotfiles=".bash_profile .gitconfig"

for dotfile in $dotfiles; do
    echo ${dotfiles_dir}/${dotfile}
    ln -svf ${dotfiles_dir}/${dotfile} ~
done

bluetext "\nYou should probably set username and email in ~/.gitconfig.local"

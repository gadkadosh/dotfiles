#! /bin/sh

bluetext() { echo "$(tput bold)$(tput setaf 33)$*$(tput sgr 0)"; }

read -n 1 -p "Symlinking into home directory, this overwrites files. Proceed? " yn

[[ $yn != [Yy] ]] && echo "\n\nExiting..." && exit

echo "\ninstalling..."

# Home directory dotfiles
dotfiles_dir=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
dotfiles=".bash_profile .inputrc .gitconfig"

for dotfile in $dotfiles; do
    # echo ${dotfiles_dir}/${dotfile}
    ln -svf ${dotfiles_dir}/${dotfile} ~
done

# Vscode settings - go in Application Support on MacOS
vscodefiles="settings.json keybindings.json snippets"
vscode_dir=$HOME/Library/Application\ Support/Code/User
for vscodefile in $vscodefiles; do
    # echo ${dotfiles_dir}/vscode/${vscodefile}
    ln -svf ${dotfiles_dir}/vscode/${vscodefile} "$vscode_dir"
done

bluetext "\nBrewfile is available to install all Homebrew packages"
bluetext "You should probably set username and email in ~/.gitconfig.local"

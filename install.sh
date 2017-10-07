#! /bin/sh

bluetext() { echo "$(tput bold)$(tput setaf 33)$*$(tput sgr 0)"; }

read -n 1 -p "Symlinking into home directory, this overwrites files. Proceed? " yn

[[ $yn != [Yy] ]] && echo "\n\nExiting..." && exit

echo "\ninstalling..."

# Home directory dotfiles
DOTFILES=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
dotfiles=".zshrc .bash_profile .inputrc .gitconfig"

for dotfile in $dotfiles; do
    # echo ${DOTFILES}/${dotfile}
    ln -svf ${DOTFILES}/${dotfile} ~
done

# vscode settings

if test "$(which code)"; then
	if [ "$(uname -s)" = "Darwin" ]; then
		VSCODE_HOME="$HOME/Library/Application Support/Code"
	else
		VSCODE_HOME="$HOME/.config/Code"
	fi

	ln -svf "$DOTFILES/vscode/settings.json" "$VSCODE_HOME/User/settings.json"
	ln -svf "$DOTFILES/vscode/keybindings.json" "$VSCODE_HOME/User/keybindings.json"
	ln -svf "$DOTFILES/vscode/snippets" "$VSCODE_HOME/User/snippets"

	# from `code --list-extensions`
	modules="
        EditorConfig.EditorConfig
        Zignd.html-css-class-completion
        christian-kohler.path-intellisense
        coderfee.open-html-in-browser
        dbaeumer.vscode-eslint
        donjayamanne.githistory
        donjayamanne.python
        emmanuelbeziat.vscode-great-icons
        qinjia.view-in-browser
        ritwickdey.LiveServer
        robertohuertasm.vscode-icons
        shinnn.stylelint
        zhuangtongfa.Material-theme
        "
	for module in $modules; do
		code --install-extension "$module" || true
	done
fi

# a few messages
bluetext "\nBrewfile is available to install all Homebrew packages"
bluetext "You should probably set username and email in ~/.gitconfig.local"

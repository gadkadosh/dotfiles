#! /bin/sh

# Home directory dotfiles
DOTFILES_DIR=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)

bluetext() {
    echo "$(tput bold)$(tput setaf 33)$*$(tput sgr 0)"
}


link_file() {
	if [ -e "$2" ]; then
		if [ "$(readlink "$2")" = "$1" ]; then
			echo "skipped $1"
			return 0
		else
			mv "$2" "$2.backup"
			echo "moved $2 to $2.backup"
		fi
	fi
	ln -sf "$1" "$2"
	echo "linked $1 to $2"
}

install_dotfiles() {
	bluetext 'Installing dotfiles'
	find -H "$DOTFILES_DIR" -maxdepth 3 -name '*.symlink' -not -path '*.git*' |
		while read -r src; do
			dst="$HOME/.$(basename "${src%.*}")"
			link_file "$src" "$dst"
		done
}

setup_vscode() {
    if test "$(which code)"; then
        bluetext "Setting up VSCode"
        if [ "$(uname -s)" = "Darwin" ]; then
            VSCODE_HOME="$HOME/Library/Application Support/Code"
        else
            VSCODE_HOME="$HOME/.config/Code"
        fi
        
        link_file "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_HOME/User/settings.json"
        link_file "$DOTFILES_DIR/vscode/keybindings.json" "$VSCODE_HOME/User/keybindings.json"
        link_file "$DOTFILES_DIR/vscode/snippets" "$VSCODE_HOME/User/snippets"

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
            streetsidesoftware.code-spell-checker
            zhuangtongfa.Material-theme
            "
        for module in $modules; do
            code --install-extension "$module" || true
        done
    fi
}

setup_gitconfig() {
	bluetext 'Setting up gitconfig'
    GITCONFIG_LOCAL="$HOME/.gitconfig.local"
	# if there is no user.email, we'll assume it's a new machine/setup and ask it
	if [ -z "$(git config --get --file ${GITCONFIG_LOCAL} user.email)" ]; then
		echo ' - What is your git author name?'
		read -r user_name
		echo ' - What is your git author email?'
		read -r user_email

		git config --file ${GITCONFIG_LOCAL} user.name "$user_name"
		git config --file ${GITCONFIG_LOCAL} user.email "$user_email"
	else
		# otherwise this gitconfig was already made by the dotfiles
		echo "already set up"
	fi
}

read -n 1 -p "Proceed with installing dotfiles and configurations? [yN]" yn
[[ $yn != [Yy] ]] && echo "\nExiting..." && exit
echo

install_dotfiles
setup_gitconfig
setup_vscode

# a few messages
echo
bluetext "Brewfile is available to install all Homebrew packages"
# bluetext "You should probably set username and email in ~/.gitconfig.local"

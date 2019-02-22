#! /bin/sh
OS=$(uname -s)

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
      echo "moved $2 to $2.bak"
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
  echo
}

setup_gitconfig() {
  bluetext 'Setting up gitconfig'
  # if there is no user.email, we'll assume it's a new machine/setup and ask it
  if [ -z "$(git config --get user.email)" ]; then
    echo ' - What is your git author name?'
    read -r user_name
    echo ' - What is your git author email?'
    read -r user_email

    git config --global user.name "$user_name"
    git config --global user.email "$user_email"
  else
    # otherwise this gitconfig was already made by the dotfiles
    echo "already set up"
  fi

  echo
}

setup_vscode() {
  if [ ! $(command -v code) ]; then
    return 0
  fi

  read -p "Install VSCode configurations? [yN] " vscode_conf
  [[ $vscode_conf != [Yy] ]] && return 0

  bluetext "Setting up VSCode"
  if [ "$OS" = "Darwin" ]; then
    VSCODE_HOME="$HOME/Library/Application Support/Code"
  else
    VSCODE_HOME="$HOME/.config/Code"
  fi

  link_file "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_HOME/User/settings.json"
  link_file "$DOTFILES_DIR/vscode/keybindings.json" "$VSCODE_HOME/User/keybindings.json"
  link_file "$DOTFILES_DIR/vscode/snippets" "$VSCODE_HOME/User/snippets"

  [[ ! -e "$DOTFILES_DIR/vscode/extensions-list" ]] && return 0

  install_vscode_extenstions

  echo
  bluetext "For vscode vim usability, I might want to run:"
  echo "defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false"
}

setup_homebrew() {
  if [ $(command -v brew) ]; then
    bluetext "Homebrew is already installed, updating..."
  else
    read -p "Would you like to install Homebrew? [yN] " brew_yn
    # Install Homebrew
    [[ $brew_yn != [Yy] ]] && return 0
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

    # Update Homebrew?
    read -p "Should I update Homebrew? [yN] " brew_update_yn
    [[ $brew_update_yn == [Yy] ]] && brew update

    echo
    read -p "Would you like to install packages from Brewfile? [yN] " packages_yn
    [[ $packages_yn != [Yy] ]] && echo && return 0
    echo "Installing packages..."
    brew bundle

    echo
  }

read -p "Proceed with installing dotfiles and configurations? [yN] " yn
[[ $yn != [Yy] ]] && echo "\nExiting..." && exit

echo

install_dotfiles
setup_gitconfig
[ "$OS" = "Darwin" ] && setup_homebrew

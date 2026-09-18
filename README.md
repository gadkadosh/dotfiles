# dotfiles

- MacOS
- Homebrew
- Neovim
- tmux
- Ghostty

## Installation

1. Install [Homebrew](https://brew.sh).
2. Clone this repository and install dependencies:

   ```sh
   git clone https://github.com/gadkadosh/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   brew bundle install --file Brewfile
   ```

3. Preview the symlinks Stow will create in your home directory:

   ```sh
   stow --simulate --verbose --target="$HOME" .
   ```

4. Resolve any conflicts with existing files by reviewing and backing them up before moving them aside. Then create the symlinks:

   ```sh
   stow --verbose --target="$HOME" .
   ```

Run Stow commands from the repository root. Re-run the preview and apply commands after adding new configuration files. Editing an already linked file takes effect without re-running Stow.

## Ignore files

- `.gitignore` prevents matching untracked files from being added to Git normally; it does not control Stow or protect files already tracked.
- `.stow-local-ignore` controls what Stow excludes, including this README, the Brewfile, and the repository's `.gitignore`.

Keep credentials and machine-private files outside this repository. Stow can link untracked files, even if Git ignores them.

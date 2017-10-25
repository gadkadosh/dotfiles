# dotfiles
These are my dotfiles and config files. I'm using MacOS, Visual Studio Code and ZSH with Antigen on Terminal.app (yes...!).
There are tons of great dotfiles and systems for managing them around. 
My solution is simple and does what I want and need. Influenced by some repositories like: [carlos' dotfiles](https://github.com/caarlos0/dotfiles), who himself advocates for sharing dotfiles, and has written some great [blog articles and documents](https://github.com/caarlos0/dotfiles/blob/master/docs/PHILOSOPHY.md) about it.

The **install.sh** script links all **.symlink** files, as well as vscode's files, to the home directory, installs vscode extensions and prompts for gitconfig user/email - which are saved in **.gitconfig.local** and included in the main **.gitconfig**.

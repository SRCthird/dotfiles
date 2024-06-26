# Dotfiles

Welcome to my dotfiles repository! This repository contains the configuration files for various applications and tools I use on my development environment. Feel free to explore, use, and customize them according to your needs.

## Contents

This repository includes configuration files for the following:

- **Bash**
  - `.bashrc`
  - `.bash_profile`
- **Zsh**
  - `.zshrc`
- **Vim**
  - `.vimrc`
- **Tmux**
  - `.tmux.conf`
- **Others**
  - Any other relevant configuration files

## Installation

To set up these dotfiles on your system, follow the steps below:

1. **Clone the repository:**

   I will be putting this in my .config folder, but you do you!
   
   ```sh
   git clone https://github.com/SRCthird/dotfiles.git
   ```

1. **Navigate to the dotfiles directory:**

   ```sh
   cd dotfiles
   ```

2. **Create symbolic links:**

   You can use the following commands to create symbolic links for the configuration files. Adjust the commands according to the files and paths in your repository.

   ```sh
   ln -sf .bashrc ~/.bashrc
   ln -sf .zshrc ~/.zshrc
   ln -sf .vimrc ~/.vimrc
   ln -sf .tmux.conf ~/.tmux.conf
   ln -sf .gitconfig ~/.gitconfig
   ```


## Customization

Feel free to customize the dotfiles to match your preferences. You can edit the files directly or create additional configuration files for other tools you use.

## Contributions

These are just dotfiles, this is only public because I like to see other peoples dotfiles too. I probably will not accept any contributions. :)

## License

[LICENSE](LICENSE)

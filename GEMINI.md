# GEMINI.md

## Project Overview

This is a dotfiles repository for managing personal development environment configurations across multiple devices. It includes settings for various tools such as shells (Bash, Fish), editors (Neovim), window managers (Hyprland), and desktop environments (KDE). The setup script is designed to handle different configurations for different hosts.

The primary technologies and tools configured in this repository are:

*   **Shell:** Fish, Bash
*   **Editor:** Neovim (with Lazy.nvim for plugin management)
*   **Terminal:** Alacritty, Kitty
*   **Multiplexer:** Zellij
*   **Version Control:** Git (with Delta for diffs)
*   **Window Manager (for CachyOS):** Hyprland
*   **Desktop Environment (for Kubuntu):** KDE Plasma
*   **Other Tools:** `zoxide`, `nvm`, `lazygit`

## Building and Running

There is no "build" process for this project. The primary action is to "install" or "set up" the dotfiles by creating symbolic links from the repository to the home directory.

The main script for this is `scripts/setup.sh`. It can be run in two modes:

*   **Full setup:** This will symlink all the configurations.
*   **Partial setup:** This will prompt the user to choose which parts of the configuration to apply.

To run the setup script:

```bash
./scripts/setup.sh
```

The script will detect the hostname and apply device-specific configurations if available. The supported hosts are `cachyos-pc` and `kubuntu-laptop`.

There is also an `update.sh` script, which is likely used to pull the latest changes from the git repository and apply any updates.

## Development Conventions

*   **Configuration Structure:** Configurations are organized by tool under the `.config` directory. Device-specific configurations are in the `cachyos` and `kubuntu` directories.
*   **Shell Scripting:** The setup script is written in Bash and uses a helper function `link()` to create symlinks.
*   **Neovim Configuration:** Neovim is configured using Lua, with plugins managed by `lazy.nvim`. The main configuration is in `.config/nvim/lua/config/lazy.lua`.
*   **Git Commits:** There is a `.gitmessage.txt` file, which suggests a standardized format for commit messages.
*   **Styling:** The repository contains various theme files for different applications, mostly based on the "gruvbox" theme.

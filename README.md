# Dotfiles

My personal dotfiles with multi-os setup. This repository contains my personal configurations for various tools, aiming for a consistent and efficient development environment across multiple machines.

## Features

*   **Multi-os support:** The setup script can apply different configurations for different os (`cachyos` and `kubuntu`).
*   **Interactive setup:** The setup script allows for a full or partial installation, giving you control over what gets configured.
*   **Comprehensive tool configuration:** Includes settings for shells, editors, terminals, window managers, and more.
*   **Gruvbox theming:** Most of the tools are themed with the popular Gruvbox color scheme.
*   **Neovim with Lazy.nvim:** The Neovim configuration is managed using `lazy.nvim` for easy plugin management.

## Structure

The dotfiles are organized by tool under the `.config` directory. Device-specific configurations are located in the `cachyos` and `kubuntu` directories. The `bin` directory contains setup and update scripts.

```
.
├── .config/                # Shared tool configurations
│   ├── alacritty/
│   ├── fish/
│   ├── kitty/
│   ├── nvim/
│   └── ...
├── cachyos/                # CachyOS specific configurations
│   └── .config/
│       ├── hypr/
│       └── ...
├── kubuntu/                # Kubuntu specific configurations
│   └── .config/
│       ├── kwinrc
│       └── ...
├── bin/                    # Scripts
│   ├── setup.sh
│   └── update.sh
└── ...
```

## Installation

1.  Clone the repository:

    ```bash
    git clone git@github.com:zlnew/dotfiles.git ~/dotfiles
    ```

2.  Run the setup script:

    ```bash
    cd ~/dotfiles
    ./bin/setup.sh
    ```

The script will guide you through the setup process, allowing you to choose between a full or partial installation.

To update the dotfiles, you can run the `update.sh` script:

```bash
./bin/update.sh
```

## Prerequisites

To make your dotfiles fully functional, you would need to install most, if not all, of the software listed below, depending on which os you are setting up. The `mason.nvim` configuration will handle the installation of many of the Neovim-related tools automatically.

### Core Tools

*   **`git`**: For version control.
*   **`bash`**: The setup script is written in Bash.
*   **`fish`**: The primary shell being configured.
*   **`curl` or `wget`**: Often used for downloading installers or other files.
*   **`make`**: Required for building some tools.

### Development Environment

*   **`nvm`**: Node Version Manager.
*   **`node.js` and `npm`**: For JavaScript/TypeScript development.
*   **`bun`**: JavaScript runtime and toolkit.
*   **`php`**: For PHP development.
*   **`composer`**: PHP package manager.

### Text Editor (Neovim)

*   **`nvim`**: The Neovim editor.
*   **Language Servers:** `intelephense`, `vtsls`, `vue-language-server`, `tailwindcss-language-server`.
*   **Linters and Formatters:** `pint`, `eslint_d`, `prettierd`, `stylua`, `shfmt`.

### Desktop and Window Management

*   **For CachyOS:** `hyprland`, `hyprctl`, `waybar`, `wofi`, `mako`, `swaylock`, `wl-copy`.
*   **For Kubuntu:** KDE Plasma Desktop.

### Other Tools

*   **`alacritty`**, **`kitty`**, and **`foot`**: Terminal emulators.
*   **`zellij`**: A terminal multiplexer.
*   **`delta`**: A diff viewer for Git.
*   **`zoxide`**: A "smarter `cd` command".
*   **`lazygit`**: A terminal UI for Git.
*   **`yazi`**: A terminal file manager.

## Screenshots

![Screenshot 1](screenshots/2025-10-01T17:28:51,372724276+07:00.png)
![Screenshot 2](screenshots/2025-10-01T17:27:50,967586453+07:00.png)
![Screenshot 3](screenshots/2025-10-01T17:27:16,214358722+07:00.png)

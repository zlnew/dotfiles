# Dotfiles

My personal dotfiles with multi-device setup.

## Installation

```bash
git clone git@github.com:zlnew/dotfiles.git ~/dotfiles
cd ~/dotfiles
./scripts/setup.sh

```

## Prerequisites

To make your dotfiles fully functional, you would need to install most, if not all, of the software listed below, depending on which host you are setting up. The `mason.nvim` configuration will handle the installation of many of the Neovim-related tools automatically.

### Core Tools

These are fundamental command-line utilities that are either used in scripts or are essential for the dotfiles to function correctly.

*   **`git`**: For version control.
*   **`bash`**: The setup script is written in Bash.
*   **`fish`**: The primary shell being configured.
*   **`stow` or `ln`**: The setup script uses `ln` to create symbolic links. GNU Stow is a common alternative for managing dotfiles.
*   **`curl` or `wget`**: Often used for downloading installers or other files.
*   **`make`**: Required for building the `git-credential-libsecret` helper.

### Development Environment

This category includes tools for software development, such as language runtimes, version managers, and build tools.

*   **`nvm`**: Node Version Manager, used to manage Node.js versions.
*   **`node.js` and `npm`**: Required for JavaScript/TypeScript development and for tools like `prettierd` and `eslint_d`.
*   **`php`**: The `phpswitch` function is for managing PHP versions.
*   **`composer`**: The PHP package manager, likely needed for projects using `rector` and `pint`.

### Text Editor (Neovim)

These are the dependencies for your Neovim setup, primarily managed by Mason.

*   **`nvim`**: The Neovim editor itself.
*   **Language Servers:**
    *   `intelephense` (for PHP)
    *   `vtsls` (for Vue, TypeScript, JavaScript)
    *   `vue-language-server` (for Vue)
    *   `tailwindcss-language-server` (for Tailwind CSS)
*   **Linters and Formatters:**
    *   `pint` (for PHP)
    *   `eslint_d` (for JavaScript/TypeScript/Vue)
    *   `prettierd` (for various web development file types)
    *   `stylua` (for Lua)
    *   `shfmt` (for shell scripts)

### Desktop and Window Management

These are specific to your graphical environment on different systems.

*   **For CachyOS:**
    *   `hyprland`: The Wayland compositor/window manager.
    *   `hyprctl`: The command-line utility for Hyprland.
    *   `waybar`: The status bar.
    *   `wofi`: An application launcher.
    *   `mako`: A notification daemon.
    *   `swaylock`: A screen locker.
    *   `wl-copy`: For clipboard integration.
*   **For Kubuntu:**
    *   KDE Plasma Desktop and its associated tools.

### Other Tools

This category includes various other utilities that are part of your workflow.

*   **`alacritty` and `kitty`**: Terminal emulators.
*   **`zellij`**: A terminal multiplexer.
*   **`delta`**: A diff viewer for Git.
*   **`zoxide`**: A "smarter `cd` command".
*   **`lazygit`**: A terminal UI for Git.
# 🧰 Dotfiles

Opinionated dotfiles for a CachyOS/Arch Wayland workstation (Hyprland or Niri),
managed by a symlink-based setup script. Configs cover Fish + Zsh, Zellij,
Neovim, Waybar, Mako, Fuzzel, Alacritty, systemd user services, and a set of
`~/.local/bin` helper scripts.

## Layout

```
dotfiles/
├── bin/                # setup.sh, update.sh, install-themes.sh, refresh-session.sh
├── colorgen/           # Gruvbox colorscheme generator (palette.yaml → resolved.json)
├── .config/            # everything symlinked into ~/.config/<dir>
│   ├── fish/  zellij/  nvim/  alacritty/  waybar/  mako/  fuzzel/
│   └── systemd/user/   # user services + timers (default.target.wants/)
├── .local/bin/         # helper scripts symlinked into ~/.local/bin
├── niri/  hyprland/    # device-specific overlays (chosen at setup time)
├── etc/                # system-level files to copy under /etc
├── howto/              # task-specific notes
└── fresh-install-guide.md
```

## Install

```bash
git clone git@github.com:zlnew/dotfiles.git ~/www/dotfiles
cd ~/www/dotfiles
./bin/setup.sh
```

`setup.sh` symlinks config dirs into `~/.config` (backing up any real files
first) and links `~/.local/bin` helpers. A menu lets you run a full or partial
setup. On first run it generates the Gruvbox colorscheme via `colorgen`.

## Colorscheme

The generator is **Gruvbox-only** — there is no TokyoNight variant.

```bash
cd ~/www/dotfiles/colorgen && ./colorgen   # regenerates resolved.json
```

Then reload the session: `bin/refresh-session.sh`.

## Save / sync

Use `bin/update.sh` to snapshot changed, tracked files into **scoped commits**
(one commit per changed top-level directory) and push to the current branch.
It deliberately:

- refuses to run on a detached HEAD,
- stages only explicit paths (never `git add .`), so unrelated WIP and untracked
  `*.bak` cruft are never swept into a commit,
- warns about untracked files without committing them.

## Validation checklist

Run after editing configs to catch breakage before reloading a live session:

```bash
# Fish syntax (every .fish file)
fish -n .config/fish/config.fish
fish -n .config/fish/conf.d/*.fish
fish -n .config/fish/functions/*.fish

# Zellij config validity
zellij setup --check

# Niri config validity (subcommand, takes a path)
niri validate ~/.config/niri/config.kdl

# Systemd user units parse cleanly
systemctl --user daemon-reload
systemctl --user status hermes-gateway.service --no-pager

# Git tree sanity
git status -sb
```

## Device overlays

`setup.sh` asks whether to link the Hyprland or Niri overlay. The overlays only
replace `.config/<compositor>`; the shared `.config/<app>` dirs are linked
regardless.

## Notes

- `~/.config/zellij` is a symlink to `~/www/dotfiles/.config/zellij`. Editing
  the live file edits the repo directly.
- The `gh` Fish wrapper routes `~/www/personal` → personal GitHub identity and
  `~/www/yodu` → office identity via separate `GH_CONFIG_DIR`s.
- For a full rebuild, follow `fresh-install-guide.md`.

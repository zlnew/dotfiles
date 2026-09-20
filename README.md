# Dotfiles

Opinionated CachyOS dotfiles: Fish + Neovim + Zellij on Niri + Noctalia,
with Alacritty, Lazygit, Git, keyd, and one Gruvbox palette driving every app.

## Layout

```
dotfiles/
├── install.sh              # link repo -> $HOME (backup, --check, --verbose, no sudo)
├── provision.sh            # CachyOS deps + toolchains (runs install.sh)
├── lib/ui.sh               # shared installer UI (quiet by default, --verbose streams)
├── .aliases                # shared aliases (-> ~/.aliases)
├── .env.example            # secrets template (-> ~/.env, mode 600)
├── config/                 # symlinked into ~/.config/<app>
│   ├── fish/               # extend (-> conf.d/10-dotfiles.fish), colors (-> 11-colors.fish), fish_plugins
│   ├── nvim/               # 10 LSP servers, plugin set, generated colors
│   ├── zellij/             # config.kdl + generated themes/gruvbox.kdl
│   ├── niri/               # config.kdl + cfg/ splits (incl. generated colors.kdl)
│   ├── alacritty/          # alacritty.toml + generated colors.toml
│   ├── lazygit/            # config.yml (terminal-inherited colors)
│   ├── noctalia/           # config.toml + generated palettes/ZlGruvbox.json
│   └── pi/                 # extensions.txt manifest only (~/.pi itself is never linked)
├── git/                    # .gitconfig (no identity — see below), .gitmessage.txt
├── system/keyd/            # manual: sudo cp to /etc/keyd/
└── pkg/colorgen/           # palette.yaml + palette-light.yaml + semantic.yaml -> 6 outputs
```

Fish: `~/.config/fish/config.fish` is CachyOS-managed and never overwritten;
the repo installs `conf.d/` snippets instead. Secrets live in `~/.env`
(`KEY=VALUE`, auto-created from `.env.example`, gitignored, never linked).

Git identity: the tracked config ships no `[user]` — git fails loudly until
you set one. Never edit `~/.gitconfig` or use `git config --global` (both
write into the symlinked repo); put identity in `~/.gitconfig.local`
(auto-created, always included — recipe in the base config's comments).
`delta` is the pager (`sudo pacman -S git-delta` via provision).

Keyd needs root and is never linked:
`sudo cp system/keyd/*.conf /etc/keyd/ && sudo systemctl restart keyd`.

## Install

```bash
git clone <repo> ~/www/dotfiles
cd ~/www/dotfiles
./provision.sh        # pacman (official repos, no AUR) + install.sh + toolchains
./install.sh          # link-only re-run (backups to ~/.dotfiles_backup/<ts>/)
./install.sh --check  # verify without changing anything
```

Provision covers: fisher + `nvm.fish`, standalone nvm with latest LTS as
default, LSPs from official toolchains (`uv`, `go install gopls`, composer
`pint`; npm only for tools with no official distribution), agents
(`opencode`, `pi`, `agy`, `herdr`) plus `pi` extensions from
`config/pi/extensions.txt`, `docker` (service + group),
`tailscale`, `discord`, `zen-browser`. Re-running either script is safe.
Both scripts are quiet by default; pass `--verbose` to stream every command.

Pi note: `~/.pi` is never symlinked (`auth.json` collects OAuth tokens).
Only the extension manifest is tracked — add a source there and re-run
provision, or `pi install` directly and backfill the file.

## Colors

One palette, six outputs — `cd pkg/colorgen && go run .`:

- nvim `lua/colors/default.lua`, alacritty `colors.toml`, fish pure bases
  (`conf.d/11-colors.fish`), niri focus-ring (`cfg/colors.kdl`), zellij
  `gruvbox` + `gruvbox-light` (auto-following), noctalia `ZlGruvbox`
  (dark + light, `source = "custom"`; `mode` stays `dark`).
- Nvim/Alacritty/Fish/Niri are dark-only (no native switching to hook into);
  Lazygit uses named ANSI colors and inherits the terminal palette.
- `resolved.json` is a debug dump and ignored.

## Validation checklist

```bash
./install.sh --check
fish -n config/fish/extend.config.fish config/fish/colors.fish
niri validate -c ~/.config/niri/config.kdl
zellij setup --check
nvim --headless "+lazy! sync" +qa
git status -sb
```

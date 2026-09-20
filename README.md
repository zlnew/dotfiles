# Dotfiles (minimal)

Opinionated minimal dotfiles. Fish + Neovim + Zellij on Niri, with Alacritty,
Lazygit, Noctalia, Git, and keyd.

## Layout

```
dotfiles/
├── install.sh              # symlink repo -> $HOME (with backup + --check)
├── .aliases                # shared shell aliases (-> ~/.aliases)
├── config/                 # symlinked into ~/.config/<app>
│   ├── fish/               # extend.config.fish (-> conf.d/10-dotfiles.fish), fish_plugins
│   ├── nvim/               # full LSP set + plugin set, custom Gruvbox colors
│   ├── zellij/             # config.kdl (kept as-is)
│   ├── niri/               # config.kdl + cfg/ splits
│   ├── alacritty/          # alacritty.toml
│   ├── lazygit/            # config.yml
│   └── noctalia/           # config.toml
├── git/.gitconfig          # -> ~/.gitconfig
├── system/keyd/            # manual: sudo cp to /etc/keyd/
└── pkg/colorgen/           # palette.yaml + semantic.yaml -> nvim/alacritty colors
```

Fish note: `install.sh` does not overwrite `~/.config/fish/config.fish`
(CachyOS-managed). It installs a `conf.d/10-dotfiles.fish` snippet instead,
which also exports secrets from `~/.env` (`KEY=VALUE`, `#` comments).
Run `fisher update` manually for `config/fish/fish_plugins`.

Secrets: copy `.env.example` → `~/.env` (done automatically by `install.sh`
with mode 600, values left empty for you to fill). `~/.env` is gitignored and
never linked — only the example is tracked.

Keyd note: system files need root and are never linked automatically:
`sudo cp system/keyd/*.conf /etc/keyd/ && sudo systemctl restart keyd`.

Git note: `git/.gitconfig` assumes `delta` as pager (also used by lazygit).
Install it (`sudo pacman -S git-delta`) or change `core.pager`.
`commit.template` points at `~/.gitmessage.txt`, linked by `install.sh`.

Identities: `git/.gitconfig` ships no `[user]` block on purpose — git fails
loudly until you set a real identity (placeholders risk silent bad commits).
After install, run `git config --global user.name/email`. The commented
`includeIf` recipe covers per-workspace identities (uncomment, adjust
`gitdir:` paths per machine, create the target files with real `[user]`
blocks). SSH auth stays in your own `~/.ssh/config`
(`github.com` vs `github.office`), which is intentionally not managed here.

## Install

```bash
git clone <repo> ~/www/dotfiles
cd ~/www/dotfiles
./provision.sh        # system deps + linking + toolchains (runs install.sh itself)
./install.sh          # link-only re-run (backup real files to ~/.dotfiles_backup/<ts>/)
./install.sh --check  # verify without changing anything (creates nothing)
```

`install.sh` is link-only and safe. `provision.sh` is CachyOS-only and does the
privileged/heavy work: one `pacman -S --needed` (all official repos, no AUR
helper needed — `noctalia` 5.x is in `[extra]`), then standalone nvm + latest
LTS node as default, fisher (`fisher update` installs `nvm.fish` from
`fish_plugins`), LSPs from their official toolchains (`uv tool install`
`basedpyright`/`ruff`, `go install gopls`, composer `pint`;
only tools with no official distribution — `bash/fish/vtsls/vue/tailwindcss/
intelephense` servers, `prettierd`, `eslint_d` — come from npm), agents via
their curl installers (`opencode`, `pi`, `agy`, `herdr` — herdr last so it
detects the others on PATH), `docker`/`docker-compose` via pacman
(docker service enabled, user added to group), plus `uv` for
Python envs. Re-running either script is safe.

## Colors

Single source of truth: `pkg/colorgen/palette.yaml` (raw Gruvbox hex) +
`semantic.yaml` (meaning mapping). Regenerate with:

```bash
cd pkg/colorgen && go run .   # needs Go toolchain
```

Outputs: `config/nvim/lua/colors/default.lua` (consumed by
`config/nvim/lua/core/colorscheme.lua`) and `config/alacritty/colors.toml`
(imported by `alacritty.toml`). `resolved.json` is a debug dump and ignored.
Fish/Noctalia manage their own theme colors and are not generated.

## Validation checklist

```bash
./install.sh --check
fish -n config/fish/extend.config.fish
niri validate ~/.config/niri/config.kdl
zellij setup --check
nvim --headless "+lazy! sync" +qa
git status -sb
```

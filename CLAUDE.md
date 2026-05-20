# Dotfiles

Personal macOS dotfiles. Symlinks are managed by [dotbot](https://github.com/anishathalye/dotbot) (vendored as a git submodule).

## How it's wired

- `bootstrap.sh` — one-shot machine setup (Homebrew → Brewfile → Oh My Zsh → zsh plugins → TPM + plugins → dotbot links).
- `install` — runs dotbot using `install.conf.yaml`. Re-run any time the link map changes.
- `install.conf.yaml` — the source of truth for which file in `config/` is symlinked where on disk.
- `Brewfile` — packages installed via `brew bundle`.
- `scripts/` — supporting install scripts (e.g. `install-zsh-plugins.sh`).
- `config/` — the actual config files, organized by app.
- `dotbot/` — submodule. Do not edit.

## Critical rule: edit here, not the symlink target

Everything under `config/` is symlinked into `$HOME` (see `install.conf.yaml`). When working on a config:

1. Edit the file in this repo (`config/...`), **not** the path it's linked from (e.g. `~/.zshrc`, `~/.config/tmux/tmux.conf`).
2. If you're adding a brand-new file, also add a `link:` entry to `install.conf.yaml` and run `./install` to create the symlink.
3. Commit from this repo.

Editing the linked target works (it's the same inode) but is easy to lose track of — always touch the repo path.

## Current link map (see `install.conf.yaml` for truth)

| Repo path | Linked to |
| --- | --- |
| `config/.zshrc` | `~/.zshrc` |
| `config/aliases` | `~/.oh-my-zsh/custom/aliases.zsh` |
| `config/.vimrc` | `~/.vimrc` |
| `config/tmux/tmux.conf` | `~/.config/tmux/tmux.conf` |
| `config/nvim/` | `~/.config/nvim` |
| `config/wezterm/` | `~/.config/wezterm` |
| `config/vscode-settings.json` | `~/Library/Application Support/Code/User/settings.json` |

Several link entries are commented out in `install.conf.yaml` (yabai, skhd, starship, sesh, aerospace, yazi, etc.) — those configs may exist in `config/` but aren't currently linked.

## Tools / what's installed

- **Shell:** zsh + Oh My Zsh (theme: `robbyrussell`), plugins `zsh-autosuggestions`, `git`, `zsh-syntax-highlighting`.
- **Terminal:** WezTerm (Lua config under `config/wezterm/`).
- **Multiplexer:** tmux with TPM, Dracula theme. Prefix is bound to **both** `C-s` and `C-a` (see `config/tmux/tmux.conf`). vi-style pane nav (`h/j/k/l`), `prefix + r` reloads `~/.tmux.conf`. Most of the file below the active block is commented-out experiments — leave it unless asked.
- **Editors:** Neovim (LazyVim starter under `config/nvim/`), Vim (`config/.vimrc`).
- **Window manager:** yabai + skhd (installed via Brewfile, configs not currently linked).
- **Runtimes / version managers:** pyenv, nvm, jenv, SDKMAN, mise. PATH/init for all of these lives in `config/.zshrc` — SDKMAN init **must stay last**.

## Common tasks

- Re-apply symlinks after editing `install.conf.yaml`: `./install`
- Re-run full setup on a new machine: `./bootstrap.sh`
- Install/update brew packages: `brew bundle --file=./Brewfile`
- Reload zsh: `reload` (alias for `RELOAD=1 source ~/.zshrc`)
- Reload tmux config: `prefix + r`

## Don't

- Don't edit anything in `dotbot/` — it's a submodule.
- Don't commit machine-specific secrets. `.gravierc` is sourced from `$HOME` (Ansible-managed) and is intentionally not in this repo.
- Don't reorder `config/.zshrc` past the SDKMAN block at the bottom.
- Don't add files under `config/` and expect them to take effect — they also need a `link:` entry in `install.conf.yaml`.

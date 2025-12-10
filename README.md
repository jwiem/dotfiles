# Dotfiles

My personal macOS dotfiles configuration for development.

## What's Included

- **Shell**: Zsh with Oh My Zsh
- **Terminal**: WezTerm
- **Editor**: Neovim with LazyVim + Vim with sensible defaults
- **Multiplexer**: Tmux with custom config
- **Window Manager**: Yabai + SKHD
- **Version Managers**: NVM, Pyenv, jenv, SDKMAN
- **Tools**: fzf, zoxide, starship, lazygit

## Quick Start

```bash
# Clone the repository
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Run the bootstrap script
chmod +x bootstrap.sh
./bootstrap.sh
```

That's it! The bootstrap script will:
1. Install Homebrew (if not already installed)
2. Install all packages from the Brewfile
3. Install Oh My Zsh
4. Install Zsh plugins
5. Install Tmux Plugin Manager
6. Create all necessary symlinks

## Manual Steps After Installation

1. **Restart your terminal** or run:
   ```bash
   source ~/.zshrc
   ```

2. **Launch Neovim to install plugins**:

   ```bash
   nvim
   ```

   - LazyVim will automatically install all plugins on first launch
   - This may take a minute or two

3. **Install Tmux plugins**:
   - Open tmux: `tmux`
   - Press `Ctrl+s` or `Ctrl+a` then `I` (capital i) to install plugins

4. **Configure Git** (if needed):

   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

5. **Install Node.js via fnm**:
   ```bash
   fnm install --lts
   fnm use lts-latest
   ```

## File Structure

```
dotfiles/
├── bootstrap.sh          # Master installation script
├── Brewfile             # Homebrew package definitions
├── install              # Dotbot installation script
├── install.conf.yaml    # Dotbot configuration
├── config/              # Configuration files
│   ├── .zshrc          # Zsh configuration
│   ├── aliases         # Shell aliases
│   ├── wezterm/        # WezTerm config
│   ├── tmux/           # Tmux config
│   └── scripts/        # Helper scripts
└── scripts/             # Installation scripts
    └── install-zsh-plugins.sh
```

## Customization

### Adding New Packages

Edit the `Brewfile` and add your package:
```ruby
brew "package-name"
cask "app-name"
```

Then run:
```bash
brew bundle --file=~/dotfiles/Brewfile
```

### Adding New Dotfiles

1. Add your config file to the `config/` directory
2. Edit `install.conf.yaml` to create the symlink:
   ```yaml
   - link:
       ~/.config/yourapp:
         path: ./config/yourapp
   ```
3. Run `./install` to create the symlink

## Key Aliases

Defined in [config/aliases](config/aliases) and [config/.zshrc](config/.zshrc):

- `lg` - lazygit
- `ld` - lazydocker
- `gs` - git status
- `ga` - git add
- `gcm` - git commit -m
- `..` - cd ..
- `...` - cd ../..

## Troubleshooting

### Homebrew not in PATH
If you see "command not found: brew" after installation:
```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Zsh plugins not loading
Make sure you've restarted your terminal or sourced your zshrc:
```bash
source ~/.zshrc
```

### Tmux plugins not working
Open tmux and install plugins manually:
```bash
tmux
# Then press: Ctrl+s (or Ctrl+a) + I
```

## Components

### Shell Configuration
- **Zsh**: Primary shell
- **Oh My Zsh**: Framework for managing Zsh configuration
- **Plugins**: zsh-autosuggestions, zsh-syntax-highlighting, zsh-vi-mode

### Development Tools
- **Docker**: Container management
- **Git**: Version control
- **Neovim**: Text editor
- **Lazygit**: Terminal UI for git commands

### Language Runtimes
- **Node.js**: Via fnm (Fast Node Manager)
- **Python**: Via pyenv
- **Java**: Via jenv and SDKMAN

### Terminal Multiplexer
- **Tmux**: Terminal multiplexer with Dracula theme
- **TPM**: Tmux Plugin Manager

### Window Management
- **Yabai**: Tiling window manager for macOS
- **SKHD**: Hotkey daemon for macOS

## License

MIT

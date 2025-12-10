#!/usr/bin/env bash

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

NVIM_CONFIG_DIR="$HOME/.config/nvim"
BACKUP_DIR="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"

# Check if neovim is installed
if ! command -v nvim &> /dev/null; then
    print_warning "Neovim is not installed. Please install it first:"
    print_info "  brew install neovim"
    exit 1
fi

# Backup existing neovim config if it exists
if [ -d "$NVIM_CONFIG_DIR" ] || [ -L "$NVIM_CONFIG_DIR" ]; then
    print_info "Backing up existing neovim config to $BACKUP_DIR"
    mv "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
    print_success "Backup created"
fi

# Clone LazyVim starter
print_info "Cloning LazyVim starter template..."
git clone https://github.com/LazyVim/starter "$NVIM_CONFIG_DIR"
print_success "LazyVim starter cloned"

# Remove .git folder to make it your own
print_info "Removing .git folder to make config your own..."
rm -rf "$NVIM_CONFIG_DIR/.git"
print_success "LazyVim installed"

print_info "LazyVim has been installed to $NVIM_CONFIG_DIR"
print_info "Next steps:"
print_info "  1. Move this config to your dotfiles: mv ~/.config/nvim ~/dotfiles/config/nvim"
print_info "  2. Update install.conf.yaml to symlink it"
print_info "  3. Run nvim to complete the setup (LazyVim will install plugins automatically)"

#!/usr/bin/env bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Get the dotfiles directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="${DOTFILES_DIR}/scripts"

print_info "Starting dotfiles setup..."
print_info "Dotfiles directory: ${DOTFILES_DIR}"

# Step 1: Install Homebrew
print_info "Step 1/6: Checking Homebrew installation..."
if ! command -v brew &> /dev/null; then
    print_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    print_success "Homebrew installed"
else
    print_success "Homebrew already installed"
fi

# Step 2: Install packages via Brewfile
print_info "Step 2/6: Installing packages from Brewfile..."
if [ -f "${DOTFILES_DIR}/Brewfile" ]; then
    brew bundle --file="${DOTFILES_DIR}/Brewfile"
    print_success "Packages installed"
else
    print_error "Brewfile not found at ${DOTFILES_DIR}/Brewfile"
    exit 1
fi

# Step 3: Install Oh My Zsh
print_info "Step 3/6: Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "Oh My Zsh installed"
else
    print_success "Oh My Zsh already installed"
fi

# Step 4: Install Zsh plugins
print_info "Step 4/6: Installing Zsh plugins..."
"${SCRIPTS_DIR}/install-zsh-plugins.sh"
print_success "Zsh plugins installed"

# Step 5: Install Tmux Plugin Manager
print_info "Step 5/6: Installing Tmux Plugin Manager..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    print_success "Tmux Plugin Manager installed"
else
    print_success "Tmux Plugin Manager already installed"
fi

# Step 6: Run dotbot to create symlinks
print_info "Step 6/6: Creating symlinks with dotbot..."
"${DOTFILES_DIR}/install"
print_success "Symlinks created"

# Final message
echo ""
print_success "========================================"
print_success "Dotfiles setup complete!"
print_success "========================================"
echo ""
print_info "Next steps:"
print_info "1. Restart your terminal or run: source ~/.zshrc"
print_info "2. Open tmux and press prefix + I to install tmux plugins"
print_info "3. Verify installation by running: which zsh brew nvim tmux"
echo ""

#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "${GREEN}Starting dotfiles installation...${NC}"

# Git
ln -sf $DOTFILES_DIR/config/.gitconfig ~
ln -sf $DOTFILES_DIR/config/.gitignore ~

# Run platform-specific installer
if [[ "$OSTYPE" == "darwin"* ]]; then
    source "$DOTFILES_DIR/install-macos.sh"
else
    source "$DOTFILES_DIR/install-linux.sh"
fi

# ZSH
ln -sf $DOTFILES_DIR/config/.zshrc ~/.zshrc

# Oh My ZSH
echo
echo "** Installing Oh My Zsh"
rm -rf ~/.oh-my-zsh
CHSH=no RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Oh my ZSH theme
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k --depth 1
ln -sf $DOTFILES_DIR/config/.p10k.zsh ~/.p10k.zsh

# Oh my ZSH plugin
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions --depth 1
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting --depth 1

# Link .zshrc-local with platform-specific config
echo
echo "** Creating .zshrc-local"
if [[ "$OSTYPE" == "darwin"* ]]; then
    ln -sf $DOTFILES_DIR/config/.zshrc-local.macos ~/.zshrc-local
else
    ln -sf $DOTFILES_DIR/config/.zshrc-local.linux ~/.zshrc-local
fi

# uv
echo
echo "** Installing uv"
curl -LsSf https://astral.sh/uv/install.sh | sh

# OpenCode config
mkdir -p ~/.config/opencode
ln -sf $DOTFILES_DIR/config/opencode.json ~/.config/opencode/opencode.json

# AI agent config (Claude Code & OpenCode)
echo
echo "** Setting up AI agent config"
mkdir -p ~/.claude
ln -sf $DOTFILES_DIR/config/AGENTS.md ~/.claude/CLAUDE.md
ln -sf $DOTFILES_DIR/config/AGENTS.md ~/.config/opencode/AGENTS.md

echo
echo -e "${GREEN}** Done${NC}"

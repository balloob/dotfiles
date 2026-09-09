#!/bin/bash
# macOS-specific installation - sourced by install.sh

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}Homebrew not found. Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo -e "${GREEN}Homebrew already installed${NC}"
fi

# Install Homebrew packages from Brewfile
echo -e "\n${GREEN}Installing Homebrew packages from Brewfile...${NC}"
brew bundle --file="$DOTFILES_DIR/Brewfile"

# Node.js LTS via mise (installed from the Brewfile).
echo -e "\n${GREEN}Installing Node.js LTS via mise...${NC}"
mise use -g node@lts

# Apply macOS system preferences
echo -e "\n${GREEN}Applying macOS system preferences...${NC}"
"$DOTFILES_DIR/macos-defaults.sh"

# Claude Code
curl -fsSL https://claude.ai/install.sh | bash

# OpenCode
curl -fsSL https://opencode.ai/install | bash

# Codex CLI (self-updating standalone binary; `codex update` thereafter)
curl -fsSL https://chatgpt.com/codex/install.sh | sh

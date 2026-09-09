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

# Install Homebrew packages from Brewfile. This is also what puts mise on disk;
# install.sh links config/mise.toml and runs `mise install` once this returns.
echo -e "\n${GREEN}Installing Homebrew packages from Brewfile...${NC}"
brew bundle --file="$DOTFILES_DIR/Brewfile"

# Apply macOS system preferences
echo -e "\n${GREEN}Applying macOS system preferences...${NC}"
"$DOTFILES_DIR/macos-defaults.sh"

# Claude Code
curl -fsSL https://claude.ai/install.sh | bash

# OpenCode. --no-modify-path: ~/.zshenv owns PATH, so the installer must not
# append its own export to .zshrc.
curl -fsSL https://opencode.ai/install | bash -s -- --no-modify-path

# Codex CLI (self-updating standalone binary; `codex update` thereafter).
# It leaves shell config alone when its install dir is already on PATH.
curl -fsSL https://chatgpt.com/codex/install.sh | PATH="$HOME/.local/bin:$PATH" sh

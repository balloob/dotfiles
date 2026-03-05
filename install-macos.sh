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

# Install Codex CLI via npm so it can update itself independently of Homebrew.
echo -e "\n${GREEN}Installing Codex CLI via npm...${NC}"
if command -v npm &> /dev/null; then
    npm install -g @openai/codex
    echo -e "${GREEN}Codex CLI installed${NC}"
    echo -e "${GREEN}Run 'codex app' to download and launch the Codex macOS app.${NC}"
else
    echo -e "${YELLOW}npm not found. Skipping Codex CLI install.${NC}"
fi

# Apply macOS system preferences
echo -e "\n${GREEN}Applying macOS system preferences...${NC}"
"$DOTFILES_DIR/macos-defaults.sh"

# Claude Code
curl -fsSL https://claude.ai/install.sh | bash

# OpenCode
curl -fsSL https://opencode.ai/install | bash

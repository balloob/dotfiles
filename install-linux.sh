#!/bin/bash
# Linux-specific installation - sourced by install.sh

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# APT
echo
echo "** Installing apt packages"
sudo -n apt-get update
sudo -n DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends zsh fzf vim jq ripgrep

USER=`whoami`
sudo -n chsh $USER -s $(which zsh)

# GH CLI
echo
echo "** Downloading GitHub CLI"
ARCH=$(dpkg --print-architecture)
curl -s https://api.github.com/repos/cli/cli/releases/latest \
  | jq -r ".assets[] | select(.name | endswith(\"_linux_${ARCH}.deb\")).browser_download_url" \
  | xargs curl -O -L

sudo -n dpkg -i ./gh_*_linux_${ARCH}.deb
rm ./gh_*_linux_${ARCH}.deb

# UV
curl -LsSf https://astral.sh/uv/install.sh | sh

# NVM/Node.js (PROFILE=/dev/null prevents nvm from modifying shell config)
export NVM_DIR="$HOME/.nvm"
NVM_VERSION=v0.40.3
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | PROFILE=/dev/null bash

source "$NVM_DIR/nvm.sh"

nvm install --lts
nvm use --lts

# Claude Code
curl -fsSL https://claude.ai/install.sh | bash

# OpenCode
curl -fsSL https://opencode.ai/install | bash

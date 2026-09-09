#!/bin/bash
# Linux-specific installation - sourced by install.sh

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# APT. Only what mise cannot provide - fzf, jq, ripgrep and gh come from
# config/mise.toml so they match the versions installed on macOS.
echo
echo "** Installing apt packages"
sudo -n apt-get update
sudo -n DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends zsh vim

USER=`whoami`
sudo -n chsh $USER -s $(which zsh)

# mise (runtime version manager). Its shims give every shell - interactive or
# not - a real node/npm on PATH (see config/.zshenv). install.sh links
# config/mise.toml and runs `mise install` once this script returns.
curl -fsSL https://mise.run | sh

# Claude Code
curl -fsSL https://claude.ai/install.sh | bash

# OpenCode. --no-modify-path: ~/.zshenv owns PATH, so the installer must not
# append its own export to .zshrc.
curl -fsSL https://opencode.ai/install | bash -s -- --no-modify-path

# Codex CLI (self-updating standalone binary; `codex update` thereafter).
# It has no --no-modify-path flag, but skips writing to shell config when its
# install dir is already on PATH, which ~/.zshenv guarantees for zsh. Set it
# here too so the same holds when this bash script runs from a bare login.
curl -fsSL https://chatgpt.com/codex/install.sh | PATH="$HOME/.local/bin:$PATH" sh

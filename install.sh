#!/bin/bash

# Install dot files

# Install gh
# Change default shell to zsh
# Add oh-my-zsh
# Add gs alias
# Add ./node_modules/.bin to path
# Add venv/bin to path


echo "Hello! "


# APT
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y zsh fzf vim
apt-get autoremove -y
apt-get clean -y
rm -rf /var/lib/apt/lists/*

# Git
ln -sf ~/dotfiles/config/.gitconfig ~
ln -sf ~/dotfiles/config/.gitignore ~

# GH CLI
curl -s https://api.github.com/repos/cli/cli/releases/latest \
  | jq '.assets[] | select(.name | endswith("_linux_amd64.deb")).browser_download_url' \
  | xargs curl -O -L

apt-get install -y ./gh_*.deb
rm ./gh_*.deb

# ZSH
ln -sf ~/dotfiles/config/.zshrc ~/.zshrc

chsh -s $(which zsh)

# Oh My ZSH
rm -rf ~/.oh-my-zsh
CHSH=no RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Oh my ZSH theme
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k --depth 1
ln -sf ~/dotfiles/config/.p10k.zsh ~/.p10k.zsh

# Oh my ZSH plugin
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions --depth 1
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting --depth 1

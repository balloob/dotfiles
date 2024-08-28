#!/bin/bash

DOTFILES_DIR=`pwd`

# Git
ln -sf $DOTFILES_DIR/config/.gitconfig ~
ln -sf $DOTFILES_DIR/config/.gitignore ~

# APT
echo
echo "** Installing apt packages"
sudo -n apt-get update
sudo -n DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends zsh fzf vim jq

USER=`whoami`
sudo -n chsh $USER -s $(which zsh)

# GH CLI
echo
echo "** Downloading GitHub CLI"
curl -s https://api.github.com/repos/cli/cli/releases/latest \
  | jq '.assets[] | select(.name | endswith("_linux_amd64.deb","_linux_arm64.deb")).browser_download_url' \
  | xargs curl -OO -L

sudo -n dpkg -i ./gh_*.deb
rm ./gh_*.deb

# UV
curl -LsSf https://astral.sh/uv/install.sh | sh

# ZSH
ln -sf $DOTFILES_DIR/config/.zshrc ~/.zshrc

# Oh My ZSH
echo
echo "** Installing Oh My Zsh"
rm -rf ~/.oh-my-zsh
touch ~/.z  # So it doesn't complain on very first usage
CHSH=no RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Oh my ZSH theme
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k --depth 1
ln -sf $DOTFILES_DIR/config/.p10k.zsh ~/.p10k.zsh

# Oh my ZSH plugin
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions --depth 1
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting --depth 1

echo
echo "** Done"

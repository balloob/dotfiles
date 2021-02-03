#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

# Git
ln -sf ~/dotfiles/config/.gitconfig ~
ln -sf ~/dotfiles/config/.gitignore ~

# GH CLI
curl -s https://api.github.com/repos/cli/cli/releases/latest \
  | jq '.assets[] | select(.name | endswith("_linux_amd64.deb")).browser_download_url' \
  | xargs curl -O -L

sudo dpkg -i ./gh_*.deb
rm ./gh_*.deb

# APT
sudo apt-get update
sudo apt-get install -y zsh fzf vim

chsh -s $(which zsh)

# ZSH
ln -sf ~/dotfiles/config/.zshrc ~/.zshrc

# Oh My ZSH
rm -rf ~/.oh-my-zsh
touch ~/.z  # So it doesn't complain on very first usage
CHSH=no RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Oh my ZSH theme
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k --depth 1
ln -sf ~/dotfiles/config/.p10k.zsh ~/.p10k.zsh

# Oh my ZSH plugin
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions --depth 1
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting --depth 1

echo "Done"

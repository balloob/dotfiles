export SHELL=/usr/bin/zsh

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Disable marking untracked files under VCS as dirty.
# This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/.p10k.zsh

plugins=(git z)

# Custom plugins
plugins+=(zsh-autosuggestions zsh-syntax-highlighting)

[ -f ~/.zshrc-local ] && source ~/.zshrc-local

source $ZSH/oh-my-zsh.sh

# Disable share history across consoles
unsetopt share_history

alias gs="git status -sb"
note() { echo -e "\n\n[$(date "+%Y-%m-%d %H:%M:%S")]\n$*" >> ~/Notes/00\ To\ Do/Latest.md && echo "Note added!"; }

# fzf
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh

# Automatically check venv and node modules for executables
export PATH="./.venv/bin:./node_modules/.bin:~/bin:$HOME/.local/bin/env:$PATH"

[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

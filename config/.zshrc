# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export SHELL=$(command -v zsh)

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Disable marking untracked files under VCS as dirty.
# This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins (note: zsh-syntax-highlighting must be last)
plugins=(zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Disable share history across consoles
unsetopt share_history

# Disable auto cd (typing directory name changes to it)
unsetopt AUTO_CD

# Aliases
alias gs="git status -sb"
note() { echo -e "\n\n[$(date "+%Y-%m-%d %H:%M:%S")]\n$*" >> ~/Notes/00\ To\ Do/Latest.md && echo "Note added!"; }

# PATH setup (before lazy-loaded tools)
export PATH="$HOME/.opencode/bin:./.venv/bin:./node_modules/.bin:~/bin:$HOME/.local/bin:$PATH"

# Source local config (machine-specific settings like Homebrew)
# Note: NVM should NOT be in .zshrc-local - it's lazy-loaded below
source ~/.zshrc-local

# Lazy load NVM - only loads when you actually use node/npm/nvm
export NVM_DIR="$HOME/.nvm"
lazy_load_nvm() {
  unset -f nvm node npm npx pnpm
  if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
    \. "/opt/homebrew/opt/nvm/nvm.sh"
  elif [ -s "$NVM_DIR/nvm.sh" ]; then
    \. "$NVM_DIR/nvm.sh"
  fi
}
nvm() { lazy_load_nvm && nvm "$@"; }
node() { lazy_load_nvm && node "$@"; }
npm() { lazy_load_nvm && npm "$@"; }
npx() { lazy_load_nvm && npx "$@"; }
pnpm() { lazy_load_nvm && pnpm "$@"; }

# Powerlevel10k config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

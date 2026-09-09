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
source ~/.zshrc-local

# mise: runtime version manager. Interactive activation adds the per-directory
# version-switching hook; non-interactive shells get the runtimes from the shims
# on PATH (see ~/.zshenv).
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# fzf key bindings and completion. `fzf --zsh` works the same on macOS and
# Linux, so this replaces the old per-platform key-bindings.zsh paths.
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi

# Powerlevel10k config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

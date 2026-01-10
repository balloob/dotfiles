# Repository Guidelines

## Project Structure & Module Organization
- `Brewfile` lists Homebrew packages, casks, and Mac App Store apps.
- `install.sh` bootstraps a new machine (installs tools and creates symlinks).
- `install-linux.sh` Linux-specific bootstrap actions. Called by `install.sh`
- `install-macos.sh` MacOS-specific bootstrap actions. Called by `install.sh`
- `macos-defaults.sh` applies macOS system preferences.
- `shell/`, `git/`, `ssh/`, `config/` contain dotfile sources that get symlinked into `$HOME`.
- `README.md` documents setup, maintenance, and the expected layout.

## Build, Test, and Development Commands
- `./install.sh` sets up a new machine (Xcode tools, Homebrew, symlinks, Rust, Node, Codex).
- `./macos-defaults.sh` applies macOS preferences (Finder, Dock, keyboard, etc.).
- `brew bundle dump --force --no-vscode` updates `Brewfile` after app changes.
- `brew update && brew upgrade` keeps Homebrew packages current.

## Coding Style & Naming Conventions
- Match existing file style in the directory you edit (shell configs in `shell/`, git in `git/`).
- Prefer concise, descriptive names for scripts and aliases; keep shell functions lowercase.
- Use POSIX-friendly shell where reasonable; add a brief comment for non-obvious steps.
- No formal formatter is configured; keep indentation consistent with nearby lines.

## Testing Guidelines
- No automated test suite is currently defined.
- Validate changes manually by running the relevant script (e.g., `./install.sh` on a clean setup) and checking updated symlinks or configs.

## Commit & Pull Request Guidelines
- Commit messages follow Conventional Commits (examples: `feat: add codex to Brewfile`, `refactor: simplified new branch alias`).
- Keep commits focused (one logical change per commit).
- PRs should describe the change, list commands run (if any), and note any manual steps needed.

## Security & Configuration Tips
- Never commit secrets, tokens, or private keys; `ssh/` is config-only.
- Dotfiles are symlinked into `$HOME`; verify changes in both the repo and the target file.

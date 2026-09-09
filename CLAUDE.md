# Repository Guidelines

## Project Structure & Module Organization
- `Brewfile` lists Homebrew packages, casks, and Mac App Store apps. macOS only.
- `config/mise.toml` lists runtimes and CLI tools managed by mise. Cross-platform;
  symlinked to `~/.config/mise/config.toml`. Prefer this over `Brewfile`/apt for
  anything that ships as a single binary.
- `install.sh` bootstraps a new machine (installs tools and creates symlinks).
- `install-linux.sh` Linux-specific bootstrap actions. Called by `install.sh`
- `install-macos.sh` MacOS-specific bootstrap actions. Called by `install.sh`
- `macos-defaults.sh` applies macOS system preferences.
- `config/` contains dotfile sources that get symlinked into `$HOME`.
- `test/` holds a Docker harness that runs `install.sh` on Linux.
- `README.md` documents setup, maintenance, and the expected layout.

## Build, Test, and Development Commands
- `./install.sh` sets up a new machine (Xcode tools, Homebrew, symlinks, and Codex CLI/App bootstrap).
- `./macos-defaults.sh` applies macOS preferences (Finder, Dock, keyboard, etc.).
- `brew bundle dump --force --no-vscode` updates `Brewfile` after app changes.
  Review the diff: it re-adds transitive dependencies and anything installed
  ad hoc, including tools that belong in `config/mise.toml`.
- `brew update && brew upgrade` keeps Homebrew packages current.
- `mise install` installs everything declared in `config/mise.toml`.
- `mise upgrade` updates the mise-managed tools.
- Edit `config/mise.toml` by hand. Do not run `mise use -g`; it writes through
  the symlink into this repo.

## Coding Style & Naming Conventions
- Match existing file style in the directory you edit; dotfile sources live in `config/`.
- Prefer concise, descriptive names for scripts and aliases; keep shell functions lowercase.
- Use POSIX-friendly shell where reasonable; add a brief comment for non-obvious steps.
- No formal formatter is configured; keep indentation consistent with nearby lines.

## Testing Guidelines
- `./test/run_test` builds a container and runs `install.sh` in it to check the
  Linux path end to end. Run it after touching any install script.
- Validate changes manually by running the relevant script (e.g., `./install.sh` on a clean setup) and checking updated symlinks or configs.

## Commit & Pull Request Guidelines
- Commit messages follow Conventional Commits (examples: `feat: add codex installer step`, `refactor: simplified new branch alias`).
- Keep commits focused (one logical change per commit).
- PRs should describe the change, list commands run (if any), and note any manual steps needed.

## Security & Configuration Tips
- Never commit secrets, tokens, or private keys; `ssh/` is config-only.
- Dotfiles are symlinked into `$HOME`; verify changes in both the repo and the target file.

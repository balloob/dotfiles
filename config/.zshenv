# ~/.zshenv — sourced by EVERY zsh invocation: interactive shells, scripts,
# `zsh -c …`, and subprocesses. Keep it minimal and side-effect-free (no output);
# it holds only what non-interactive shells and child processes must find on PATH.

# Rust (rustup writes this; guarded because brew-managed rust has no such file).
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# User-local binaries (mise, uv, claude, codex, …) and mise's runtime shims.
# This lives in .zshenv, not .zshrc, so the shims — real executables — are on
# PATH for non-interactive shells, scripts and child processes (e.g. `env node`),
# not just interactive prompts.
export PATH="$HOME/.local/bin:$HOME/.local/share/mise/shims:$PATH"

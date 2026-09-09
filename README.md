# Dotfiles

Setup scripts that are automatically added to my VS Code dev containers and GitHub Codespaces.

## Using with dev containers

You need to tell VS Code to use this dotfiles repository. It will be automatically installed on every new dev container.

These dotfiles do not contain the Git author identity. On a normal machine, put it in `~/.gitconfig-local`. That file stays outside this repo, and `.gitconfig` includes it. In a dev container, set it with the environment variables below.

Add this to your VS Code settings:

```json
{
  "dotfiles.repository": "balloob/dotfiles",
  "remote.containers.dotfiles.repository": "balloob/dotfiles",
  "terminal.integrated.env.linux": {
    "GIT_COMMITTER_NAME": "Your Name",
    "GIT_COMMITTER_EMAIL": "your@email.com",
    "GIT_AUTHOR_NAME": "Your Name",
    "GIT_AUTHOR_EMAIL": "your@email.com"
  }
}
```

## Using with Github Codespaces

Nothing. Just works.

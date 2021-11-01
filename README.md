# Dotfiles

Setup scripts that are automatically added to my VS Code dev containers and GitHub Codespaces.

## Using with dev containers

You need to tell VS Code to use this dotfiles repository. It will be automatically installed on every new dev container.

These dotfiles does not contain configuration for the Git author. This needs to be added via environment variables.

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

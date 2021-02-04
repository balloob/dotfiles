# Dotfiles

Used to be automatically added to my VS Code dev containers and GitHub Codespaces.

## Using with dev containers

You need to tell VS Code to use this dotfiles repository. It will be automatically installed on every new dev container.

These dotfiles does not contain configuration for the Git author. This needs to be added via environment variables.

Add this to your VS Code settings:

```json
{
  "dotfiles.repository": "balloob/dotfiles",
  "terminal.integrated.env.linux": {
    "GIT_COMMITTER_NAME": "Paulus Schoutsen",
    "GIT_COMMITTER_EMAIL": "balloob@gmail.com",
    "GIT_AUTHOR_NAME": "Paulus Schoutsen",
    "GIT_AUTHOR_EMAIL": "balloob@gmail.com"
  }
}
```

## Using with Github Codespaces

Nothing. Just works.

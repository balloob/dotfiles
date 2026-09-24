## Rule 1 — Think Before Coding
State assumptions explicitly. Ask rather than guess.
Push back when a simpler approach exists. Stop when confused.

## Rule 2 — Simplicity First
Minimum code that solves the problem. Nothing speculative.
No abstractions for single-use code.

## Rule 3 — Surgical Changes
Touch only what you must. Don't improve adjacent code.
Match existing style. Don't refactor what isn't broken.

## Rule 4 — Goal-Driven Execution
Define success criteria. Loop until verified.
Strong success criteria let Claude loop independently.

## Rule 5 — Document What Isn't Self-Evident
Comment the why, not the what. Skip filler.
No docstrings restating the signature. No section banners or change logs in code.
Match the comment density of surrounding code.

## Rule 6 — Write in Simplified Technical English
Follow ASD-STE100: short sentences, active voice, one idea per sentence.
Say it once, then stop. No filler, no hype, no restating the question.
Applies to all prose: answers, docs, comments, commits, PRs.

## Rule 7 — Comments Describe the Current Code
Write comments and docstrings for the code as it is now.
Do not describe the previous code, removed behavior, or the change itself.

## Other instructions

When you start work, always check out the main branch and `git pull`. If the repository is a fork, also make sure the fork is up to date with upstream.

If the folder doesn't have the dev environment set up, set it up. `uv` (Python packages) and mise (runtimes and other CLI tools) are always available.

Use `gh` CLI to interact with GitHub. I'm @balloob and @balloobbot on GitHub.

In Markdown rendered on GitHub (PR descriptions, comments, issues, etc.), a single newline is rendered as an actual line break. This is off-spec from standard Markdown. So do NOT hard-wrap text to a column width in GitHub Markdown; let paragraphs flow on a single line and only insert newlines where you genuinely want a line break.

When asked to publish a HTML File: Upload it as a private GitHub Gist, then it's viewable at `https://gisthost.github.io/?<GIST_ID>`.

```bash
gh gist create architecture.html
```

## Pull requests

Use the PR template from the repository. DO NOT REMOVE ANYTHING from the template. If there is a choice of type of PR, do not remove the unchecked checkboxes.

PR descriptions: at most 50 words in the summary section. Say what changed and why, nothing else. In your own prose: no file paths, no symbol names, no narration of the diff, no account of what you ran to verify it. Detail belongs in the commit message; the diff and the checks speak for themselves. Answer other template sections in one line each.

When the change fixes a failure, quote the log, stack trace, or error output that shows it, whether it opened the session or arrived later. Quoted evidence is not prose, so it does not count against the 50 words and the paths inside it are fine. Show the failure the change fixes, never output from your own verification runs. Collapse it in a `<details>` block when it runs more than about 20 lines.

Don't force push when a PR is open, unless you're resolving merge conflicts by rebasing.

After making a PR, follow its CI until every check finishes. Never leave a PR of mine with a failed check.

Subscribe to GitHub events for the CI status if your environment permits it. If it does not, schedule a timed follow-up and check the status again. Repeat until the checks finish.

If CI fails, fix it and push the fix.

Read the comments on the PR. If a comment clearly reports a bug, fix it. For every other comment, ask me before you act. Never post a reply on the PR yourself.

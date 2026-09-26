---
name: macos-dotfile-setup
description: >-
  Set up a new Mac from the shumuko/dotfile repo: prerequisites, Homebrew, NVM,
  Yarn, Java, SDKMAN, and symlinks into the home directory. Use when the user
  asks to set up a new Mac, bootstrap a machine, or install these dotfiles.
---

# macOS dotfile setup

Follow [README.md](../../../README.md) at the repo root. Do not invent extra tools.

## Rules

- Never copy tokens, API keys, emails, or usernames from another machine into this repo or into committed files.
- Secrets belong only in `$HOME/.secrets` (mode `600`). The profiles source that file when it exists.
- Link files from `$HOME/dotfile`. Do not overwrite `~/.secrets`.
- Back up an existing `~/.zshrc` or `~/.bash_profile` before replacing it with a symlink.
- `.zshrc` expects Java 25. `.bash_profile` expects Java 21. Install the JDK for the shell in use.
- `git-completion.bash` must be linked to `$HOME/git-completion.bash`, not only left inside the repo.
- Stop after the README checks pass, and say which optional pieces (SDKMAN, iTerm2, bash as login shell) were skipped.

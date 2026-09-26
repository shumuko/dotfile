# Dotfiles

Shell and editor config for a new Mac. These files contain no tokens, emails, or other secrets.

| File | Role |
|---|---|
| `.zshrc` | Default shell on current macOS. Homebrew, NVM, Yarn, git prompt, `.nvmrc` switching, SDKMAN, Java 25 |
| `.bash_profile` | Bash login shell. NVM, Yarn, git prompt, SDKMAN, Java 21. `cdnvm` is defined but not bound to `cd` |
| `.git-prompt.sh` | Git branch in the bash prompt |
| `git-completion.bash` | Git tab completion for bash. The profile sources `~/git-completion.bash` |
| `.vimrc` | Vim |
| `.editorconfig` | Editor defaults (UTF-8, LF, 2-space indent) |
| `iterm/Solarized-Dark.json` | iTerm2 dynamic profile: Solarized Dark, Monaco 12 |

## Prerequisites

Install these before linking the files. Versions below match what the profiles expect.

1. **macOS** with a local user account.
2. **Xcode Command Line Tools** — `git`, compilers, and `/usr/libexec/java_home`.
3. **Homebrew** — used by `.zshrc` (`brew shellenv`).
4. **Git** — Command Line Tools or `brew install git`.
5. **NVM** — installed under `$HOME/.nvm`.
6. **Node** — install a version with NVM and set a default (`nvm alias default node`).
7. **Yarn** — the profiles add `$HOME/.yarn/bin` to `PATH`.
8. **A JDK that `/usr/libexec/java_home` can see.**
   - `.zshrc` asks for Java **25**.
   - `.bash_profile` asks for Java **21**.
   - Install the one for the shell you use. Install both if you use both shells.
9. **SDKMAN** — optional. The profiles source it when `$HOME/.sdkman` exists.
10. **iTerm2** — optional. Each profile sources iTerm’s shell integration only if that file is already installed.

Not required for the shell to start: Vim, and anything in `$HOME/.local/bin` (local CLIs such as Codex).

## New Mac setup

### 1. Command Line Tools, Homebrew, and Git

```bash
xcode-select --install
```

Install Homebrew from https://brew.sh, then:

```bash
brew install git
```

### 2. Clone this repo

```bash
git clone https://github.com/shumuko/dotfile.git "$HOME/dotfile"
```

### 3. NVM, Node, and Yarn

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.8/install.sh | bash
```

Open a new terminal, then:

```bash
nvm install --lts
nvm alias default node
npm install -g yarn
```

### 4. Java

```bash
brew install openjdk@21
```

Install `openjdk@25` as well if you use zsh. Follow the `brew info` caveats so `/usr/libexec/java_home -v 21` and `-v 25` succeed. Homebrew JDKs often need a symlink into `/Library/Java/JavaVirtualMachines`.

### 5. SDKMAN (optional)

```bash
curl -s "https://get.sdkman.io" | bash
```

### 6. iTerm2

```bash
brew install --cask iterm2
```

This Mac’s default iTerm profile is **Solarized Dark**, font **Monaco 12**, 80×25, no transparency, no blur, bold and italic on, cursor not blinking. The shell prompt colors (yellow name, cyan path, git branch) come from `.zshrc` and `.bash_profile`, not from iTerm.

Load the same profile:

```bash
mkdir -p "$HOME/Library/Application Support/iTerm2/DynamicProfiles"
ln -sfn "$HOME/dotfile/iterm/Solarized-Dark.json" \
  "$HOME/Library/Application Support/iTerm2/DynamicProfiles/Solarized-Dark.json"
```

Quit and reopen iTerm. In **Settings → Profiles**, select **Solarized Dark**, open **Other Actions**, and choose **Set as Default**.

In iTerm: **Settings → General → Magic → Install Shell Integration**.

### 7. Link the files into your home directory

Back up anything you already have. Linking replaces the destination.

```bash
cd "$HOME"
ln -sfn "$HOME/dotfile/.zshrc" .zshrc
ln -sfn "$HOME/dotfile/.bash_profile" .bash_profile
ln -sfn "$HOME/dotfile/.git-prompt.sh" .git-prompt.sh
ln -sfn "$HOME/dotfile/git-completion.bash" git-completion.bash
ln -sfn "$HOME/dotfile/.vimrc" .vimrc
ln -sfn "$HOME/dotfile/.editorconfig" .editorconfig
```

### 8. Secrets stay on the machine

Both profiles source `$HOME/.secrets` when that file exists. Put tokens there and do not commit it.

```bash
chmod 600 "$HOME/.secrets"
```

Example contents:

```bash
export NPM_TOKEN="..."
export HOMEBREW_GITHUB_API_TOKEN="..."
```

### 9. Reload

macOS uses zsh by default, so open a new terminal and `.zshrc` loads.

For bash as the login shell:

```bash
chsh -s /bin/bash
```

Then quit and reopen the terminal.

## Check

```bash
command -v brew
command -v nvm
command -v yarn
java -version
git --version
```

In a git repo, the prompt should show the branch name.

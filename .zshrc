# ~/.zshrc - ZSH Configuration File

# ——————————————————————————————————————————————————————————
# 1) Homebrew (macOS) - Load first to ensure proper PATH
# ——————————————————————————————————————————————————————————
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"

# ——————————————————————————————————————————————————————————
# 2) NVM (Node Version Manager)
# ——————————————————————————————————————————————————————————
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"            # nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# ——————————————————————————————————————————————————————————
# 3) Yarn & Additional PATH
# ——————————————————————————————————————————————————————————
export PATH="$HOME/.yarn/bin:/usr/local/sbin:$PATH"

# ——————————————————————————————————————————————————————————
# 4) Automatic cd → nvm use (.nvmrc) support
# ——————————————————————————————————————————————————————————
# Set to "false" to disable auto nvm switching
NVM_AUTO_SWITCH="${NVM_AUTO_SWITCH:-true}"

cdnvm() {
    # First, do the actual cd - if this fails, return immediately
    command cd "$@" || return $?

    # Only try nvm stuff if auto-switch is enabled and nvm is available
    if [[ "$NVM_AUTO_SWITCH" == "true" ]] && command -v nvm >/dev/null 2>&1 && command -v nvm_find_up >/dev/null 2>&1; then
        local nvm_path
        nvm_path="$(nvm_find_up .nvmrc 2>/dev/null | command tr -d '\n')"

        # If there's an .nvmrc file, use it
        if [[ -n "$nvm_path" && -s "${nvm_path}/.nvmrc" && -r "${nvm_path}/.nvmrc" ]]; then
            local nvm_version
            nvm_version=$(<"${nvm_path}"/.nvmrc)

            # Only switch if we're not already using the right version
            if [ "$(nvm current 2>/dev/null)" != "v${nvm_version}" ]; then
                nvm use "${nvm_version}" 2>/dev/null || nvm use default 2>/dev/null
            fi
        else
            # No .nvmrc found, use default if we're not already using it
            local default_version
            default_version="$(nvm version default 2>/dev/null)"
            if [[ -n "$default_version" && "$default_version" != "N/A" ]]; then
                if [ "$(nvm current 2>/dev/null)" != "${default_version}" ]; then
                    nvm use default 2>/dev/null
                fi
            fi
        fi
    fi
}

# Comment out this line if you want to use native cd without nvm auto-switching
alias cd='cdnvm'

# initialize cdnvm on shell start
cdnvm "$PWD" 2>/dev/null || true

# ——————————————————————————————————————————————————————————
# 5) Load macOS default profile (if any)
# ——————————————————————————————————————————————————————————
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

# ——————————————————————————————————————————————————————————
# 6) Git prompt + completion
# ——————————————————————————————————————————————————————————
# add custom completion directory
fpath=(~/.zsh/completion $fpath)
autoload -U compinit && compinit

# ZSH-native git prompt function
git_prompt_info() {
    local branch
    if branch=$(git symbolic-ref --short HEAD 2>/dev/null); then
        local dirty=""
        # Check for uncommitted changes
        if ! git diff --quiet 2>/dev/null; then
            dirty="*"
        fi
        # Check for staged changes
        if ! git diff --cached --quiet 2>/dev/null; then
            dirty="${dirty}+"
        fi
        echo " (%F{blue}${branch}${dirty}%f)"
    fi
}

# ZSH-compatible PS1 with branch name
setopt PROMPT_SUBST
export PS1='%F{yellow}%n%f:%F{cyan}%~%f$(git_prompt_info) %# '

# ——————————————————————————————————————————————————————————
# 7) Common env vars & aliases
# ——————————————————————————————————————————————————————————
# Colorize ls & grep
export CLICOLOR=1
export GREP_OPTIONS='--color=auto'

# Custom aliases
alias ll='ls -la'
alias gru='git remote update'
alias grom='git rebase origin/master'
alias co='git checkout'
alias be='bundle exec'

# iTerm2 shell integration (use zsh version)
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# History settings for zsh
export HISTIGNORE="&:[ ]*:exit:oplop*"
export HISTSIZE=10000
export SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export JAVA_HOME=$(/usr/libexec/java_home -v 25)
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Optional local secrets. Never commit this file.
[[ -s "$HOME/.secrets" ]] && source "$HOME/.secrets"

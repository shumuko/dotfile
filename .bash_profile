### Load the default .profile
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

### NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH="/usr/local/sbin:$PATH"

### YARN
export PATH="$PATH:$HOME/.yarn/bin"

### Git tab completion
if [ -f ~/git-completion.sh ]; then
    source ~/git-completion.sh
elif [ -f ~/git-completion.bash ]; then
    source ~/git-completion.bash
fi

### Added for color ls and grep
export CLICOLOR=1
export GREP_OPTIONS='--color=auto'

### Git branch in prompt
source ~/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1 # Show statge changes

PS1='\[\e[0;33m\]\u\[\e[0m\]\[\e[0;37m\]:\[\e[0m\]\[\e[0;36m\][\w]\[\e[0m\]\[\e[0;31m\]$(__git_ps1 " (%s)")\[\e[0m\]: '

### Set alias
alias ll='ls -la'
alias gru='git remote update'
alias grom='git rebase origin/master'
alias co='git checkout'
alias be='bundle exec'

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

### Oplop
export HISTIGNORE="&:[ ]*:exit:oplop*"

### Switch node version (https://github.com/nvm-sh/nvm#bash)
cdnvm() {
    command cd "$@" || return $?
    nvm_path="$(nvm_find_up .nvmrc | command tr -d '\n')"

    # If there are no .nvmrc file, use the default nvm version
    if [[ ! $nvm_path = *[^[:space:]]* ]]; then

        declare default_version
        default_version="$(nvm version default)"

        # If there is no default version, set it to `node`
        # This will use the latest version on your machine
        if [ $default_version = 'N/A' ]; then
            nvm alias default node
            default_version=$(nvm version default)
        fi

        # If the current version is not the default version, set it to use the default version
        if [ "$(nvm current)" != "${default_version}" ]; then
            nvm use default
        fi
    elif [[ -s "${nvm_path}/.nvmrc" && -r "${nvm_path}/.nvmrc" ]]; then
        declare nvm_version
        nvm_version=$(<"${nvm_path}"/.nvmrc)

        declare locally_resolved_nvm_version
        # `nvm ls` will check all locally-available versions
        # If there are multiple matching versions, take the latest one
        # Remove the `->` and `*` characters and spaces
        # `locally_resolved_nvm_version` will be `N/A` if no local versions are found
        locally_resolved_nvm_version=$(nvm ls --no-colors "${nvm_version}" | command tail -1 | command tr -d '\->*' | command tr -d '[:space:]')

        # If it is not already installed, install it
        # `nvm install` will implicitly use the newly-installed version
        if [ "${locally_resolved_nvm_version}" = 'N/A' ]; then
            nvm install "${nvm_version}";
        elif [ "$(nvm current)" != "${locally_resolved_nvm_version}" ]; then
            nvm use "${nvm_version}";
        fi
    fi
}

#alias cd='cdnvm'
#cdnvm "$PWD" 2>/dev/null || true

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export JAVA_HOME=$(/usr/libexec/java_home -v 21)
export PATH="$JAVA_HOME/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"

# Optional local secrets. Never commit this file.
[[ -s "$HOME/.secrets" ]] && source "$HOME/.secrets"

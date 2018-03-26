export PATH="/usr/local/sbin:$PATH"

### Load the default .profile
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

### Load RVM into a shell session *as a function*
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

### Add RVM to PATH for scripting
#export PATH="$PATH:$HOME/.rvm/bin"

### NVM
export NVM_DIR="/Users/fionkou/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

### Git tab completion
source ~/git-completion.bash

### Added for color ls and grep
export CLICOLOR=1
export GREP_OPTIONS='--color=auto'

### Git branch in prompt
source ~/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1 # Show statge changes

PS1="\[\e[00;33m\]\u\[\e[0m\]\[\e[00;37m\]:\[\e[0m\]\[\e[00;36m\][\w]\[\e[00;31m\]\$(__git_ps1 \"(%s)\"): \[\e[0m\]"

#PS1="\[\e[00;33m\]\u\[\e[0m\]\[\e[00;37m\]@\h:\[\e[0m\]\[\e[00;36m\][\w] \$(__git_ps1 \"(%s)\"): \[\e[0m\]"

### Set alias
alias ll='ls -la'
alias gru='git remote update'
alias grom='git rebase origin/master'
alias co='checkout'
alias be='bundle exec'

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

### Oplop
export HISTIGNORE="&:[ ]*:exit:oplop*"

### Autodesk for Artifactory to work over VPN
export BUNDLE_ARTIFACTORY__ADSKENGINEER__NET="bim360cif:J%23CKGs_peagz48%2F%26"

### Rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="/usr/local/opt/postgresql@9.5/bin:$PATH"

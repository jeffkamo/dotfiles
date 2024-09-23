export ZSH="$HOME/.oh-my-zsh"

# Custom paths
export PATH="$HOME/Library/Python/2.7/bin:$PATH" # for the aws eb CLI
export PATH="/usr/local/sbin:$PATH" # recommended by `brew doctor`
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export PATH=$HOME/.nodenv/shims/typescript-language-server:$PATH
export PATH=$HOME/.nodenv/versions/14.17.0/bin/prettierd:$PATH
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"

# Clio dev command stuff. Disable if the machine is not for Clio
eval "$(dev _hook)"

# Set ZSH configs
ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh

# Make autocomplete more like Bash
# http://serverfault.com/questions/109207/how-do-i-make-zsh-completion-act-more-like-bash-completion
setopt noautomenu
setopt nomenucomplete

# Some Neovim stuff
export EDITOR='nvim'
alias vim='nvim'


# == CLIO_ANDROID_SETUP ==

# Android PATHs
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin/:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

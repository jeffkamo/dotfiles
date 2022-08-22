export ZSH="$HOME/.oh-my-zsh"

# Paths I copied from other people
export PATH="$HOME/Library/Python/2.7/bin:$PATH" # for the aws eb CLI
export PATH="/usr/local/sbin:$PATH" # recommended by `brew doctor`
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"

# Paths to my node shim modules
export PATH=$HOME/.nodenv/shims/typescript-language-server:$PATH
export PATH=$HOME/.nodenv/versions/14.17.0/bin/prettierd:$PATH

# Some ZSH stuff
ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh
# Make autocomplete more like Bash
# http://serverfault.com/questions/109207/how-do-i-make-zsh-completion-act-more-like-bash-completion
setopt noautomenu
setopt nomenucomplete

# Some Neovim stuff
export EDITOR='nvim'
alias vim='nvim'


export ZSH="$HOME/.oh-my-zsh"

# Custom paths
export PATH="/opt/homebrew/bin:$PATH"

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


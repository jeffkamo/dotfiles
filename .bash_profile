# Applies customization to command prompt
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] \n$ "

# Aliases
alias karma='function _karma(){ KARMA_FILTER="$1" NUM_EXECUTORS=1 yarn --cwd components/manage run test:main; };_karma'

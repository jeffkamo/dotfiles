# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# ZSH autocomplete customizations
# zstyle ':autocomplete:*' delay 1  # seconds (float)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Make autocomplete more like Bash
# http://serverfault.com/questions/109207/how-do-i-make-zsh-completion-act-more-like-bash-completion
# setopt noautomenu
# setopt nomenucomplete

# Work (Clio)
# ===========

# Clio - Paths for Work
# ---------------------
# export PATH="$HOME/Library/Python/2.7/bin:$PATH" # for the aws eb CLI
# export PATH="/usr/local/sbin:$PATH" # recommended by `brew doctor`
# export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
# export PATH=$HOME/.nodenv/shims/typescript-language-server:$PATH
# export PATH=$HOME/.nodenv/versions/14.17.0/bin/prettierd:$PATH
# export PATH="/opt/homebrew/bin:$PATH"
# export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"

# Clio - Android setup, including paths
# -------------------------------------
# export ANDROID_HOME="$HOME/Library/Android/sdk"
# export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin/:$PATH"

# Clio - Dev CLI setup
# --------------------
# eval "$(dev _hook)" # Enable if this is a work machine for Clio

# Personal
# ========

# ZSH customizations with ZINIT plugins
# -------------------------------------

# Set the directory we want to store zinit and plugins
# https://github.com/zdharma-continuum/zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Load zinit dependencies / zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab # especially used for ctrl-r history search

# keybindings for zsh stuff
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Configure zinit plugins
HISTSIZE=5000 # the size of the history
HISTFILE=~/.zsh_history # The location history is saved
SAVEHIST=$HISTSIZE # must be the same size as HISTSIZE
HISTDUPE=erase # whether duplicates are erased or not
setopt appendhistory # appends to history rather than overriding it
setopt sharehistory # shares history across all zsh sessions that are simultaneously running
setopt hist_ignore_space # prevents a command from writing to history if it starts with a space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups # prevents dupes from appearing in historical search

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "{(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# Load zinit completions
autoload -U compinit && compinit
zinit cdreplay -q # Not sure what this is, something about caching? Recommended by zinit's docs

# Personal paths
# --------------
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH" # where oh-my-posh is located
export PATH="$HOME/.local/share:$PATH" # where zinit is location

# Setup oh-my-posh for custom prompt goodness
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"

# My aliases
export EDITOR='nvim'
alias vim='nvim'
alias ls='eza -lah --icons=auto --group-directories-first'
alias l='eza -lah --icons=auto --group-directories-first'
alias ll='eza -lh --icons=auto --group-directories-first'

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# I think this is related to TMUX stuff
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

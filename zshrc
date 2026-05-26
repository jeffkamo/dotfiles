# ====== Clio LLM Gateway (managed by `dev`) ======
# Routes Claude through Clio's LLM gateway by setting ANTHROPIC_BASE_URL and
# ANTHROPIC_AUTH_TOKEN from the local token file.
#
#   Gateway: https://llm-gateway.clio.systems/
#   Help:    #pt-llm-gateway on Slack
#   Refresh: `dev login --force`
#
# Edits to this block will be overwritten.
__clio_llm_gateway_token_path="$HOME/.clio/llm-gateway-token"
if [ -f "$__clio_llm_gateway_token_path" ]; then
  export ANTHROPIC_BASE_URL="${LLM_GATEWAY_URL:-https://llm-gateway.clio.systems}"
  export ANTHROPIC_AUTH_TOKEN="$(cat "$__clio_llm_gateway_token_path")"
fi
unset __clio_llm_gateway_token_path
# ====== End Clio LLM Gateway ======

export ZSH="$HOME/.oh-my-zsh"

# Custom paths
export PATH="$HOME/Library/Python/2.7/bin:$PATH" # for the aws eb CLI
export PATH="/usr/local/sbin:$PATH" # recommended by `brew doctor`
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH=$HOME/.nodenv/shims/typescript-language-server:$PATH
export PATH=$HOME/.nodenv/versions/14.17.0/bin/prettierd:$PATH
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

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

# A Clio tool called "Reflect" which spins up a process that automatically
# applies all of a repo's related worktrees to the main working branch.#
alias reflect="python3 ~/clio/grow_tools/reflect/reflect.py"

# Configuration for `wt` tool. https://github.com/max-sixty/worktrunk
# wt is a dependency of .config/lazygit/config.yml
if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

# == CLIO_ANDROID_SETUP ==

# Android PATHs
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin/:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

[[ -d "/opt/clio/bin/devxp" ]] && export PATH="/opt/clio/bin/devxp:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jeffkamo/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jeffkamo/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jeffkamo/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jeffkamo/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

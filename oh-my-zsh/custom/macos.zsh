if command -v dev &>/dev/null; then
  eval "$(dev _hook)"
fi

# export local bin after rbenv inits so we can override the shims (for bin/rspec, bin/rails, etc)
export PATH="./bin:$PATH" 

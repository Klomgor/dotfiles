# Local Machine-Specific Configuration

# Source secure environment variables
if [ -f ~/.env ]; then
    set -o allexport
    source ~/.env
    set +o allexport
fi

# Ansible Configuration
export ANSIBLE_CONFIG="$HOME/.ansible.cfg"
export ANSIBLE_INVENTORY="$HOME/.ansible/inventory"
export ANSIBLE_NOCOWS=1
export ANSIBLE_RETRY_FILES_ENABLED=0
export ANSIBLE_FORCE_COLOR=true

# Docker Desktop completions
if [ -d "$HOME/.docker/completions" ]; then
    fpath=($HOME/.docker/completions $fpath)
fi

# Load completions from Homebrew
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Load local custom plugins if they exist
if [ -d "$HOME/.zsh/custom" ]; then
    for file in $HOME/.zsh/custom/*.zsh; do
        [ -r "$file" ] && source "$file"
    done
fi

# Local PATH additions
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$PATH:$HOME/.local/bin"
fi

# Local completion paths
if [ -d "$HOME/.zsh/completions" ]; then
    fpath=($HOME/.zsh/completions $fpath)
fi

# Reload completion system after all configurations are loaded
autoload -Uz compinit
compinit -u

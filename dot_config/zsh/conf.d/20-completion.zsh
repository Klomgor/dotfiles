# Completion System Configuration

# Initialize completion system
autoload -Uz compinit && compinit -u
autoload -U +X bashcompinit && bashcompinit

# Cache completion for faster startup
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
    compinit -i
else
    compinit -C -i
fi

# Load completion cache
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"

# Completion Options
zstyle ':completion:*' menu select                       # Use menu selection
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}   # Colored completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive
zstyle ':completion:*' group-name ''                    # Group results by category
zstyle ':completion:*:descriptions' format '[%d]'       # Group description format
zstyle ':completion:*' verbose yes                      # Verbose completion
zstyle ':completion:*' rehash true                      # Rehash automatically
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f' # Warning format
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'

# Fuzzy match mistyped completions
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Process completion
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# Load external completions
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Docker completions
if [ -d "$HOME/.docker/completions" ]; then
    fpath=($HOME/.docker/completions $fpath)
fi

# Kubernetes completions
if command -v kubectl &>/dev/null; then
    source <(kubectl completion zsh)
fi

# Helm completions
if command -v helm &>/dev/null; then
    source <(helm completion zsh)
fi

# AWS completions
if command -v aws &>/dev/null; then
    complete -C aws_completer aws
fi

# FZF completions
if [ -n "${commands[fzf-share]}" ]; then
    source "$(fzf-share)/key-bindings.zsh"
    source "$(fzf-share)/completion.zsh"
fi

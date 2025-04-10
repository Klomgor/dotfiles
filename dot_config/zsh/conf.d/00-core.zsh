# Core ZSH Configuration

# Basic Environment Settings
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export TERM="xterm-256color"
export EDITOR="nano"
export STARSHIP_CONFIG="$HOME/.config/starship.toml"

# Path Configuration
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="$PATH:/Users/osama/.local/bin"

# Node.js Configuration
export NODE_HOME="/opt/homebrew/opt/node@20"
export CPPFLAGS="${CPPFLAGS} -I${NODE_HOME}/include"
export LDFLAGS="${LDFLAGS} -L${NODE_HOME}/lib"

# Security Settings
umask 022
export HISTCONTROL=ignorespace

# FZF Configuration
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
export FZF_DEFAULT_COMMAND="eza --all --long --group --icons"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Less Configuration
export LESSHISTFILE=-    # Disables less history

# Homebrew Configuration
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_AUTOREMOVE=1
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
export HOMEBREW_BAT=1
export HOMEBREW_INSTALL_FROM_API=1

# Basic ZSH Options
setopt AUTO_CD              # Change directory without cd
setopt EXTENDED_GLOB        # Extended globbing
setopt NOTIFY              # Report status of background jobs immediately
setopt PROMPT_SUBST        # Enable parameter expansion in prompts
setopt INTERACTIVE_COMMENTS # Allow comments in interactive shells

# Directory Stack
setopt AUTO_PUSHD           # Push directories automatically
setopt PUSHD_IGNORE_DUPS    # Don't push duplicates
setopt PUSHD_MINUS          # Use +/- operators for directory stack

# Performance Improvements
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

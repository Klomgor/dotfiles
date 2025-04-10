# Plugins Configuration

# Initialize Starship Prompt
eval "$(starship init zsh)"

# Initialize Zoxide
eval "$(zoxide init --cmd cd zsh)"

# Initialize Direnv
eval "$(direnv hook zsh)"

# Initialize TheFuck with custom configuration
if (( $+commands[thefuck] )); then
    export THEFUCK_PRIORITY="no_command=9999:sudo=100"
    export THEFUCK_HISTORY_LIMIT=9999
    export THEFUCK_WAIT_COMMAND=3
    export THEFUCK_REQUIRE_CONFIRMATION=true
    export THEFUCK_INSTANT_MODE=true
    export THEFUCK_NUM_CLOSE_MATCHES=4
    export THEFUCK_ALTER_HISTORY=true
    export THEFUCK_WAIT_SLOW_COMMAND=15
    export THEFUCK_SLOW_COMMANDS="lein react-native gradle ./gradlew vagrant"
    export THEFUCK_DEBUG=false
    eval "$(thefuck --alias)"
    alias f='fuck'
fi

# Load and configure zsh-syntax-highlighting
if [ -f /run/current-system/sw/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /run/current-system/sw/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Load and configure zsh-autosuggestions
if [ -f /run/current-system/sw/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /run/current-system/sw/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
    ZSH_AUTOSUGGEST_USE_ASYNC=1
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    bindkey '^ ' autosuggest-accept
fi

# Load and configure zsh-history-substring-search
if [ -f /run/current-system/sw/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
    source /run/current-system/sw/share/zsh-history-substring-search/zsh-history-substring-search.zsh
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi

# Load and configure zsh-autopair
if [ -f /run/current-system/sw/share/zsh-autopair/autopair.zsh ]; then
    source /run/current-system/sw/share/zsh-autopair/autopair.zsh
fi

# Load and configure zsh-command-time
if [ -f /run/current-system/sw/share/zsh-command-time/command-time.plugin.zsh ]; then
    source /run/current-system/sw/share/zsh-command-time/command-time.plugin.zsh
fi

# Load and configure you-should-use
if [ -f /run/current-system/sw/share/zsh-you-should-use/you-should-use.plugin.zsh ]; then
    source /run/current-system/sw/share/zsh-you-should-use/you-should-use.plugin.zsh
    YSU_MESSAGE_FORMAT="💡 %alias_type: %alias → %command"
    YSU_MODE="ALL"
fi

# Load and configure zsh-defer
if [ -f /run/current-system/sw/share/zsh-defer/zsh-defer.plugin.zsh ]; then
    source /run/current-system/sw/share/zsh-defer/zsh-defer.plugin.zsh
fi

# Load and configure forgit
if [ -f /run/current-system/sw/share/zsh-forgit/forgit.plugin.zsh ]; then
    source /run/current-system/sw/share/zsh-forgit/forgit.plugin.zsh
fi

# Load and configure fzf-tab
if [ -f /run/current-system/sw/share/zsh-fzf-tab/fzf-tab.plugin.zsh ]; then
    source /run/current-system/sw/share/zsh-fzf-tab/fzf-tab.plugin.zsh

    # Preview configuration
    zstyle ':completion:*:*:*:*:*' fzf-preview 'bat --color=always --style=numbers --line-range=:500 {}'
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -l --color=always $realpath'
    zstyle ':completion:*:*:kill:*:processes' fzf-preview 'ps --pid=$1 -o cmd --no-headers -w -w'
fi

# iTerm2 Integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Function to check if plugins are properly sourced
check_zsh_plugins() {
    local plugins=(
        "zsh-syntax-highlighting"
        "zsh-autosuggestions"
        "zsh-history-substring-search"
        "zsh-autopair"
        "zsh-command-time"
        "zsh-you-should-use"
        "zsh-defer"
        "zsh-forgit"
        "zsh-fzf-tab"
    )

    for plugin in "${plugins[@]}"; do
        if [ -d "/run/current-system/sw/share/${plugin}" ]; then
            echo "✅ ${plugin} is installed"
        else
            echo "❌ ${plugin} is missing"
        fi
    done
}

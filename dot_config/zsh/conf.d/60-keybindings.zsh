# Keybindings Configuration

# Use emacs key bindings
bindkey -e

# Make sure the terminal is in application mode when zle is active
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init() {
        echoti smkx
    }
    function zle-line-finish() {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# History substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

# Atuin history search
bindkey '^r' _atuin_search_widget
bindkey '^[[A' _atuin_up_search_widget
bindkey '^[OA' _atuin_up_search_widget

# Word movement
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Beginning/End of line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# Delete word
bindkey '^w' backward-kill-word

# Clear screen
bindkey '^l' clear-screen

# Menu selection
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Autosuggestions
bindkey '^ ' autosuggest-accept
bindkey '^f' autosuggest-accept

# FZF
bindkey '^t' fzf-file-widget
bindkey '^[c' fzf-cd-widget
bindkey '^[r' fzf-history-widget

# Edit command in editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Reverse menu completion
bindkey '^[[Z' reverse-menu-complete

# History Configuration

# History file configuration
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

# History command configuration
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format
setopt SHARE_HISTORY            # Share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST   # Expire duplicate entries first when trimming history
setopt HIST_IGNORE_DUPS         # Don't record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS     # Delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS        # Do not display a line previously found
setopt HIST_IGNORE_SPACE        # Don't record entries starting with a space
setopt HIST_SAVE_NO_DUPS        # Don't write duplicate entries in the history file
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks before recording entry
setopt HIST_VERIFY             # Don't execute immediately upon history expansion

# Atuin Configuration (if installed)
if command -v atuin &>/dev/null; then
    export ATUIN_NOBIND="true"
    eval "$(atuin init zsh)"

    # Keybindings for Atuin
    bindkey '^r' _atuin_search_widget
    bindkey '^[[A' _atuin_up_search_widget
    bindkey '^[OA' _atuin_up_search_widget
fi

# Additional history search bindings
bindkey '^[[B' history-substring-search-down  # Down arrow
bindkey '^[[A' history-substring-search-up    # Up arrow

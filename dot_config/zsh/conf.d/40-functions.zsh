# Functions Configuration

# Directory Management
# Create a new directory and enter it
mkcd() {
    mkdir -p "$@" && cd "$@"
}

# Navigate up directories with fzf
up() {
    local parent
    parent=$(pwd | awk -F/ '{for(i=NF;i>1;i--){print $i}}' | fzf)
    [ -n "$parent" ] && cd "$(pwd | sed "s|/$parent.*||")/$parent"
}

# Archive Management
# Extract most known archives with one command
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Git Functions
# Sync with upstream repository
gsync() {
    if [[ ! "$1" ]] ; then
        echo "You must supply a branch."
        return 1
    fi

    BRANCHES=$(git branch --list $1)
    if [ ! "$BRANCHES" ] ; then
        echo "Branch $1 does not exist."
        return 1
    fi

    git checkout "$1" && \
    git pull upstream "$1" && \
    git push origin "$1"
}

# Initialize a new git repository
ginit() {
    git init && \
    git add . && \
    git commit -m "Initial commit"
}

# Cleanup merged branches
git-cleanup() {
    git branch --merged | egrep -v "(^\*|master|main|dev)" | xargs git branch -d
}

# Docker Functions
# Run a one-off container
dockrun() {
    docker run -it ${1:-ubuntu:latest} /bin/bash
}

# Enter a running container
denter() {
    if [[ ! "$1" ]] ; then
        echo "You must supply a container ID or name."
        return 1
    fi
    docker exec -it $1 ${2:-bash}
}

# SSH Management
# Remove known_hosts entry
knownrm() {
    re='^[0-9]+$'
    if ! [[ $1 =~ $re ]] ; then
        echo "error: line number missing" >&2
        return 1
    fi
    sed -i '' "$1d" ~/.ssh/known_hosts
}

# Development Tools
# Create a data URL from a file
dataurl() {
    local mimeType=$(file -b --mime-type "$1")
    if [[ $mimeType == text/* ]]; then
        mimeType="${mimeType};charset=utf-8"
    fi
    echo "data:${mimeType};base64,$(base64 -i "$1")"
}

# Start an HTTP server from a directory
serve() {
    local port="${1:-8000}"
    python3 -m http.server "$port"
}

# Directory Navigation with FZF
# Fuzzy find directory and cd into it
zf() {
    local dir
    dir=$(zoxide query -l | fzf \
        --preview="eza --all --long --group --icons {}" \
        --height 40% \
        --layout=reverse \
        --border \
        --bind 'ctrl-/:change-preview-window(down|hidden|)' \
        --preview-window 'right:60%'
    ) && cd "$dir"
}

# Find file and cd into its directory
ff() {
    local file
    file=$(fd --type d --hidden --follow --exclude .git | fzf)
    [ -n "$file" ] && cd "$file"
}

# Search history with fzf
search_history() {
    atuin search --shell-history | fzf --preview 'echo {}'
}

# Utility Functions
# Get weather information
get_weather() {
    local city="${1:-}"
    command curl -s "wttr.in/${city}"
}

# Get public IP address
get_public_ip() {
    command dig +short myip.opendns.com @resolver1.opendns.com
}

# Set window title
set_win_title() {
    echo -ne "\033]0;$(basename "$PWD")\007"
}

# Initialize window title
starship_precmd_user_func="set_win_title"

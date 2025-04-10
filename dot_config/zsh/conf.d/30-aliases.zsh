# Aliases Configuration

# Directory Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias :q='exit'

# List Directory Contents (using eza if available)
if command -v eza &>/dev/null; then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza --icons --group-directories-first -l'
    alias la='eza --icons --group-directories-first -la'
    alias lt='eza --icons --group-directories-first --tree'
    alias l='eza --icons --group-directories-first -l'
else
    alias ls='ls --color=auto'
    alias ll='ls -l'
    alias la='ls -la'
    alias l='ls -l'
fi

# File Operations
alias mkdir='mkdir -p'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Git Aliases
alias g='git status -sb'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gco='git checkout'
alias gd='git diff --color-words'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gp='git push'
alias gpl='git pull --rebase'
alias gf='git fetch'
alias gfa='git fetch --all'
alias gst='git status'
alias gss='git stash save'
alias gsp='git stash pop'
alias gr='git rebase -i HEAD~15'

# Docker Aliases
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias lzd='lazydocker'

# Kubernetes Aliases
alias k='kubectl'
alias kns='kubens'
alias kctx='kubectx'
alias kg='kubectl get'
alias kd='kubectl describe'
alias krm='kubectl delete'

# Ansible Aliases
alias ap='ansible-playbook'
alias al='ansible-lint'
alias av='ansible-vault'
alias ag='ansible-galaxy'
alias ai='ansible-inventory --list'

# Development Tools
alias py='python3'
alias pip='pip3'
alias tf='terraform'
alias a='ansible'

# Text Manipulation
alias cat='bat --style=plain --paging=never'
alias grep='rg'
alias find='fzf'

# System Information
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias top='htop'
alias path='echo -e ${PATH//:/\\n}'
alias ports='netstat -tulanp'

# Tmux
alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tmux='tmux -2'

# Package Management (Homebrew)
if command -v brew &>/dev/null; then
    alias bi='brew install'
    alias bci='brew cask install'
    alias bu='brew update'
    alias bup='brew upgrade'
fi

# Cheat Sheets
alias chw='cheat -t work'
alias chd='cheat -t development'
alias chp='cheat -t personal'
alias chl='cheat -l'
alias che='cheat -e'
alias chs='cheat -s'

# Utility Aliases
alias reload='source ~/.zshrc'
alias zshrc='nano ~/.zshrc'
alias c='clear'
alias h='history'
alias weather='curl wttr.in'
alias myip='curl ifconfig.me'
alias timestamp='date "+%Y%m%d_%H%M%S"'
alias tldr='tldr --theme=base16'

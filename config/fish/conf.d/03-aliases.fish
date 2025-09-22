# =============================================================================
# ALIASES AND SHORTCUTS
# =============================================================================

if status is-interactive
    # Enhanced file operations
    alias ls="eza --icons --group-directories-first -s date -r"
    alias ll="eza -l --icons --header --group-directories-first -s date -r --git"
    alias la="eza -la --icons --header --group-directories-first -s date -r --git"
    alias tree="eza --tree --icons --group-directories-first"
    alias cat="batcat --theme=Dracula"

    # Shell management
    alias sfish="source ~/.config/fish/config.fish"
    alias cfish="nvim ~/.config/fish/config.fish"

    # Project navigation
    alias cdcode='cd ~/Code'
    alias cdutils='cd ~/Code/deptecnologiagke/utils'
    alias pcd='cd (find ~/Code -type d -maxdepth 2 2>/dev/null | fzf)'

    # System monitoring
    alias du='du -h'
    alias df='df -h'
    alias free='free -h'

    # Development servers
    alias serve='python -m http.server'
end

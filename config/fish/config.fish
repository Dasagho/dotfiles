if status is-interactive
    # Commands to run in interactive sessions can go here
    # alias ls="exa"
    # alias ll="exa -l --icons --header"
    # alias cat="batcat"
    alias dps='docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Command}}\t{{.CreatedAt}}\t{{.Status}}"'
    alias sfish="source ~/.config/fish/config.fish"
    # alias kubectl="minikube kubectl --"
    alias dconn='docker ps --format "{{.Names}}" | fzf | xargs -o -I {} docker exec -it {} /bin/bash'
    alias kitty='kitty --title "kitty"'

    fish_add_path -g /home/ayuda104/Scripts
    set -g theme_nerd_fonts yes
    set -g theme_color_scheme dark
    set -g theme_display_git_dirty yes
    set -g theme_display_git_untracked yes
    set -g theme_display_python_virtualenv no

    # fish_add_path "/home/ayuda104/.local/share/fnm"

    # set -Ux FLYCTL_INSTALL "/home/ayuda104/.fly"
    # fish_add_path "$FLYCTL_INSTALL/bin"
    fish_add_path $HOME/.local/share/nvim/mason/bin
    fish_add_path $HOME/.local/bin

    if test -n "$TMUX"
        set -x TERM xterm-256color
    end

    set -g __sdkman_custom_dir "$HOME/.sdkman"
    fnm env | source
end

# source ~/.config/fish/functions/git_alias.fish

# bun
# set --export BUN_INSTALL "$HOME/.bun"
# set --export PATH $BUN_INSTALL/bin $PATH

# pnpm
# set -gx PNPM_HOME "/home/ayuda104/.local/share/pnpm"
# if not string match -q -- $PNPM_HOME $PATH
#   set -gx PATH "$PNPM_HOME" $PATH
# end
# pnpm end

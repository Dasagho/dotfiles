if status is-interactive
    # Commands to run in interactive sessions can go here
    alias ls="exa"
    alias ll="exa -l --icons --header"
    alias cat="batcat"
    alias cat="batcat"
    alias nubes="cd ~/svn/dialapplet-clients"
    alias tags="cd ~/svn/DIALAPPLET/tags"
    alias dck="cd ~/svn/tecsible/dialapplet-docker-desarrollo"
    alias dps='docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Command}}\t{{.CreatedAt}}\t{{.Status}}"'
    alias dup="docker-compose up -d"
    alias sfish="source ~/.config/fish/config.fish"
    alias kubectl="minikube kubectl --"
    alias containers='docker ps --format "{{.Names}}" | fzf | xargs -o -I {} docker exec -it {} /bin/bash'

    fish_add_path -g /home/ayuda104/Scripts
    set -g theme_nerd_fonts yes
    set -g theme_color_scheme dark
    set -g theme_display_git_dirty yes
    set -g theme_display_git_untracked yes
    fish_add_path "/home/ayuda104/.local/share/fnm"

    set -Ux FLYCTL_INSTALL "/home/ayuda104/.fly"
    fish_add_path "$FLYCTL_INSTALL/bin"
    fish_add_path $HOME/.local/share/nvim/mason/bin

    if test -n "$TMUX"
        set -x TERM xterm-256color
    end

    set branch (readlink $HOME/currentProject | sed 's|.*/DIALAPPLET/||')
    echo -n "Working on branch: "
    set_color cyan
    echo $branch
    set_color normal
    dialstatus dialserver
    dialstatus dialcontact
    dialstatus dialreport
    # set -g SDKMAN_DIR "$HOME/.sdkman"
    # source "$HOME/.sdkman/bin/sdkman-init.sh"
    set -g __sdkman_custom_dir "$HOME/.sdkman"
    fnm env | source
end

# Remap suspend action to Ctrl+Y
stty susp \x19
# Disable Ctrl+Z
stty susp undef

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# pnpm
set -gx PNPM_HOME "/home/ayuda104/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# ================================
# Aliases y Comandos Personalizados
# ================================
alias dps 'docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Command}}\t{{.CreatedAt}}\t{{.Status}}"'
alias sfish 'source ~/.config/fish/config.fish'
alias dconn 'docker ps --format "{{.Names}}" | fzf | xargs -o -I {} docker exec -it {} /bin/bash'
alias kitty 'kitty --title "kitty"'

# ================================
# Opciones del Tema (para Oh My Fish o similar)
# ================================
set -g theme_nerd_fonts yes
set -x VIRTUAL_ENV_DISABLE_PROMPT 1
set -g theme_color_scheme dracula
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked yes
set -g theme_display_python_virtualenv no
set -g theme_display_node yes
set -g theme_title_use_abbreviated_path no
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_default_branch yes
# Se mantiene solo el formato de hora que deseas:
set -g theme_date_format +%H:%M:%S
set -g theme_use_abbreviated_branch_name yes
set -g theme_display_git yes

# ================================
# Agregar Rutas al PATH usando fish_add_path
# ================================
# En lugar de sobrescribir PATH, usamos fish_add_path, que modifica la variable interna fish_user_paths.
# Esto asegura que las rutas se agreguen correctamente sin eliminar las existentes.
# La opción --prepend permite que la ruta de FNM aparezca al inicio del PATH.
fish_add_path --prepend "/run/user/1000/fnm_multishells/20447_1739988041653/bin"
fish_add_path "$HOME/.local/share/nvim/mason/bin"
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.sdkman/candidates/maven/current/bin"
fish_add_path "$HOME/.sdkman/candidates/java/current/bin"
fish_add_path "$HOME/.sdkman/candidates/springboot/current/bin"

# ================================
# Configuración para TMUX
# ================================
if test -n "$TMUX"
    set -x TERM xterm-256color
end

# ================================
# Otras configuraciones comentadas (descomentar si es necesario)
# ================================
# alias ls="exa"
# alias ll="exa -l --icons --header"
# alias cat="batcat"
# alias kubectl="minikube kubectl --"
# fish_add_path -g /home/ayuda104/Scripts
# source ~/.config/fish/functions/git_alias.fish
#
# bun
# set --export BUN_INSTALL "$HOME/.bun"
# set --export PATH $BUN_INSTALL/bin $PATH
#
# FLYCTL
# set -Ux FLYCTL_INSTALL "/home/ayuda104/.fly"
# fish_add_path "$FLYCTL_INSTALL/bin"


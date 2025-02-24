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

  # set -gx PATH $HOME/Scripts $PATH
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
  set -g theme_date_format +%c
  set -g theme_date_format +%H:%M:%S
  set -g theme_use_abbreviated_branch_name yes
  set -g theme_display_git yes

  # set -Ux FLYCTL_INSTALL "$HOME/.fly"
  # set -gx PATH "$FLYCTL_INSTALL/bin" $PATH
  set -gx PATH  "$HOME/.local/share/nvim/mason/bin" $PATH

  set -g __sdkman_custom_dir "$HOME/.sdkman"
  set -gx PATH "$HOME/.sdkman/candidates/maven/current/bin" $PATH
  set -gx PATH "$HOME/.sdkman/candidates/java/current/bin" $PATH
  set -gx PATH "$HOME/.sdkman/candidates/springboot/current/bin" $PATH
  if not contains "$HOME/.local/bin" $PATH
    set -gx PATH "$HOME/.local/bin" $PATH
  end

  fnm env | source
end
# source ~/.config/fish/functions/git_alias.fish

# bun
# set --export BUN_INSTALL "$HOME/.bun"
# set --export PATH $BUN_INSTALL/bin $PATH

# pnpm
set -gx PNPM_HOME "/home/david/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# =============================================================================
# THEME CONFIGURATION
# =============================================================================

if status is-interactive
  set -g fish_greeting ""
  set -g theme_nerd_fonts yes
  set -g theme_color_scheme dracula
  set -g theme_display_git yes
  set -g theme_display_git_dirty yes
  set -g theme_display_git_untracked yes
  set -g theme_display_git_dirty_verbose yes
  set -g theme_display_git_ahead_verbose yes
  set -g theme_display_git_default_branch yes
  set -g theme_display_node yes
  set -g theme_display_python_virtualenv no
  set -g theme_title_use_abbreviated_path no
  set -g theme_use_abbreviated_branch_name yes
  set -g theme_date_format "+%H:%M:%S"
end

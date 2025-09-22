# =============================================================================
# ENVIRONMENT VARIABLES AND PATH SETUP
# =============================================================================

if status is-interactive
    # Environment variables
    set -gx VIRTUAL_ENV_DISABLE_PROMPT 1
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx DOCKER_BUILDKIT 1
    set -gx COMPOSE_DOCKER_CLI_BUILD 1

    # PATH management
    set -l paths_to_add \
        "$HOME/.local/bin" \
        "$HOME/.deno/bin" \
        "$HOME/.meteor" \
        "$HOME/Code/deptecnologiagke/utils" \
        "$HOME/go/bin" \
        /usr/local/go/bin

    for path_dir in $paths_to_add
        if test -d $path_dir; and not contains $path_dir $PATH
            set -gx PATH $path_dir $PATH
        end
    end
end

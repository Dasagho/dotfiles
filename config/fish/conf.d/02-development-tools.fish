# =============================================================================
# DEVELOPMENT TOOLS SETUP
# =============================================================================

if status is-interactive
    # Python - pyenv
    set -gx PYENV_ROOT $HOME/.pyenv
    if test -d $PYENV_ROOT/bin
        set -gx PATH $PYENV_ROOT/bin $PATH
    end

    # Java - SDKMAN paths
    set -l sdkman_tools maven java springboot
    for tool in $sdkman_tools
        set -l tool_path "$HOME/.sdkman/candidates/$tool/current/bin"
        if test -d $tool_path; and not contains $tool_path $PATH
            set -gx PATH $tool_path $PATH
        end
    end

    # Bun
    set -gx BUN_INSTALL "$HOME/.bun"
    if test -d $BUN_INSTALL/bin; and not contains $BUN_INSTALL/bin $PATH
        set -gx PATH $BUN_INSTALL/bin $PATH
    end

    # pnpm
    set -gx PNPM_HOME "$HOME/.local/share/pnpm"
    if test -d $PNPM_HOME; and not contains $PNPM_HOME $PATH
        set -gx PATH $PNPM_HOME $PATH
    end
end

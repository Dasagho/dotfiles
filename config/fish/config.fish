# =============================================================================
# MAIN FISH CONFIGURATION
# =============================================================================
# Most configuration is loaded automatically from conf.d/ and functions/

if status is-interactive
    # Lazy load heavy tools for performance

    # Pyenv lazy loading
    function pyenv
        if not functions -q __pyenv_init
            function __pyenv_init
                command pyenv init - | source
                functions -e __pyenv_init
            end
            __pyenv_init
        end
        command pyenv $argv
    end
end

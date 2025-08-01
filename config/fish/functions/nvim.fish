function nvim
    set -l use_tmux true
    set -l nvim_args

    for arg in $argv
        if test "$arg" = -d
            set use_tmux false
        else
            set nvim_args $nvim_args $arg
        end
    end

    if not set -q TMUX; and test "$use_tmux" = true
        set -l session_name dev
        set -l counter 1

        while tmux has-session -t $session_name 2>/dev/null
            set session_name "dev$counter"
            set counter (math $counter + 1)
        end

        tmux new-session -As $session_name "nvim $nvim_args"
    else
        command nvim $nvim_args
    end
end

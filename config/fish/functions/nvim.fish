function nvim
    if not set -q TMUX
        # Start (or attach to) session “dev”, then run nvim; keep shell afterwards
        tmux new-session -d -As dev      # create/attach, but detached
        tmux send-keys   -t dev "nvim $argv" C-m
        tmux attach      -t dev          # now attach
    else
        command nvim $argv
    end
end

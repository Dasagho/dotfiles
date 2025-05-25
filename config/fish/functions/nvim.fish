function nvim
    # Si la variable TMUX NO está definida...
    if not set -q TMUX
        # → arrancamos tmux y ejecutamos nvim con todos los argumentos
        tmux new-session -As dev nvim $argv
    else
        # → ya estamos en tmux, llamamos al nvim “real”
        command nvim $argv
    end
end

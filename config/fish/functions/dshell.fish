function dshell
    if test (count $argv) -eq 0
        set container (docker ps --format "{{.Names}}" | fzf)
    else
        set container $argv[1]
    end

    if test -n "$container"
        docker exec -it $container /bin/bash 2>/dev/null; or docker exec -it $container /bin/sh
    end
end

# Tab completion function
complete -c dshell -f -a '(docker ps --format "{{.Names}}" 2>/dev/null)'

function dmeteorrun
    set container_name (echo 'europe-southwest1-docker.pkg.dev/eid-contenedores/tec-upper/uneed:latest' | string split / -f 4 | string split : -f 1)

end

complete -c dmeteorrun -f -n 'test (count (commandline -opc)) -eq 2' -a '(docker images --format "{{.Repository}}:{{.Tag}}" | sort)'
complete -c dmeteorrun -f -n 'test (count (commandline -opc)) -eq 3' -a '(docker ps --format "{{.Names}}")'

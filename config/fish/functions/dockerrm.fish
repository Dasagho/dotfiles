function dockerrm docker ps -a --format "table {{.ID}}\t{{.Image}}" | tail -n+2 | fzf --with-nth 2 --tac -m | cut -d ' ' -f1 | xargs -n 1 docker rm
end

function listen
    netstat -tulpan | grep -i listen && printf "\n\n" && docker ps --format "table {{.Names}}\t{{.Ports}}"
end

# =============================================================================
# DOCKER WORKFLOW ALIASES
# =============================================================================

if status is-interactive
    # Basic Docker commands
    alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"'
    alias dpsa='docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}\t{{.CreatedAt}}"'
    alias di='docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.Size}}\t{{.CreatedAt}}"'
    alias dnet='docker network ls'
    alias dvol='docker volume ls'

    # Interactive Docker operations
    alias dconn='docker ps --format "{{.Names}}" | fzf --preview "docker inspect {}" | xargs -r -I {} docker exec -it {} /bin/bash'
    alias dstop='docker ps --format "{{.Names}}" | fzf --multi | xargs -r docker stop'
    alias drm='docker ps -a --format "{{.Names}}" | fzf --multi | xargs -r docker rm'
    alias drmi='docker images --format "{{.Repository}}:{{.Tag}}" | fzf --multi | xargs -r docker rmi'
    alias dlogs='docker ps --format "{{.Names}}" | fzf | xargs -r -I {} docker logs -f {}'

    # Docker Compose shortcuts
    alias dcu='docker compose up -d'
    alias dcd='docker compose down'
    alias dcr='docker compose restart'
    alias dcl='docker compose logs -f'
    alias dcps='docker compose ps'
    alias dcpull='docker compose pull'
    alias dcbuild='docker compose build --no-cache'

    # Docker maintenance
    alias dclean='docker system prune -af && docker volume prune -f'
    alias dstats='docker stats --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}"'
end

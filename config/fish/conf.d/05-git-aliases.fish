# =============================================================================
# GIT ALIASES (OH-MY-ZSH STYLE)
# =============================================================================

if status is-interactive
  # Basic git commands
  alias g='git'
  alias ga='git add'
  alias gaa='git add --all'
  alias gapa='git add --patch'
  alias gau='git add --update'

  # Branch operations
  alias gb='git branch'
  alias gba='git branch -a'
  alias gbd='git branch -d'
  alias gbD='git branch -D'

  # Commit operations
  alias gc='git commit -v'
  alias gc!='git commit -v --amend'
  alias gcn!='git commit -v --no-edit --amend'
  alias gca='git commit -v -a'
  alias gcam='git commit -a -m'
  alias gcmsg='git commit -m'
  alias gco='git checkout'
  alias gcb='git checkout -b'

  # Status and diff
  alias gst='git status'
  alias gss='git status -s'
  alias gd='git diff'
  alias gdca='git diff --cached'

  # Push/Pull operations
  alias gp='git push'
  alias gpl='git pull'
  alias gpf='git push --force-with-lease'
  alias gup='git pull --rebase'

  # Log operations
  alias glog='git log --oneline --decorate --graph'
  alias glola='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --all'

  # Stash operations
  alias gsta='git stash push'
  alias gstaa='git stash apply'
  alias gstp='git stash pop'
  alias gstl='git stash list'

  # Remote operations
  alias gr='git remote'
  alias grv='git remote -v'
  alias gf='git fetch'
  alias gfa='git fetch --all --prune'
end

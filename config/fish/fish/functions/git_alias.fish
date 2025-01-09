# Status
function s
    command git status $argv
end

function st
    command git status $argv
end

function ss
    command git status -s $argv
end

# Add
function a
    command git add $argv
end

function aa
    command git add --all $argv
end

# Branch
function b
    command git branch $argv
end

function ba
    command git branch -a $argv
end

function bd
    command git branch -d $argv
end

# Commit
function c
    command git commit -v $argv
end

function ca
    command git commit -v -a $argv
end

function cm
    command git commit -m $argv
end

function cmsg
    command git commit -m $argv
end

function cs
    command git commit -S $argv
end

# Checkout
function co
    command git checkout $argv
end

# Fetch
function f
    command git fetch $argv
end

function fa
    command git fetch --all --prune $argv
end

# Pull
function p
    command git pull $argv
end

function up
    command git pull --rebase $argv
end

# Push
function pu
    command git push $argv
end

function pdu
    command git push --dry-run $argv
end

# Merge
function m
    command git merge $argv
end

function mom
    command git merge origin/master $argv
end

# Remote
function r
    command git remote $argv
end

function ra
    command git remote add $argv
end

function rv
    command git remote -v $argv
end

# Log
function lg
    command git log --stat --max-count=10 $argv
end

function lgg
    command git log --graph --max-count=10 $argv
end

function lgga
    command git log --graph --decorate --all $argv
end

function lo
    command git log --oneline --decorate $argv
end

function log
    command git log --oneline --decorate --graph $argv
end

# Diff
function d
    command git diff $argv
end

function dc
    command git diff --cached $argv
end

function dca
    command git diff --cached --stat $argv
end

function dn
    command git diff --name-only $argv
end

function dt
    command git diff-tree --no-commit-id --name-only -r $argv
end

# Stash
function sta
    command git stash push $argv
end

function staa
    command git stash apply $argv
end

function std
    command git stash drop $argv
end

function stl
    command git stash list $argv
end

function stp
    command git stash pop $argv
end

function stc
    command git stash clear $argv
end

function sts
    command git stash show --text $argv
end

# Cherry-pick
function cp
    command git cherry-pick $argv
end

# Pull rebase (duplicado de 'up' o 'pr')
function pr
    command git pull --rebase $argv
end

# Otros
function count
    command git shortlog -sn $argv
end

function clean
    command git clean -fd $argv
end

# Reset / revert
function rhh
    command git reset HEAD --hard $argv
end

function rev
    command git revert $argv
end

function ru
    command git reset -- $argv
end

# Descartar cambios y limpiar
function pristine
    command git reset --hard; and command git clean -dfx
end

# Config
function cf
    command git config --list $argv
end

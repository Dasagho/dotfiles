# Function to run from a wsl to take a file from windows filesystem with completion the user dsaleh directory
function take
    if test (count $argv) -eq 0
        set file (eza /mnt/c/Users/dsaleh/Downloads | grep -vE '^(ZZZZZ|!!!!!|XORXOR|gRkQIwg)' | fzf)
    else
        set file $argv[1]
    end
    if test -n "$file"
        cp -r "/mnt/c/Users/dsaleh/Downloads/$file" .
    end
end

complete -c take -f -a "(eza --sort modified /mnt/c/Users/dsaleh/Downloads/ | grep -vE '^(ZZZZZ|!!!!!|XORXOR|gRkQIwg)' 2>/dev/null)"

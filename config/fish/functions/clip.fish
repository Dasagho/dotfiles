function clip
    set -l clips \
        linuxmongo_uri "mongodb://linuxmongo.lab.id:27017/citric" \
        k8s_mongo_uri "mongodb://root:Etra-3000@localhost:27017/?authSource=admin"

    set -l key $argv[1]

    if test -z "$key"
        set -l keys
        for i in (seq 1 2 (count $clips))
            set -a keys $clips[$i]
        end
        set key (printf "%s\n" $keys | fzf)
    end

    test -z "$key"; and return

    for i in (seq 1 2 (count $clips))
        if test "$clips[$i]" = "$key"
            printf "%s" $clips[(math $i + 1)] | xclip -selection clipboard
            return
        end
    end
    echo "Key not found"
end

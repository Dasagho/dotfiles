#!/usr/bin/env bash

BIN_DIRECTORY=$HOME/.local/bin

last_kitty_version=$(curl https://api.github.com/repos/kovidgoyal/kitty/releases/latest | jq -r .name | awk '{print $2}')
wget "https://github.com/kovidgoyal/kitty/releases/download/v$last_kitty_version/kitten-linux-amd64" -O $BIN_DIRECTORY/kitty

chmod +x -R $BIN_DIRECTORY

#!/usr/bin/env bash

BIN_DIRECTORY=$HOME/.local/bin
INSTALL_DIRECTORY=$HOME/.local/share
CONFIG_DIRECTORY=$HOME/.config

# Install kitty
last_kitty_version=$(curl https://api.github.com/repos/kovidgoyal/kitty/releases/latest | jq -r .name | awk '{print $2}')
wget "https://github.com/kovidgoyal/kitty/releases/download/v$last_kitty_version/kitty-$last_kitty_version-x86_64.txz" -O "$INSTALL_DIRECTORY/kitty.txz"
mkdir -p "$INSTALL_DIRECTORY/kitty" && tar xvf "$INSTALL_DIRECTORY/kitty.txz" --directory "$INSTALL_DIRECTORY/kitty"
ln -sf "$INSTALL_DIRECTORY/kitty/bin/kitty" "$BIN_DIRECTORY/kitty"
cp ./desktop/kitty/kitty.desktop $INSTALL_DIRECTORY/applications
cp ./desktop/kitty/icon/kitty.png $INSTALL_DIRECTORY/icons/hicolor/256x256/apps/

# Install fish
last_fish_version=$(curl https://api.github.com/repos/fish-shell/fish-shell/releases/latest | jq -r .name | awk '{print $2}')
wget "https://github.com/fish-shell/fish-shell/releases/download/$last_fish_version/fish-$last_fish_version.app.zip" -O "$INSTALL_DIRECTORY/fish.zip"
rm "$INSTALL_DIRECTORY/fish.zip" && unzip "$INSTALL_DIRECTORY/fish.zip"
ln -sf "$INSTALL_DIRECTORY/fish.app/Contents/Resources/base/usr/local/bin/fish" "$BIN_DIRECTORY/fish"

# Install ohmyfish
rm -rf "$INSTALL_DIRECTORY/omf"
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
fish --command "omf install bobthefish"

cp -r ../config/fish $CONFIG_DIRECTORY
chmod +x -R $BIN_DIRECTORY

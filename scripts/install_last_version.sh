#!/usr/bin/env bash

# Lista de paquetes a verificar
required_packages=("fish" "curl" "wget" "git")

# Función para verificar un paquete
check_package() {
  local package=$1
  if ! command -v "$package" &>/dev/null; then
    echo "Error: El paquete '$package' no está instalado." >&2
    exit 1
  fi
}

# Verificar cada paquete de la lista
for package in "${required_packages[@]}"; do
  check_package "$package"
done

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
cp -r ../config/kitty $CONFIG_DIRECTORY

# Config fish
cp -r ../config/fish $CONFIG_DIRECTORY
chmod +x -R $BIN_DIRECTORY

# Install fonts
cp ../fonts/* "$INSTALL_DIRECTORY/fonts"
fc-cache

# Install ohmyfish
rm -rf "$INSTALL_DIRECTORY/omf"
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
fish --command "omf install bobthefish"

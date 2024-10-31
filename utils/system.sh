#!/bin/bash

source "../config/paths.sh"

setup_flatpak() {
  echo "Setting up Flatpak and Flathub repository..."
  flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

  for app in "${FLATPAK_GUI_APPS[@]}"; do
    flatpak install -y flathub "$app"
  done
}

setup_docker_permissions() {
  echo "Setting up Docker permissions..."
  sudo groupadd docker || true
  sudo usermod -aG docker "$USER"
  newgrp docker
}

setup_directories() {
  mkdir -p "$DOWNLOADS_DIR" "$SHARE_DIR" "$BIN_DIR" "$CONFIG_DIR" "$FONTS_DIR"
}

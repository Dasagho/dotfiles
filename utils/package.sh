#!/bin/bash

source "../config/paths.sh"
source "../config/packages.sh"

download_and_extract() {
  local package_name=$1
  local url=${SOURCE_URLS[$package_name]}
  local current_user=$ORIGINAL_USER
  [[ -z "$current_user" ]] && current_user=$USER

  echo "Downloading $package_name..."

  # Crear directorios si no existen
  mkdir -p "$DOWNLOADS_DIR/$package_name"

  # Descargar y extraer
  cd "$DOWNLOADS_DIR/$package_name"
  if [[ $url == *.tar.gz ]]; then
    curl -L "$url" | tar -xz
  elif [[ $url == *.tar.xz ]]; then
    curl -L "$url" | tar -xJ
  else
    curl -L "$url" -o "${package_name}_installer"
  fi
}

link_binary() {
  local package_name=$1
  local binary_path=$2
  local target_name=$3

  mkdir -p "$BIN_DIR"
  ln -sf "$binary_path" "$BIN_DIR/$target_name"
}

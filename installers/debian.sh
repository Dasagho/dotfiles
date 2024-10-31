#!/bin/bash

source "../config/packages.sh"
source "../config/paths.sh"
source "../utils/package.sh"
source "../utils/system.sh"

install_linuxbrew_deps() {
  sudo apt update
  sudo apt install -y build-essential procps curl file git
}

install_flatpak() {
  sudo apt install -y flatpak
}

install_from_source() {
  local package=$1

  download_and_extract "$package"

  # Download and install nvim, fish and tmux
}

main() {
  setup_directories
  install_linuxbrew_deps
  install_flatpak

  if install_linuxbrew; then
    brew install "${HOMEBREW_PACKAGES[@]}"
  else
    sudo apt install -y "${APT_PACKAGES[@]}"
    for package in "fish" "tmux" "neovim"; do
      install_from_source "$package"
    done
  fi

  setup_flatpak
  setup_docker_permissions
}
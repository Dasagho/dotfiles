#!/bin/bash

source "../config/packages.sh"
source "../config/paths.sh"
source "../utils/package_utils.sh"
source "../utils/system_utils.sh"

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

  case $package in
  "fish")
    cd fish-*/
    cmake -DCMAKE_INSTALL_PREFIX="$SHARE_DIR/fish" .
    make
    make install
    link_binary "$package" "$SHARE_DIR/fish/bin/fish" "fish"
    ;;
  "tmux")
    cd tmux-*/
    ./configure --prefix="$SHARE_DIR/tmux"
    make
    make install
    link_binary "$package" "$SHARE_DIR/tmux/bin/tmux" "tmux"
    ;;
  "neovim")
    cd nvim-linux64
    cp -r * "$SHARE_DIR/neovim/"
    link_binary "$package" "$SHARE_DIR/neovim/bin/nvim" "nvim"
    ;;
  esac
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

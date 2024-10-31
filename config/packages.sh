#!/bin/bash

# URLs para paquetes from source
declare -A SOURCE_URLS=(
  ["fish"]="https://github.com/fish-shell/fish-shell/releases/download/3.6.1/fish-3.6.1.tar.xz"
  ["tmux"]="https://github.com/tmux/tmux/releases/download/3.3a/tmux-3.3a.tar.gz"
  ["neovim"]="https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz"
  ["docker"]="https://get.docker.com"
)

# Paquetes Homebrew
declare -a HOMEBREW_PACKAGES=(
  "htop"
  "git"
  "gcc"
  "go"
  "deno"
  "fish"
  "tmux"
  "docker"
  "bat"
  "fzf"
  "lazygit"
)

# GUI apps para macOS
declare -a MACOS_GUI_APPS=(
  "kitty"
  "chromium"
  "discord"
  "thunderbird"
  "visual-studio-code"
  "vlc"
  "spotify"
)

# Paquetes específicos por distribución
declare -a APT_PACKAGES=(
  "htop"
  "git"
  "gcc"
  "build-essential"
  "bat"
  "fzf"
)

declare -a DNF_PACKAGES=(
  "htop"
  "git"
  "gcc"
  "make"
  "bat"
  "fzf"
)

declare -a PACMAN_PACKAGES=(
  "htop"
  "git"
  "gcc"
  "base-devel"
  "bat"
  "fzf"
)

# Apps Flatpak
declare -a FLATPAK_GUI_APPS=(
  "org.kde.kitty"
  "org.chromium.Chromium"
  "com.discordapp.Discord"
  "org.mozilla.Thunderbird"
  "com.visualstudio.code"
  "org.videolan.VLC"
  "com.spotify.Client"
)

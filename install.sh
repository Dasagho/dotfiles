#!/bin/bash

# Install homebrew package manager
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Define packages or formulas on homebrew
packages=(
  htop
  git
  fnm
  gcc
  go
  deno
  fish
  tmux
  tpm
  docker
  tealdeer
  bat
  fzf
  lazygit
)

# Define formulas that requires cask on homebrew
casks=(
  kitty
  chromium
  discord
  thunderbird
  visual-studio-code
  vlc
  spotify
)

brew install ${packages[@]}
brew install --cask ${casks[@]}

curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

# Create directories in case don't exists already
mkdir -p ~/.config ~/.local/share/fonts/

# Copy dotfiles on respective locations
cp -r ./nvim ./omf ./fish ./rofi -t ~/.config/
cp -r ./fonts -t ~/.local/share/fonts/
cp -r ./.gitconfig ./.tmux.conf -t ~/

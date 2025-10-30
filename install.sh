#!/usr/bin/env bash

required_packages=("fish" "curl" "wget" "git" "tmux")

CONFIG_DIRECTORY=$HOME/.config

BIN_DIRECTORY=$HOME/.local/bin
mkdir -p "$BIN_DIRECTORY"

INSTALL_DIRECTORY=$HOME/.local/share
mkdir -p "$INSTALL_DIRECTORY"

DESKTOP_APPS_DIRECTORY=$INSTALL_DIRECTORY/applications
mkdir -p "$DESKTOP_APPS_DIRECTORY"

ICONS_DIRECTORY=$INSTALL_DIRECTORY/icons/hicolor/256x256/apps/
mkdir -p "$ICONS_DIRECTORY"

color_echo() {
  local type="$1"
  shift
  local message="$*"

  local RED="\033[1;31m"
  local BLUE="\033[1;94m"
  local RESET="\033[0m"

  case "$type" in
    info)
      echo -e "${BLUE}[INFO] ${message}${RESET}\n"
      ;;
    error)
      echo -e "${RED}[ERROR] ${message}${RESET}\n" >&2
      ;;
    *)
      echo -e "[UNKNOWN] ${message}\n"
      ;;
  esac
}

check_installed_package() {
  local package=$1
  if ! command -v "$package" &>/dev/null; then
		color_echo error "Error: El paquete '$package' no está instalado." >&2
    exit 1
  fi
}

# Verificar cada paquete de la lista
for package in "${required_packages[@]}"; do
  check_installed_package "$package"
done

install_and_config_kitty() {
  last_kitty_version=$(curl https://api.github.com/repos/kovidgoyal/kitty/releases/latest | jq -r .name | awk '{print $2}')
  wget "https://github.com/kovidgoyal/kitty/releases/download/v$last_kitty_version/kitty-$last_kitty_version-x86_64.txz" -O "$INSTALL_DIRECTORY/kitty.txz"

  mkdir -p "$INSTALL_DIRECTORY/kitty"
  tar xvf "$INSTALL_DIRECTORY/kitty.txz" --directory "$INSTALL_DIRECTORY/kitty"

  # Install kitty
  ln -sf "$INSTALL_DIRECTORY/kitty/bin/kitty" "$BIN_DIRECTORY/kitty"
  cp ./scripts/desktop/kitty/kitty.desktop "$INSTALL_DIRECTORY/applications"
  cp ./scripts/desktop/kitty/icon/kitty.png "$INSTALL_DIRECTORY/icons/hicolor/256x256/apps/"

  # Config kitty
  cp -r ./config/kitty $CONFIG_DIRECTORY

  # clean up
  rm -rf "$INSTALL_DIRECTORY/kitty.txz"
}

install_tealdeer() {
  # Reset binary and functions
  rm -f "$BIN_DIRECTORY/tldr"

  # Download and install
  last_tldr_version=$(curl https://api.github.com/repos/tealdeer-rs/tealdeer/releases/latest | jq -r .name | awk '{print $2}')
  wget "https://github.com/tealdeer-rs/tealdeer/releases/download/v$last_tldr_version/tealdeer-linux-x86_64-musl" -O "$BIN_DIRECTORY/tldr"
  chmod +x "$BIN_DIRECTORY/tldr"
  wget "https://github.com/tealdeer-rs/tealdeer/releases/download/v$last_tldr_version/completions_fish" -O "$CONFIG_DIRECTORY/fish/functions"
}

install_nvim() {
  # Clean old install
  rm -rf "$HOME/.config/nvim"
  rm -rf "$INSTALL_DIRECTORY/nvim.tar.gz"
  rm -rf "$INSTALL_DIRECTORY/nvim"

  # Install nvim
  last_nvim_version=$(curl https://api.github.com/repos/neovim/neovim/releases/latest | jq -r .name | awk '{print $2}')
  wget "https://github.com/neovim/neovim/releases/download/v$last_nvim_version/nvim-linux-x86_64.tar.gz" -O "$INSTALL_DIRECTORY/nvim.tar.gz"
  tar xfz "$INSTALL_DIRECTORY/nvim.tar.gz" --directory "$INSTALL_DIRECTORY"
  mv "$INSTALL_DIRECTORY/nvim-linux-x86_64" "$INSTALL_DIRECTORY/nvim"
  ln -sf "$INSTALL_DIRECTORY/nvim/bin/nvim" "$BIN_DIRECTORY/nvim"

  # Config nvim
  cp -r ./config/nvim "$HOME/.config"
}

# Install fonts
mkdir -p "$INSTALL_DIRECTORY/fonts"
cp ./fonts/* "$INSTALL_DIRECTORY/fonts"
fc-cache

# Install tpm
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  color_echo info "TPM already installed"
fi

# Install fnm
if [ -x "$(which fnm)" ]; then
  color_echo info "fnm already installed"
else
  curl -fsSL https://fnm.vercel.app/install | bash
fi

# Install PNPM
if [ -x "$(which pnpm)" ]; then
  color_echo info "pnpm already installed"
else
  curl -fsSL https://get.pnpm.io/install.sh | sh -
fi

# Install sdkman
if [ -x "$(which sdk)" ]; then
	color_echo info "sdkman already installed"
else
  curl -s "https://get.sdkman.io" | bash
fi

# Install deno
if [ -x "$(which deno)" ]; then
  color_echo info "deno already installed"
else
  curl -fsSL https://deno.land/install.sh | sh
fi

# Install bun
if [ -x "$(which bun)" ]; then
    color_echo info "bun already installed"
else
    curl -fsSL https://bun.sh/install | bash
fi

# Install pyenv
if [ ! -d "$HOME/.pyenv" ]; then
    curl -fsSL https://pyenv.run | bash
else
    color_echo info "pyenv already installed"
fi

install_nvim

install_and_config_kitty

install_tealdeer

# Config fish
rm -rf "$CONFIG_DIRECTORY/fish"
cp -r ./config/fish "$CONFIG_DIRECTORY"

# Install ohmyfish
rm -rf "$INSTALL_DIRECTORY/omf"
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

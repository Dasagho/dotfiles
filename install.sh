#!/usr/bin/env bash


set -euo pipefail  # Exit on error, undefined vars, pipe failures


# ============================================================================
# Configuration - Static Versions for Reproducible Builds
# ============================================================================

# Tool versions (update these to control which versions to install)
readonly KITTY_VERSION="0.32.2"
readonly TEALDEER_VERSION="1.6.1"
readonly NVIM_VERSION="0.11.3"

# Required system packages

readonly REQUIRED_PACKAGES=("fish" "curl" "wget" "git" "tmux" "jq" "tar" "fc-cache" "batcat" "eza")

# Directory setup
readonly CONFIG_DIRECTORY="$HOME/.config"
readonly BIN_DIRECTORY="$HOME/.local/bin"
readonly INSTALL_DIRECTORY="$HOME/.local/share"
readonly DESKTOP_APPS_DIRECTORY="$INSTALL_DIRECTORY/applications"
readonly ICONS_DIRECTORY="$INSTALL_DIRECTORY/icons/hicolor/256x256/apps"

# Create directories
mkdir -p "$BIN_DIRECTORY" "$INSTALL_DIRECTORY" "$DESKTOP_APPS_DIRECTORY" "$ICONS_DIRECTORY"

# ============================================================================
# Logging and UI
# ============================================================================

# Colors
readonly RED='\033[1;31m'
readonly GREEN='\033[1;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[1;34m'
readonly CYAN='\033[1;36m'
readonly RESET='\033[0m'

# Progress tracking

declare -a INSTALL_RESULTS=()

log() {
  local level="$1"
  shift
  local message="$*"
  local timestamp=$(date '+%H:%M:%S')

  case "$level" in
    "INFO")  echo -e "${BLUE}[${timestamp}][INFO]${RESET} $message" ;;

    "SUCCESS") echo -e "${GREEN}[${timestamp}][SUCCESS]${RESET} $message" ;;
    "WARNING") echo -e "${YELLOW}[${timestamp}][WARNING]${RESET} $message" ;;
    "ERROR") echo -e "${RED}[${timestamp}][ERROR]${RESET} $message" >&2 ;;
    *) echo -e "[${timestamp}][$level] $message" ;;
  esac

}


show_progress() {

  local current="$1"
  local total="$2"
  local task="$3"
  local width=50
  local percentage=$((current * 100 / total))
  local filled=$((current * width / total))

  printf "\r${CYAN}Progress:${RESET} ["

  printf "%*s" $filled | tr ' ' '█'
  printf "%*s" $((width - filled)) | tr ' ' '░'
  printf "] %d%% - %s" $percentage "$task"

  if [ "$current" -eq "$total" ]; then
    echo ""
  fi
}

# ============================================================================
# Security Functions
# ============================================================================


verify_checksum() {
  local file="$1"
  local expected_checksum="$2"
  local algorithm="${3:-sha256}"

  if [ -z "$expected_checksum" ]; then
    log "WARNING" "No checksum provided for $file - skipping verification"
    return 0
  fi

  local actual_checksum
  case "$algorithm" in
    "sha256") actual_checksum=$(sha256sum "$file" | cut -d' ' -f1) ;;
    "sha1") actual_checksum=$(sha1sum "$file" | cut -d' ' -f1) ;;
    *) log "ERROR" "Unsupported checksum algorithm: $algorithm"; return 1 ;;
  esac

  if [ "$actual_checksum" = "$expected_checksum" ]; then
    log "SUCCESS" "Checksum verification passed for $file"
    return 0
  else
    log "ERROR" "Checksum verification failed for $file"
    log "ERROR" "Expected: $expected_checksum"
    log "ERROR" "Actual: $actual_checksum"
    return 1
  fi
}


secure_download() {
  local url="$1"
  local output="$2"

  local checksum="${3:-}"
  local max_retries=3
  local retry=0

  log "INFO" "Downloading $(basename "$output")..."


  while [ $retry -lt $max_retries ]; do
    if wget --progress=dot:giga \

      --timeout=30 \

      --tries=3 \
      --secure-protocol=TLSv1_2 \
      --no-check-certificate=false \
      "$url" -O "$output" 2>/dev/null; then

      if [ -n "$checksum" ]; then
        if verify_checksum "$output" "$checksum"; then
          log "SUCCESS" "Downloaded and verified $(basename "$output")"
          return 0
        else
          rm -f "$output"
          ((retry++))
          log "WARNING" "Checksum failed, retrying... ($retry/$max_retries)"

          continue
        fi
      else
        log "SUCCESS" "Downloaded $(basename "$output")"
        return 0
      fi

    else
      ((retry++))
      log "WARNING" "Download failed, retrying... ($retry/$max_retries)"
      sleep 2
    fi
  done

  log "ERROR" "Failed to download $url after $max_retries attempts"
  return 1
}

# ============================================================================
# System Checks
# ============================================================================


check_system_requirements() {

  log "INFO" "Checking system requirements..."
  local missing_packages=()

  for package in "${REQUIRED_PACKAGES[@]}"; do

    if ! command -v "$package" &>/dev/null; then
      missing_packages+=("$package")
    fi
  done


  if [ ${#missing_packages[@]} -gt 0 ]; then
    log "ERROR" "Missing required packages: ${missing_packages[*]}"

    log "ERROR" "Please install them first: sudo apt-get install ${missing_packages[*]}"
    exit 1

  fi


  log "SUCCESS" "All system requirements satisfied"
}

check_disk_space() {

  local required_mb=500
  local available_mb=$(df "$HOME" | awk 'NR==2 {print int($4/1024)}')

  if [ "$available_mb" -lt "$required_mb" ]; then
    log "ERROR" "Insufficient disk space. Required: ${required_mb}MB, Available: ${available_mb}MB"
    exit 1
  fi

  log "SUCCESS" "Sufficient disk space available (${available_mb}MB)"
}

# ============================================================================
# Installation Functions

# ============================================================================

install_and_config_kitty() {
  local task_name="Kitty Terminal"
  log "INFO" "Installing $task_name v$KITTY_VERSION..."

  local kitty_url="https://github.com/kovidgoyal/kitty/releases/download/v${KITTY_VERSION}/kitty-${KITTY_VERSION}-x86_64.txz"

  local kitty_archive="$INSTALL_DIRECTORY/kitty.txz"

  # Clean old installation
  rm -rf "$INSTALL_DIRECTORY/kitty" "$kitty_archive"

  if secure_download "$kitty_url" "$kitty_archive"; then
    mkdir -p "$INSTALL_DIRECTORY/kitty"

    if tar xf "$kitty_archive" --directory "$INSTALL_DIRECTORY/kitty" --strip-components=0 2>/dev/null; then
      # Create symlink
      ln -sf "$INSTALL_DIRECTORY/kitty/bin/kitty" "$BIN_DIRECTORY/kitty"


      # Install desktop files if they exist
      if [ -f "./scripts/desktop/kitty/kitty.desktop" ]; then
        cp "./scripts/desktop/kitty/kitty.desktop" "$DESKTOP_APPS_DIRECTORY/"

      fi
      if [ -f "./scripts/desktop/kitty/icon/kitty.png" ]; then
        cp "./scripts/desktop/kitty/icon/kitty.png" "$ICONS_DIRECTORY/"

      fi


      # Install config if it exists
      if [ -d "./config/kitty" ]; then
        cp -r "./config/kitty" "$CONFIG_DIRECTORY/"
      fi

      # Cleanup
      rm -f "$kitty_archive"

      INSTALL_RESULTS+=("✅ $task_name")

      log "SUCCESS" "$task_name installed successfully"
      return 0
    else
      log "ERROR" "Failed to extract $task_name"

    fi
  else

    log "ERROR" "Failed to download $task_name"
  fi

  INSTALL_RESULTS+=("❌ $task_name")

  return 1
}

install_tealdeer() {
  local task_name="Tealdeer (tldr)"

  log "INFO" "Installing $task_name v$TEALDEER_VERSION..."

  local tldr_url="https://github.com/tealdeer-rs/tealdeer/releases/download/v${TEALDEER_VERSION}/tealdeer-linux-x86_64-musl"
  local completions_url="https://github.com/tealdeer-rs/tealdeer/releases/download/v${TEALDEER_VERSION}/completions_fish"


  # Clean old installation

  rm -f "$BIN_DIRECTORY/tldr"

  if secure_download "$tldr_url" "$BIN_DIRECTORY/tldr"; then
    chmod +x "$BIN_DIRECTORY/tldr"

    # Download fish completions if fish config directory exists
    if [ -d "$CONFIG_DIRECTORY/fish/functions" ]; then
      secure_download "$completions_url" "$CONFIG_DIRECTORY/fish/functions/tldr.fish" || log "WARNING" "Failed to download fish completions for tldr"
    fi

    INSTALL_RESULTS+=("✅ $task_name")
    log "SUCCESS" "$task_name installed successfully"
    return 0
  else

    log "ERROR" "Failed to download $task_name"
  fi

  INSTALL_RESULTS+=("❌ $task_name")

  return 1
}

install_nvim() {
  local task_name="Neovim"
  log "INFO" "Installing $task_name v$NVIM_VERSION..."

  local nvim_url="https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux-x86_64.tar.gz"
  local nvim_archive="$INSTALL_DIRECTORY/nvim.tar.gz"

  # Clean old installation
  rm -rf "$HOME/.config/nvim" "$INSTALL_DIRECTORY/nvim.tar.gz" "$INSTALL_DIRECTORY/nvim" "$INSTALL_DIRECTORY/nvim-linux-x86_64"


  if secure_download "$nvim_url" "$nvim_archive"; then
    if tar xzf "$nvim_archive" --directory "$INSTALL_DIRECTORY" 2>/dev/null; then
      mv "$INSTALL_DIRECTORY/nvim-linux-x86_64" "$INSTALL_DIRECTORY/nvim"

      ln -sf "$INSTALL_DIRECTORY/nvim/bin/nvim" "$BIN_DIRECTORY/nvim"

      # Install config if it exists
      if [ -d "./config/nvim" ]; then
        cp -r "./config/nvim" "$HOME/.config/"

      fi


      # Cleanup
      rm -f "$nvim_archive"


      INSTALL_RESULTS+=("✅ $task_name")
      log "SUCCESS" "$task_name installed successfully"
      return 0
    else
      log "ERROR" "Failed to extract $task_name"
    fi
  else
    log "ERROR" "Failed to download $task_name"

  fi


  INSTALL_RESULTS+=("❌ $task_name")
  return 1
}

install_web_based_tool() {

  local name="$1"
  local url="$2"
  local check_command="$3"

  log "INFO" "Installing $name..."

  if command -v "$check_command" &>/dev/null; then

    log "INFO" "$name already installed"

    INSTALL_RESULTS+=("⚠️ $name (already installed)")
    return 0
  fi

  if curl -fsSL "$url" | bash -s 2>/dev/null; then
    INSTALL_RESULTS+=("✅ $name")

    log "SUCCESS" "$name installed successfully"
    return 0
  else
    INSTALL_RESULTS+=("❌ $name")
    log "ERROR" "Failed to install $name"

    return 1
  fi
}

install_git_repo() {

  local name="$1"
  local repo_url="$2"
  local target_dir="$3"

  log "INFO" "Installing $name..."

  if [ -d "$target_dir" ]; then
    log "INFO" "$name already installed"
    INSTALL_RESULTS+=("⚠️ $name (already installed)")
    return 0
  fi

  if git clone --depth 1 "$repo_url" "$target_dir" 2>/dev/null; then
    INSTALL_RESULTS+=("✅ $name")
    log "SUCCESS" "$name installed successfully"
    return 0

  else
    INSTALL_RESULTS+=("❌ $name")
    log "ERROR" "Failed to install $name"
    return 1
  fi
}

install_fonts() {
  log "INFO" "Installing fonts..."

  if [ -d "./fonts" ] && [ "$(ls -A ./fonts 2>/dev/null)" ]; then
    mkdir -p "$INSTALL_DIRECTORY/fonts"

    cp ./fonts/* "$INSTALL_DIRECTORY/fonts/" 2>/dev/null || {
      log "WARNING" "Some fonts failed to copy"
    }

  if fc-cache -f 2>/dev/null; then
    INSTALL_RESULTS+=("✅ Fonts")
    log "SUCCESS" "Fonts installed and cache updated"
  else

    INSTALL_RESULTS+=("⚠️ Fonts (cache update failed)")
    log "WARNING" "Fonts copied but cache update failed"

  fi
else

  INSTALL_RESULTS+=("⚠️ Fonts (no fonts directory found)")
  log "WARNING" "No fonts directory found or it's empty"
  fi

}


configure_fish() {
  log "INFO" "Configuring Fish shell..."


  # Install fish config if it exists
  if [ -d "./config/fish" ]; then
    rm -rf "$CONFIG_DIRECTORY/fish"
    cp -r "./config/fish" "$CONFIG_DIRECTORY/"

    log "SUCCESS" "Fish configuration installed"
  else
    log "WARNING" "No fish configuration found"

  fi


  # Install oh-my-fish
  if curl -fsSL https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install 2>/dev/null | fish 2>/dev/null; then
    INSTALL_RESULTS+=("✅ Fish Configuration")

    log "SUCCESS" "Oh My Fish installed successfully"
  else
    INSTALL_RESULTS+=("❌ Fish Configuration")
    log "ERROR" "Failed to install Oh My Fish"
    return 1
  fi
}

# ============================================================================
# Main Installation Process
# ============================================================================


print_banner() {
  echo -e "${CYAN}"
  echo "╔══════════════════════════════════════════════════════════════╗"
  echo "║                    Development Tools Installer               ║"
  echo "║                          v2.0.0                             ║"
  echo "╚══════════════════════════════════════════════════════════════╝"
  echo -e "${RESET}"

}


print_summary() {

  echo ""

  echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗"
  echo -e "║                    Installation Summary                      ║"
  echo -e "╚══════════════════════════════════════════════════════════════╝${RESET}"
  echo ""


  local success_count=0
  local warning_count=0
  local error_count=0

  for result in "${INSTALL_RESULTS[@]}"; do
    echo "  $result"
    case "$result" in
      "✅"*) ((success_count++)) ;;
      "⚠️"*) ((warning_count++)) ;;
      "❌"*) ((error_count++)) ;;
    esac
  done


  echo ""

  echo -e "${GREEN}✅ Successful: $success_count${RESET}"
  echo -e "${YELLOW}⚠️  Warnings: $warning_count${RESET}"

  echo -e "${RED}❌ Failed: $error_count${RESET}"
  echo ""

  if [ $error_count -eq 0 ]; then

    echo -e "${GREEN}🎉 All installations completed successfully!${RESET}"
    echo -e "${CYAN}💡 Please restart your terminal or run 'source ~/.bashrc' to use the new tools.${RESET}"
  else
    echo -e "${YELLOW}⚠️  Some installations failed. Check the logs above for details.${RESET}"
  fi
}


main() {

  local total_tasks=11
  local current_task=0



  print_banner

  # System checks
  show_progress $((++current_task)) $total_tasks "Checking system requirements"
  check_system_requirements
  check_disk_space

  # Install binary tools
  show_progress $((++current_task)) $total_tasks "Installing Neovim"
  install_nvim || true


  show_progress $((++current_task)) $total_tasks "Installing Kitty"

  install_and_config_kitty || true

  show_progress $((++current_task)) $total_tasks "Installing Tealdeer"
  install_tealdeer || true

  # Install fonts
  show_progress $((++current_task)) $total_tasks "Installing fonts"
  install_fonts || true


  # Install Git-based tools
  show_progress $((++current_task)) $total_tasks "Installing TPM"
  install_git_repo "TPM (Tmux Plugin Manager)" "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm" || true

  # Install web-based tools
  show_progress $((++current_task)) $total_tasks "Installing FNM"
  install_web_based_tool "FNM (Fast Node Manager)" "https://fnm.vercel.app/install" "fnm" || true

  show_progress $((++current_task)) $total_tasks "Installing PNPM"
  install_web_based_tool "PNPM" "https://get.pnpm.io/install.sh" "pnpm" || true


  show_progress $((++current_task)) $total_tasks "Installing SDKMAN"
  install_web_based_tool "SDKMAN" "https://get.sdkman.io" "sdk" || true

  show_progress $((++current_task)) $total_tasks "Installing Deno"

  install_web_based_tool "Deno" "https://deno.land/install.sh" "deno" || true

  show_progress $((++current_task)) $total_tasks "Installing Bun"
  install_web_based_tool "Bun" "https://bun.sh/install" "bun" || true

  # Configure shell
  show_progress $((++current_task)) $total_tasks "Configuring Fish shell"

  configure_fish || true


  print_summary
}


# ============================================================================
# Script Execution
# ============================================================================


# Trap to ensure cleanup on exit
cleanup() {
  local exit_code=$?

  if [ $exit_code -ne 0 ]; then
    log "ERROR" "Script interrupted or failed with exit code $exit_code"
  fi
  exit $exit_code
}


trap cleanup EXIT INT TERM

# Run main function
main "$@"

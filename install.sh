#!/bin/bash

detect_os() {
  if [[ "$(uname)" == "Darwin" ]]; then
    if [[ "$(uname -m)" == "arm64" ]]; then
      source "./installers/apple_silicon.sh"
    else
      echo "Intel-based Mac detected. This script is optimized for Apple Silicon."
      exit 1
    fi
  elif [[ "$(uname)" == "Linux" ]]; then
    if command -v apt-get &>/dev/null; then
      source "./installers/debian.sh"
    elif command -v dnf &>/dev/null; then
      source "./installers/redhat.sh"
    elif command -v pacman &>/dev/null; then
      source "./installers/arch.sh"
    else
      echo "Unsupported Linux distribution"
      exit 1
    fi
  else
    echo "Unsupported operating system"
    exit 1
  fi
}

main() {
  detect_os
  main
}

main

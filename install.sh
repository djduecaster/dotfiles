#!/usr/bin/env bash
set -euo pipefail

# Repo root = directory where this script lives
REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

ensure_local_ssh_config() {
  local local_cfg="$REPO_ROOT/ssh/config"
  local example_cfg="$REPO_ROOT/ssh/config.example"

  if [ -e "$local_cfg" ]; then
    return 0
  fi

  if [ ! -e "$example_cfg" ]; then
    echo "ERROR: Missing template $example_cfg"
    exit 1
  fi

  mkdir -p "$(dirname "$local_cfg")"
  cp "$example_cfg" "$local_cfg"
  chmod 600 "$local_cfg" 2>/dev/null || true
  echo "INIT: $local_cfg created from $example_cfg"
}

link_file() {
  local src="$1"
  local dst="$2"

  # Ensure parent dir exists (e.g. ~/.config/ghostty)
  mkdir -p "$(dirname "$dst")"

  # If destination is already a symlink to the correct place, do nothing
  if [ -L "$dst" ]; then
    local target
    target="$(readlink "$dst")"
    if [ "$target" = "$src" ]; then
      echo "OK: $dst already links to $src"
      return 0
    fi
    echo "WARN: $dst is a symlink to $target (expected $src). Leaving as-is."
    echo "      Remove it manually if you want this script to replace it."
    return 0
  fi

  # If destination exists (file/dir), back it up with a timestamp
  if [ -e "$dst" ]; then
    local backup="${dst}.bak.$(date +%Y%m%d_%H%M%S)"
    echo "BACKUP: $dst -> $backup"
    mv "$dst" "$backup"
  fi

  # Create symlink
  ln -s "$src" "$dst"
  echo "LINK: $dst -> $src"
}

# Ghostty
link_file "$REPO_ROOT/ghostty/config" "$HOME/.config/ghostty/config"

# SSH
ensure_local_ssh_config
link_file "$REPO_ROOT/ssh/config" "$HOME/.ssh/config"

echo "Done."

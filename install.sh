#!/usr/bin/env bash
set -euo pipefail

# Repo root = directory where this script lives
REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

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

echo "Done."

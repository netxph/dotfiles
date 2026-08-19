#!/usr/bin/env bash
# Usage: link-herdr.sh [linux|windows]
# Creates a symlink from the repo herdr config to the platform's herdr config path.
set -euo pipefail
REPO_DIR="/home/netxph/Projects/dotfiles/herdr"
MODE="${1:-}" 
if [ -z "$MODE" ]; then
  echo "Specify 'linux' or 'windows'"
  exit 2
fi
if [ "$MODE" = "linux" ]; then
  TARGET_DIR="$HOME/.config/herdr"
  SRC="$REPO_DIR/config.linux.toml"
elif [ "$MODE" = "windows" ]; then
  # On Windows (WSL/Cygwin) user can pass 'windows' to symlink the windows config
  TARGET_DIR="$HOME/.config/herdr" # fallback; Windows users can modify this
  SRC="$REPO_DIR/config.windows.toml"
else
  echo "Unknown mode: $MODE"
  exit 2
fi
mkdir -p "$TARGET_DIR"
TARGET="$TARGET_DIR/config.toml"
if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
  echo "Backing up existing $TARGET to ${TARGET}.bak"
  mv "$TARGET" "${TARGET}.bak"
fi
ln -sfn "$SRC" "$TARGET"
echo "Linked $SRC -> $TARGET"

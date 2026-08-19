#!/usr/bin/env bash
# POSIX wrapper for start-herdr.py — callable from fish as `start-herdr`.
set -euo pipefail
SCRIPT_DIR="/home/netxph/Projects/dotfiles/scripts"
python3 "$SCRIPT_DIR/start-herdr.py" "$@"

#!/usr/bin/env bash
set -euo pipefail

link_config() {
  local source="$1"
  local destination="$2"

  mkdir -p "$(dirname "$destination")"

  if [[ -L "$destination" ]] && [[ "$(readlink -f "$destination")" == "$(readlink -f "$source")" ]]; then
    echo "Already linked: $destination"
    return
  fi

  if [[ -e "$destination" || -L "$destination" ]]; then
    local backup="${destination}.backup-$(date +%Y%m%d-%H%M%S)"
    mv "$destination" "$backup"
    echo "Backed up: $destination -> $backup"
  fi

  ln -s "$source" "$destination"
  echo "Linked: $destination -> $source"
}

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

link_config "$repo_root/arch/hypr" "$HOME/.config/hypr"
link_config "$repo_root/arch/noctalia" "$HOME/.config/noctalia"
link_config "$repo_root/fish" "$HOME/.config/fish"

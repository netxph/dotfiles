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

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link_config "$repo_root/alacritty" "$HOME/.config/alacritty"
link_config "$repo_root/fish" "$HOME/.config/fish"
link_config "$repo_root/git/gitconfig" "$HOME/.gitconfig"
link_config "$repo_root/herdr/config.linux.toml" "$HOME/.config/herdr/config.toml"
link_config "$repo_root/tmux/tmux.conf" "$HOME/.tmux.conf"
link_config "$repo_root/zellij/config/config.linux.kdl" "$HOME/.config/zellij/config.kdl"

if [[ -x "$repo_root/arch/link.sh" ]]; then
  "$repo_root/arch/link.sh"
fi

-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

hl.unbind("SUPER + W")
o.bind("SUPER + Q", "Close window", hl.dsp.window.close())

o.bind("SUPER + N", "Vim scratchpad", hl.dsp.workspace.toggle_special("nvim"))
o.bind("SUPER + N", nil, "hyprctl clients -j | jq -e '.[] | select(.class == \"com.netxph.nvim_scratchpad\")' >/dev/null || uwsm app -- ghostty --class=com.netxph.nvim_scratchpad -e nvim \"$HOME/.scratchpad.md\"")

o.bind("SUPER + Z", "Terminal scratchpad", hl.dsp.workspace.toggle_special("terminal"))
o.bind("SUPER + Z", nil, "hyprctl clients -j | jq -e '.[] | select(.class == \"com.netxph.terminal_scratchpad\")' >/dev/null || uwsm app -- ghostty --class=com.netxph.terminal_scratchpad")

o.bind("SUPER + I", "Pi scratchpad", hl.dsp.workspace.toggle_special("pi"))
o.bind("SUPER + I", nil, "hyprctl clients -j | jq -e '.[] | select(.class == \"com.netxph.pi_scratchpad\")' >/dev/null || uwsm app -- ghostty --gtk-single-instance=false --class=com.netxph.pi_scratchpad -e pi --no-session")

o.bind("SUPER + E", "Yazi scratchpad", hl.dsp.workspace.toggle_special("yazi"))
o.bind("SUPER + E", nil, "hyprctl clients -j | jq -e '.[] | select(.class == \"com.netxph.yazi_scratchpad\")' >/dev/null || uwsm app -- ghostty --class=com.netxph.yazi_scratchpad -e yazi")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

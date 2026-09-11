-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
-- omarchy_default_bindings = false
--
-- Or disable only bindings for Omarchy's preinstalled apps/web apps while
-- keeping core window-manager bindings:
-- omarchy_preinstalled_bindings = false

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Put your personal overrides in these files. They're loaded after Omarchy's
-- defaults so package updates can improve the defaults without rewriting your
-- ~/.config/hypr files.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- Add any other personal Hyprland configuration below.
-- o.window("qemu", { workspace = "5" })

o.window("^com\\.netxph\\.nvim_scratchpad$", {
  workspace = "special:nvim silent",
  float = true,
  size = { 1024, 768 },
  move = { "monitor_w - 1064", "(monitor_h - 768) / 2" },
})

o.window("^com\\.netxph\\.terminal_scratchpad$", {
  workspace = "special:terminal silent",
  float = true,
  size = { 1024, 768 },
  move = { "monitor_w - 1064", "(monitor_h - 768) / 2" },
})

o.window("^com\\.netxph\\.pi_scratchpad$", {
  workspace = "special:pi silent",
  float = true,
  size = { 1024, 768 },
  move = { "monitor_w - 1064", "(monitor_h - 768) / 2" },
})

o.window("^com\\.netxph\\.yazi_scratchpad$", {
  workspace = "special:yazi silent",
  float = true,
  size = { 1024, 768 },
  move = { "monitor_w - 1064", "(monitor_h - 768) / 2" },
})

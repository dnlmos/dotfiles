local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

local mod = {
  SUPER = "CMD",
  SUPER_REV = "OPT",
}

config.colors = {
  foreground = "#CBE0F0",
  background = "#011423",
  cursor_bg = "#47FF9C",
  cursor_border = "#47FF9C",
  cursor_fg = "#011423",
  selection_bg = "#033259",
  selection_fg = "#CBE0F0",
  ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
  brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

config.inactive_pane_hsb = {
  brightness = 0.5,
  saturation = 0.8,
}

config.keys = {
  { key = "LeftArrow",  mods = mod.SUPER_REV, action = wezterm.action({ SendString = "\x1bb" }) },  -- ALT + Left to move one word left
  { key = "LeftArrow",  mods = mod.SUPER,     action = wezterm.action({ SendString = "\x1bOH" }) }, -- CMD + Left to move to the beginning of the line
  { key = "RightArrow", mods = mod.SUPER_REV, action = wezterm.action({ SendString = "\x1bf" }) },  -- ALT + Right to move one word right
  { key = "RightArrow", mods = mod.SUPER,     action = wezterm.action({ SendString = "\x1bOF" }) }, -- CMD + Right to move to the end of the line
  -- tabs: navigation
  { key = "[",          mods = mod.SUPER,     action = act.ActivateTabRelative(-1) },
  { key = "]",          mods = mod.SUPER,     action = act.ActivateTabRelative(1) },
  { key = "[",          mods = mod.SUPER_REV, action = act.MoveTabRelative(-1) },
  { key = "]",          mods = mod.SUPER_REV, action = act.MoveTabRelative(1) },

  -- panes: navigation
  { key = "k",          mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Up") },
  { key = "j",          mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Down") },
  { key = "h",          mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Left") },
  { key = "l",          mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Right") },
  {
    key = "p",
    mods = mod.SUPER_REV,
    action = act.PaneSelect({ alphabet = "1234567890", mode = "SwapWithActiveKeepFocus" }),
  },
}

config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 15

config.enable_tab_bar = true

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.95
config.macos_window_background_blur = 10

-- and finally, return the configuration to wezterm
return config

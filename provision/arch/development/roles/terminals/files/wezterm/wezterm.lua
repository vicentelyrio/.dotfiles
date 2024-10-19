local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font 'JetBrains Mono Nerd Font'
config.font_size = 14.0

config.use_fancy_tab_bar = false

config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 0,
}

config.window_frame = {
  border_left_width = '0.5cell',
  border_right_width = '0.5cell',
  border_bottom_height = '0.25cell',
  border_top_height = '0.25cell',
  border_left_color = '#11111b',
  border_right_color = '#11111b',
  border_bottom_color = '#11111b',
  border_top_color = '#11111b',
}

config.keys = {
  {
    key = 'h',
    mods = 'SUPER',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'l',
    mods = 'SUPER',
    action = act.ActivatePaneDirection 'Right',
  },
  {
    key = 'k',
    mods = 'SUPER',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'j',
    mods = 'SUPER',
    action = act.ActivatePaneDirection 'Down',
  },
}

return config


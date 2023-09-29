-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font 'SFMono Nerd Font'
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

-- and finally, return the configuration to wezterm
return config


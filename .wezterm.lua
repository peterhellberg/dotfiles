local wezterm = require 'wezterm';

return {
  automatically_reload_config = true,
  font = wezterm.font('Office Code Pro D', {
    weight = 'Regular',
    italic = false
  }),
  font_size = 10.0,
  color_scheme = 'Jellybeans (Gogh)',
  enable_tab_bar = false,
  audible_bell = 'Disabled',
  exit_behavior = 'Close',
  cursor_blink_rate = 800,
  default_cursor_style = 'BlinkingBar',
  bold_brightens_ansi_colors = true,
  window_close_confirmation = 'NeverPrompt',
  window_decorations = 'RESIZE',
  window_padding = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
  },
  colors = {
    cursor_bg = '#FFB371',
  },
  keys = {
    {
      key = 'd',
      mods = 'SUPER',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'D',
      mods = 'SUPER',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'LeftArrow',
      mods = 'META',
      action = wezterm.action.ActivatePaneDirection 'Left',
    },
    {
      key = 'RightArrow',
      mods = 'META',
      action = wezterm.action.ActivatePaneDirection 'Right',
    },
    {
      key = 'UpArrow',
      mods = 'META',
      action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
      key = 'DownArrow',
      mods = 'META',
      action = wezterm.action.ActivatePaneDirection 'Down',
    },
  },
}

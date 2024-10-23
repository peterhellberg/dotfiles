local wezterm = require 'wezterm';

return {
  automatically_reload_config = true,
  font = wezterm.font('Office Code Pro D', {
    weight = 'Regular',
    italic = false
  }),
  font_size = 10.0,
  color_scheme = 'Jellybeans',
  enable_tab_bar = false,
  audible_bell = 'Disabled',
  exit_behavior = 'Close',
  cursor_blink_rate = 800,
  default_cursor_style = 'BlinkingBar',
  bold_brightens_ansi_colors = false,
  window_close_confirmation = 'NeverPrompt',
  window_decorations = 'RESIZE',
  window_padding = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
  },
  inactive_pane_hsb = {
    saturation = 1,
    brightness = 1,
  },
  colors = {
    foreground = '#DDDDC5',
    background = '#131313',
    cursor_bg = '#FFB371',
    cursor_fg = '#000000',
    split = '#333333',
    ansi = {
      '#353534',
      '#D35737',
      '#97A950',
      '#F9CF75',
      '#44677F',
      '#C5B5EC',
      '#88C5E8',
      '#FEFEFE',
    },
    brights = {
      '#626566',
      '#FF2600',
      '#C1D64F',
      '#FFD366',
      '#7492CF',
      '#CDC0FF',
      '#90D2F6',
      '#F9F9F4',
    },
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
    {
      key = 'PageUp',
      mods = 'CTRL',
      action = wezterm.action.ActivateTabRelative(-1),
    },
    {
      key = 'PageDown',
      mods = 'CTRL',
      action = wezterm.action.ActivateTabRelative(1),
    },
  },
}

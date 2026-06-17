local wezterm = require 'wezterm'

return {
  default_prog = { "wsl.exe", "-d", "Ubuntu" },

  font = wezterm.font("JetBrainsMono Nerd Font"),
  font_size = 12.5,

  color_scheme = "Catppuccin Mocha",

  enable_tab_bar = false,

  use_fancy_tab_bar = false,

  window_padding = {
    left = 8,
    right = 8,
    top = 8,
    bottom = 8,
  },

  keys = {
    {
      key = 'v',
      mods = 'CTRL',
      action = wezterm.action.PasteFrom 'Clipboard',
    },

    {
      key = 'c',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.CopyTo 'Clipboard',
    },

    {
      key = 'v',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitHorizontal,
    },

    {
      key = 's',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitVertical,
    },

    {
      key = 'h',
      mods = 'ALT',
      action = wezterm.action.ActivatePaneDirection 'Left',
    },

    {
      key = 'l',
      mods = 'ALT',
      action = wezterm.action.ActivatePaneDirection 'Right',
    },

    {
      key = 'k',
      mods = 'ALT',
      action = wezterm.action.ActivatePaneDirection 'Up',
    },

    {
      key = 'j',
      mods = 'ALT',
      action = wezterm.action.ActivatePaneDirection 'Down',
    },
  },
}
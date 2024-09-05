{ pkgs, config, ... }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
    return {
      color_scheme = 'Ayu Dark (Gogh)',
      font = wezterm.font('Iosevka Nerd Font'),
      font_size = 16,
      use_fancy_tab_bar = false,
      native_macos_fullscreen_mode = false,
      enable_scroll_bar = false,
      window_decorations = "RESIZE",
      enable_kitty_graphics = true,
      hide_tab_bar_if_only_one_tab = true,
      keys = {
        {
          key = 'n',
          mods = 'CMD|SHIFT',
          action = wezterm.action.ToggleFullScreen,
        },
      },
      window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
      },
      window_background_opacity = 1,
      macos_window_background_blur = 0,
      front_end = "WebGpu",
    }
    '';
  };
}

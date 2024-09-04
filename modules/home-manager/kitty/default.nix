{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" "NerdFontsSymbolsOnly" ]; })
  ];

  programs.kitty = {
    enable = true;
    font = {
      name = "Iosevka Nerd Font Mono";
      size = 12;
    };
    shellIntegration = {
      enableZshIntegration = true;
    };
    theme = "Catppuccin-Frappe";
    darwinLaunchOptions = [
      "--single-instance"
    ];
    settings = {
      background_opacity = "0.9";
      background_blur = 5;
      macos_traditional_fullscreen = "yes";
    };
  };
}

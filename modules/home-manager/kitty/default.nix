{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];

  programs.kitty = {
    enable = true;
    font = {
      name = "Iosevka Nerd Font";
      size = 12;
    };
    shellIntegration = {
      enableZshIntegration = true;
    };
    theme = "Catppuccin-Frappe";
  };
}

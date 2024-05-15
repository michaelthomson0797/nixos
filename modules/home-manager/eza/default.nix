{ pkgs, config, ... }:

{
  programs = {
    eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = false;
    };
  };
}

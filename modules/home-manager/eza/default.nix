{ pkgs, config, ... }:

{
  programs = {
    eza = {
      enable = true;
      enableAliases = true;
      git = true;
      icons = false;
    };
  };
}

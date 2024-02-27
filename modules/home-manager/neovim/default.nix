{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    noevim
  ];
  home.file.".config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };
}

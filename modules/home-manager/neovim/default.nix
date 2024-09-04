{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    fzf
    ripgrep
    luarocks
  ];

  programs.neovim = {
    enable = true;
  };

  home.file.".config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };

}

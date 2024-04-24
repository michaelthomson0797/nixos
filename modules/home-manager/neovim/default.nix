{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    neovim
    fzf
    ripgrep
  ];
  home.file.".config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };
}

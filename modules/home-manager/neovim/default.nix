{ inputs, pkgs, config, ... }:

{
  home.packages = with pkgs; [
    fzf
    ripgrep
    luarocks
    luajit
    lua-language-server
    nil
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  home.file.".config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };

}

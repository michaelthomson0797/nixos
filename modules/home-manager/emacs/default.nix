{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    emacs
    fzf
    ripgrep
    emacs-lsp-booster
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];

  home.file.".emacs.d" = {
    source = ./emacs.d;
    recursive = true;
  };
}

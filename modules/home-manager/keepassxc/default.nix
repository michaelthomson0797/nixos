{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    keepassxc
  ];

  # home.sessionPath = [ "${pkgs.keepassxc}/Applications/KeePassXC.app/Contents/MacOS/" ];
}

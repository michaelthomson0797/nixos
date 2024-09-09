{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    pinentry-curses
  ];

  programs = {
    gpg = {
      enable = true;
    };
    password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: [ exts.pass-otp exts.pass-file exts.pass-import ]);
      settings = {
        PASSWORD_STORE_DIR = "\${HOME}/.password-store";
      };
    };
    browserpass = {
      enable = true;
    };
  };

  services = {
    gpg-agent = {
      enable = !pkgs.stdenv.isDarwin;
      pinentryPackage = pkgs.pinentry-curses;
    };
  };
}

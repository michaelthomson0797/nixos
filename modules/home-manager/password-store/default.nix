{ pkgs, config, ... }:

{

  home.packages = with pkgs; [
    passExtensions.pass-otp
    passExtensions.pass-file
  ];

  programs = {
    gpg = {
      enable = true;
    };
    password-store = {
      enable = true;
    };
    browserpass = {
      enable = true;
    };
  };

  # services = {
  #   gpg-agent = {
  #     enable = true;
  #   };
  # };
}

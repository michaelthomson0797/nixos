{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    protonmail-bridge
  ];

  programs = {
    mbsync = {
      enable = true;
    };
    neomutt = {
      enable = true;
    };
    msmtp = {
      enable = true;
    };
    notmuch = {
      enable = true;
    };
    password-store = {
      enable = true;
    };
  };

  accounts.email = {
    accounts.michaelthomson = {
      address = "michael@michaelthomson.dev";
      imap = {
        host = "127.0.0.1";
        port = 1143;
      };
      mbsync = {
        enable = true;
        create = "maildir";
      };
      msmtp = {
        enable = true;
      };
      notmuch = {
        enable = true;
      };
      primary = true;
      realName = "Michael Thomson";
      smtp = {
        host = "127.0.0.1";
        port = "1025";
      };
      userName = "michael@michaelthomson.dev";
    };
  };
}

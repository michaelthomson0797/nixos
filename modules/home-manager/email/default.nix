{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    w3m
  ];

  services = {
    # mbsync = {
    #   enable = true;
    #   frequency = "*-*-* *:*/5:00";
    #   postExec = "\${pkgs.notmuch} new";
    # };
    vdirsyncer = {
      enable = true;
      frequency = "*-*-* *:*/5:00";
    };
  };

  programs = {
    aerc = {
      enable = true;
      extraConfig = {
        ui = {
          sort = "arrival -r";
        };
        general = {
          unsafe-accounts-conf = true;
        };
        compose = {
          address-book-cmd = "khard email --parsable --remove-first-line %s";
        };
        filters = {
          "text/plain" = "colorize";
          "text/calendar" = "calendar";
          "text/html" = "html | colorize";
        };
      };
    };
    msmtp = {
      enable = true;
    };
    mbsync = {
      enable = true;
    };
    notmuch = {
      enable = true;
    };
    lieer = {
      enable = true;
    };
    vdirsyncer = {
      enable = true;
    };
    khal = {
      enable = true;
    };
    khard = {
      enable = true;
    };
  };

  accounts = {
    email = {
      accounts.personal = {
        primary = true;
        address = "michael@michaelthomson.dev";
        realName = "Michael Thomson";
        userName = "michael@michaelthomson.dev";
        passwordCommand = "pass email/michael@michaelthomson.dev";
        aerc = {
          enable = true;
        };
        mbsync = {
          enable = true;
          create = "both";
        };
        imap = {
          host = "mail.michaelthomson.dev";
          port = 993;
          tls = {
            enable = true;
          };
        };
        msmtp = {
          enable = true;
        };
        smtp = {
          host = "mail.michaelthomson.dev";
          port = 465;
          tls = {
            enable = true;
          };
        };
        notmuch = {
          enable = true;
        };
      };
    };
    calendar = {
      basePath = ".calendar";
      accounts.personal = {
        primary = true;
        primaryCollection = "default";
        remote = {
          type = "caldav";
          url = "https://baikal.michaelthomson.dev/dav.php";
          userName = "michael@michaelthomson.dev";
          passwordCommand = [
            "pass"
            "calendar/michael@michaelthomson.dev"
          ];
        };
        vdirsyncer = {
          enable = true;
          auth = "basic";
          collections = [ "default" "shared" ];
        };
        khal = {
          enable = true;
          addresses = [ "michael@michaelthomson.dev" ];
          type = "discover";
        };
      };
    };
    contact = {
      basePath = ".contacts";
      accounts.personal = {
        local = {
          type = "filesystem";
          fileExt = ".vcf";
        };
        remote = {
          type = "carddav";
          url = "https://baikal.michaelthomson.dev/dav.php";
          userName = "michael@michaelthomson.dev";
          passwordCommand = [
            "pass"
            "calendar/michael@michaelthomson.dev"
          ];
        };
        vdirsyncer = {
          enable = true;
          auth = "basic";
          collections = [ "default" ];
        };
        khal = {
          enable = true;
          addresses = [ "michael@michaelthomson.dev" ];
          collections = [ "default" ];
        };
        khard = {
          enable = true;
          defaultCollection = "default";
        };
      };
    };
  };
}

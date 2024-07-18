{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    w3m
  ];

  home.file = {
    "calendar-password.sh" = {
      source = ./calendar-password.sh;
      executable = true;
    };
  };

  services = {
    # mbsync = {
    #   enable = true;
    #   frequency = "*-*-* *:*/5:00";
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
        general = {
          unsafe-accounts-conf = true;
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
    vdirsyncer = {
      enable = true;
    };
    khal = {
      enable = true;
    };
  };

  accounts = {
    email = {
      accounts.michaelthomson = {
        primary = true;
        address = "michael@michaelthomson.dev";
        realName = "Michael Thomson";
        userName = "michael@michaelthomson.dev";
        passwordCommand = "${pkgs._1password}/bin/op read \"op://Personal/SES SMTP/password\"";
        aerc = {
          enable = true;
        };
        mbsync = {
          enable = true;
          create = "maildir";
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
      };
    };
    calendar = {
      basePath = ".calendar";
      accounts.michaelthomson = {
        primary = true;
        primaryCollection = "default";
        remote = {
          type = "caldav";
          url = "https://baikal.michaelthomson.dev/dav.php";
          userName = "michael@michaelthomson.dev";
          passwordCommand = [
            "~/calendar-password.sh"
          ];
          # passwordCommand = [ 
          #   "${pkgs._1password}/bin/op" 
          #   "read"
          #   "op://Personal/Baikal/password"
          # ];
        };
        vdirsyncer = {
          enable = true;
          auth = "basic";
          collections = [ "default" "shared" ];
        };
        khal = {
          enable = true;
          type = "discover";
          color = "#f2d5cf";
        };
      };
    };
  };
}

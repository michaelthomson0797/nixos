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
    "work-calendar-client-id.sh" = {
      source = ./work-calendar-client-id.sh;
      executable = true;
    };
    "work-calendar-client-secret.sh" = {
      source = ./work-calendar-client-secret.sh;
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
      stylesets = {
        catppuccin-frappe = ''
          *.default=true
          *.normal=true

          default.fg=#c6d0f5

          error.fg=#e78284
          warning.fg=#ef9f76
          success.fg=#a6d189

          tab.fg=#737994
          tab.bg=#292c3c
          tab.selected.fg=#c6d0f5
          tab.selected.bg=#303446
          tab.selected.bold=true

          border.fg=#232634
          border.bold=true

          msglist_unread.bold=true
          msglist_flagged.fg=#e5c890
          msglist_flagged.bold=true
          msglist_result.fg=#8caaee
          msglist_result.bold=true
          msglist_*.selected.bold=true
          msglist_*.selected.bg=#414559

          dirlist_*.selected.bold=true
          dirlist_*.selected.bg=#414559

          statusline_default.fg=#949cbb
          statusline_default.bg=#414559
          statusline_error.bold=true
          statusline_success.bold=true

          completion_default.selected.bg=#414559

          [viewer]
          url.fg=#8caaee
          url.underline=true
          header.bold=true
          signature.dim=true
          diff_meta.bold=true
          diff_chunk.fg=#8caaee
          diff_chunk_func.fg=#8caaee
          diff_chunk_func.bold=true
          diff_add.fg=#a6d189
          diff_del.fg=#e78284
          quote_*.fg=#737994
          quote_1.fg=#949cbb
        '';
      };
      extraConfig = {
        general = {
          unsafe-accounts-conf = true;
        };
        ui = {
          border-char-vertical = "│";
          border-char-horizontal = "─";
          styleset-name = "catppuccin-frappe";
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
      settings = {
        view = {
          agenda_event_format = "{calendar-color}{cancelled}{start-end-time-style} {title}{repeat-symbol}{reset}";
        };
      };
    };
  };

  accounts = {
    email = {
      accounts.personal = {
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
        notmuch = {
          enable = true;
        };
      };
      accounts.work = {
        primary = false;
        flavor = "gmail.com";
        address = "mthomson@konradgroup.com";
        realName = "Michael Thomson";
        aerc = {
          enable = true;
          extraAccounts = { source = "maildir://~/Maildir/work"; };
        };
        notmuch = {
          enable = true;
        };
        lieer = {
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
      accounts.work = {
        primary = false;
        remote = {
          type = "google_calendar";
        };
        vdirsyncer = {
          enable = true;
          collections = [ "from a" "from b" ];
          clientIdCommand = [
            "~/work-calendar-client-id.sh"
          ];
          clientSecretCommand = [
            "~/work-calendar-client-secret.sh"
          ];
          tokenFile = "~/token_file";
        };
        khal = {
          enable = true;
          type = "discover";
          color = "#e78284";
        };
      };
    };
  };
}

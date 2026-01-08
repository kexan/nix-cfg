{
  flake.modules = {
    homeManager.plasma =
      { config, pkgs, ... }:
      {
        home.file.".local/share/wallpapers/winxp.jpg".source = ../wallpapers/winxp.jpg;

        programs.plasma = {
          workspace = {
            wallpaper = "${config.home.homeDirectory}/.local/share/wallpapers/winxp.jpg";
          };

          panels = [
            {
              location = "top";
              hiding = "none";
              height = 36;
              floating = true;
              widgets = [
                {
                  name = "org.kde.plasma.kickoff";
                  config = {
                    General = {
                      icon = "nix-snowflake";
                    };
                  };
                }
                "org.kde.plasma.marginsseparator"
                {
                  name = "org.kde.plasma.taskmanager";
                  config = {
                    General = {
                      taskMaxWidth = "Narrow";
                      wheelEnabled = "AllTask";
                      launchers = [ ];
                    };
                  };
                }
                {
                  name = "org.kde.plasma.panelspacer";
                  config = {
                    expanding = true;
                  };
                }
                {
                  name = "org.kde.plasma.pager";
                  config = {
                    General = {
                      showWindowIcons = true;
                    };
                  };
                }
                "org.kde.plasma.marginsseparator"
                {
                  systemTray.items = {
                    hidden = [
                      "org.kde.plasma.clipboard"
                      "Wallet Manager"
                    ];
                    shown = [
                      "org.kde.plasma.bluetooth"
                      "org.kde.plasma.keyboardlayout"
                      "org.kde.plasma.volume"
                      "org.kde.plasma.brightness"
                      "org.kde.plasma.battery"
                      "org.kde.plasma.networkmanagement"
                    ];
                  };
                }
                {
                  name = "org.kde.plasma.digitalclock";
                  config = {
                    Appearance = {
                      use24hFormat = true;
                      showDate = false;
                    };
                  };
                }
                "org.kde.plasma.showdesktop"
              ];
            }
          ];
        };

      };
  };
}

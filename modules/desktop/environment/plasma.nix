{ inputs, ... }:
{
  flake.modules = {
    nixos.desktop =
      { pkgs, ... }:

      let
        # Фикс маленького курсора в некоторых приложениях
        breezeCursorDefaultTheme = pkgs.runCommandLocal "breeze-cursor-default-theme" { } ''
          mkdir -p $out/share/icons
          ln -s ${pkgs.kdePackages.breeze}/share/icons/breeze_cursors $out/share/icons/default
        '';
      in
      {

        services.desktopManager.plasma6.enable = true;

        environment.plasma6.excludePackages = with pkgs; [
          kdePackages.elisa
        ];

        xdg.portal = {
          enable = true;
          config.common.default = "kde";
          extraPortals = with pkgs; [ kdePackages.xdg-desktop-portal-kde ];
        };

        environment.systemPackages = [
          breezeCursorDefaultTheme
        ];
      };

    homeManager.desktop =
      { pkgs, ... }:

      {
        imports = [
          inputs.plasma-manager.homeModules.plasma-manager
        ];

        programs.plasma = {
          enable = true;

          workspace = {
            wallpaperPictureOfTheDay.provider = "bing";
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
                      icon = "nix-snowflake-white";
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

          krunner = {
            position = "center";
            shortcuts.launch = "Meta+Space";
            historyBehavior = "enableSuggestions";
          };

          shortcuts = {
            kwin = {
              "Switch to Desktop 1" = "Meta+1";
              "Switch to Desktop 2" = "Meta+2";
              "Switch to Desktop 3" = "Meta+3";
              "Switch to Desktop 4" = "Meta+4";
              "Switch to Desktop 5" = "Meta+5";
              "Window Close" = "Meta+C";
            };
            "services/org.kde.konsole.desktop"._launch = "Meta+Q";
            "services/zen-beta.desktop"._launch = "Meta+Z";
          };

          configFile = {
            kcminputrc = {
              "Libinput/13364/53288/Keychron Keychron Ultra-Link 8K".NaturalScroll = true;
              "Libinput/13364/53288/Keychron Keychron Ultra-Link 8K".PointerAccelerationProfile = 1;
            };
            kdeglobals = {
              General = {
                accentColorFromWallpaper = true;
                fixed = "FiraCode Nerd Font Mono,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
              };
            };
            kscreenlockerrc = {
              Daemon.RequirePassword = false;
              Daemon.Timeout = 200;
            };
            ksmserverrc = {
              General.loginMode = "emptySession";
            };
            kwinrc = {
              Desktops = {
                Id_1 = "590e19e8-9580-4cf9-b56d-e944544c340b";
                Id_2 = "303f2d41-95ed-41ee-ab52-41238411c432";
                Id_3 = "7e838448-4c25-4e2d-ba8c-a00be4ebf179";
                Id_4 = "6ff37b80-223a-426e-a98e-459919b07c0c";
                Id_5 = "e448198e-8437-48dc-9b06-61878b7a8c99";
                Number = 5;
                Rows = 1;
              };
              Windows = {
                DelayFocusInterval = 0;
                FocusPolicy = "FocusFollowsMouse";
                FocusStealingPreventionLevel = 0;
              };
              Xwayland.Scale = 1.5;
              "org.kde.kdecoration2" = {
                ButtonsOnLeft = "XI";
                ButtonsOnRight = "SHM";
              };
            };
            kxkbrc = {
              Layout = {
                DisplayNames = ",";
                LayoutList = "us,ru";
                Options = "grp:caps_toggle";
                ResetOldOptions = true;
                Use = true;
                VariantList = ",";
              };
            };
            plasma-localerc.Formats.LANG = "ru_RU.UTF-8";
          };
        };

        home.file.".icons/default".source = "${pkgs.kdePackages.breeze}/share/icons/breeze_cursors";
      };
  };
}

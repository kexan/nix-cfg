{
  flake.modules = {
    nixos.gnome =
      { pkgs, ... }:

      {
        services = {
          desktopManager = {
            gnome = {
              enable = true;
              extraGSettingsOverrides = ''
                [org.gnome.desktop.input-sources]
                sources=[('xkb', 'us'), ('xkb', 'ru')]
              '';
            };
          };
          gnome.games.enable = false;
        };

        environment = {
          gnome.excludePackages = with pkgs; [
            epiphany
            baobab
            decibels
            simple-scan
            geary
            snapshot
            gnome-maps
            gnome-tour
            gnome-user-docs
            gnome-font-viewer
            gnome-connections
            gnome-contacts
            yelp
          ];

          systemPackages = with pkgs; [
            gnomeExtensions.appindicator
          ];
        };

        xdg = {
          autostart.enable = true;

          portal = {
            enable = true;
            config.common.default = "gtk";
            extraPortals = with pkgs; [ xdg-desktop-portal-gnome ];
          };
        };
      };

    homeManager.gnome =
      { pkgs, ... }:
      {
        xdg = {
          autostart.enable = true;
        };

        dconf = {
          settings = {
            "org/gnome/mutter" = {
              experimental-features = [
                "scale-monitor-framebuffer"
                "xwayland-native-scaling"
              ];
            };

            "org/gnome/shell" = {
              enabled-extensions = [
                pkgs.gnomeExtensions.appindicator.extensionUuid
              ];
            };

            "org/gnome/shell/app-switcher" = {
              current-workspace-only = true;
            };

            "org/gnome/desktop/input-sources" = {
              xkb-options = [ "grp:caps_toggle" ];
            };

            "org/gnome/desktop/session" = {
              idle-delay = 900;
            };

            "org/gnome/settings-daemon/plugins/power" = {
              sleep-inactive-ac-timeout = 7200;
            };

            "org/gnome/desktop/interface" = {
              cursor-theme = "Adwaita";
              cursor-size = 24;
              gtk-theme = "Adwaita";
              icon-theme = "Adwaita";
              accent-color = "green";
              show-battery-percentage = true;
            };

            "org/gnome/desktop/peripherals/mouse" = {
              accel-profile = "flat";
              natural-scroll = true;
            };

            "org/gnome/settings-daemon/plugins/media-keys" = {
              www = [ "<Super>z" ];
              custom-keybindings = [
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/"
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/nautilus/"
              ];
            };

            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal" = {
              name = "Terminal";
              command = "kgx";
              binding = "<Super>q";
            };

            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/nautilus" = {
              name = "File manager";
              command = "nautilus --new-window";
              binding = "<Super>e";
            };

            "org/gnome/desktop/wm/keybindings" = {
              close = [ "<Super>c" ];

              "switch-to-workspace-1" = [ "<Super><Shift>1" ];
              "switch-to-workspace-2" = [ "<Super><Shift>2" ];
              "switch-to-workspace-3" = [ "<Super><Shift>3" ];
              "switch-to-workspace-4" = [ "<Super><Shift>4" ];
              "switch-to-workspace-5" = [ "<Super><Shift>5" ];
            };

            "org/gnome/desktop/wm/preferences" = {
              button-layout = ":close";
              focus-mode = "sloppy";
            };

          };
        };
      };
  };
}

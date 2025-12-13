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
            gnome-tour
            gnome-user-docs
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

    homeManager.gnome = {
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
          };

          "org/gnome/desktop/peripherals/mouse" = {
            accel-profile = "flat";
            natural-scroll = true;
          };
        };
      };
    };
  };
}

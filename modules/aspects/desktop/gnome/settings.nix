{
  den.aspects.desktop.provides.gnome = {
    nixos = {
      services.desktopManager.gnome.extraGSettingsOverrides = ''
        [org.gnome.desktop.input-sources]
        sources=[('xkb', 'us'), ('xkb', 'ru')]
      '';
    };

    homeManager = {
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          accent-color = "green";
          show-battery-percentage = true;
        };

        "org/gnome/desktop/input-sources" = {
          xkb-options = ["grp:caps_toggle"];
        };

        "org/gnome/desktop/peripherals/touchpad" = {
          tap-to-click = true;
          natural-scroll = true;
          two-finger-scrolling-enabled = true;
          disable-while-typing = true;
        };

        "org/gnome/desktop/peripherals/mouse" = {
          accel-profile = "flat";
          natural-scroll = true;
        };

        "org/gnome/desktop/session" = {
          idle-delay = 900;
        };

        "org/gnome/settings-daemon/plugins/power" = {
          sleep-inactive-ac-timeout = 7200;
        };

        "org/gnome/shell/app-switcher" = {
          current-workspace-only = true;
        };

        "org/gnome/mutter" = {
          experimental-features = [
            "scale-monitor-framebuffer"
            "xwayland-native-scaling"
          ];
        };
      };
    };
  };
}

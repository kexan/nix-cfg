{
  flake.modules = {
    nixos.gnome = {
      services.desktopManager.gnome.extraGSettingsOverrides = ''
        [org.gnome.desktop.input-sources]
        sources=[('xkb', 'us'), ('xkb', 'ru')]
      '';
    };

    homeManager.gnome = {
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          cursor-theme = "Adwaita";
          cursor-size = 24;
          gtk-theme = "Adwaita";
          icon-theme = "Adwaita";
          accent-color = "green";
          show-battery-percentage = true;
        };

        "org/gnome/desktop/input-sources" = {
          xkb-options = ["grp:caps_toggle"];
        };

        "org/gnome/desktop/peripherals/touchpad" = {
          tap-to-click = false;
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

        "org/gnome/desktop/wm/preferences" = {
          button-layout = ":close";
          focus-mode = "sloppy";
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

{
  flake.modules = {
    homeManager.gnome = {
      dconf.settings = {
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
      };
    };
  };

}

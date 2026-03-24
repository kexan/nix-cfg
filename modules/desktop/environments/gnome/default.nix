{
  flake.modules = {
    nixos.gnome = {
      inputs,
      pkgs,
      ...
    }: {
      #if switching from kde then apply those fixes:
      #dconf reset /org/gnome/desktop/interface/cursor-theme
      #dconf reset /org/gnome/desktop/interface/icon-theme
      services = {
        desktopManager.gnome.enable = true;
        displayManager.gdm.enable = true;
        gnome.games.enable = false;
      };

      environment.gnome.excludePackages = with pkgs; [
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

      xdg = {
        autostart.enable = true;

        portal = {
          enable = true;
          config.common.default = "gtk";
          extraPortals = with pkgs; [xdg-desktop-portal-gnome];
        };
      };

      home-manager.sharedModules = [
        inputs.self.modules.homeManager._gnome
      ];
    };

    homeManager._gnome = {
      xdg.autostart.enable = true;
    };
  };
}

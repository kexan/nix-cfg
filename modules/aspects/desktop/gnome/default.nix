{den, ...}: {
  den.aspects.desktop.provides.gnome = {pkgs, ...}: {
    nixos = {
      includes = [
        den.aspects.desktop.provides.fonts
      ];

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
        portal = {
          enable = true;
          config.common.default = "gnome";
          extraPortals = with pkgs; [xdg-desktop-portal-gnome];
        };
      };
    };
  };
}

{
  flake.modules = {
    nixos.gnome =
      { inputs, pkgs, ... }:

      {
        services = {
          desktopManager.gnome.enable = true;
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
            extraPortals = with pkgs; [ xdg-desktop-portal-gnome ];
          };
        };

        home-manager.sharedModules = [
          inputs.self.modules.homeManager.gnome
        ];
      };

    homeManager.gnome = {
      xdg.autostart.enable = true;
    };
  };
}

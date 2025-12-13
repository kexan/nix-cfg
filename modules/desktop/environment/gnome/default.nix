{
  flake.modules = {
    nixos.gnome =
      { pkgs, ... }:

      {
        services = {
          desktopManager.gnome.enable = true;
        };

        xdg = {
          autostart.enable = true;

          portal = {
            enable = true;
            config.common.default = "gnome";
            extraPortals = with pkgs; [ xdg-desktop-portal-gnome ];
          };
        };

      };

    homeManager.gnome =
      { pkgs, ... }:

      {
        home = {
          packages = with pkgs; [
            kdePackages.kate
            kdePackages.krdc
            haruna
          ];
        };
      };
  };
}

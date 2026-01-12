{
  flake.modules = {
    nixos.gnome =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          gnomeExtensions.appindicator
        ];
      };

    homeManager.gnome =
      { pkgs, ... }:
      {
        dconf.settings."org/gnome/shell" = {
          enabled-extensions = [
            pkgs.gnomeExtensions.appindicator.extensionUuid
          ];
        };
      };
  };
}

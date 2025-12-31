{
  flake.modules = {
    nixos.desktop =
      {
        lib,
        config,
        inputs,
        pkgs,
        ...
      }:
      {

        services = {
          displayManager.ly = {
            enable = true;
            settings = {
              animation = "colormix";
              full_color = "true";
              colormix_col1 = "0x00FF0000";
              colormix_col2 = "0x000000FF";
              colormix_col3 = "0x20000000";
              bigclock = "en";
              clear_password = "true";
              brightness_down_key = "null";
              brightness_up_key = "null";
              default_input = "password";
              hide_version_string = "true";
              xsessions = "/";
            };
          };
        };

        security.pam.services.ly.enableKwallet =
          lib.mkIf config.services.desktopManager.plasma6.enable true;

        home-manager.sharedModules = [
          inputs.self.modules.homeManager._desktop
        ];
      };

    homeManager._desktop =
      { pkgs, ... }:
      {
        home = {
          packages = with pkgs; [
            qbittorrent
          ];
        };
      };
  };
}

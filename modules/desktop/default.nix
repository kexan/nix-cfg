{
  flake.modules = {
    nixos.desktop =
      { inputs, pkgs, ... }:
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

        home-manager.sharedModules = [
          inputs.self.modules.homeManager.desktop
        ];
      };

    homeManager.desktop =
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

{
  flake.modules = {
    nixos.desktop =
      { pkgs, ... }:
      {

        services = {
          desktopManager = {
            plasma6 = {
              enable = true;
            };
          };

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
            };
          };
        };

        environment = {
          plasma6.excludePackages = with pkgs; [
            kdePackages.elisa
          ];
        };

        xdg = {
          portal = {
            enable = true;
            config.common.default = "kde";
            extraPortals = with pkgs; [ kdePackages.xdg-desktop-portal-kde ];
          };
        };
      };

    homeManager.desktop =
      { pkgs, ... }:
      {
        home = {
          packages = with pkgs; [
            kdePackages.kate
            kdePackages.krdc
            qbittorrent
            haruna
          ];
        };
      };
  };
}

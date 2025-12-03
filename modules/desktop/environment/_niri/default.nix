{
  flake.modules = {
    nixos.desktop = {
      programs.niri.enable = true;
    };

    homeManager.desktop =
      {
        lib,
        pkgs,
        inputs,
        ...
      }:
      {
        imports = [ inputs.niri-flake.homeModules.niri ];
        programs.niri = {
          enable = true;
          package = pkgs.niri;
          settings = {

            xwayland-satellite = {
              enable = true;
              path = lib.getExe pkgs.xwayland-satellite;
            };

            binds = {
              "Mod+E".action.spawn = "dolphin";
              "Mod+Q".action.spawn = "konsole";
              "Mod+Z".action.spawn = "zen-beta";

              "Mod+C".action.close-window = { };
            };
          };
        };
      };
  };
}

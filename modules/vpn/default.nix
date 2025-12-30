{
  flake.modules = {
    nixos.vpn =
      { inputs, ... }:
      {
        programs.throne = {
          enable = true;
          tunMode.enable = true;
        };

        home-manager.sharedModules = [
          inputs.self.modules.homeManager._vpn
        ];
      };

    homeManager._vpn =
      { pkgs, ... }:
      {
        xdg.autostart.entries = [
          "${pkgs.throne}/share/applications/throne.desktop"
        ];
      };
  };
}

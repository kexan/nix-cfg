{
  flake.modules = {
    nixos.podman =
      { inputs, pkgs, ... }:
      {
        virtualisation.podman = {
          enable = true;
          dockerCompat = true;
          dockerSocket.enable = true;
        };

        environment.systemPackages = [ pkgs.podman-compose ];

        home-manager.sharedModules = [
          inputs.self.modules.homeManager._podman
        ];
      };

    homeManager._podman = {
      programs = {
        lazydocker.enable = true;
      };
    };
  };
}

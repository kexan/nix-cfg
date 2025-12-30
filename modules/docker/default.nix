{
  flake.modules = {
    nixos.docker =
      { inputs, ... }:
      {
        virtualisation.docker.enable = true;

        home-manager.sharedModules = [
          inputs.self.modules.homeManager._docker
        ];
      };

    homeManager._docker = {
      programs = {
        lazydocker.enable = true;
      };
    };
  };
}

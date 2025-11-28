{
  flake.modules = {
    nixos.docker = {
      virtualisation.docker.enable = true;
    };

    homeManager.docker = {
      programs = {
        lazydocker.enable = true;
      };
    };
  };
}

{
  den.aspects.virtualisation.provides.docker = {
    nixos = {
      virtualisation.docker.enable = true;
    };
    homeManager = {
      programs.lazydocker.enable = true;
    };

    user = {
      extraGroups = ["docker"];
    };
  };
}
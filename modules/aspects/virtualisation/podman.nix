{__findFile, ...}: {
  den.aspects.virtualisation.provides.podman = {
    includes = [
      (<tools/groups> ["podman"])
    ];
    nixos = {
      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        dockerSocket.enable = true;
      };
    };
    homeManager = {pkgs, ...}: {
      programs.lazydocker.enable = true;
      home.packages = [pkgs.podman-compose];
    };
  };
}

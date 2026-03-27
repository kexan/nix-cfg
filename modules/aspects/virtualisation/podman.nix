{
  den.aspects.virtualisation.provides.podman = {
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

    user = {
      extraGroups = ["podman"];
    };
  };
}
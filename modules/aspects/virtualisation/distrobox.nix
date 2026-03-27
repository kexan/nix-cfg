{__findFile, ...}: {
  den.aspects.virtualisation.provides.distrobox = {
    includes = [<virtualisation/podman>];
    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.distrobox];
    };
  };
}

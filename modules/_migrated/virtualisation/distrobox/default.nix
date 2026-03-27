{
  flake.modules = {
    nixos.distrobox = {pkgs, ...}: {
      virtualisation.podman = {
        enable = true;
      };

      environment.systemPackages = [pkgs.distrobox];
    };
  };
}

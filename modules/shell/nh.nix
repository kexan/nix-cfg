{
  flake.modules = {
    nixos.shell = {lib, ...}: {
      programs.nh = {
        enable = true;
        clean.enable = true;
      };

      nix.gc.automatic = lib.mkForce false;
    };
  };
}

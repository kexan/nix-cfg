{inputs, ...}: {
  den.aspects.services.provides.flatpak = {
    nixos = {
      imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

      services.flatpak = {
        enable = true;
        uninstallUnmanaged = true;
        update.auto.enable = true;
      };
    };
  };

  flake-file.inputs = {
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };
}

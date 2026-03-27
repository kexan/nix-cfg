{
  den.aspects.services.provides.flatpak = {
    nixos = {inputs, ...}: {
      imports = [inputs.flatpak.nixosModules.nix-flatpak];

      services.flatpak = {
        enable = true;
        uninstallUnmanaged = true;
        update.auto.enable = true;
      };
    };
  };

  flake-file.inputs = {
    flatpak.url = "github:gmodena/nix-flatpak";
  };
}

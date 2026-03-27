{inputs, ...}: {
  flake.modules = {
    nixos.flatpak = {
      imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

      services.flatpak = {
        enable = true;
        uninstallUnmanaged = true;
        update.auto.enable = true;
      };
    };
  };
}

{ inputs, ... }:

{
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

  services.flatpak = {
    enable = true;
    uninstallUnmanaged = true;
    update.auto.enable = true;
    packages = [
      "ru.linux_gaming.PortProton"
    ];
  };

  xdg.portal.enable = true;
}

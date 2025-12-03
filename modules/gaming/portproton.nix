{
  flake.modules = {
    nixos.gaming =
      {
        inputs,
        config,
        lib,
        ...
      }:
      {
        imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

        services.flatpak = {
          enable = lib.mkDefault true;
          packages = lib.mkIf config.services.flatpak.enable [
            "ru.linux_gaming.PortProton"
          ];
        };

        warnings = lib.mkIf (!config.services.flatpak.enable) [
          "Gaming: Flatpak is disabled. PortProton will not be installed."
        ];
      };
  };
}

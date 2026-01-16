{
  flake.modules = {
    nixos.gaming =
      {
        inputs,
        config,
        lib,
        ...
      }:

      let
        flatpakEnabled = config.services.flatpak.enable or false;
      in
      {
        imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

        services.flatpak = lib.mkIf flatpakEnabled {
          packages = [ "ru.linux_gaming.PortProton" ];
        };

        warnings = lib.mkIf (!flatpakEnabled) [
          "Gaming: Flatpak is disabled. PortProton will not be installed."
        ];
      };
  };
}

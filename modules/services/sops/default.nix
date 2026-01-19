{
  flake.modules = {
    nixos.sops =
      { inputs, lib, ... }:
      {
        imports = [ inputs.sops-nix.nixosModules.sops ];

        options.sops.enable = lib.mkEnableOption "Enable sops-nix integration";

        config = {
          sops = {
            enable = true;
            defaultSopsFile = ../../../secrets/secrets.yaml;
            age.keyFile = "/var/lib/sops-nix/key.txt";
          };

          home-manager.sharedModules = [
            inputs.self.modules.homeManager.sops
          ];
        };
      };

    homeManager.sops =
      {
        inputs,
        lib,
        config,
        ...
      }:
      {
        imports = [ inputs.sops-nix.homeManagerModules.sops ];

        options.sops.enable = lib.mkEnableOption "Enable sops-nix for home-manager";

        config = {
          sops = {
            enable = true;
            defaultSopsFile = ../../../secrets/secrets.yaml;
            age = {
              keyFile = "${config.home.homeDirectory}/.config/sops/key.txt";
            };
          };
        };
      };
  };
}

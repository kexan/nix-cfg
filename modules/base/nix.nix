{
  flake.modules.nixos.base =
    { inputs, ... }:
    {
      nix = {
        settings = {
          trusted-users = [
            "root"
          ];
          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          warn-dirty = false;
        };
        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
        };
        optimise.automatic = true;
      };

      nixpkgs = {
        config.allowUnfree = true;
        overlays = [
          (final: _prev: {
            master = import inputs.nixpkgs-master {
              inherit (final.stdenv.hostPlatform) system;
              inherit (final) config;
            };
          })
        ];
      };

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
      };
    };
}

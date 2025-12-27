{
  flake.modules.nixos.base =
    { pkgs, ... }:
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

      nixpkgs.config.allowUnfree = true;

      home-manager.backupFileExtension = "backup";
    };
}

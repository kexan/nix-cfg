{
  den.aspects.base = {
    nixos = {
      nix = {
        settings = {
          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          warn-dirty = false;
        };
        optimise.automatic = true;
      };
    };

    homeManager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
    };
  };
}

{inputs, ...}: let
  sops_config = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/var/lib/secrets/sops/age/keys.txt";
  };
in {
  den.aspects.sops = {
    nixos = {
      imports = [inputs.sops.nixosModules.sops];
      sops = sops_config;
    };
    homeManager = {pkgs, ...}: {
      imports = [inputs.sops.homeManagerModules.sops];
      sops = sops_config;
      home.sessionVariables.SOPS_AGE_KEY_FILE = sops_config.age.keyFile;
      home.packages = [pkgs.sops];
    };
  };

  flake-file.inputs = {
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

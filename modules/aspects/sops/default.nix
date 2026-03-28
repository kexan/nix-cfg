{
  inputs,
  lib,
  den,
  ...
}: let
  sops_config = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/var/lib/secrets/sops/age/keys.txt";
  };

  class = {
    class,
    aspect-chain,
  }:
    den._.forward {
      each = lib.singleton class;
      fromClass = _: "sops";
      intoClass = _: "nixos";
      intoPath = _: ["sops" "secrets"];
      fromAspect = _: lib.head aspect-chain;
      guard = {options, ...}: options ? sops;
    };
in {
  den.ctx.user.includes = [class];

  den.aspects.sops = {
    nixos = {
      imports = [inputs.sops-nix.nixosModules.sops];
      sops = sops_config;
    };
    homeManager = {pkgs, ...}: {
      imports = [inputs.sops-nix.homeManagerModules.sops];
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

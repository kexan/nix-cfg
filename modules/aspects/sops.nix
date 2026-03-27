{
  den.aspects.sops = {
  };
  flake-file.inputs = {
    sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

{
  inputs,
  den,
  lib,
  ...
}: {
  imports = [
    (inputs.flake-file.flakeModules.dendritic or {})
    (inputs.den.flakeModules.dendritic or {})
  ];

  _module.args.__findFile = den.lib.__findFile;
  den.ctx.user.includes = [den._.mutual-provider];
  den.schema.user.classes = lib.mkDefault ["homeManager"];

  flake-file.inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    import-tree.url = "github:vic/import-tree";
    inputs.den.url = "github:vic/den";
  };
}

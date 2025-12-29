{
  inputs,
  lib,
  config,
  ...
}:
let
  hostsPrefix = "hosts/";
  hostModules = lib.filterAttrs (name: _: lib.hasPrefix hostsPrefix name) config.flake.modules.nixos;
  mkHost =
    name: module:
    let
      hostName = lib.removePrefix hostsPrefix name;
      specialArgs = {
        inherit inputs;
        hostConfig.name = hostName;
      };
    in
    {
      name = hostName;
      value = inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          module
          inputs.disko.nixosModules.disko
          inputs.home-manager.nixosModules.home-manager
          { home-manager.extraSpecialArgs = specialArgs; }
        ];
      };
    };
in
{
  flake.nixosConfigurations = lib.mapAttrs' mkHost hostModules;
}

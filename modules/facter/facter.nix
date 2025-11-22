{ inputs, ... }:
{
  flake.modules = {
    nixos.facter =
      { pkgs, ... }:
      {
        imports = [ inputs.nixos-facter-modules.nixosModules.facter ];

        environment.systemPackages = [
          pkgs.nixos-facter
        ];
      };
  };
}

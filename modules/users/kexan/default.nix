{ config, ... }:

let
  meta = config.flake.meta.users.kexan;
in
{
  flake = {
    meta.users.kexan = rec {
      email = "kexa76@gmail.com";
      name = "Sergei Nikitin";
      username = "kexan";

      sshKeys = {
        default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINoEOEalFKRQplgze0K4HIFXUun2NcEUgb+ou/4UnKZB kexan@arch";
        mac = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPqSOM2HdLv6kEa1e6Mv82bGBYJ7MnD/LrDSaU6P6Nk5 kexan@MacBook-Air-Sergei.local";
      };

      authorizedKeys = [
        sshKeys.mac
        sshKeys.default
      ];
    };

    modules.nixos.kexan =
      { inputs, ... }:
      {
        users.users.kexan = {
          description = meta.name;
          isNormalUser = true;
          createHome = true;
          extraGroups = [
            "wheel"
            "networkmanager"
          ];
          openssh.authorizedKeys.keys = meta.authorizedKeys;
          initialPassword = "id";
        };

        nix.settings.trusted-users = [ meta.username ];

        home-manager.sharedModules = [
          inputs.self.modules.homeManager.kexan
        ];
      };
  };
}

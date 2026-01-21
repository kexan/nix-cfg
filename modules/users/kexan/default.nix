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
        aliastes = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGVpR21HvBLpxNt6ADi4GJblqqzkBHBP6FfU7idSHY/V aliastes@mac";
      };

      authorizedKeys = [
        sshKeys.mac
        sshKeys.default
        sshKeys.aliastes
      ];
    };

    modules.nixos.kexan =
      {
        inputs,
        config,
        lib,
        ...
      }:

      let
        sopsEnabled = config.sops.enable or false;
      in
      {
        imports = [ inputs.sops-nix.nixosModules.sops ];

        config = lib.mkMerge [
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
          }

          (lib.mkIf sopsEnabled {
            sops.secrets."users/kexan/password" = {
              neededForUsers = true;
            };

            users.users.kexan = {
              initialPassword = lib.mkForce null;
              hashedPasswordFile = config.sops.secrets."users/kexan/password".path;
            };
          })
        ];
      };
  };
}

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
        lib,
        config,
        ...
      }:
      let
        sopsEnabled = config.sops.enable or false;
      in
      {
        users.users.kexan =
          {
            description = meta.name;
            isNormalUser = true;
            createHome = true;
            extraGroups = [
              "wheel"
              "networkmanager"
            ];
            openssh.authorizedKeys.keys = meta.authorizedKeys;
          }
          // lib.optionalAttrs sopsEnabled {
            hashedPasswordFile = config.sops.secrets."users/kexan/password".path;
          };

        nix.settings.trusted-users = [ meta.username ];

        sops.secrets."users/kexan/password" = lib.mkIf sopsEnabled {
          neededForUsers = true;
          owner = "root";
          group = "root";
          mode = "0400";
        };

        home-manager.sharedModules = [
          inputs.self.modules.homeManager.kexan
        ];
      };
  };
}

{config, ...}: {
  flake = {
    meta.users.root = rec {
      sshKeys = {
        mac = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPqSOM2HdLv6kEa1e6Mv82bGBYJ7MnD/LrDSaU6P6Nk5 kexan@MacBook-Air-Sergei.local";
        desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINoEOEalFKRQplgze0K4HIFXUun2NcEUgb+ou/4UnKZB kexan@arch";
      };

      authorizedKeys = [
        sshKeys.mac
        sshKeys.desktop
      ];
    };

    modules.nixos.root = {
      users.users.root = {
        hashedPassword = "!";
        openssh.authorizedKeys.keys = config.flake.meta.users.root.authorizedKeys;
      };

      services.openssh.settings.PermitRootLogin = "prohibit-password";
    };
  };
}

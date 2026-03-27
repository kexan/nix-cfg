{den, ...}: {
  den.aspects.kexan = {
    includes = [
      den.provides.define-user
      den.provides.primary-user
      den.aspects.tools.provides.nix-trusted-user
    ];

    nixos = {config, ...}: {
      sops.secrets."users/kexan/password" = {
        neededForUsers = true;
      };
      users.users.kexan = {
        description = "Sergei Nikitin";
        isNormalUser = true;
        createHome = true;
        hashedPasswordFile = config.sops.secrets."users/kexan/password".path;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPqSOM2HdLv6kEa1e6Mv82bGBYJ7MnD/LrDSaU6P6Nk5 kexan@MacBook-Air-Sergei.local"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINoEOEalFKRQplgze0K4HIFXUun2NcEUgb+ou/4UnKZB kexan@arch"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGVpR21HvBLpxNt6ADi4GJblqqzkBHBP6FfU7idSHY/V aliastes@mac"
        ];
      };
    };
  };
}

{
  config,
  ...
}:

{
  flake = {
    meta.users = {
      kexan = {
        email = "kexa76@gmail.com";
        name = "Sergei Nikitin";
        username = "kexan";
        authorizedKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPqSOM2HdLv6kEa1e6Mv82bGBYJ7MnD/LrDSaU6P6Nk5 kexan@MacBook-Air-Sergei.local"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINoEOEalFKRQplgze0K4HIFXUun2NcEUgb+ou/4UnKZB kexan@arch"
        ];
      };
    };

    modules.nixos.kexan = {
      users.users.kexan = {
        description = config.flake.meta.users.kexan.name;
        isNormalUser = true;
        createHome = true;
        extraGroups = [
          "wheel"
          "networkmanager"
          "podman"
          "vboxusers"
          "corectrl"
        ];
        openssh.authorizedKeys.keys = config.flake.meta.users.kexan.authorizedKeys;
        initialPassword = "id";
      };

      nix.settings.trusted-users = [ config.flake.meta.users.kexan.username ];

      sops.secrets.ssh_key = {
        path = "/home/kexan/.ssh/id_ed25519";
        owner = "kexan";
        group = "users";
        mode = "0600";
      };
    };

    modules.homeManager.kexan = {
      home.file.".ssh/id_ed25519.pub".text =
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINoEOEalFKRQplgze0K4HIFXUun2NcEUgb+ou/4UnKZB kexan@arch";
    };
  };
}

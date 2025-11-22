topLevel@{ }:

{
  flake = {
    meta.users = {
      kexan = {
        email = "kexa76@gmail.com";
        name = "Sergei Nikitin";
        username = "kexan";
        authorizedKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPqSOM2HdLv6kEa1e6Mv82bGBYJ7MnD/LrDSaU6P6Nk5 kexan@MacBook-Air-Sergei.local"
        ];
      };
    };

    modules.nixos.kexan = {
      users.users.kexan = {
        description = topLevel.config.flake.meta.users.kexan.name;
        isNormalUser = true;
        createHome = true;
        extraGroups = [
          "wheel"
          "networkmanager"
          "docker"
          "vboxusers"
          "corectrl"
        ];
        openssh.authorizedKeys.keys = topLevel.config.flake.meta.users.kexan.authorizedKeys;
        initialPassword = "id";
      };

      nix.settings.trusted-users = [ topLevel.config.flake.meta.users.kexan.username ];
    };
  };
}

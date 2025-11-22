{
  config,
  ...
}:

{
  flake = {
    meta.users = {
      root = {
        authorizedKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPqSOM2HdLv6kEa1e6Mv82bGBYJ7MnD/LrDSaU6P6Nk5 kexan@MacBook-Air-Sergei.local"
        ];
      };
    };

    modules.nixos.root = {
      users.users.root = {
        openssh.authorizedKeys.keys = config.flake.meta.users.kexan.authorizedKeys;
        initialPassword = "id";
      };
    };
  };
}

{ config, ... }:

let
  user = "kexan";
  pubKey = config.flake.meta.users.${user}.sshKeys.default;
in
{
  flake.modules.nixos.sops =
    { config, lib, ... }:
    let
      hasUser = config.users.users ? "${user}";
    in
    {
      config = lib.mkIf hasUser {
        sops.secrets.ssh_key = {
          path = "/home/${user}/.ssh/id_ed25519";
          owner = user;
          group = "users";
          mode = "0600";
        };

      };
    };

  flake.modules.homeManager._sops =
    {
      osConfig,
      config,
      lib,
      ...
    }:
    let
      hasUser = osConfig.users.users ? "${user}";
      isCorrectUser = config.home.username == user;
    in
    {
      config = lib.mkIf (hasUser && isCorrectUser) {
        home.file.".ssh/id_ed25519.pub".text = pubKey;
      };
    };
}

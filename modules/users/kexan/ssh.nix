{ inputs, config, ... }:

let
  meta = config.flake.meta.users.kexan;
in
{
  flake.modules = {
    nixos.kexan =
      {
        lib,
        config,
        ...
      }:
      {
        imports = [ inputs.sops-nix.nixosModules.sops ];

        config = lib.mkIf (config.sops.enable or false) {
          sops.secrets.ssh_key = {
            path = "/home/${meta.username}/.ssh/id_ed25519";
            owner = meta.username;
            group = "users";
            mode = "0600";
          };
        };
      };

    homeManager.kexan = {
      home.file.".ssh/id_ed25519.pub".text = meta.sshKeys.default;

      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;

        matchBlocks = {
          "*" = {
            serverAliveInterval = 60;
            addKeysToAgent = "yes";
            identityFile = "~/.ssh/id_ed25519";
          };

          "aeza" = {
            hostname = "138.124.29.188";
            user = "kexan";
          };

          "u1host" = {
            hostname = "144.31.66.123";
            user = "deploy";
          };

          "yougile" = {
            hostname = "5.53.126.212";
            user = "root";
          };

          "mikrotik" = {
            hostname = "192.168.88.1";
            user = "admin";
          };
        };
      };
    };
  };
}

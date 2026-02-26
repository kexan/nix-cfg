{
  inputs,
  config,
  ...
}: let
  meta = config.flake.meta.users.kexan;
in {
  flake.modules = {
    nixos.kexan = {
      lib,
      config,
      ...
    }: let
      sopsEnabled = config.sops.enable or false;
    in {
      imports = [inputs.sops-nix.nixosModules.sops];

      sops = lib.mkIf sopsEnabled {
        secrets.ssh_key = {
          path = "/home/${meta.username}/.ssh/id_ed25519";
          owner = meta.username;
          group = "users";
          mode = "0600";
        };
      };
    };

    homeManager.kexan = {
      lib,
      nixosConfig ? null,
      ...
    }: let
      tailscaleEnabled = (nixosConfig != null) && (nixosConfig.services.tailscale.enable or false);
    in {
      home.file.".ssh/id_ed25519.pub".text = meta.sshKeys.default;

      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;

        matchBlocks = lib.mkMerge [
          {
            "*" = {
              serverAliveInterval = 60;
              addKeysToAgent = "yes";
              identityFile = "~/.ssh/id_ed25519";
            };

            "aeza" = {
              hostname = "138.124.29.188";
              user = "kexan";
            };

            "yougile" = {
              hostname = "5.53.126.212";
              user = "root";
            };

            "mikrotik" = {
              hostname = "192.168.10.1";
              user = "admin";
            };
          }

          (lib.mkIf tailscaleEnabled {
            "u1host" = {
              hostname = "u1host.armadillo-piranha.ts.net";
              user = "deploy";
            };
          })
        ];
      };
    };
  };
}

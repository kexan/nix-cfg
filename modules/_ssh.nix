{den, ...}: let
  inherit (den.lib) mkIf;
in {
  den.aspects.kexan.user = {
    user,
    nixosConfig,
    ...
  }: let
    tailscaleEnabled = (nixosConfig != null) && (nixosConfig.services.tailscale.enable or false);
    firstKey = builtins.head user.authorizedKeys;
    sshPublicKey =
      if firstKey != null
      then firstKey
      else "";
  in {
    home.file.".ssh/id_ed25519.pub".text = sshPublicKey;

    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      matchBlocks =
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
        // (mkIf tailscaleEnabled {
          "u1host" = {
            hostname = "u1host.armadillo-piranha.ts.net";
            user = "deploy";
          };
        });
    };
  };
}

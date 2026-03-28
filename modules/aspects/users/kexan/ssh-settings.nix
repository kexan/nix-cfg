{
  den.aspects.kexan.provides.ssh-settings = {
    sops.ssh_key = {
      path = "/home/kexan/.ssh/id_ed25519";
      owner = "kexan";
      group = "users";
      mode = "0600";
    };

    homeManager = {
      home.file.".ssh/id_ed25519.pub".text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPqSOM2HdLv6kEa1e6Mv82bGBYJ7MnD/LrDSaU6P6Nk5 kexan@MacBook-Air-Sergei.local";

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

          "yougile" = {
            hostname = "5.53.126.212";
            user = "root";
          };

          "mikrotik" = {
            hostname = "192.168.10.1";
            user = "admin";
          };

          "u1host" = {
            hostname = "u1host.armadillo-piranha.ts.net";
            user = "deploy";
          };
        };
      };
    };
  };
}

{
  flake.modules.homeManager.kexan = {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      matchBlocks = {
        "*" = {
          serverAliveInterval = 60;
          addKeysToAgent = "yes";
        };

        "aeza" = {
          hostname = "138.124.29.188";
          user = "kexan";
          identityFile = "~/.ssh/id_ed25519";
        };

        "u1host" = {
          hostname = "144.31.66.123";
          user = "deploy";
          identityFile = "~/.ssh/id_ed25519";
        };

        "yougile" = {
          hostname = "5.53.126.212";
          user = "root";
          identityFile = "~/.ssh/id_ed25519";
        };
      };
    };
  };
}

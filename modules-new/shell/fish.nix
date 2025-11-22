{
  flake.modules = {
    nixos.shell =
      { pkgs, ... }:
      {
        programs.fish.enable = true;
        users.defaultUserShell = pkgs.fish;
      };

    homeManager.shell =
      { pkgs, ... }:
      {
        home.shell.enableFishIntegration = true;

        programs = {
          fish = {
            enable = true;
            plugins = [
              {
                name = "autopair";
                src = pkgs.fishPlugins.autopair;
              }
            ];
            shellAliases = {
              ".." = "cd ..";
              "..." = "cd ../..";
              cat = "bat";
              grep = "rg";
            };
            functions = {
              fish_greeting = "";
            };
          };
        };
      };
  };
}

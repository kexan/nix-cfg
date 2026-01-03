{
  flake.modules = {
    nixos.shell =
      { pkgs, ... }:
      {
        programs.fish = {
          enable = true;
        };

        users.defaultUserShell = pkgs.fish;
      };

    homeManager.shell =
      { config, pkgs, ... }:
      {
        home.shell.enableFishIntegration = true;

        programs.fish = {
          enable = true;

          shellAliases = {
            cd = "z";
            cat = "bat";
            grep = "rg";
          };

          functions = {
            last_history_item = ''
              echo $history[1]
            '';

            fish_greeting = ''
              echo "ようこそ $(whoami)"
            '';
          };

          interactiveShellInit = ''
            abbr -a !! --position anywhere --function last_history_item
          '';
        };
      };
  };
}

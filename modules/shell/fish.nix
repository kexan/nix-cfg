{
  flake.modules = {
    nixos.shell =
      { pkgs, ... }:
      {
        programs.fish.enable = true;
        users.defaultUserShell = pkgs.fish;
      };

    homeManager.shell =
      { config, pkgs, ... }:
      {
        home.shell.enableFishIntegration = true;

        programs.fish = {
          enable = true;
          plugins = [
            {
              name = "autopair";
              src = pkgs.fishPlugins.autopair;
            }
          ];

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

          #FIXME: https://github.com/nix-community/home-manager/issues/8178
          interactiveShellInit = ''
            set -p fish_complete_path ${config.programs.fish.package}/share/fish/completions
            abbr -a !! --position anywhere --function last_history_item
          '';
        };
      };
  };
}

{
  flake.modules = {
    nixos.shell =
      { pkgs, ... }:
      {
        programs.fish = {
          enable = true;
        };

        #FIXME: regression in unstable: https://github.com/nix-community/home-manager/issues/8435
        users.defaultUserShell = pkgs.master.fish;
      };

    homeManager.shell =
      { config, pkgs, ... }:
      {
        home.shell.enableFishIntegration = true;

        programs.fish = {
          enable = true;

          #FIXME: regression in unstable: https://github.com/nix-community/home-manager/issues/8435
          package = pkgs.master.fish;

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

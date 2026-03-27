{
  flake.modules = {
    nixos.shell = {pkgs, ...}: {
      programs.fish = {
        enable = true;
      };

      users.defaultUserShell = pkgs.fish;
    };

    homeManager.shell = {
      home.shell.enableFishIntegration = true;

      programs.fish = {
        enable = true;

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

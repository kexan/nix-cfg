{den, ...}: {
  den.aspects.shell = {
    includes = [
      den.aspects.shell.provides.fish
      den.aspects.shell.provides.starship
      den.aspects.shell.provides.git
      den.aspects.shell.provides.utils
    ];
  };

  den.aspects.shell.provides.fish = {
    nixos = {pkgs, ...}: {
      programs.fish.enable = true;
      users.defaultUserShell = pkgs.fish;
    };

    homeManager = {
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

  den.aspects.shell.provides.starship = {
    homeManager = {
      programs.starship = {
        enable = true;
        enableTransience = true;
      };
    };
  };
}

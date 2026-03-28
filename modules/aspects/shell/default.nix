{__findFile, ...}: {
  den.aspects.shell = {
    includes = [
      <shell/fish>
      <shell/starship>
      <shell/git>
      <shell/utils>
    ];
  };

  den.aspects.shell.provides = {
    fish = {
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

    starship = {
      homeManager = {
        programs.starship = {
          enable = true;
          enableTransience = true;
        };
      };
    };
  };
}

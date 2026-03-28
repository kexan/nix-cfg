{
  den,
  __findFile,
  ...
}: {
  den.aspects.shell.provides = {
    utils = {
      includes = [
        <shell/fzf>
        <shell/ripgrep>
        <shell/bat>
        <shell/lsd>
        <shell/zoxide>
        <shell/btop>
        <shell/direnv>
        <shell/nix-your-shell>
        <shell/devenv>
      ];
    };

    fzf = {
      homeManager = {
        programs.fzf = {
          enable = true;
          enableFishIntegration = true;
        };
      };
    };

    ripgrep = {
      homeManager = {
        programs.ripgrep.enable = true;

        programs.fish.shellAliases.grep = "rg";
      };
    };

    bat = {
      homeManager = {
        programs.bat.enable = true;

        programs.fish.shellAliases.cat = "bat";
      };
    };

    lsd = {
      homeManager = {
        programs.lsd = {
          enable = true;
          enableFishIntegration = true;
        };
      };
    };

    zoxide = {
      homeManager = {
        programs.zoxide = {
          enable = true;
          enableFishIntegration = true;
        };

        programs.fish.shellAliases.cd = "z";
      };
    };

    btop = {
      homeManager = {
        programs.btop.enable = true;
      };
    };

    direnv = {
      homeManager = {
        programs.direnv = {
          enable = true;

          config.global = {
            hide_env_diff = true;
          };

          nix-direnv.enable = true;
        };
      };
    };

    nix-your-shell = {
      homeManager = {
        programs.nix-your-shell = {
          enable = true;
          enableFishIntegration = true;
        };
      };
    };

    devenv = {
      homeManager = {pkgs, ...}: {
        home.packages = [pkgs.devenv];
      };
    };
  };
}

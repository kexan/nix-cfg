{den, ...}: {
  den.aspects.shell.provides = {
    utils = {
      includes = [
        den.aspects.shell.provides.fzf
        den.aspects.shell.provides.ripgrep
        den.aspects.shell.provides.bat
        den.aspects.shell.provides.lsd
        den.aspects.shell.provides.zoxide
        den.aspects.shell.provides.btop
        den.aspects.shell.provides.direnv
        den.aspects.shell.provides.nix-your-shell
        den.aspects.shell.provides.devenv
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

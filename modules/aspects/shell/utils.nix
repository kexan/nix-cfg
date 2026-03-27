{den, ...}: {
  den.aspects.shell.provides.utils = {
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

  den.aspects.shell.provides.fzf = {
    homeManager = {
      programs.fzf = {
        enable = true;
        enableFishIntegration = true;
      };
    };
  };

  den.aspects.shell.provides.ripgrep = {
    homeManager = {
      programs.ripgrep.enable = true;

      programs.fish.shellAliases.grep = "rg";
    };
  };

  den.aspects.shell.provides.bat = {
    homeManager = {
      programs.bat.enable = true;

      programs.fish.shellAliases.cat = "bat";
    };
  };

  den.aspects.shell.provides.lsd = {
    homeManager = {
      programs.lsd = {
        enable = true;
        enableFishIntegration = true;
      };
    };
  };

  den.aspects.shell.provides.zoxide = {
    homeManager = {
      programs.zoxide = {
        enable = true;
        enableFishIntegration = true;
      };

      programs.fish.shellAliases.cd = "z";
    };
  };

  den.aspects.shell.provides.btop = {
    homeManager = {
      programs.btop.enable = true;
    };
  };

  den.aspects.shell.provides.direnv = {
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

  den.aspects.shell.provides.nix-your-shell = {
    homeManager = {
      programs.nix-your-shell = {
        enable = true;
        enableFishIntegration = true;
      };
    };
  };

  den.aspects.shell.provides.devenv = {
    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.devenv];
    };
  };
}

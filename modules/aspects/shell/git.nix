{
  den.aspects.shell.provides.git = {
    homeManager = {
      programs = {
        git = {
          enable = true;
          ignores = [
            ".direnv/"
            "result"
          ];
          signing = {
            key = "~/.ssh/id_ed25519.pub";
            signByDefault = true;
            format = "ssh";
          };
          settings = {
            user = {
              name = "Sergei Nikitin";
              email = "kexa76@gmail.com";
            };
            branch = {
              autosetuprebase = "always";
            };
            color = {
              ui = "auto";
            };
            core = {
              autocrlf = "input";
              editor = "nvim";
              safecrlf = "warn";
              excludesfile = "~/.gitignore_global";
            };
            diff = {
              mnemonicprefix = true;
            };
            init = {
              defaultBranch = "main";
            };
            merge = {
              conflictstyle = "diff3";
              commit = "no";
              ff = "no";
              tool = "splice";
            };
            push = {
              autoSetupRemote = true;
              default = "current";
            };
            pull = {
              default = "matching";
              autoSetupRemote = true;
              rebase = true;
              useForceIfIncludes = true;
            };
            rebase = {
              autostash = true;
              autosquash = true;
              instructionFormat = "(%an <%ae>) %s";
              updateRefs = true;
            };
            rerere = {
              enabled = true;
            };
          };
        };

        lazygit.enable = true;
      };
    };
  };
}

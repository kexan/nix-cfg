{inputs, ...}: {
  den.aspects.development.provides.lazyvim = {
    homeManager = {pkgs, ...}: {
      imports = [inputs.lazyvim.homeManagerModules.default];

      home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };

      programs.lazyvim = {
        enable = true;
        ignoreBuildNotifications = true;
        extras = {
          lang = {
            nix.enable = true;
            json.enable = true;
            typescript.enable = true;
            rust.enable = true;
            yaml.enable = true;
          };
          editor = {
            inc_rename.enable = true;
          };
          formatting = {
            prettier.enable = true;
          };
          ui = {
            treesitter_context.enable = true;
          };
          test.core.enable = true;
        };

        plugins.lsp = ''
          return {
            {
              "stevearc/conform.nvim",
              optional = true,
              opts = {
                formatters_by_ft = {
                  nix = { "alejandra" },
                },
              },
            }
          }
        '';

        extraPackages = with pkgs; [
          clang
          tree-sitter
          lua-language-server
          nil
          statix
          alejandra
          vscode-json-languageserver
          vtsls
          rust-analyzer
          yaml-language-server
        ];
      };
    };
  };

  flake-file.inputs = {
    lazyvim = {
      url = "github:pfassina/lazyvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

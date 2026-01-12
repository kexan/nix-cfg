{ inputs, ... }:

{
  flake.modules = {
    homeManager.lazyvim =
      { pkgs, ... }:

      {
        imports = [ inputs.lazyvim.homeManagerModules.default ];

        home.sessionVariables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
        };

        programs.lazyvim = {
          enable = true;

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
          };

          extraPackages = with pkgs; [
            clang
            tree-sitter

            lua-language-server

            nil
            statix
            nixfmt

            vscode-json-languageserver

            vtsls

            rust-analyzer

            yaml-language-server
          ];

          plugins = {
            colorscheme = ''
              return {
                { "ellisonleao/gruvbox.nvim" },

                {
                  "LazyVim/LazyVim",
                  opts = {
                    colorscheme = "gruvbox",
                  },
                }
              }  '';
          };
        };

      };
  };
}

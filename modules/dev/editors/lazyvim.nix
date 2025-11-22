{ inputs, ... }:

{
  flake.modules = {
    homeManager.dev =
      { pkgs, ... }:

      {
        imports = [ inputs.lazyvim.homeManagerModules.default ];
        programs.lazyvim = {
          enable = true;

          extras = {
            lang = {
              nix.enable = true;
              json.enable = true;
              typescript.enable = true;
            };
            editor = {
              inc_rename.enable = true;
            };
          };

          extraPackages = with pkgs; [
            clang
            tree-sitter

            lua-language-server

            nixd
            statix
            nixfmt

            vscode-json-languageserver

            vtsls
          ];

          #FIXME: Must add the 'plugins' attribute with content**
          plugins = {
            # Adding any single valid plugin configuration resolves the issue.
            # A colorscheme is a safe choice if you don't need anything else.
            colorscheme = ''
              return {
                "ellisonleao/gruvbox.nvim",
                opts = {
                  colorscheme = "gruvbox",
                },
              }
            '';
          };
        };

      };
  };
}

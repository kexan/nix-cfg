{ inputs, ... }:

{
  flake.modules = {
    homeManager.dev =
      { pkgs, ... }:

      {
        imports = [ inputs.lazyvim.homeManagerModules.default ];

        #FIXME: ждём когда смержат в unstable https://github.com/NixOS/nixpkgs/pull/464616
        nixpkgs.overlays = [
          (final: prev: {
            vimPlugins = prev.vimPlugins // {
              fzf-lua = prev.neovimUtils.buildNeovimPlugin {
                luaAttr = prev.luaPackages.fzf-lua.overrideAttrs (oldAttrs: {
                  version = "0.0.2311-1";

                  knownRockspec =
                    (prev.fetchurl {
                      url = "mirror://luarocks/fzf-lua-0.0.2311-1.rockspec";
                      sha256 = "0ldxn3v2bkjydnqcq5zz0rxxlv953azi6zvm8hl9vdsil1gg9vcz";
                    }).outPath;

                  src = prev.fetchzip {
                    url = "https://github.com/ibhagwan/fzf-lua/archive/3170d98240266a68c2611fc63260c3ab431575aa.zip";
                    sha256 = "0zlrzvwc29arf8y6x6niyglqgvj403mryffnwq18nmd6gabrjjx1";
                  };
                });
              };

              lualine-nvim = prev.neovimUtils.buildNeovimPlugin {
                luaAttr = prev.luaPackages.lualine-nvim.overrideAttrs (oldAttrs: {
                  knownRockspec =
                    (prev.fetchurl {
                      url = "mirror://luarocks/lualine.nvim-scm-1.rockspec";
                      sha256 = "01cqa4nvpq0z4230szwbcwqb0kd8cz2dycrd764r0z5c6vivgfzs";
                    }).outPath;

                  src = prev.fetchFromGitHub {
                    owner = "nvim-lualine";
                    repo = "lualine.nvim";
                    rev = "47f91c416daef12db467145e16bed5bbfe00add8";
                    hash = "sha256-OpLZH+sL5cj2rcP5/T+jDOnuxd1QWLHCt2RzloffZOA=";
                  };
                });
              };
            };
          })
        ];

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

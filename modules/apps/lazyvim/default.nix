{inputs, ...}: {
  flake.modules = {
    homeManager.lazyvim = {
      pkgs,
      osConfig,
      ...
    }: {
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
            indent_blankline.enable = true;
          };
          test.core.enable = true;
        };

        plugins.lsp = let
          myFlake = "(builtins.getFlake \"/home/kexan/nix-cfg\")";
          nixosOpts = "${myFlake}.nixosConfigurations.${osConfig.networking.hostName}.options";
          homeManagerOpts = "${nixosOpts}.home-manager.users.type.getSubOptions []";
          nixpkgsExpr = "import ${myFlake}.inputs.nixpkgs { }";
        in ''
          return {
                  {
                    "neovim/nvim-lspconfig",
                    opts = {
                      servers = {
                        nixd = {
                          settings = {
                            nixd = {
                              nixpkgs = {
                                expr = [[${nixpkgsExpr}]],
                              },
                              formatting = {
                                command = { "alejandra" },
                              },
                              options = {
                                nixos = {
                                  expr = [[${nixosOpts}]],
                                },
                                home_manager = {
                                  expr = [=[${homeManagerOpts}]=],
                                },
                              },
                            },
                          },
                        },

                        nil_ls = false,
                      },
                    },
                  },
                }
        '';

        extraPackages = with pkgs; [
          clang
          tree-sitter
          lua-language-server
          nixd
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
}

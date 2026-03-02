{
  flake.modules = {
    homeManager.zed = {
      pkgs,
      osConfig,
      ...
    }: {
      programs.zed-editor = {
        enable = true;
        extensions = [
          "nix"
          "toml"
          "rust"
          "cargo-tom"
        ];
        extraPackages = with pkgs; [
          nixd
          alejandra
          package-version-server
          vscode-json-languageserver
        ];
        userSettings = {
          project_panel = {
            hide_gitignore = true;
            hide_hidden = true;
          };
          icon_theme = "Zed (Default)";
          theme = "Ayu Dark";
          agent_servers = {
            opencode = {
              type = "custom";
              command = "opencode";
              args = ["acp"];
            };
          };
          agent = {
            default_model = {
              provider = "openrouter";
              model = "openrouter/free";
            };
          };
          inlay_hints = {
            enabled = true;
          };
          diagnostics = {
            inline = {
              enabled = true;
            };
          };
          languages = {
            Rust = {
              inlay_hints = {
                enabled = true;
              };
              soft_wrap = "prefer_line";
            };
            Nix = {
              language_servers = ["nixd" "!nil"];
              formatter.external.command = "alejandra";
            };
          };
          lsp = {
            rust-analyzer = {
              initialization_options = {
                check = {
                  command = "clippy";
                };
              };
            };
            nixd = {
              settings = let
                myFlake = "(builtins.getFlake \"/home/kexan/nix-cfg\")";
                nixosOpts = "${myFlake}.nixosConfigurations.${osConfig.networking.hostName}.options";
                homeManagerOpts = "${nixosOpts}.home-manager.users.type.getSubOptions []";
                nixpkgsExpr = "import ${myFlake}.inputs.nixpkgs { }";
              in {
                nixpkgs = {
                  expr = nixpkgsExpr;
                };
                options = {
                  nixos = {
                    expr = nixosOpts;
                  };
                  home_manager = {
                    expr = homeManagerOpts;
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}

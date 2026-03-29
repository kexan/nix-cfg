{
  den.aspects.development.provides.zed = {
    homeManager = {pkgs, ...}: {
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
          vim_mode = true;
          project_panel = {
            hide_gitignore = true;
            hide_hidden = true;
          };
          icon_theme = "Zed (Default)";
          theme = "Ayu Dark";
          ui_font_size = 15.0;
          buffer_font_size = 14.0;
          buffer_line_height = "comfortable";
          agent_servers = {
            opencode = {
              type = "custom";
              command = "opencode";
              args = ["acp"];
            };

            qwen = {
              type = "custom";
              command = "qwen";
              args = ["--acp"];
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
              language_servers = ["nixd"];
              formatter = {
                language_server = {
                  name = "nixd";
                };
              };
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
              settings = {
                nixd = {
                  nixpkgs = {
                    expr = "(builtins.getFlake \"/home/kexan/nix-cfg\").inputs.nixpkgs {}";
                  };
                  formatting = {
                    command = ["alejandra"];
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

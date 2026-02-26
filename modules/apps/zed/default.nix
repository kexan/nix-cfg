{
  flake.modules = {
    homeManager.zed = {pkgs, ...}: {
      programs.zed-editor = {
        enable = true;
        extensions = [
          "nix"
          "toml"
          "rust"
          "cargo-tom"
        ];
        extraPackages = with pkgs; [
          nil
          nixd
          package-version-server
          vscode-json-languageserver
        ];
        userSettings = {
          project_panel = {
            hide_gitignore = true;
            hide_hidden = true;
          };
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
          };
          lsp = {
            rust-analyzer = {
              initialization_options = {
                check = {
                  command = "clippy";
                };
              };
            };
          };
        };
      };
    };
  };
}

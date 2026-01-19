{
  flake.modules = {
    homeManager.anki =
      {
        inputs,
        pkgs,
        lib,
        config,
        ...
      }:

      let
        sopsEnabled = config.sops.enable or false;

        minimizeToTray = pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
          pname = "minimize-to-tray";
          version = "2.1.0";
          src = pkgs.fetchFromGitHub {
            owner = "simgunz";
            repo = "anki21-addons_minimize-to-tray";
            rev = finalAttrs.version;
            sparseCheckout = [ "src" ];
            hash = "sha256-REoh97eUSqlkLvFkcsj2IHDFT3McnfBXlNz61o1omys=";
          };
          sourceRoot = "${finalAttrs.src.name}/src";

          preInstall = ''
            rm -f config.json

            echo '{"hide_on_startup": true, "debug": false}' > config.json
          '';
        });
      in
      {
        imports = [ inputs.sops-nix.homeManagerModules.sops ];

        config = lib.mkMerge [
          {
            programs.anki = {
              enable = true;
              addons = [
                pkgs.ankiAddons.anki-connect
                pkgs.ankiAddons.review-heatmap
                minimizeToTray
              ];

              language = "ru_RU";
              theme = "followSystem";
              style = "native";
            };

            xdg.autostart.entries = [
              "${pkgs.anki}/share/applications/anki.desktop"
            ];
          }

          (lib.mkIf sopsEnabled {
            sops.secrets = {
              "anki/username" = { };
              "anki/key" = { };
            };
            programs.anki.sync = {
              usernameFile = config.sops.secrets."anki/username".path;
              keyFile = config.sops.secrets."anki/key".path;
            };
          })
        ];
      };
  };
}

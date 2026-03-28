{
  den.aspects.apps.provides.anki = {
    sops-hm = {
      "anki/username" = {};
      "anki/key" = {};
    };

    homeManager = {
      config,
      pkgs,
      options,
      lib,
      ...
    }: let
      minimizeToTray = pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
        pname = "minimize-to-tray";
        version = "2.1.0";
        src = pkgs.fetchFromGitHub {
          owner = "simgunz";
          repo = "anki21-addons_minimize-to-tray";
          rev = finalAttrs.version;
          sparseCheckout = ["src"];
          hash = "sha256-/87tH9nXyNSUqaI+bKhZ6vBqRA/OdloGTfmckFnRS3w=";
        };
        sourceRoot = "${finalAttrs.src.name}/src";

        preInstall = ''
          rm -f config.json
          echo '{"hide_on_startup": true, "debug": false}' > config.json
        '';
      });
    in {
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

        profiles."User 1".sync = lib.optionalAttrs (options ? sops) {
          usernameFile = config.sops.secrets."anki/username".path;
          keyFile = config.sops.secrets."anki/key".path;
        };
      };

      xdg.autostart.entries = [
        "${pkgs.anki}/share/applications/anki.desktop"
      ];
    };
  };
}

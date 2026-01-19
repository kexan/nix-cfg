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
      in
      {
        imports = [ inputs.sops-nix.homeManagerModules.sops ];

        config = lib.mkMerge [
          {
            programs.anki = {
              enable = true;
              addons = [ pkgs.ankiAddons.anki-connect ];

              language = "ru_RU";
              theme = "followSystem";
              style = "native";
            };
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

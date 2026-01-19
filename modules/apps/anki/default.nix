{
  flake.modules = {
    homeManager.anki =
      { pkgs, ... }:
      {
        programs.anki = {
          enable = true;
          addons = [ pkgs.ankiAddons.anki-connect ];

          language = "ru_RU";
          theme = "followSystem";
          style = "native";
        };
      };
  };
}

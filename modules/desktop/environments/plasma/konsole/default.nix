{
  flake.modules = {
    homeManager.plasma =
      { pkgs, ... }:
      {
        programs.konsole = {
          enable = true;
          defaultProfile = "Main";

          customColorSchemes = {
            Gruvbox = ./gruvbox.colorscheme;
          };

          profiles.Main.colorScheme = "Gruvbox";

          extraConfig = {
            MainWindow = {
              MenuBar = "Disabled";
            };
          };
        };
      };
  };
}

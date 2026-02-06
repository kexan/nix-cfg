{
  flake.modules = {
    homeManager.plasma =
      { config, pkgs, ... }:
      {
        programs.plasma = {

          shortcuts = {
            kwin = {
              "Switch to Desktop 1" = "Meta+1";
              "Switch to Desktop 2" = "Meta+2";
              "Switch to Desktop 3" = "Meta+3";
              "Switch to Desktop 4" = "Meta+4";
              "Switch to Desktop 5" = "Meta+5";
              "Window Close" = "Meta+C";
            };
            "services/org.kde.konsole.desktop".NewWindow = "Meta+Q";
          };

          krunner.shortcuts.launch = "Meta+Space";
        };
      };
  };
}

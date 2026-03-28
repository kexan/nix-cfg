{__findFile, ...}: {
  den.aspects.desktop.provides.cosmic = {
    includes = [
      <desktop/fonts>
    ];

    nixos = {
      services = {
        desktopManager.cosmic.enable = true;
        displayManager.cosmic-greeter.enable = true;
      };
    };

    homeManager = {
      xdg.autostart.enable = true;
    };
  };
}

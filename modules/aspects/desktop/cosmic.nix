{den, ...}: {
  den.aspects.desktop.provides.cosmic = {
    includes = [
      den.aspects.desktop.provides.fonts
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
{
  flake.modules = {
    nixos.cosmic = {inputs, ...}: {
      services = {
        desktopManager.cosmic.enable = true;
        displayManager.cosmic-greeter.enable = true;
      };

      home-manager.sharedModules = [
        inputs.self.modules.homeManager._cosmic
      ];
    };

    homeManager._cosmic = {
      xdg.autostart.enable = true;
    };
  };
}

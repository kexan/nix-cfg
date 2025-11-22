{
  flake.modules = {
    homeManager.shell = {
      programs = {
        lsd = {
          enable = true;
          enableFishIntegration = true;
        };
      };
    };
  };
}

{
  flake.modules = {
    homeManager.shell = {
      programs.yazi = {
        enable = true;
        enableFishIntegration = true;
        shellWrapperName = "y";
      };
    };
  };
}

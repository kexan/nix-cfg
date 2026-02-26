{
  flake.modules = {
    homeManager.bitwig = {pkgs, ...}: {
      home.packages = [
        pkgs.bitwig-studio
      ];
    };
  };
}

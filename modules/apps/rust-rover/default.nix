{
  flake.modules = {
    homeManager.rust-rover = {pkgs, ...}: {
      home.packages = [
        pkgs.jetbrains.rust-rover
      ];
    };
  };
}

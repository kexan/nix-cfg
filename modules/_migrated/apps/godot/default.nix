{
  flake.modules = {
    homeManager.godot = {pkgs, ...}: {
      home.packages = [
        pkgs.godot
      ];
    };
  };
}

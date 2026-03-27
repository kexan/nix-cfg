{
  den.aspects.development.provides.godot = {
    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.godot];
    };
  };
}

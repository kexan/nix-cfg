{
  den.aspects.development.provides.rust-rover = {
    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.jetbrains.rust-rover];
    };
  };
}

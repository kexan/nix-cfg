{den, ...}: {
  den.aspects.development.provides.rust-rover = {
    includes = [
      (den.provides.unfree [
        "rust-rover"
      ])
    ];
    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.jetbrains.rust-rover];
    };
  };
}

{inputs, ...}: {
  imports = [
    inputs.make-shell.flakeModules.default
  ];

  den.aspects.base = {
    nixos = {
      programs = {
        nh = {
          enable = true;
          clean.enable = true;
        };
      };
    };
  };

  perSystem = {pkgs, ...}: {
    make-shells.default.packages = with pkgs; [nh];
  };

  flake-file.inputs = {
    make-shell.url = "github:nicknovitski/make-shell";
  };
}

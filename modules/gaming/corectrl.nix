{
  flake.modules = {
    nixos.gaming =
      { pkgs, ... }:
      {
        programs.corectrl = {
          enable = true;
        };

        hardware.amdgpu.overdrive = {
          enable = true;
          ppfeaturemask = "0xffffffff";
        };
      };
  };
}

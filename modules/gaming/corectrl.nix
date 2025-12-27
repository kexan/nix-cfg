{
  flake.modules.nixos.gaming =
    { config, lib, ... }:
    {
      options.gaming.corectrl.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable CoreCtrl for AMD GPU management";
      };

      config = lib.mkIf config.gaming.corectrl.enable {
        programs.corectrl.enable = true;

        hardware.amdgpu.overdrive = {
          enable = true;
          ppfeaturemask = "0xffffffff";
        };
      };
    };

  flake.modules.homeManager.gaming =
    {
      lib,
      pkgs,
      osConfig,
      ...
    }:
    {
      xdg.autostart.entries = lib.mkIf (osConfig.gaming.corectrl.enable or false) [
        "${pkgs.corectrl}/share/applications/org.corectrl.CoreCtrl.desktop"
      ];
    };
}

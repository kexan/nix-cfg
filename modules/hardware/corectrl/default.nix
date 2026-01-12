{
  flake.modules.nixos.corectrl =
    { inputs, ... }:
    {
      programs.corectrl.enable = true;

      hardware.amdgpu.overdrive = {
        enable = true;
        ppfeaturemask = "0xffffffff";
      };

      home-manager.sharedModules = [
        inputs.self.modules.homeManager._corectrl
      ];
    };

  flake.modules.homeManager._corectrl =
    {
      pkgs,
      ...
    }:
    {
      xdg.autostart.entries = [
        "${pkgs.corectrl}/share/applications/org.corectrl.CoreCtrl.desktop"
      ];
    };
}

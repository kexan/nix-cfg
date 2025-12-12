{
  flake.modules = {
    nixos.gaming = {
      programs.corectrl = {
        enable = true;
      };

      hardware.amdgpu.overdrive = {
        enable = true;
        ppfeaturemask = "0xffffffff";
      };
    };

    homeManager.gaming =
      { pkgs, ... }:
      {
        xdg.autostart.entries = [
          "${pkgs.corectrl}/share/applications/org.corectrl.CoreCtrl.desktop"
        ];
      };
  };
}

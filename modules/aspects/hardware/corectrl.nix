{
  den.aspects.hardware.provides.corectrl = {
    nixos = {
      programs.corectrl.enable = true;
    };
    homeManager = {pkgs, ...}: {
      xdg.autostart.entries = [
        "${pkgs.corectrl}/share/applications/org.corectrl.CoreCtrl.desktop"
      ];
    };
    user = {
      extraGroups = ["corectrl"];
    };
  };
}

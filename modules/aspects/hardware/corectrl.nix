{__findFile, ...}: {
  den.aspects.hardware.provides.corectrl = {
    includes = [
      (<tools/groups> ["corectrl"])
    ];
    nixos = {
      programs.corectrl.enable = true;
    };
    homeManager = {pkgs, ...}: {
      xdg.autostart.entries = [
        "${pkgs.corectrl}/share/applications/org.corectrl.CoreCtrl.desktop"
      ];
    };
  };
}

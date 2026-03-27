{
  den.aspects.vpn = {
    nixos = {
      programs.throne = {
        enable = true;
        tunMode.enable = true;
      };
    };

    homeManager = {pkgs, ...}: {
      xdg.autostart.entries = [
        "${pkgs.throne}/share/applications/throne.desktop"
      ];
    };
  };
}

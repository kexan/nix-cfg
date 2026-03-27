{
  flake.modules = {
    nixos.vpn = {
      programs.throne = {
        enable = true;
        tunMode.enable = true;
      };
    };

    homeManager._vpn = {pkgs, ...}: {
      xdg.autostart.entries = [
        "${pkgs.throne}/share/applications/throne.desktop"
      ];
    };
  };
}

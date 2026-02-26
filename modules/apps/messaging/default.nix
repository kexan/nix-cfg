{
  flake.modules = {
    homeManager.messaging = {pkgs, ...}: {
      home.packages = with pkgs; [
        telegram-desktop
      ];

      programs.vesktop.enable = true;
    };
  };
}

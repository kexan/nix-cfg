{
  den.aspects.apps.provides.messaging = {
    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        telegram-desktop
      ];

      programs.vesktop.enable = true;
    };
  };
}

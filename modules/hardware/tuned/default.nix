{
  flake.modules.nixos.tuned =
    { lib, ... }:
    {
      services = {
        tuned = {
          enable = true;
          settings.dynamic_tuning = true;
          ppdSupport = true;
          ppdSettings.main.default = "balanced";
        };

        upower.enable = true;

        power-profiles-daemon.enable = lib.mkForce false;
        tlp.enable = lib.mkForce false;
      };
    };
}

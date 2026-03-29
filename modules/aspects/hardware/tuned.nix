{lib, ...}: {
  den.aspects.hardware.provides.tuned = {
    nixos = {
      services = {
        tuned = {
          enable = true;
          settings.dynamic_tuning = true;
          ppdSupport = true;
        };
        upower.enable = true;
        power-profiles-daemon.enable = lib.mkForce false;
        tlp.enable = lib.mkForce false;
      };
    };
  };
}

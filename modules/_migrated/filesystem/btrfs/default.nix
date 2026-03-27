{
  flake.modules.nixos.btrfs = {pkgs, ...}: {
    environment.systemPackages = [pkgs.snapper];

    services = {
      btrfs.autoScrub = {
        enable = true;
        interval = "monthly";
        fileSystems = ["/"];
      };

      snapper.configs.home = {
        SUBVOLUME = "/home";
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        TIMELINE_LIMIT_HOURLY = "10";
        TIMELINE_LIMIT_DAILY = "7";
        TIMELINE_LIMIT_WEEKLY = "2";
        TIMELINE_LIMIT_MONTHLY = "1";
      };
    };
  };
}

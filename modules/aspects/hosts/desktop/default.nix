{den, ...}: {
  den.hosts.x86_64-linux.desktop.users.kexan = {};
  den.aspects.desktop = {
    provides.to-users = {
      includes = with den.aspects; [
        base
        shell
        openssh
        sops
        vpn

        desktop._.plasma
        apps._.anki
        apps._.zen-browser
        apps._.messaging
        apps._.winbox
        apps._.ocr

        development._.zed
        development._.lazyvim

        gaming._.base
        gaming._.emulation

        (hardware._.facter ./facter.json)
        hardware._.corectrl
        hardware._.tuned

        virtualisation._.virtualbox

        services._.flatpak
        services._.caddy
        services._.jellyfin
        services._.qbittorrent
        services._.tailscale
      ];
    };
    nixos = {pkgs, ...}: {
      networking = {
        hosts = {
          "192.168.10.100" = [
            "linuxservice.test"
            "yg.linuxservice.test"
          ];
          "192.168.10.101" = [
            "yougile.local"
            "yg.yougile.local"
          ];
        };
      };

      boot.kernelPackages = pkgs.linuxPackages_6_18;

      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/0bc05461-e615-466d-bf53-6192417f74d4";
          fsType = "ext4";
        };

        "/boot" = {
          device = "/dev/disk/by-uuid/9865-7182";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };
      };

      zramSwap.enable = true;
    };
  };
}

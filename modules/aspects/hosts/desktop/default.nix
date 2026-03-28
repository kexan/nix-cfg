{
  den,
  __findFile,
  ...
}: {
  den.hosts.x86_64-linux.desktop.users.kexan = {};
  den.aspects.desktop = {
    provides.to-users = {
      includes = with den.aspects; [
        base
        shell
        sops
        vpn

        <desktop/plasma>
        <apps/anki>
        <apps/zen-browser>
        <apps/messaging>
        <apps/winbox>
        <apps/ocr>

        <development/zed>
        <development/lazyvim>
        <development/ai>

        <gaming/base>
        <gaming/emulation>

        (<hardware/facter> ./facter.json)
        <hardware/tuned>
        <hardware/corectrl>

        <virtualisation/virtualbox>

        <services/openssh>
        <services/flatpak>
        <services/caddy>
        <services/jellyfin>
        <services/qbittorrent>
        <services/tailscale>
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

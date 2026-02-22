{
  config,
  ...
}:

{
  flake.modules.nixos."hosts/desktop" =
    { pkgs, ... }:
    {
      imports =
        with config.flake.modules.nixos;
        [
          # --- Core & System ---
          base
          shell
          openssh
          sops
          #btrfs

          # --- Hardware ---
          sound
          corectrl
          tuned

          # --- Desktop Environment ---
          desktop
          plasma
          flatpak

          # --- Network ---
          vpn
          winbox

          # --- Virtualization ---
          virtualbox

          # --- Gaming ---
          gaming

          # --- Services ---
          caddy
          jellyfin
          qbittorrent
          samba
          tailscale

          # --- Users ---
          kexan
        ]

        # Specific Home-Manager modules
        ++ [
          {
            home-manager.users.kexan = {
              imports = with config.flake.modules.homeManager; [
                ai
                anki
                lazyvim
                messaging
                retroarch
                zen-browser
                bitwig
                ocr
                zed
              ];
            };
          }
        ];

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

      #FIXME: vbox not workin on 6.19
      boot.kernelPackages = pkgs.linuxPackages_6_18;

      hardware.facter.reportPath = ./facter.json;

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

      # disko.devices = {
      #   disk = {
      #     main = {
      #       type = "disk";
      #       device = "/dev/nvme0n1";
      #       content = {
      #         type = "gpt";
      #         partitions = {
      #           ESP = {
      #             priority = 1;
      #             name = "ESP";
      #             start = "1M";
      #             end = "512M";
      #             type = "EF00";
      #             content = {
      #               type = "filesystem";
      #               format = "vfat";
      #               mountpoint = "/boot";
      #               mountOptions = [
      #                 "fmask=0077"
      #                 "dmask=0077"
      #               ];
      #             };
      #           };
      #           root = {
      #             size = "100%";
      #             content = {
      #               type = "btrfs";
      #               extraArgs = [ "-f" ];
      #
      #               subvolumes = {
      #                 "@" = {
      #                   mountpoint = "/";
      #                   mountOptions = [
      #                     "compress=zstd"
      #                     "noatime"
      #                   ];
      #                 };
      #
      #                 "@home" = {
      #                   mountpoint = "/home";
      #                   mountOptions = [
      #                     "compress=zstd"
      #                     "noatime"
      #                   ];
      #                 };
      #
      #                 "@nix" = {
      #                   mountpoint = "/nix";
      #                   mountOptions = [
      #                     "compress=zstd"
      #                     "noatime"
      #                   ];
      #                 };
      #
      #                 "@swap" = {
      #                   mountpoint = "/.swapvol";
      #                   swap = {
      #                     swapfile.size = "8G";
      #                   };
      #                 };
      #               };
      #             };
      #           };
      #         };
      #       };
      #     };
      #   };
      # };

      zramSwap.enable = true;
    };
}

{
  inputs,
  den,
  __findFile,
  ...
}: {
  den.hosts.x86_64-linux.redmibook.users.kexan = {};
  den.aspects.redmibook = {
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

        (<hardware/facter> ./facter.json)
        <hardware/tuned>
        <hardware/thermald>

        <virtualisation/virt-manager>

        <services/flatpak>
        <services/flatpak>
      ];
    };
    nixos = {
      imports = [
        inputs.disko.nixosModules.disko
      ];

      boot.kernelParams = [
        "i915.force_probe=!*"
        "xe.force_probe=*"
      ];

      disko.devices = {
        disk = {
          main = {
            type = "disk";
            device = "/dev/nvme0n1";
            content = {
              type = "gpt";
              partitions = {
                ESP = {
                  priority = 1;
                  name = "ESP";
                  start = "1M";
                  end = "512M";
                  type = "EF00";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = [
                      "fmask=0077"
                      "dmask=0077"
                    ];
                  };
                };
                root = {
                  size = "100%";
                  content = {
                    type = "btrfs";
                    extraArgs = ["-f"];

                    subvolumes = {
                      "@" = {
                        mountpoint = "/";
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                        ];
                      };

                      "@home" = {
                        mountpoint = "/home";
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                        ];
                      };

                      "@nix" = {
                        mountpoint = "/nix";
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                        ];
                      };

                      "@swap" = {
                        mountpoint = "/.swapvol";
                        swap = {
                          swapfile.size = "8G";
                        };
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };

      zramSwap.enable = true;
    };
  };
}
# flake.modules.nixos."hosts/redmibook" = {
#   imports = with config.flake.modules.nixos;
#     [
#       # --- Core & System ---
#       base
#       shell
#       openssh
#       sops
#       btrfs
#       # --- Hardware ---
#       sound
#       tuned
#       thermald
#       # --- Desktop Environment ---
#       plasma
#       fonts
#       flatpak
#       # --- Network ---
#       vpn
#       winbox
#       # --- Virtualisation ---
#       virtmanager
#       # --- Services ---
#       tailscale
#       # --- Gaming ---
#       gaming
#       # --- Apps ---
#       ocr
#       zed
#       # --- Users ---
#       kexan
#     ]
#     # Specific Home-Manager modules
#     ++ [
#       {
#         home-manager.users.kexan = {
#           imports = with config.flake.modules.homeManager; [
#             ai
#             anki
#             lazyvim
#             messaging
#             zen-browser
#             godot
#             rust-rover
#           ];
#         };
#       }
#     ];
# };


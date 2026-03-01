{config, ...}: {
  flake.modules.nixos."hosts/redmibook" = {
    imports = with config.flake.modules.nixos;
      [
        # --- Core & System ---
        base
        shell
        openssh
        sops
        btrfs

        # --- Hardware ---
        sound
        tuned
        thermald

        # --- Desktop Environment ---
        desktop
        plasma
        flatpak

        # --- Network ---
        vpn
        winbox

        # --- Virtualisation ---
        virtmanager

        # --- Services ---
        tailscale

        # --- Gaming ---
        gaming

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
              zen-browser
              ocr
              zed
              godot
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

    boot.kernelParams = [
      "i915.force_probe=!*"
      "xe.force_probe=*"
    ];

    hardware.facter.reportPath = ./facter.json;

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
}

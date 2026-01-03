{
  config,
  ...
}:

{
  flake.modules.nixos."hosts/redmibook" = {
    imports =
      with config.flake.modules.nixos;
      [
        base
        btrfs
        sops
        desktop
        plasma
        sound
        shell
        openssh
        podman
        virtualbox
        flatpak
        gaming
        vpn
        kexan
      ]

      # Specific Home-Manager modules
      ++ [
        {
          home-manager.users.kexan = {
            imports = with config.flake.modules.homeManager; [
              ai
              dev
              messaging
              retroarch
              zen-browser
            ];
          };
        }
      ];

    networking = {
      hosts = {
        "192.168.1.100" = [
          "linuxservice.test"
          "yg.linuxservice.test"
        ];
        "192.168.1.101" = [
          "yougile.local"
          "yg.yougile.local"
        ];
      };
    };

    #TODO: ADD FACTER.JSON!!!
    # hardware.facter.reportPath = ./facter.json;

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
                  extraArgs = [ "-f" ];

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

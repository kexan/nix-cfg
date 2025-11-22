{
  config,
  ...
}:

{
  flake.modules.nixos."hosts/desktop" =
    { lib, ... }:

    {
      imports =
        with config.flake.modules.nixos;
        [
          # Modules
          base
          facter
          desktop
          sound
          shell

          docker
          virtualbox

          flatpak

          gaming

          vpn

          # Users
          root
          kexan
        ]

        # Specific Home-Manager modules
        ++ [
          {
            home-manager.users.kexan = {
              imports = with config.flake.modules.homeManager; [
                ai

                base
                desktop

                docker
                dev

                messaging
                shell
              ];
            };
          }
        ];

      networking = {
        useDHCP = lib.mkDefault true;
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
        firewall.allowedTCPPorts = [
          #jellyfin port
          8096
        ];
      };

      boot = {
        loader = {
          limine = {
            enable = true;
            maxGenerations = 15;
          };
        };

        initrd = {
          kernelModules = [ "kvm-amd" ];
          availableKernelModules = [
            "nvme"
            "xhci_pci"
            "ahci"
            "usbhid"
            "usb_storage"
            "sd_mod"
          ];
        };
      };

      facter.reportPath = ./facter.json;

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

      swapDevices = [
        { device = "/dev/disk/by-uuid/6e5076bc-253c-4dd6-9831-676ee770423a"; }
      ];

      nixpkgs = {
        config.allowUnfree = true;
      };

      #TODO: потестить Facter - если чёт будет не ок, вернуть
      # hardware.cpu.amd.updateMicrocode = true;
    };
}

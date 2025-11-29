{
  config,
  ...
}:

{
  flake.modules.nixos."hosts/mac" =
    { inputs, lib, ... }:

    {
      imports =
        with config.flake.modules.nixos;
        [
          inputs.apple-silicon-support.nixosModules.apple-silicon-support

          # Modules
          base
          desktop
          sound
          shell
          openssh
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
                dev
                messaging
                shell
              ];
            };
          }
        ];

      home-manager.backupFileExtension = "backup";

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

      boot = {
        loader = {
          limine = {
            enable = true;
            maxGenerations = 15;
          };
        };

        initrd = {
          availableKernelModules = [
            "usb_storage"
          ];
        };
      };

      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/814baa1f-cf00-426a-9e9c-bd11e0799e90";
          fsType = "ext4";
        };

        "/boot" = {
          device = "/dev/disk/by-uuid/86EC-1D02";
          fsType = "vfat";
          options = [
            "fmask=0022"
            "dmask=0022"
          ];
        };
      };

      zramSwap.enable = true;

      hardware.asahi.peripheralFirmwareDirectory = ./firmware;

      nixpkgs = {
        config.allowUnfree = true;
        hostPlatform = lib.mkDefault "aarch64-linux";
      };

      nix.settings = {
        extra-substituters = [
          "https://nixos-apple-silicon.cachix.org"
        ];
        extra-trusted-public-keys = [
          "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
        ];
      };
    };
}

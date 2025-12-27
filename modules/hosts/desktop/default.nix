{
  config,
  ...
}:

{
  flake.modules.nixos."hosts/desktop" = {
    imports =
      with config.flake.modules.nixos;
      [
        base
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
              base
              desktop
              plasma
              podman
              dev
              messaging
              shell
              gaming
              vpn
            ];
          };
        }
      ];

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

    zramSwap.enable = true;

    gaming = {
      corectrl.enable = true;
    };

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

      firewall.allowedTCPPorts = [
        #jellyfin port
        8096
      ];

    };
  };
}

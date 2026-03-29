{
  inputs,
  den,
  __findFile,
  ...
}: {
  den.hosts.x86_64-linux.vm.users.kexan = {};
  den.aspects.vm = {
    provides.to-users = {
      includes = with den.aspects; [
        base
        shell
        vpn

        <desktop/plasma>
        <apps/zen-browser>

        (<hardware/facter> ./facter.json)
        <hardware/tuned>

        <services/openssh>
        <services/tailscale>
      ];
    };
    nixos = {pkgs, ...}: {
      imports = [
        inputs.disko.nixosModules.disko
      ];

      virtualisation.vmVariant = {
        virtualisation = {
          graphics = true;
          cores = 4;
          memorySize = 4096;
          qemu.options = [
            "-vga virtio"
            "-display gtk,gl=on"
          ];
        };
      };
      boot.kernelPackages = pkgs.linuxPackages_6_18;

      disko.devices = {
        disk = {
          main = {
            type = "disk";
            device = "/dev/sda";
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
                    type = "filesystem";
                    format = "ext4";
                    mountpoint = "/";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}

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
        sops
        vpn

        <desktop/plasma>
        <apps/zen-browser>

        (<hardware/facter> ./facter.json)
        <hardware/tuned>

        <services/openssh>
        <services/tailscale>
      ];
    };
    nixos = {
      imports = [
        inputs.disko.nixosModules.disko
      ];

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

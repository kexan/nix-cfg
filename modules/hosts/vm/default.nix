{
  config,
  ...
}:

{
  flake.modules.nixos."hosts/vm" = {
    imports =
      with config.flake.modules.nixos;
      [
        base
        desktop
        plasma
        shell
        openssh
        kexan
      ]

      # Specific Home-Manager modules
      ++ [
        {
          home-manager.users.kexan = {
            imports = with config.flake.modules.homeManager; [
              dev
              zen-browser
            ];
          };
        }
      ];

    hardware.facter.reportPath = ./facter.json;

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
}

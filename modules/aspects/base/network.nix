{__findFile, ...}: {
  den.aspects.base = {
    includes = [
      (
        {host, ...}: {
          ${host.class}.networking.hostName = host.hostName;
        }
      )
      (<tools/groups> ["networkmanager"])
    ];

    nixos = {
      networking = {
        dhcpcd.enable = false;

        networkmanager = {
          enable = true;
        };
      };

      systemd = {
        services.NetworkManager-wait-online.enable = false;
        network.wait-online.enable = false;
      };

      services.resolved = {
        enable = true;
      };
    };
  };
}

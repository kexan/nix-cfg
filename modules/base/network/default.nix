{
  flake.modules.nixos.base = {hostConfig, ...}: {
    networking = {
      hostName = hostConfig.name;
      networkmanager.enable = true;
      dhcpcd.enable = false;
      useDHCP = false;
    };

    systemd = {
      services.NetworkManager-wait-online.enable = false;
      network.wait-online.enable = false;
    };
  };
}

{
  flake.modules.nixos.base =
    { pkgs, hostConfig, ... }:
    {
      networking = {
        hostName = hostConfig.name;

        networkmanager = {
          enable = true;
          plugins = [ pkgs.networkmanager-openvpn ];
        };
      };

      systemd = {
        services.NetworkManager-wait-online.enable = false;
        network.wait-online.enable = false;
      };
    };
}

{ pkgs, ... }:

{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    networkmanager.plugins = [ pkgs.networkmanager-openvpn ];
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
}

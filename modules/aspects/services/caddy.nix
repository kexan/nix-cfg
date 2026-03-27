{
  den.aspects.services.provides.caddy = {
    nixos = {
      services.caddy.enable = true;

      networking.firewall.allowedTCPPorts = [
        80
        443
      ];
    };
  };
}

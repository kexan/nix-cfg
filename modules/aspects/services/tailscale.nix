{
  den.aspects.services.provides.tailscale = {
    nixos = {
      services = {
        tailscale = {
          enable = true;
          openFirewall = true;
          useRoutingFeatures = "both";
        };
      };
    };
  };
}

{
  den.aspects.openssh = {
    nixos = {
      services = {
        enable = true;
        openFirewall = true;
        settings = {
          PasswordAuthentication = false;
        };
      };
    };
  };
}

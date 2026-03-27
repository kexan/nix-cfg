{
  den.aspects.openssh = {
    nixos = {
      services.openssh = {
        enable = true;
        openFirewall = true;
        settings = {
          PasswordAuthentication = false;
        };
      };
    };
  };
}

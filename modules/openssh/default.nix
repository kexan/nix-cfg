{
  flake.modules.nixos.openssh = {
    services = {
      openssh = {
        enable = true;
        openFirewall = true;
        settings = {
          PasswordAuthentication = false;
        };
      };
    };
  };
}

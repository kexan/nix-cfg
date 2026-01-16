{
  flake.modules.nixos.samba = {
    services.samba = {
      enable = true;
      openFirewall = true;
    };
  };
}

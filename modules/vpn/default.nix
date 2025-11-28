{
  flake.modules = {
    nixos.vpn = {
      programs.throne = {
        enable = true;
        tunMode.enable = true;
      };
    };
  };
}

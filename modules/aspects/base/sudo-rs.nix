{
  den.aspects.base = {
    nixos = {
      security.sudo-rs.enable = true;
    };

    user = {
      extraGroups = ["wheel"];
    };
  };
}

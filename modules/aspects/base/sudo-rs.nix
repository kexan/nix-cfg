{__findFile, ...}: {
  den.aspects.base = {
    includes = [
      (<tools/groups> ["wheel"])
    ];
    nixos = {
      security.sudo-rs.enable = true;
    };
  };
}

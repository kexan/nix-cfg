{
  den.aspects.base = {
    nixos = {
      boot.loader.limine = {
        enable = true;
        maxGenerations = 15;
      };
    };
  };
}

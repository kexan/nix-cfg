{
  flake.modules.nixos.base = {
    boot.loader.limine = {
      enable = true;
      maxGenerations = 15;
    };
  };
}

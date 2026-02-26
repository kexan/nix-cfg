{inputs, ...}: {
  flake.modules.nixos.base = {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager._base
    ];
  };
}

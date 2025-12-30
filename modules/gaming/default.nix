{ inputs, ... }:
{
  flake.modules.nixos.gaming = {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.gaming
    ];
  };
}

{ inputs, ... }:
{
  flake.modules.nixos.shell = {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.shell
    ];
  };
}

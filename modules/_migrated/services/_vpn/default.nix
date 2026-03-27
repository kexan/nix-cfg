{inputs, ...}: {
  flake.modules = {
    nixos.vpn.home-manager.sharedModules = [
      inputs.self.modules.homeManager._vpn
    ];
  };
}

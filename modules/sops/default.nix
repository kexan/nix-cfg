{
  flake.modules.nixos.sops =
    { inputs, ... }:
    {
      imports = [ inputs.sops-nix.nixosModules.sops ];

      sops = {
        defaultSopsFile = ../../secrets/secrets.yaml;
        age.keyFile = "/var/lib/sops-nix/key.txt";
      };

      home-manager.sharedModules = [
        inputs.self.modules.homeManager._sops
      ];
    };
}

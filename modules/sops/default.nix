{
  flake.modules.nixos.sops =
    { inputs, lib, ... }:
    {
      imports = [ inputs.sops-nix.nixosModules.sops ];

      options.sops.enable = lib.mkEnableOption "Enable sops-nix integration";

      config = {
        sops = {
          enable = true;
          defaultSopsFile = ../../secrets/secrets.yaml;
          age.keyFile = "/var/lib/sops-nix/key.txt";
        };
      };
    };
}

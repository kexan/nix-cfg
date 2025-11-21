{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./imports.nix
  ];

  users = {
    users.kexan = {
      isNormalUser = true;
      description = "Sergei";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "vboxusers"
        "corectrl"
      ];
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
    users.kexan = {
      imports = [ ./home.nix ];
    };
  };

  system.stateVersion = "25.05";
}

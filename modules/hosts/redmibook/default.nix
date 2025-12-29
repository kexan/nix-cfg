{
  config,
  inputs,
  ...
}:

{
  flake.modules.nixos."hosts/redmibook" = {
    imports =
      with config.flake.modules.nixos;
      [
        inputs.disko.nixosModules.disko
        ./disko.nix
        base
        sops
        desktop
        plasma
        sound
        shell
        openssh
        podman
        virtualbox
        flatpak
        gaming
        vpn
        kexan
      ]

      # Specific Home-Manager modules
      ++ [
        {
          home-manager.users.kexan = {
            imports = with config.flake.modules.homeManager; [
              ai
              dev
              messaging
            ];
          };
        }
      ];

    zramSwap.enable = true;

    networking = {
      hosts = {
        "192.168.1.100" = [
          "linuxservice.test"
          "yg.linuxservice.test"
        ];
        "192.168.1.101" = [
          "yougile.local"
          "yg.yougile.local"
        ];
      };
    };
  };
}

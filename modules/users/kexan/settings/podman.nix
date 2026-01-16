{
  flake.modules = {
    nixos.kexan =
      {
        lib,
        config,
        ...
      }:

      let
        podmanEnabled = config.virtualisation.podman.enable or false;
      in
      {
        users.users.kexan.extraGroups = lib.mkIf podmanEnabled [ "podman" ];
      };
  };
}

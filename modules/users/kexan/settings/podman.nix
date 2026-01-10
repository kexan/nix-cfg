{
  flake.modules = {
    nixos.kexan =
      {
        lib,
        config,
        ...
      }:
      {
        config = lib.mkIf (config.virtualisation.podman.enable or false) {
          users.users.kexan.extraGroups = [ "podman" ];
        };
      };
  };
}

{
  flake.modules = {
    nixos.kexan =
      {
        lib,
        config,
        ...
      }:
      {
        config = lib.mkIf (config.virtualisation.virtualbox.host.enable or false) {
          users.users.kexan.extraGroups = [ "vboxusers" ];
        };
      };
  };
}

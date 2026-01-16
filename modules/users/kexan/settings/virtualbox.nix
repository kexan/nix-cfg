{
  flake.modules = {
    nixos.kexan =
      {
        lib,
        config,
        ...
      }:

      let
        vboxEnabled = config.virtualisation.virtualbox.host.enable or false;
      in
      {
        users.users.kexan.extraGroups = lib.mkIf vboxEnabled [ "vboxusers" ];
      };
  };
}

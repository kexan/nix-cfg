{
  flake.modules = {
    nixos.kexan =
      {
        lib,
        config,
        ...
      }:
      {
        config = lib.mkIf (config.programs.corectrl.enable or false) {
          users.users.kexan.extraGroups = [ "corectrl" ];
        };
      };
  };
}

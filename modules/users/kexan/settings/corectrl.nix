{
  flake.modules = {
    nixos.kexan =
      {
        lib,
        config,
        ...
      }:

      let
        corectrlEnabled = config.programs.corectrl.enable or false;
      in
      {
        users.users.kexan.extraGroups = lib.mkIf corectrlEnabled [ "corectrl" ];
      };
  };
}

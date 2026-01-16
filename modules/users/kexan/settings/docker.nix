{
  flake.modules.nixos.kexan =
    { lib, config, ... }:

    let
      dockerEnabled = config.virtualisation.docker.enable or false;
    in
    {
      users.users.kexan.extraGroups = lib.mkIf dockerEnabled [ "docker" ];
    };
}

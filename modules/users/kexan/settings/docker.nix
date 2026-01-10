{
  flake.modules.nixos.kexan =
    { lib, config, ... }:
    {
      config = lib.mkIf (config.virtualisation.docker.enable or false) {
        users.users.kexan.extraGroups = [ "docker" ];
      };
    };
}

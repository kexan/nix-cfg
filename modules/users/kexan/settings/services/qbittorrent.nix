{ config, ... }:

let
  meta = config.flake.meta.users.kexan;
in
{
  flake.modules = {
    nixos.kexan =
      {
        lib,
        config,
        ...
      }:
      {
        config = lib.mkIf (config.services.qbittorrent.enable or false) {
          users.users.kexan.extraGroups = [ "qbittorrent" ];

          systemd.tmpfiles.rules = [
            "L /home/${meta.username}/torrents - ${meta.username} users - /var/lib/qBittorrent/qBittorrent/downloads"
          ];
        };
      };
  };
}

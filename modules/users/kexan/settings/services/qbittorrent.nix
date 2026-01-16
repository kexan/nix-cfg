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

      let
        qbittorrentEnabled = config.services.qbittorrent.enable or false;
      in
      {
        config = lib.mkIf qbittorrentEnabled {
          users.users.kexan.extraGroups = [ "qbittorrent" ];

          systemd.tmpfiles.rules = [
            "L /home/${meta.username}/torrents - ${meta.username} users - /var/lib/qBittorrent/qBittorrent/downloads"
          ];
        };
      };
  };
}

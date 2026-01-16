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
        pkgs,
        ...
      }:

      let
        jellyfinEnabled = config.services.jellyfin.enable or false;
      in
      {
        config = lib.mkIf jellyfinEnabled {
          environment.systemPackages = [ pkgs.bindfs ];

          systemd.tmpfiles.rules = [
            "d /home/${meta.username}/Видео/Фильмы 0755 ${meta.username} users -"
            "d /home/${meta.username}/Видео/Сериалы 0755 ${meta.username} users -"
          ];

          fileSystems."/var/lib/jellyfin/media/movies" = {
            device = "/home/${meta.username}/Видео/Фильмы";
            fsType = "fuse.bindfs";
            options = [
              "ro"
              "force-user=jellyfin"
              "force-group=jellyfin"
              "allow_other"
              "nofail"
            ];
          };

          fileSystems."/var/lib/jellyfin/media/shows" = {
            device = "/home/${meta.username}/Видео/Сериалы";
            fsType = "fuse.bindfs";
            options = [
              "ro"
              "force-user=jellyfin"
              "force-group=jellyfin"
              "allow_other"
              "nofail"
            ];
          };
        };
      };
  };
}

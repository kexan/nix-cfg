{
  flake.modules = {
    nixos.kexan =
      {
        lib,
        config,
        pkgs,
        ...
      }:
      {
        config = lib.mkIf (config.services.jellyfin.enable or false) {
          environment.systemPackages = [ pkgs.bindfs ];

          fileSystems."/var/lib/jellyfin/media/movies" = {
            device = "/home/kexan/Видео/Фильмы";
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
            device = "/home/kexan/Видео/Сериалы";
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

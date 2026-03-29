{__findFile, ...}: {
  den.aspects.services.provides.jellyfin = {
    includes = [
      (<tools/groups> ["jellyfin"])
    ];
    nixos = {
      services.jellyfin = {
        enable = true;
        openFirewall = true;
        hardwareAcceleration = {
          enable = true;
          type = "vaapi";
          device = "/dev/dri/renderD128";
        };
        transcoding = {
          enableHardwareEncoding = true;
          hardwareEncodingCodecs = {
            hevc = true;
            av1 = true;
          };
          hardwareDecodingCodecs = {
            hevc = true;
            h264 = true;
            av1 = true;
          };
        };
      };

      services.caddy.virtualHosts."http://jellyfin.lan" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:8096
        '';
      };
    };
  };
}

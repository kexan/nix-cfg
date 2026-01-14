{
  flake.modules = {
    nixos.jellyfin =
      { lib, config, ... }:

      let
        localDomain = "jellyfin.lan";
        caddyEnabled = config.services.caddy.enable or false;
      in
      {
        services.jellyfin = {
          enable = true;
          openFirewall = !caddyEnabled;
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

        services.caddy = lib.mkIf caddyEnabled {
          virtualHosts."http://${localDomain}" = {
            extraConfig = ''
              reverse_proxy 127.0.0.1:8096
            '';
          };
        };
      };
  };
}

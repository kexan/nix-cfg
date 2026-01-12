{
  flake.modules = {
    nixos.jellyfin =
      { inputs, ... }:
      {
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
      };
  };
}

{
  flake.modules = {
    homeManager.gaming =
      {
        inputs,
        pkgs,
        lib,
        config,
        ...
      }:
      {
        programs = {
          plasma = lib.mkIf config.programs.plasma.enable {
            window-rules = [
              {
                description = "Fullscreen hack for com.libretro.RetroArch";
                match = {
                  window-class = {
                    value = "com.libretro.RetroArch";
                    type = "exact";
                    match-whole = false;
                  };
                };
                apply = {
                  fullscreen = {
                    value = true;
                    apply = "force";
                  };
                };
              }
            ];
          };

          retroarch = {
            enable = true;

            cores = {
              swanstation.enable = true;
              ppsspp.enable = true;
              dolphin.enable = true;
            };

            settings = {
              video_driver = "vulkan";
              video_fullscreen = "false";
              video_window_custom_size_enable = "true";
              video_windowed_position_width = "2560";
              video_windowed_position_height = "1440";
              pause_content_when_not_active = "false";
              menu_driver = "xmb";
            };
          };
        };
      };
  };
}

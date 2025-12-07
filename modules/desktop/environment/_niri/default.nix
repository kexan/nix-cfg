{
  flake.modules = {
    nixos.desktop = {
      programs = {
        niri = {
          enable = true;
        };
        dms-shell = {
          enable = true;
        };
      };
    };

    homeManager.desktop =
      {
        lib,
        pkgs,
        inputs,
        ...
      }:
      {
        imports = with inputs; [
          niri.homeModules.niri
        ];

        programs = {
          niri = {
            enable = true;
            package = pkgs.niri;
            settings = {

              xwayland-satellite = {
                enable = true;
                path = lib.getExe pkgs.xwayland-satellite;
              };

              spawn-at-startup = [
                {
                  command = [
                    "dms"
                    "run"
                  ];
                }
              ];

              environment = {
                CLUTTER_BACKEND = "wayland";
                MOZ_ENABLE_WAYLAND = "1";
                NIXOS_OZONE_WL = "1";
                QT_QPA_PLATFORM = "wayland;xcb";
                QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
                SDL_VIDEODRIVER = "wayland";
                WLR_RENDERER = "vulkan";
                WLR_NO_HARDWARE_CURSORS = "1";
                QT_QPA_PLATFORMTHEME = "qt6ct";
                GTK_IM_MODULE = "simple";
              };

              input = {
                focus-follows-mouse = {
                  enable = true;
                  max-scroll-amount = "90%";
                };

                warp-mouse-to-focus.enable = true;
                workspace-auto-back-and-forth = true;
              };

              hotkey-overlay.skip-at-startup = true;
            };
          };
        };
      };
  };
}

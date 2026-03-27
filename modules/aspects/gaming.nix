{
  inputs,
  den,
  ...
}: {
  den.aspects.gaming.provides = {
    base = {host, ...}: {
      includes = [
        den.aspects.services.provides.flatpak.nixos
      ];

      nixos = {pkgs, ...}: {
        boot.kernelModules = ["ntsync"];
        services.flatpak.packages = ["ru.linux_gaming.PortProton"];
        programs = {
          steam = {
            enable = true;
            extraCompatPackages = with pkgs; [
              proton-ge-bin
              steamtinkerlaunch
            ];
          };
          gamemode.enable = true;
          gamescope = {
            enable = true;
            args = [
              "-W ${toString host.primaryDisplay.width}"
              "-H ${toString host.primaryDisplay.height}"
              "-r ${toString host.primaryDisplay.refresh}"
              "-O ${host.primaryDisplay.name}"
              "-f"
              "--adaptive-sync"
            ];
          };
        };
      };
    };

    emulation = {
      nixos = {
        imports = [
          inputs.plasma-manager.homeModules.plasma-manager
        ];

        programs = {
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

          plasma.window-rules = [
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
      };
    };
  };
}

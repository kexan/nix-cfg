{
  den,
  inputs,
  ...
}: {
  den.aspects.gaming.provides = {
    base = {
      includes = [
        (den.provides.unfree [
          "steam"
          "steam-unwrapped"
        ])
      ];
      nixos = {pkgs, ...}: {
        imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];
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
          gamescope.enable = true;
        };
      };
    };

    emulation = {
      homeManager = {
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

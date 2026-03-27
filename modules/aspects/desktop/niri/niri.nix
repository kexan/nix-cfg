{
  den,
  inputs,
  ...
}: {
  den.aspects.desktop.provides.niri = {
    includes = [
      den.aspects.desktop.provides.fonts
    ];

    nixos = {pkgs, ...}: {
      programs = {
        niri.enable = true;
        dms-shell.enable = true;
        dms-shell.quickshell.package = inputs.quickshell.packages.${pkgs.system}.quickshell;
      };

      environment.systemPackages = with pkgs; [
        nautilus
        xwayland-satellite
        adwaita-icon-theme
        kdePackages.qt6ct
        kdePackages.breeze
        kdePackages.breeze-icons
      ];

      environment.variables = {
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_QPA_PLATFORMTHEME = "qt6ct";
        XDG_CURRENT_DESKTOP = "niri:GNOME";
        XDG_SESSION_DESKTOP = "niri";
        XDG_SESSION_TYPE = "wayland";
      };

      services = {
        gvfs.enable = true;
        displayManager.dms-greeter = {
          enable = true;
          compositor.name = "niri";
        };
      };
    };

    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [alacritty];
    };
  };

  flake-file.inputs = {
    quickshell = {
      url = "github:quickshell-mirror/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

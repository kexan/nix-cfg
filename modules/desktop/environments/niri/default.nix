{
  flake.modules = {
    nixos.niri = {
      inputs,
      pkgs,
      ...
    }: {
      programs = {
        niri.enable = true;
        dms-shell.enable = true;
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
        CLUTTER_BACKEND = "wayland";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
        WLR_RENDERER = "vulkan";
        QT_QPA_PLATFORMTHEME = "qt6ct";
      };

      services.gvfs.enable = true;

      home-manager.sharedModules = [
        inputs.self.modules.homeManager._niri
      ];
    };

    homeManager._niri = {pkgs, ...}: {
      home.packages = with pkgs; [
        alacritty
      ];
    };
  };
}

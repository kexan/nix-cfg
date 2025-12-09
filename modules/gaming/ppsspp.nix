{
  flake.modules = {
    homeManager.gaming =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          ppsspp-sdl-wayland
        ];
      };
  };
}

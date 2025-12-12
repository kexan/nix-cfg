{
  flake.modules = {
    nixos.desktop =
      { pkgs, ... }:

      {
        fonts = {
          enableDefaultPackages = true;

          packages = with pkgs; [
            corefonts
            roboto
            noto-fonts
            nerd-fonts.fira-code
          ];
        };
      };

    homeManager.desktop = {
      fonts = {
        fontconfig = {
          enable = true;
        };
      };
    };
  };
}

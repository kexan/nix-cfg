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
            noto-fonts-cjk-sans-static
            noto-fonts-cjk-serif-static
            nerd-fonts.fira-code
            joypixels
          ];

          fontconfig = {
            enable = true;

            defaultFonts = {
              emoji = [
                "JoyPixels"
                "Noto Color Emoji"
              ];

              monospace = [
                "FiraCode Nerd Font Mono"
              ];
            };
          };
        };

        nixpkgs.config = {
          joypixels.acceptLicense = true;
        };
      };
  };
}

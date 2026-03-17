{
  flake.modules = {
    nixos.desktop = {pkgs, ...}: {
      fonts = {
        enableDefaultPackages = true;

        packages = with pkgs; [
          corefonts
          adwaita-fonts
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
            sansSerif = [
              "Adwaita Sans"
            ];

            serif = [
              "Adwaita Serif"
            ];

            monospace = [
              "FiraCode Nerd Font Mono"
            ];

            emoji = [
              "JoyPixels"
              "Noto Color Emoji"
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

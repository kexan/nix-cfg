{
  den.aspects.desktop.provides.fonts = {
    nixos = {pkgs, ...}: {
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
            monospace = ["FiraCode Nerd Font Mono"];
            emoji = ["JoyPixels" "Noto Color Emoji"];
          };
        };
      };

      nixpkgs.config.joypixels.acceptLicense = true;
    };
  };
}

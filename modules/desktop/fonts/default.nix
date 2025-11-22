{
  flake.modules = {
    nixos.desktop =
      { pkgs, ... }:

      {
        fonts = {
          enableDefaultPackages = true;

          packages = with pkgs; [
            corefonts
            # тянуть все гугловские шрифты мне чет не нравится, мне нужен фактически только noto-fonts и roboto - но надо поресерчить почему jpdb.io ломается
            google-fonts
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

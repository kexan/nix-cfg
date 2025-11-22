#TODO: здесь будет plasma-manager
{
  flake.modules = {
    nixos.desktop =
      { pkgs, ... }:

      let
        # Фикс маленького курсора в некоторых приложениях
        breezeCursorDefaultTheme = pkgs.runCommandLocal "breeze-cursor-default-theme" { } ''
          mkdir -p $out/share/icons
          ln -s ${pkgs.kdePackages.breeze}/share/icons/breeze_cursors $out/share/icons/default
        '';
      in
      {
        environment.systemPackages = [
          breezeCursorDefaultTheme
        ];
      };

    homeManager.desktop =
      { pkgs, ... }:

      {
        home.file.".icons/default".source = "${pkgs.kdePackages.breeze}/share/icons/breeze_cursors";
      };
  };
}

{
  pkgs,
  ...
}:

let
  # Фикс маленького курсора в некоторых приложениях
  breezeCursorDefaultTheme = pkgs.runCommandLocal "breeze-cursor-default-theme" { } ''
    mkdir -p $out/share/icons
    ln -s ${pkgs.kdePackages.breeze}/share/icons/breeze_cursors $out/share/icons/default
  '';
in
{
  environment.systemPackages = with pkgs; [
    git
    curl
    breezeCursorDefaultTheme
  ];
}

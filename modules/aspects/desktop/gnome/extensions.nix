{
  den.aspects.desktop.provides.gnome = {
    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.gnomeExtensions.appindicator];
      dconf.settings."org/gnome/shell" = {
        enabled-extensions = [
          pkgs.gnomeExtensions.appindicator.extensionUuid
        ];
      };
    };
  };
}

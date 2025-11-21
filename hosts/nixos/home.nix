{
  imports = [
    ./hm-imports.nix
  ];

  home = {
    username = "kexan";
    homeDirectory = "/home/kexan";
    stateVersion = "25.05";
  };

  xdg.configFile."fontconfig/conf.d/10-hm-fonts.conf".force = true;
}

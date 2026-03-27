{
  den.aspects.apps.provides.winbox = {
    nixos = {pkgs, ...}: {
      programs.winbox = {
        enable = true;
        openFirewall = true;
        package = pkgs.winbox4;
      };
    };
  };
}

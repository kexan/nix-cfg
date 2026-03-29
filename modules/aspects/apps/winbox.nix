{den, ...}: {
  den.aspects.apps.provides.winbox = {
    includes = [
      (den.provides.unfree [
        "winbox"
      ])
    ];
    nixos = {pkgs, ...}: {
      programs.winbox = {
        enable = true;
        openFirewall = true;
        package = pkgs.winbox4;
      };
    };
  };
}

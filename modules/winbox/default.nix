{
  flake.modules = {
    nixos.winbox =
      { pkgs, ... }:
      {
        programs.winbox = {
          enable = true;
          openFirewall = true;
          package = pkgs.winbox4;
        };
      };

  };
}

{
  flake.modules = {
    homeManager.shell =
      { lib, config, ... }:

      let
        fishEnabled = config.programs.fish.enable;
      in
      {
        programs = {
          ripgrep.enable = true;

          fish.shellAliases = lib.mkIf fishEnabled {
            grep = "rg";
          };
        };
      };
  };
}

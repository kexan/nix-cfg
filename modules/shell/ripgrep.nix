{
  flake.modules = {
    homeManager.shell =
      { lib, config, ... }:
      {
        programs = {
          ripgrep.enable = true;

          fish.shellAliases = lib.mkIf config.programs.fish.enable {
            grep = "rg";
          };
        };
      };
  };
}

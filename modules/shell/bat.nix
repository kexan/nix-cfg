{
  flake.modules = {
    homeManager.shell =
      { config, lib, ... }:
      {
        programs = {
          bat.enable = true;

          fish.shellAliases = lib.mkIf config.programs.fish.enable {
            cat = "bat";
          };
        };
      };
  };
}

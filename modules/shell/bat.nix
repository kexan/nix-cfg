{
  flake.modules = {
    homeManager.shell =
      { config, lib, ... }:

      let
        fishEnabled = config.programs.fish.enable;
      in
      {
        programs = {
          bat.enable = true;

          fish.shellAliases = lib.mkIf fishEnabled {
            cat = "bat";
          };
        };
      };
  };
}

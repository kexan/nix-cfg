{
  flake.modules = {
    homeManager.shell =
      { lib, config, ... }:

      let
        fishEnabled = config.programs.fish.enable;
      in
      {
        programs = {
          zoxide = {
            enable = true;
            enableFishIntegration = true;
          };

          fish.shellAliases = lib.mkIf fishEnabled {
            cd = "z";
          };
        };
      };
  };
}

{
  flake.modules = {
    homeManager.shell =
      { lib, config, ... }:
      {
        programs = {
          zoxide = {
            enable = true;
            enableFishIntegration = true;
          };

          fish.shellAliases = lib.mkIf config.programs.fish.enable {
            cd = "z";
          };
        };
      };
  };
}

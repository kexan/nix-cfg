{
  flake.modules = {
    homeManager.ai =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.qwen-code ];
      };
  };
}

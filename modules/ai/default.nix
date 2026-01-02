{
  flake.modules = {
    homeManager.ai =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.master.qwen-code ];
      };
  };
}

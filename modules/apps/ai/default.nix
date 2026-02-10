{
  flake.modules = {
    homeManager.ai =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          qwen-code
          opencode
        ];
      };
  };
}

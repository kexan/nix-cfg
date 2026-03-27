{
  den.aspects.development.provides.ai = {
    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        qwen-code
        opencode
      ];
    };
  };
}

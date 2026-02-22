{
  flake.modules = {
    homeManager.zed =
      { pkgs, ... }:
      {
        programs.zed-editor = {
          enable = true;
          extensions = [
            "nix"
            "toml"
            "rust"
          ];
          extraPackages = with pkgs; [
            nil
            nixd
            package-version-server
          ];
        };
      };
  };
}

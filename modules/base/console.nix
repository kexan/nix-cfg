{
  den.aspects.base = {
    homeManager = {
      programs.zellij = {
        enable = true;
        attachExistingSession = true;
        enableFishIntegration = true;
        settings = {
          default_mode = "locked";
          pane_frames = true;
          mouse_mode = true;
          copy_on_select = true;
        };
      };
    };

    nixos = {pkgs, ...}: {
      console = {
        earlySetup = true;
        font = "ter-124b";
        useXkbConfig = true;
        packages = with pkgs; [terminus_font];
      };
    };
  };
}
